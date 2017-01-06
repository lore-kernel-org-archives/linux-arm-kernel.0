From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 6 Jan 2017 09:20:29 +0000
Subject: [PATCH v6 17/18] vfio/type1: Check MSI remapping at irq domain
 level
In-Reply-To: <af612e18-ca0b-b855-e198-d4c706f2febc@redhat.com>
References: <1483643086-2883-1-git-send-email-eric.auger@redhat.com>
 <1483643086-2883-18-git-send-email-eric.auger@redhat.com>
 <AM5PR0401MB25454B0C8F6E610A50B299D19A630@AM5PR0401MB2545.eurprd04.prod.outlook.com>
 <af612e18-ca0b-b855-e198-d4c706f2febc@redhat.com>
Message-ID: <845d7167-6734-03c9-4df6-2f82f1627dbc@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/01/17 09:08, Auger Eric wrote:
> Hi Bharat
> 
> On 06/01/2017 09:50, Bharat Bhushan wrote:
>> Hi Eric,
>>
>>> -----Original Message-----
>>> From: Eric Auger [mailto:eric.auger at redhat.com]
>>> Sent: Friday, January 06, 2017 12:35 AM
>>> To: eric.auger at redhat.com; eric.auger.pro at gmail.com;
>>> christoffer.dall at linaro.org; marc.zyngier at arm.com;
>>> robin.murphy at arm.com; alex.williamson at redhat.com;
>>> will.deacon at arm.com; joro at 8bytes.org; tglx at linutronix.de;
>>> jason at lakedaemon.net; linux-arm-kernel at lists.infradead.org
>>> Cc: kvm at vger.kernel.org; drjones at redhat.com; linux-
>>> kernel at vger.kernel.org; pranav.sawargaonkar at gmail.com;
>>> iommu at lists.linux-foundation.org; punit.agrawal at arm.com; Diana Madalina
>>> Craciun <diana.craciun@nxp.com>; gpkulkarni at gmail.com;
>>> shankerd at codeaurora.org; Bharat Bhushan <bharat.bhushan@nxp.com>;
>>> geethasowjanya.akula at gmail.com
>>> Subject: [PATCH v6 17/18] vfio/type1: Check MSI remapping at irq domain
>>> level
>>>
>>> In case the IOMMU translates MSI transactions (typical case on ARM), we
>>> check MSI remapping capability at IRQ domain level. Otherwise it is checked
>>> at IOMMU level.
>>>
>>> At this stage the arm-smmu-(v3) still advertise the
>>> IOMMU_CAP_INTR_REMAP capability at IOMMU level. This will be removed
>>> in subsequent patches.
>>>
>>> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>>>
>>> ---
>>>
>>> v6: rewrite test
>>> ---
>>>  drivers/vfio/vfio_iommu_type1.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/vfio/vfio_iommu_type1.c
>>> b/drivers/vfio/vfio_iommu_type1.c index b473ef80..fa0b5c4 100644
>>> --- a/drivers/vfio/vfio_iommu_type1.c
>>> +++ b/drivers/vfio/vfio_iommu_type1.c
>>> @@ -40,6 +40,7 @@
>>>  #include <linux/mdev.h>
>>>  #include <linux/notifier.h>
>>>  #include <linux/dma-iommu.h>
>>> +#include <linux/irqdomain.h>
>>>
>>>  #define DRIVER_VERSION  "0.2"
>>>  #define DRIVER_AUTHOR   "Alex Williamson
>>> <alex.williamson@redhat.com>"
>>> @@ -1208,7 +1209,7 @@ static int vfio_iommu_type1_attach_group(void
>>> *iommu_data,
>>>  	struct vfio_domain *domain, *d;
>>>  	struct bus_type *bus = NULL, *mdev_bus;
>>>  	int ret;
>>> -	bool resv_msi;
>>> +	bool resv_msi, msi_remap;
>>>  	phys_addr_t resv_msi_base;
>>>
>>>  	mutex_lock(&iommu->lock);
>>> @@ -1284,8 +1285,10 @@ static int vfio_iommu_type1_attach_group(void
>>> *iommu_data,
>>>  	INIT_LIST_HEAD(&domain->group_list);
>>>  	list_add(&group->next, &domain->group_list);
>>>
>>> -	if (!allow_unsafe_interrupts &&
>>> -	    !iommu_capable(bus, IOMMU_CAP_INTR_REMAP)) {
>>> +	msi_remap = resv_msi ? irq_domain_check_msi_remap() :
>>
>> There can be multiple interrupt-controller, at-least theoretically it is possible and not sure practically it exists and supported, where not all may support IRQ_REMAP. If that is the case be then should we check for IRQ-REMAP for that device-bus irq-domain?
>>
> I mentioned in the cover letter that the approach was defensive and
> rough today. As soon as we detect an MSI controller in the platform that
> has no support for MSI remapping we flag the assignment as unsafe. I
> think this approach was agreed on the ML. Such rough assessment was used
> in the past on x86.
> 
> I am reluctant to add more complexity at that stage. This can be
> improved latter I think when such platforms show up.

I don't think this is worth it. If the system is so broken that the
designer cannot make up their mind about device isolation, too bad.
People will either disable the non-isolating MSI controller altogether,
or force the unsafe flag.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
