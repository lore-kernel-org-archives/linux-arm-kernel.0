From: santosh.shilimkar@ti.com (Santosh)
Date: Wed, 14 Sep 2011 14:23:54 +0530
Subject: [PATCH v2 1/2] ARM: cache-l2x0: remove __init annotation from
	initialization functions
In-Reply-To: <20110914084237.GC6267@n2100.arm.linux.org.uk>
References: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>	<1315288107-14689-2-git-send-email-shawn.guo@linaro.org>
	<20110914084237.GC6267@n2100.arm.linux.org.uk>
Message-ID: <4E706BA2.5060804@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 September 2011 02:12 PM, Russell King - ARM Linux wrote:
> On Tue, Sep 06, 2011 at 01:48:26PM +0800, Shawn Guo wrote:
>> If ARM core gets powered off during suspend, L2 cache controller
>> has to be reinitialized by resume procedure.
>>
>> The patch removes __init annotation from a few initialization
>> functions to make the reinitialization possible.  For example,
>> platform resume function can call l2x0_of_init() to get L2 cache
>> back to work.
>>
>> Signed-off-by: Shawn Guo<shawn.guo@linaro.org>
>> ---
>>   arch/arm/include/asm/hardware/cache-l2x0.h |    2 +-
>>   arch/arm/mm/cache-l2x0.c                   |   10 +++++-----
>>   2 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
>> index d22765c..d270310 100644
>> --- a/arch/arm/include/asm/hardware/cache-l2x0.h
>> +++ b/arch/arm/include/asm/hardware/cache-l2x0.h
>> @@ -89,7 +89,7 @@
>>   #define L2X0_ADDR_FILTER_EN		1
>>
>>   #ifndef __ASSEMBLY__
>> -extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
>> +extern void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
>>   #if defined(CONFIG_CACHE_L2X0)&&  defined(CONFIG_OF)
>>   extern int l2x0_of_init(__u32 aux_val, __u32 aux_mask);
>>   #else
>> diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
>> index c035b9a..7835cb6 100644
>> --- a/arch/arm/mm/cache-l2x0.c
>> +++ b/arch/arm/mm/cache-l2x0.c
>> @@ -280,7 +280,7 @@ static void l2x0_disable(void)
>>   	spin_unlock_irqrestore(&l2x0_lock, flags);
>>   }
>>
>> -void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>> +void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
>>   {
>>   	__u32 aux;
>>   	__u32 cache_id;
>
> I'm unconvinced about the wise-ness of this.  We read-modify-write the
> auxillary control register, which means some bits are preserved from
> the initial boot.  If the boot loader sets the L2 cache up for normal
> boot and not for resume, we'll end up with different L2 cache settings.
>
> We've historically seen this kind of thing with boot loaders over the
> years, to the point where systems boot at one CPU clock rate but resume
> at some other CPU clock rate.
>
> So, it may be wiser to implement a 'save' and 'restore' interface
> instead so that we can be sure that things are setup in the same way
> after resume.
>
I agree with Russell and has same concern when I commented on V1 of this
patch.

As mentioned earlier, you need to save only once since non of the L2
configuration values will change. So 'save ones' and 'restore always
when context lost' should be the right way to go about it.

Regards
Santosh
