From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 11 Dec 2017 09:19:42 +0000
Subject: [PATCH] KVM: arm/arm64: Fix HYP unmapping going off limits
In-Reply-To: <20171211090520.GC910@cbox>
References: <20171207114545.23845-1-marc.zyngier@arm.com>
 <20171211090520.GC910@cbox>
Message-ID: <61a6f0bd-cdfc-e569-6289-b969b80a1f2f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/12/17 09:05, Christoffer Dall wrote:
> On Thu, Dec 07, 2017 at 11:45:45AM +0000, Marc Zyngier wrote:
>> When we unmap the HYP memory, we try to be clever and unmap one
>> PGD at a time. If we start with a non-PGD aligned address and try
>> to unmap a whole PGD, things go horribly wrong in unmap_hyp_range
>> (addr and end can never match, and it all goes really badly as we
>> keep incrementing pgd and parse random memory as page tables...).
>>
>> The obvious fix is to let unmap_hyp_range do what it does best,
>> which is to iterate over a range.
> 
> Would you mind terribly if I add the following to the commit message?
> 
>   The size of the linear mapping, which begins at PAGE_OFFSET, can be
>   easily calculated by subtracting PAGE_OFFSET form high_memory, because
>   high_memory is defined as the linear map address of the last byte of
>   DRAM, plus one.
>   
>   The size of the vmalloc region is given trivially by VMALLOC_END -
>   VMALLOC_START.

Please do!

> Otherwise:
> 
> Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
