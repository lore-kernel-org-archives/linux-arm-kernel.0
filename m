From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 26 Aug 2015 18:10:53 +0100
Subject: [PATCH 1/1] irqchip: imx-gpcv2:  Simplify the implemenation
In-Reply-To: <CY1PR0301MB0843D36145639EB35E956CA383600@CY1PR0301MB0843.namprd03.prod.outlook.com>
References: <1440604166-2624-1-git-send-email-shenwei.wang@freescale.com>
 <55DDE56E.2040206@arm.com>
 <CY1PR0301MB0843D36145639EB35E956CA383600@CY1PR0301MB0843.namprd03.prod.outlook.com>
Message-ID: <55DDF31D.2030702@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 26/08/15 17:44, Shenwei Wang wrote:
>
>
>> -----Original Message-----
>> From: Sudeep Holla [mailto:sudeep.holla at arm.com]
>> Sent: 2015?8?26? 11:13
>> To: Wang Shenwei-B38339; jason at lakedaemon.net
>> Cc: shawn.guo at linaro.org; tglx at linutronix.de; Sudeep Holla;
>> linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; Huang
>> Yongcai-B20788
>> Subject: Re: [PATCH 1/1] irqchip: imx-gpcv2: Simplify the implemenation
>>
>> typo in $subject
>
> Just noticed. Will change it.
>
>> On 26/08/15 16:49, Shenwei Wang wrote:
>>> Based on Sudeep Holla's review comments, the implementation can be
>>> simplified by using the two flags: IRQCHIP_SKIP_SET_WAKE and
>>> IRQCHIP_MASK_ON_SUSPEND. This patch enables the flags in the struct
>>> irq_chip and removes the unnecessory syscore_ops callbacks.
>>>
>>> Signed-off-by: Shenwei Wang <shenwei.wang@freescale.com>
>>> ---
>>>    drivers/irqchip/irq-imx-gpcv2.c | 83 +++++++----------------------------------
>>>    1 file changed, 13 insertions(+), 70 deletions(-)
>>>
>>> diff --git a/drivers/irqchip/irq-imx-gpcv2.c
>>> b/drivers/irqchip/irq-imx-gpcv2.c index 4a97afa..e25df78 100644
>>> --- a/drivers/irqchip/irq-imx-gpcv2.c
>>> +++ b/drivers/irqchip/irq-imx-gpcv2.c
>>> @@ -22,7 +22,6 @@ struct gpcv2_irqchip_data {
>>>    	struct raw_spinlock    rlock;
>>>    	void __iomem       *gpc_base;
>>>    	u32 wakeup_sources[IMR_NUM];
>>> -	u32 saved_irq_mask[IMR_NUM];
>>>    	u32 cpu2wakeup;
>>>    };
>>>
>>> @@ -30,79 +29,25 @@ static struct gpcv2_irqchip_data
>>> *imx_gpcv2_instance;
>>>
>>>    u32 imx_gpcv2_get_wakeup_source(u32 **sources)
>>
>> I assume this patch is against -next and I don't see any users of
>> imx_gpcv2_get_wakeup_source in -next.
>>
>> If possible I would avoid exposing this function by implementing suspend_ops just
>> as before(just saving raw h/w reg values and restoring then back on resume w/o
>> tagging them as wakeup mask though they might be indeed wakeup mask).
>>
>> In that way, this driver is self-contained and whatever imx code calls this function
>> will not have dependency on this driver, no ? Do you need access to
>> imx_gpcv2_get_wakeup_source too early in resume much before suspend_ops
>> resume ? I would like to see the user of that function to comment on that any
>> further.
>
> It is linux-next. The user is in the following patch which is under review.
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-July/361388.html
>

I got lost trying to follow through that 1000 odd line of code with lots
of register accesses. I couldn't understand much, so I gave up.

Such details are abstracted well and hidden in firmware with PSCI(good
that it's enforced in ARM64, hopefully ARM32 also sees more adoption).

So, for the parts adding those 2 flags and removing the unnecessary
code, you can add:
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Regards,
Sudeep
