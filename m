From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 28 Feb 2018 16:25:37 +0000
Subject: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
In-Reply-To: <1e76c66c-952e-71bd-d831-d3a1ded9559c@codeaurora.org>
References: <20180212183352.22730-1-jean-philippe.brucker@arm.com>
 <20180212183352.22730-38-jean-philippe.brucker@arm.com>
 <1e76c66c-952e-71bd-d831-d3a1ded9559c@codeaurora.org>
Message-ID: <e428976f-c381-309a-be57-264fea5c9b18@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/02/18 01:26, Sinan Kaya wrote:
[...]
>> +static int vfio_iommu_sva_init(struct device *dev, void *data)
>> +{
> 
> data is not getting used.

That's the pointer passed to "iommu_group_for_each_dev", NULL at the
moment. Next version of this patch will keep some state in data to
ensure one device per group.

>> +
>> +	int ret;
>> +
>> +	ret = iommu_sva_device_init(dev, IOMMU_SVA_FEAT_PASID |
>> +				    IOMMU_SVA_FEAT_IOPF, 0);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return iommu_register_mm_exit_handler(dev, vfio_iommu_mm_exit);
>> +}
>> +
>> +static int vfio_iommu_sva_shutdown(struct device *dev, void *data)
>> +{
>> +	iommu_sva_device_shutdown(dev);
>> +	iommu_unregister_mm_exit_handler(dev);
>> +
>> +	return 0;
>> +}
>> +
>> +static int vfio_iommu_bind_group(struct vfio_iommu *iommu,
>> +				 struct vfio_group *group,
>> +				 struct vfio_mm *vfio_mm)
>> +{
>> +	int ret;
>> +	int pasid;
>> +
>> +	if (!group->sva_enabled) {
>> +		ret = iommu_group_for_each_dev(group->iommu_group, NULL,
>> +					       vfio_iommu_sva_init);
>> +		if (ret)
>> +			return ret;
>> +
>> +		group->sva_enabled = true;
>> +	}
>> +
>> +	ret = iommu_sva_bind_group(group->iommu_group, vfio_mm->mm, &pasid,
>> +				   IOMMU_SVA_FEAT_PASID | IOMMU_SVA_FEAT_IOPF,
>> +				   vfio_mm);
>> +	if (ret)
>> +		return ret;
> 
> don't you need to clean up the work done by vfio_iommu_sva_init() here.

Yes I suppose we can, if we enabled during this bind

[...]
>> +static long vfio_iommu_type1_bind_process(struct vfio_iommu *iommu,
>> +					  void __user *arg,
>> +					  struct vfio_iommu_type1_bind *bind)
>> +{
>> +	struct vfio_iommu_type1_bind_process params;
>> +	struct vfio_domain *domain;
>> +	struct vfio_group *group;
>> +	struct vfio_mm *vfio_mm;
>> +	struct mm_struct *mm;
>> +	unsigned long minsz;
>> +	int ret = 0;
>> +
>> +	minsz = sizeof(*bind) + sizeof(params);
>> +	if (bind->argsz < minsz)
>> +		return -EINVAL;
>> +
>> +	arg += sizeof(*bind);
>> +	if (copy_from_user(&params, arg, sizeof(params)))
>> +		return -EFAULT;
>> +
>> +	if (params.flags & ~VFIO_IOMMU_BIND_PID)
>> +		return -EINVAL;
>> +
>> +	if (params.flags & VFIO_IOMMU_BIND_PID) {
>> +		mm = vfio_iommu_get_mm_by_vpid(params.pid);
>> +		if (IS_ERR(mm))
>> +			return PTR_ERR(mm);
>> +	} else {
>> +		mm = get_task_mm(current);
>> +		if (!mm)
>> +			return -EINVAL;
>> +	}
> 
> I think you can merge mm failure in both states.

Yes, I think vfio_iommu_get_mm_by_vpid could return NULL instead of an
error pointer, and we can throw -ESRCH in all cases (the existing
get_task_mm() failure in this driver does return -ESRCH, so it would be
consistent.)

[...]
>> +	/*
>> +	 * We can't simply unbind a foreign process by PASID, because the
>> +	 * process might have died and the PASID might have been reallocated to
>> +	 * another process. Instead we need to fetch that process mm by PID
>> +	 * again to make sure we remove the right vfio_mm. In addition, holding
>> +	 * the mm guarantees that mm_users isn't dropped while we unbind and the
>> +	 * exit_mm handler doesn't fire. While not strictly necessary, not
>> +	 * having to care about that race simplifies everyone's life.
>> +	 */
>> +	if (params.flags & VFIO_IOMMU_BIND_PID) {
>> +		mm = vfio_iommu_get_mm_by_vpid(params.pid);
>> +		if (IS_ERR(mm))
>> +			return PTR_ERR(mm);
>> +	} else {
>> +		mm = get_task_mm(current);
>> +		if (!mm)
>> +			return -EINVAL;
>> +	}
>> +
> 
> I think you can merge mm failure in both states.

ok

>> +	ret = -ESRCH;
>> +	mutex_lock(&iommu->lock);
>> +	list_for_each_entry(vfio_mm, &iommu->mm_list, next) {
>> +		if (vfio_mm->mm != mm)
>> +			continue;
>> +
> 
> these loops look wierd 
> 1. for loops + break 
> 2. for loops + goto
> 
> how about closing the for loop here. and then return here if not vfio_mm
> not found.

ok

>> +		vfio_iommu_unbind(iommu, vfio_mm);
>> +		list_del(&vfio_mm->next);
>> +		kfree(vfio_mm);
>> +		ret = 0;
>> +		break;
>> +	}
>> +	mutex_unlock(&iommu->lock);
>> +	mmput(mm);
>> +
>> +	return ret;
>> +}
>> +
> 

Thanks,
Jean
