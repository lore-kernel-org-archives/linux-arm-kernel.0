From: phil@raspberrypi.org (Phil Elwell)
Date: Wed, 7 Mar 2018 08:02:49 +0000
Subject: [PATCH 2/5] staging: vc04_services: Remove cache-line-size
 property.
In-Reply-To: <87muzl9ger.fsf@anholt.net>
References: <20180305202806.21219-1-eric@anholt.net>
 <20180305202806.21219-3-eric@anholt.net>
 <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com> <87muzl9ger.fsf@anholt.net>
Message-ID: <638bd870-bb17-a0e1-d2aa-30a364b53279@raspberrypi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 06/03/2018 19:02, Eric Anholt wrote:
> Stefan Wahren <stefan.wahren@i2se.com> writes:
> 
>> Hi Eric,
>>
>>
>> Am 05.03.2018 um 21:28 schrieb Eric Anholt:
>>> This was just a way for the DT-passed value to get out of sync with
>>> what Linux has configured the ARM for.
>>>
>>> Signed-off-by: Eric Anholt <eric@anholt.net>
>>> ---
>>>    .../interface/vchiq_arm/vchiq_2835_arm.c           | 25 +++++++---------------
>>>    .../interface/vchiq_arm/vchiq_pagelist.h           |  1 -
>>>    2 files changed, 8 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>>> index b59ef14890aa..e0e01c812036 100644
>>> --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>>> +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_2835_arm.c
>>> @@ -77,7 +77,6 @@ struct vchiq_pagelist_info {
>>>    };
>>>    
>>>    static void __iomem *g_regs;
>>> -static unsigned int g_cache_line_size = sizeof(CACHE_LINE_SIZE);
>>>    static unsigned int g_fragments_size;
>>>    static char *g_fragments_base;
>>>    static char *g_free_fragments;
>>> @@ -117,15 +116,7 @@ int vchiq_platform_init(struct platform_device *pdev, VCHIQ_STATE_T *state)
>>>    	if (err < 0)
>>>    		return err;
>>>    
>>> -	err = of_property_read_u32(dev->of_node, "cache-line-size",
>>> -				   &g_cache_line_size);
>>> -
>>> -	if (err) {
>>> -		dev_err(dev, "Missing cache-line-size property\n");
>>> -		return -ENODEV;
>>> -	}
>>> -
>>> -	g_fragments_size = 2 * g_cache_line_size;
>>> +	g_fragments_size = 2 * cache_line_size();
>>>    
>>>    	/* Allocate space for the channels in coherent memory */
>>>    	slot_mem_size = PAGE_ALIGN(TOTAL_SLOTS * VCHIQ_SLOT_SIZE);
>>> @@ -548,9 +539,9 @@ create_pagelist(char __user *buf, size_t count, unsigned short type)
>>>    
>>>    	/* Partial cache lines (fragments) require special measures */
>>>    	if ((type == PAGELIST_READ) &&
>>> -		((pagelist->offset & (g_cache_line_size - 1)) ||
>>> +		((pagelist->offset & (cache_line_size() - 1)) ||
>>>    		((pagelist->offset + pagelist->length) &
>>> -		(g_cache_line_size - 1)))) {
>>> +		 (cache_line_size() - 1)))) {
>>>    		char *fragments;
>>>    
>>>    		if (down_interruptible(&g_free_fragments_sema) != 0) {
>>> @@ -598,10 +589,10 @@ free_pagelist(struct vchiq_pagelist_info *pagelistinfo,
>>>    			g_fragments_size;
>>>    		int head_bytes, tail_bytes;
>>>    
>>> -		head_bytes = (g_cache_line_size - pagelist->offset) &
>>> -			(g_cache_line_size - 1);
>>> +		head_bytes = (cache_line_size() - pagelist->offset) &
>>> +			(cache_line_size() - 1);
>>>    		tail_bytes = (pagelist->offset + actual) &
>>> -			(g_cache_line_size - 1);
>>> +			(cache_line_size() - 1);
>>
>> should it be so easy? Back in 2016 we said that cache_line_size() won't
>> work. I always thought that we need the cache line size of L2 not of the
>> L1 one.
>>
>> Did you already test the behavior for these combinations?
>> BCM2835 ARM32, expected cache line size = 32
>> BCM2836 ARM32, expected cache line size = 64
>> BCM2837 ARM32, expected cache line size = 64
>> BCM2837 ARM64, expected cache line size = 64
> 
> I didn't explicitly test, but was going by:
> 
> config ARM_L1_CACHE_SHIFT_6
> 	bool
> 	default y if CPU_V7
> 	help
> 	  Setting ARM L1 cache line size to 64 Bytes.
> 
> config ARM_L1_CACHE_SHIFT_7
> 	bool
> 	help
> 	  Setting ARM L1 cache line size to 128 Bytes.
> 
> config ARM_L1_CACHE_SHIFT
> 	int
> 	default 7 if ARM_L1_CACHE_SHIFT_7
> 	default 6 if ARM_L1_CACHE_SHIFT_6
> 	default 5
> 
> and only L1_CACHE_SHIFT_7 gets selected by UNIPHIER and neither one is
> accessible by menus.
> 
> I think you're technically correct that it's the size of L2 that matters
> (or, specifically, the hardcoded value that the firmware is using on its
> side for the fragments list handling.  It overrides a cache-line-size DT
> property with that number if present).  However, I think L1==L2 cache
> line size this should be a safe assumption for us.
> 
> Phil, any opinion?

It is the L2 cache line size that matters, but as long as you end up with
the numbers Stefan mentioned - 32 on BCM2835, 64 on BCM2836 and BCM2837 -
I'm not too bothered how you get there.

Phil
