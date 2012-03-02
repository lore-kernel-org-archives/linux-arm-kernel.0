From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 2 Mar 2012 21:28:34 +0100
Subject: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
In-Reply-To: <20120302192058.GP18901@atomide.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-12-git-send-email-b-cousson@ti.com>
 <20120302181522.GC13967@legolas.emea.dhcp.ti.com>
 <20120302192058.GP18901@atomide.com>
Message-ID: <4F512D72.1090002@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On 3/2/2012 8:20 PM, Tony Lindgren wrote:
> * Felipe Balbi<balbi@ti.com>  [120302 09:43]:
>> Hi,
>>
>> On Fri, Mar 02, 2012 at 05:50:23PM +0100, Benoit Cousson wrote:
>>> Card detect IRQ from the TWL6030 used to be provided to the MMC
>>> controller code using a statically allocated IRQ scheme:
>>>
>>>    card_detect_irq = TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET;
>>>
>>> This is no longer valid in a SPARSE_IRQ context since there is no more
>>> pre-defined TWL6030_IRQ_BASE.
>>>
>>> Return the proper card detect IRQ value in the twl6030_mmc_card_detect_config
>>> that will be called from the MMC controller.
>>>
>>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>>> Cc: Felipe Balbi<balbi@ti.com>
>>> Cc: Tony Lindgren<tony@atomide.com>
>>> Cc: Rajendra Nayak<rnayak@ti.com>
>>
>> Reviewed-by: Felipe Balbi<balbi@ti.com>
>>
>>> ---
>>>   drivers/mfd/twl6030-irq.c |    3 ++-
>>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
>>> index a1c7183..4a63de2 100644
>>> --- a/drivers/mfd/twl6030-irq.c
>>> +++ b/drivers/mfd/twl6030-irq.c
>>> @@ -308,7 +308,8 @@ int twl6030_mmc_card_detect_config(void)
>>>   									ret);
>>>   		return ret;
>>>   	}
>>> -	return 0;
>>> +
>>> +	return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
>>>   }
>>>   EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
>>
>> At some point this twl6030_mmc_card_detect_config() needs to vanish in
>> favor of a better mechanism. Maybe passing the GPIO number an requiring
>> the driver to request the GPIO, set its direction and use it as IRQ
>> line.
>>
>> the only problem would arise if we end up hooking the Card Detect pin to
>> a real IRQ line, but then we can use a flag to differentiate.
>
> I'm trying to leave out the need for this callback to pdata..
> See mmc: omap_hsmmc: Simplify init for twl6030 MMC card detect
> that does pretty much the same as Benoit's patch plus removes
> the need for the callback.

That's cool. I did that patch to still have a working MMC after my TWL 
series, and I missed your MMC series.

The patch #4 "mmc: omap_hsmmc: Simplify init for twl6030 MMC card 
detect" is indeed simplifying a lot that IRQ mess.

I will check with that TWL series, but since you are already using the 
twl6030_irq_base it should work without any trouble.

Thanks,
Benoit
