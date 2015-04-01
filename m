From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 01 Apr 2015 14:20:38 +0200
Subject: [RFC v5 06/13] VFIO: platform: add
 vfio_external_{mask|is_active|set_automasked}
In-Reply-To: <1427822405.5567.163.camel@redhat.com>
References: <1426776951-24901-1-git-send-email-eric.auger@linaro.org>	
 <1426776951-24901-7-git-send-email-eric.auger@linaro.org>
 <1427822405.5567.163.camel@redhat.com>
Message-ID: <551BE296.2080509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/31/2015 07:20 PM, Alex Williamson wrote:
> On Thu, 2015-03-19 at 15:55 +0100, Eric Auger wrote:
>> Introduces 3 new external functions aimed at doining some actions
>> on VFIO platform devices:
>> - mask a VFIO IRQ
>> - get the active status of a VFIO IRQ (active at interrupt
>>   controller level or masked by the level-sensitive automasking).
>> - change the automasked property and the VFIO handler
>>
>> Note there is no way to discriminate between user-space
>> masking and automasked handler masking. As a consequence, is_active
>> will return true in case the IRQ was masked by the user-space.
>>
>> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>>
>> ---
>>
>> V4: creation
>> ---
>>  drivers/vfio/platform/vfio_platform_irq.c | 43 +++++++++++++++++++++++++++++++
>>  include/linux/vfio.h                      | 14 ++++++++++
>>  2 files changed, 57 insertions(+)
>>
>> diff --git a/drivers/vfio/platform/vfio_platform_irq.c b/drivers/vfio/platform/vfio_platform_irq.c
>> index 8eb65c1..49994cb 100644
>> --- a/drivers/vfio/platform/vfio_platform_irq.c
>> +++ b/drivers/vfio/platform/vfio_platform_irq.c
>> @@ -231,6 +231,49 @@ static int vfio_set_trigger(struct vfio_platform_device *vdev, int index,
>>  	return 0;
>>  }
>>  
>> +void vfio_external_mask(struct vfio_platform_device *vdev, int index)
>> +{
>> +	vfio_platform_mask(&vdev->irqs[index]);
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_external_mask);
>> +
>> +bool vfio_external_is_active(struct vfio_platform_device *vdev, int index)
>> +{
>> +	unsigned long flags;
>> +	struct vfio_platform_irq *irq = &vdev->irqs[index];
>> +	bool active, masked, outstanding;
>> +	int ret;
>> +
>> +	spin_lock_irqsave(&irq->lock, flags);
>> +
>> +	ret = irq_get_irqchip_state(irq->hwirq, IRQCHIP_STATE_ACTIVE, &active);
>> +	BUG_ON(ret);
>> +	masked = irq->masked;
>> +	outstanding = active || masked;
>> +
>> +	spin_unlock_irqrestore(&irq->lock, flags);
>> +	return outstanding;
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_external_is_active);
>> +
>> +void vfio_external_set_automasked(struct vfio_platform_device *vdev,
>> +				  int index, bool automasked)
>> +{
>> +	unsigned long flags;
>> +	struct vfio_platform_irq *irq = &vdev->irqs[index];
>> +
>> +	spin_lock_irqsave(&irq->lock, flags);
>> +	if (automasked) {
>> +		irq->flags |= VFIO_IRQ_INFO_AUTOMASKED;
>> +		irq->handler = vfio_automasked_irq_handler;
>> +	} else {
>> +		irq->flags &= ~VFIO_IRQ_INFO_AUTOMASKED;
>> +		irq->handler = vfio_irq_handler;
>> +	}
>> +	spin_unlock_irqrestore(&irq->lock, flags);
>> +}
>> +EXPORT_SYMBOL_GPL(vfio_external_set_automasked);
>> +
> 
> 
> This is where the abstraction breaks down.  These are
> vfio_external_foo() interfaces, yet they assume a specific type of
> device, a vfio platform device.  Either the name should reflect that or
> they should be hosted in vfio-core with a callout to the device specific
> implementations.  Can we make kvm-vfio deal only in struct vfio_device
> and struct device?

Hi Alex,

I will follow your guidelines and intend to extend vfio_platform_ops to
store those new callbacks. Indeed kvm-vfio should be able to be
vfio_platform_device independent.

Thank you for the review.

Best Regards

Eric
> 
>>  static int vfio_platform_set_irq_trigger(struct vfio_platform_device *vdev,
>>  					 unsigned index, unsigned start,
>>  					 unsigned count, uint32_t flags,
>> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
>> index b18c38f..7aa6330 100644
>> --- a/include/linux/vfio.h
>> +++ b/include/linux/vfio.h
>> @@ -105,6 +105,20 @@ extern struct vfio_device *vfio_device_get_external_user(struct file *filep);
>>  extern void vfio_device_put_external_user(struct vfio_device *vdev);
>>  extern struct device *vfio_external_base_device(struct vfio_device *vdev);
>>  
>> +struct vfio_platform_device;
>> +extern void vfio_external_mask(struct vfio_platform_device *vdev, int index);
>> +/*
>> + * returns whether the VFIO IRQ is active:
>> + * true if not yet deactivated at interrupt controller level or if
>> + * automasked (level sensitive IRQ). Unfortunately there is no way to
>> + * discriminate between handler auto-masking and user-space masking
>> + */
>> +extern bool vfio_external_is_active(struct vfio_platform_device *vdev,
>> +				    int index);
>> +
>> +extern void vfio_external_set_automasked(struct vfio_platform_device *vdev,
>> +					 int index, bool automasked);
>> +
>>  struct pci_dev;
>>  #ifdef CONFIG_EEH
>>  extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
> 
> 
> 
