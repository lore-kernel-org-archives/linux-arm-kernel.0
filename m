From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Wed, 29 Nov 2017 15:01:00 +0000
Subject: [RFCv2 PATCH 09/36] iommu/fault: Allow blocking fault handlers
In-Reply-To: <7e1c8ea4-e568-1000-17de-62f8562c7169@huawei.com>
References: <20171006133203.22803-1-jean-philippe.brucker@arm.com>
 <20171006133203.22803-10-jean-philippe.brucker@arm.com>
 <7e1c8ea4-e568-1000-17de-62f8562c7169@huawei.com>
Message-ID: <74891e35-17d8-5831-1ebd-18e00ce00d74@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 29/11/17 06:15, Yisheng Xie wrote:
> Hi Jean,
> 
> On 2017/10/6 21:31, Jean-Philippe Brucker wrote:
>> -	if (domain->ext_handler) {
>> +	if (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) {
>> +		fault->flags |= IOMMU_FAULT_ATOMIC;
> 
> Why remove the condition of domain->ext_handler? should it be much better like:
>   if ((domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC) && domain->ext_handler)
> 
> If domain->ext_handler is NULL, and (domain->handler_flags & IOMMU_FAULT_HANDLER_ATOMIC)
> is true. It will oops, right?

I removed the check because ext_handler shouldn't be NULL if handler_flags
has a bit set (as per iommu_set_ext_fault_handler). But you're right that
this is fragile, and I overlooked the case where users could call
set_ext_fault_handler to clear the fault handler.

(Note that this ext_handler will most likely be replaced by the fault
infrastructure that Jacob is working on:
https://patchwork.kernel.org/patch/10063385/ to which we should add the
atomic/blocking flags)

Thanks,
Jean
