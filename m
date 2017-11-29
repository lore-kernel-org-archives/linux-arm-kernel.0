From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 29 Nov 2017 15:01:04 +0000
Subject: [RFCv2 PATCH 05/36] iommu/process: Bind and unbind process to and
 from devices
In-Reply-To: <9c364147-12c4-5a8a-9cd9-0642a6b92555@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-6-jean-philippe.brucker@arm.com>
 <9c364147-12c4-5a8a-9cd9-0642a6b92555@huawei.com>
Message-ID: <3338635f-f2ba-4b78-a72b-2568645f7df3@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/11/17 06:08, Yisheng Xie wrote:
> 
> 
> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>> +int iommu_process_bind_device(struct device *dev, struct task_struct *task,
>> +			      int *pasid, int flags)
>> +{
> [..]
>> +			err = iommu_process_attach_locked(context, dev);
>> +			if (err)
>> +				iommu_process_put_locked(process);
> one ref for a context is enough right? so also need call iommu_process_put_locked()
> if attach ok, or will be leak if user call bind twice for the same device and task.

I wasn't sure, I think I prefer taking one ref for each bind. If user
calls bind twice, it should call unbind twice as well (in case of leak we
free the context on process exit).

Also with this implementation, user can call bind for two devices in the
same domain, which will share the same context structure. So we have to
take as many refs as bind() calls.

Thanks,
Jean
