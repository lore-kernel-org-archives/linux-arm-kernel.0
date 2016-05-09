From: eric.auger@linaro.org (Eric Auger)
Date: Mon, 9 May 2016 10:05:08 +0200
Subject: [PATCH v9 5/7] vfio/type1: also check IRQ remapping capability at
 msi domain
In-Reply-To: <FFD9D7C5-B6EF-4E16-A209-BED31DAB26AA@caviumnetworks.com>
References: <1462362858-2925-1-git-send-email-eric.auger@linaro.org>
 <1462362858-2925-6-git-send-email-eric.auger@linaro.org>
 <FFD9D7C5-B6EF-4E16-A209-BED31DAB26AA@caviumnetworks.com>
Message-ID: <573044B4.4000905@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chalamarla,
On 05/05/2016 09:23 PM, Chalamarla, Tirumalesh wrote:
> 
> 
> 
> 
> 
> On 5/4/16, 4:54 AM, "linux-arm-kernel on behalf of Eric Auger" <linux-arm-kernel-bounces at lists.infradead.org on behalf of eric.auger@linaro.org> wrote:
> 
>> On x86 IRQ remapping is abstracted by the IOMMU. On ARM this is abstracted
>> by the msi controller. vfio_safe_irq_domain allows to check whether
>> interrupts are "safe" for a given device. They are if the device does
>> not use MSI or if the device uses MSI and the msi-parent controller
>> supports IRQ remapping.
>>
>> Then we check at group level if all devices have safe interrupts: if not,
>> we only allow the group to be attached if allow_unsafe_interrupts is set.
>>
>> At this point ARM sMMU still advertises IOMMU_CAP_INTR_REMAP. This is
>> changed in next patch.
> 
> Will this work in systems with multiple ITS?
Yes it should support multiple ITS.

Please note however that the series does not yet implement the
msi_doorbell_info callback in GICv3 ITS PCIe/platform irqchip. Without
that, the pci_enable is going to fail. I am going to submit a separate
RFC for that but I can't test it at the moment.

Best Regards

Eric
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>
>> ---
>> v3 -> v4:
>> - rename vfio_msi_parent_irq_remapping_capable into vfio_safe_irq_domain
>>  and irq_remapping into safe_irq_domains
>>
>> v2 -> v3:
>> - protect vfio_msi_parent_irq_remapping_capable with
>>  CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> ---
>> drivers/vfio/vfio_iommu_type1.c | 44 +++++++++++++++++++++++++++++++++++++++--
>> 1 file changed, 42 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
>> index 4d3a6f1..2fc8197 100644
>> --- a/drivers/vfio/vfio_iommu_type1.c
>> +++ b/drivers/vfio/vfio_iommu_type1.c
>> @@ -37,6 +37,8 @@
>> #include <linux/vfio.h>
>> #include <linux/workqueue.h>
>> #include <linux/msi-iommu.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/msi.h>
>>
>> #define DRIVER_VERSION  "0.2"
>> #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
>> @@ -777,6 +779,33 @@ static int vfio_bus_type(struct device *dev, void *data)
>> 	return 0;
>> }
>>
>> +/**
>> + * vfio_safe_irq_domain: returns whether the irq domain
>> + * the device is attached to is safe with respect to MSI isolation.
>> + * If the irq domain is not an MSI domain, we return it is safe.
>> + *
>> + * @dev: device handle
>> + * @data: unused
>> + * returns 0 if the irq domain is safe, -1 if not.
>> + */
>> +static int vfio_safe_irq_domain(struct device *dev, void *data)
>> +{
>> +#ifdef CONFIG_GENERIC_MSI_IRQ_DOMAIN
>> +	struct irq_domain *domain;
>> +	struct msi_domain_info *info;
>> +
>> +	domain = dev_get_msi_domain(dev);
>> +	if (!domain)
>> +		return 0;
>> +
>> +	info = msi_get_domain_info(domain);
>> +
>> +	if (!(info->flags & MSI_FLAG_IRQ_REMAPPING))
>> +		return -1;
>> +#endif
>> +	return 0;
>> +}
>> +
>> static int vfio_iommu_replay(struct vfio_iommu *iommu,
>> 			     struct vfio_domain *domain)
>> {
>> @@ -870,7 +899,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>> 	struct vfio_group *group, *g;
>> 	struct vfio_domain *domain, *d;
>> 	struct bus_type *bus = NULL;
>> -	int ret;
>> +	int ret, safe_irq_domains;
>>
>> 	mutex_lock(&iommu->lock);
>>
>> @@ -893,6 +922,13 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>>
>> 	group->iommu_group = iommu_group;
>>
>> +	/*
>> +	 * Determine if all the devices of the group have a safe irq domain
>> +	 * with respect to MSI isolation
>> +	 */
>> +	safe_irq_domains = !iommu_group_for_each_dev(iommu_group, &bus,
>> +				       vfio_safe_irq_domain);
>> +
>> 	/* Determine bus_type in order to allocate a domain */
>> 	ret = iommu_group_for_each_dev(iommu_group, &bus, vfio_bus_type);
>> 	if (ret)
>> @@ -920,8 +956,12 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>> 	INIT_LIST_HEAD(&domain->group_list);
>> 	list_add(&group->next, &domain->group_list);
>>
>> +	/*
>> +	 * to advertise safe interrupts either the IOMMU or the MSI controllers
>> +	 * must support IRQ remapping/interrupt translation
>> +	 */
>> 	if (!allow_unsafe_interrupts &&
>> -	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
>> +	    (!iommu_capable(bus, IOMMU_CAP_INTR_REMAP) && !safe_irq_domains)) {
>> 		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
>> 		       __func__);
>> 		ret = -EPERM;
>> -- 
>> 1.9.1
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
