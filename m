From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Fri, 25 May 2018 10:47:43 +0100
Subject: [PATCH v2 13/40] vfio: Add support for Shared Virtual Addressing
In-Reply-To: <5B077765.30703@huawei.com>
References: <20180511190641.23008-1-jean-philippe.brucker@arm.com>
 <20180511190641.23008-14-jean-philippe.brucker@arm.com>
 <5B0536A3.1000304@huawei.com> <cd13f60d-b282-3804-4ca7-2d34476c597f@arm.com>
 <5B06B17C.1090809@huawei.com> <205c1729-8026-3efe-c363-d37d7150d622@arm.com>
 <5B077765.30703@huawei.com>
Message-ID: <fea420ff-e738-e2ed-ab1e-a3f4dde4b6ef@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25/05/18 03:39, Xu Zaibo wrote:
> Hi,
> 
> On 2018/5/24 23:04, Jean-Philippe Brucker wrote:
>> On 24/05/18 13:35, Xu Zaibo wrote:
>>>> Right, sva_init() must be called once for any device that intends to use
>>>> bind(). For the second process though, group->sva_enabled will be true
>>>> so we won't call sva_init() again, only bind().
>>> Well, while I create mediated devices based on one parent device to support multiple
>>> processes(a new process will create a new 'vfio_group' for the corresponding mediated device,
>>> and 'sva_enabled' cannot work any more), in fact, *sva_init and *sva_shutdown are basically
>>> working on parent device, so, as a result, I just only need sva initiation and shutdown on the
>>> parent device only once. So I change the two as following:
>>>
>>> @@ -551,8 +565,18 @@ int iommu_sva_device_init(struct device *dev, unsigned long features,
>>>        if (features & ~IOMMU_SVA_FEAT_IOPF)
>>>           return -EINVAL;
>>>
>>> +    /* If already exists, do nothing  */
>>> +    mutex_lock(&dev->iommu_param->lock);
>>> +    if (dev->iommu_param->sva_param) {
>>> +        mutex_unlock(&dev->iommu_param->lock);
>>> +        return 0;
>>> +    }
>>> +    mutex_unlock(&dev->iommu_param->lock);
>>>
>>>       if (features & IOMMU_SVA_FEAT_IOPF) {
>>>           ret = iommu_register_device_fault_handler(dev, iommu_queue_iopf,
>>>
>>>
>>> @@ -621,6 +646,14 @@ int iommu_sva_device_shutdown(struct device *dev)
>>>       if (!domain)
>>>           return -ENODEV;
>>>
>>> +    /* If any other process is working on the device, shut down does nothing. */
>>> +    mutex_lock(&dev->iommu_param->lock);
>>> +    if (!list_empty(&dev->iommu_param->sva_param->mm_list)) {
>>> +        mutex_unlock(&dev->iommu_param->lock);
>>> +        return 0;
>>> +    }
>>> +    mutex_unlock(&dev->iommu_param->lock);
>> I don't think iommu-sva.c is the best place for this, it's probably
>> better to implement an intermediate layer (the mediating driver), that
>> calls iommu_sva_device_init() and iommu_sva_device_shutdown() once. Then
>> vfio-pci would still call these functions itself, but for mdev the
>> mediating driver keeps a refcount of groups, and calls device_shutdown()
>> only when freeing the last mdev.
>>
>> A device driver (non mdev in this example) expects to be able to free
>> all its resources after sva_device_shutdown() returns. Imagine the
>> mm_list isn't empty (mm_exit() is running late), and instead of waiting
>> in unbind_dev_all() below, we return 0 immediately. Then the calling
>> driver frees its resources, and the mm_exit callback along with private
>> data passed to bind() disappear. If a mm_exit() is still running in
>> parallel, then it will try to access freed data and corrupt memory. So
>> in this function if mm_list isn't empty, the only thing we can do is wait.
>>
> I still don't understand why we should 'unbind_dev_all', is it possible 
> to do a 'unbind_dev_pasid'?

Not in sva_device_shutdown(), it needs to clean up everything. For
example you want to physically unplug the device, or assign it to a VM.
To prevent any leak sva_device_shutdown() needs to remove all bonds. In
theory there shouldn't be any, since either the driver did unbind_dev(),
or all process exited. This is a safety net.

> Then we can do other things instead of waiting that user may not like. :)

They may not like it, but it's for their own good :) At the moment we're
waiting that:

* All exit_mm() callback for this device have finished. If we don't wait
  then the caller will free the private data passed to bind and the
  mm_exit() callback while they are still being used.

* All page requests targeting this device are dealt with. If we don't
  wait then some requests, that are lingering in the IOMMU PRI queue,
  may hit the next contexts bound to this device, possibly in a
  different VM. It may not be too risky (though probably exploitable in
  some way), but is incredibly messy.

All of this is bounded in time, and normally should be over pretty fast
unless the device driver's exit_mm() does something strange. If the
driver did the right thing, there shouldn't be any wait here (although
there may be one in unbind_dev() for the same reasons - prevent use
after free).

Thanks,
Jean
