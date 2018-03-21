From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 21 Mar 2018 13:40:13 +0000
Subject: [PATCH 37/37] vfio: Add support for Shared Virtual Addressing
In-Reply-To: <e3ae1693-0ed8-65e1-352a-07f79038dcbd@huawei.com>
References: <1519280641-30258-1-git-send-email-xieyisheng1@huawei.com>
 <1519280641-30258-37-git-send-email-xieyisheng1@huawei.com>
 <e3ae1693-0ed8-65e1-352a-07f79038dcbd@huawei.com>
Message-ID: <09ecbaf4-477c-1a06-4f37-523391e5b92e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/18 09:47, Yisheng Xie wrote:
> Hi Jean,
> 
> vfio can be compiled as module, however you use some functions which are not
> exported.

Oh right. I remember the kbuild test robot warning about this once, I
wonder why it didn't find this one.

> comment inline:
> 
> [...]
>> Add two new ioctl for VFIO containers. VFIO_IOMMU_BIND_PROCESS creates a
>> bond between a container and a process address space, identified by a
>> device-specific ID named PASID. This allows the device to target DMA
>> transactions at the process virtual addresses without a need for mapping
>> and unmapping buffers explicitly in the IOMMU. The process page tables are
>> shared with the IOMMU, and mechanisms such as PCI ATS/PRI are used to
>> handle faults. VFIO_IOMMU_UNBIND_PROCESS removes a bond created with
>> VFIO_IOMMU_BIND_PROCESS.
>>
>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>> ---
> [...]
>> +static struct mm_struct *vfio_iommu_get_mm_by_vpid(pid_t vpid)
>> +{
>> +	struct mm_struct *mm;
>> +	struct task_struct *task;
>> +
>> +	rcu_read_lock();
>> +	task = find_task_by_vpid(vpid);
> 
> Maybe can use?
> 	task = pid_task(find_vpid(params.vpid), PIDTYPE_PID)

I'd rather submit a patch requesting to export the symbol. Especially
since this function can be further simplified by using the brand new
find_get_task_by_vpid() helper, introduced by 2ee0826085d1.

>> +	if (task)
>> +		get_task_struct(task);
>> +	rcu_read_unlock();
>> +	if (!task)
>> +		return ERR_PTR(-ESRCH);
>> +
>> +	/* Ensure that current has RW access on the mm */
>> +	mm = mm_access(task, PTRACE_MODE_ATTACH_REALCREDS);
> 
> You will try to export mm_access, I find Felix have tried to, but seems give up:
> 
>  https://patchwork.kernel.org/patch/9744281/

Thanks for the pointer, I'll try to revive this.

Thanks,
Jean
