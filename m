From: shankerd@codeaurora.org (Shanker Donthineni)
Date: Sat, 7 Oct 2017 07:59:47 -0500
Subject: [PATCH] irqchip/gicv3-its: Add missing changes to support 52bit
 physical address
In-Reply-To: <867ew7mg81.fsf@arm.com>
References: <1507353204-28808-1-git-send-email-shankerd@codeaurora.org>
 <867ew7mg81.fsf@arm.com>
Message-ID: <1b61de4e-b1df-798a-a973-3275dbc96886@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc, 

Thanks for your quick review comments.

On 10/07/2017 04:58 AM, Marc Zyngier wrote:
> On Sat, Oct 07 2017 at 12:13:24 am BST, Shanker Donthineni <shankerd@codeaurora.org> wrote:
>> The current ITS driver works fine as long as normal memory and GICR
>> regions are located within the lower 48bit (>=0 && <2^48) physical
>> address space. Some of the registers GICR_PEND/PROP, GICR_VPEND/VPROP
>> and GITS_CBASER are handled properly but not all when configuring
>> the hardware with 52bit physical address.
>>
>> This patch does the following changes to support 52bit PA.
>>   -Handle 52bit PA in GITS_BASERn.
>>   -Fix ITT_addr width to 52bits, bits[51:8].
>>   -Fix RDbase width to 52bits, bits[51:16].
>>   -Fix VPT_addr width to 52bits, bits[51:16].
>>
>> Definition of the GITS_BASERn register when ITS PageSize is 64KB:
>>  -Bits[47:16] of the register provide bits[47:16] of the table PA.
>>  -Bits[15:12] of the register provide bits[51:48] of the table PA.
>>  -Bits[15:00] of the base physical address are 0.
>>
>> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
>> ---
>>  drivers/irqchip/irq-gic-v3-its.c   | 24 +++++++++++++++++++-----
>>  include/linux/irqchip/arm-gic-v3.h |  3 +++
>>  2 files changed, 22 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
>> index e8d8934..e52c0da 100644
>> --- a/drivers/irqchip/irq-gic-v3-its.c
>> +++ b/drivers/irqchip/irq-gic-v3-its.c
>> @@ -308,7 +308,7 @@ static void its_encode_size(struct its_cmd_block *cmd, u8 size)
>>  
>>  static void its_encode_itt(struct its_cmd_block *cmd, u64 itt_addr)
>>  {
>> -	its_mask_encode(&cmd->raw_cmd[2], itt_addr >> 8, 50, 8);
>> +	its_mask_encode(&cmd->raw_cmd[2], itt_addr >> 8, 51, 8);
>>  }
>>  
>>  static void its_encode_valid(struct its_cmd_block *cmd, int valid)
>> @@ -318,7 +318,7 @@ static void its_encode_valid(struct its_cmd_block *cmd, int valid)
>>  
>>  static void its_encode_target(struct its_cmd_block *cmd, u64 target_addr)
>>  {
>> -	its_mask_encode(&cmd->raw_cmd[2], target_addr >> 16, 50, 16);
>> +	its_mask_encode(&cmd->raw_cmd[2], target_addr >> 16, 51, 16);
>>  }
>>  
>>  static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
>> @@ -358,7 +358,7 @@ static void its_encode_its_list(struct its_cmd_block *cmd, u16 its_list)
>>  
>>  static void its_encode_vpt_addr(struct its_cmd_block *cmd, u64 vpt_pa)
>>  {
>> -	its_mask_encode(&cmd->raw_cmd[3], vpt_pa >> 16, 50, 16);
>> +	its_mask_encode(&cmd->raw_cmd[3], vpt_pa >> 16, 51, 16);
>>  }
>>  
>>  static void its_encode_vpt_size(struct its_cmd_block *cmd, u8 vpt_size)
>> @@ -1478,9 +1478,9 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>>  	u64 val = its_read_baser(its, baser);
>>  	u64 esz = GITS_BASER_ENTRY_SIZE(val);
>>  	u64 type = GITS_BASER_TYPE(val);
>> +	u64 baser_phys, tmp;
>>  	u32 alloc_pages;
>>  	void *base;
>> -	u64 tmp;
>>  
>>  retry_alloc_baser:
>>  	alloc_pages = (PAGE_ORDER_TO_SIZE(order) / psz);
>> @@ -1496,8 +1496,22 @@ static int its_setup_baser(struct its_node *its, struct its_baser *baser,
>>  	if (!base)
>>  		return -ENOMEM;
>>  
>> +	baser_phys = virt_to_phys(base);
>> +
>> +	/* Check if the physical address of the memory is above 48bits */
>> +	if (baser_phys & (~GITS_BASER_PHYS_MASK)) {
>> +		/* 52bit PA is supported only when PageSize=64K */
>> +		if (psz != SZ_64K) {
>> +			free_pages((unsigned long)base, order);
>> +			return -EFAULT;
>> +		}
>> +
>> +		/* Convert 52bit PA to 48bit field */
>> +		baser_phys = GITS_BASER_64K_PHYS(baser_phys);
>> +	}
> 
> I'm not sure this is completely right. What guarantees that the memory
> you get is 64kB aligned? Your initial masking will do the wrong thing on
> a system with 16kB pages, and everything will break from that point on,
> as you're confusing the ITS page size with the CPU page size.
> 

The first is check right, and the intention was to find out the upper bits
of the PA (bits[51:12]) have non-zero value irrespective of PS 64K/16K/4KB.

#define GITS_BASER_PHYS_MASK		GENMASK_ULL(47, 12)    

(baser_phys & (~GITS_BASER_PHYS_MASK)) becomes (baser_phys & 0xFFFF 0000 0000 0000)

We program GITS_BASERn PageSize based on 'psz' value.

However the current code has a hidden bug, we assume memory allocation is aligned
on 64K/16K when the ITS PageSize (variable of 'psz') is 64K/16K. We have two options
to solve the problem.

 -fall-baclk to a lower ITS PageSize if the memory size is lower than 'psz'.
 -allocate minimum of 64K for all BASERn tables.


 Something like using the second method.

  retry_alloc_baser:
     alloc_pages = (min(PAGE_ORDER_TO_SIZE(order), 64K) / psz);

  ....

     baser_phys = virt_to_phys(base);
 
     /* Check if the physical address of the memory is above 48bits */
     if (baser_phys & (~GITS_BASER_PHYS_MASK)) {
         /* 52bit PA is supported only when PageSize=64K */
         if (psz != SZ_64K) {
              free_pages((unsigned long)base, order);
              return -EFAULT;
         }
 
         /* Convert 52bit PA to 48bit field */
         baser_phys = GITS_BASER_64K_PHYS(baser_phys);
     }


> This probably wants to be predicated with a 64kB CPU page size (which is
> the only valid configuration for 52bit PA anyway).
> 
> Thanks,
> 
> 	M.
> 

-- 
Shanker Donthineni
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
