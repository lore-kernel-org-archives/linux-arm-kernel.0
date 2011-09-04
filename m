From: santosh.shilimkar@ti.com (Santosh)
Date: Sun, 04 Sep 2011 17:54:27 +0530
Subject: [PATCH] ARM: l2x0: make sure I&D are not locked down on init
In-Reply-To: <20110904120925.GB17180@e102144-lin.cambridge.arm.com>
References: <1315126872-3290-1-git-send-email-linus.walleij@stericsson.com>
	<4E634F59.1010207@ti.com>
	<20110904120925.GB17180@e102144-lin.cambridge.arm.com>
Message-ID: <4E636DFB.1070001@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 04 September 2011 05:39 PM, Will Deacon wrote:
> Hi Santosh,
>
> On Sun, Sep 04, 2011 at 11:13:45AM +0100, Santosh wrote:
>> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h
>> b/arch/arm/include/asm/hardware/cache-l2x0.h
>> index 16bd480..e04e947 100644
>> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
>> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
>> @@ -45,8 +45,10 @@
>>    #define L2X0_CLEAN_INV_LINE_PA		0x7F0
>>    #define L2X0_CLEAN_INV_LINE_IDX		0x7F8
>>    #define L2X0_CLEAN_INV_WAY		0x7FC
>> -#define L2X0_LOCKDOWN_WAY_D		0x900
>> -#define L2X0_LOCKDOWN_WAY_I		0x904
>> +#define L2X0_LOCKDOWN_WAY_D0		0x900
>> +#define L2X0_LOCKDOWN_WAY_D1		0x908
>> +#define L2X0_LOCKDOWN_WAY_I0		0x904
>> +#define L2X0_LOCKDOWN_WAY_I1		0x90C
>
> Maybe you could macroify these to take the CPU number as an argument?
>
Should work as well.

>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index 44c0867..f95b269 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -322,6 +322,12 @@ void __init l2x0_init(void __iomem *base, __u32
>> aux_val, __u32 aux_mask)
>>    	way_size = 1<<  (way_size + 3);
>>    	l2x0_size = ways * way_size * SZ_1K;
>>
>> +	/* Clear the I and D lock-down way registers */
>> +	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D0);
>> +	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_D1);
>> +	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I0);
>> +	writel_relaxed(0x0, l2x0_base + L2X0_LOCKDOWN_WAY_I1);
>
> Then you could write this as a for loop from 0 to 7 for the PL310. For
> L210/220 I think there's just a single register pair.
>
Pl310 data is what I know and you are right.
Loop is good idea considering we just want to clear
them and not set any specific values.

Regards
Santosh
