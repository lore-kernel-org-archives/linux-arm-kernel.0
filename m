From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 05 Mar 2012 13:49:45 +0530
Subject: [PATCH 11/12] mfd: twl4030-irq: Return twl6030_mmc_card_detect
 IRQ for board setup
In-Reply-To: <20120302181522.GC13967@legolas.emea.dhcp.ti.com>
References: <1330707024-23730-1-git-send-email-b-cousson@ti.com>
 <1330707024-23730-12-git-send-email-b-cousson@ti.com>
 <20120302181522.GC13967@legolas.emea.dhcp.ti.com>
Message-ID: <4F547721.4010107@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012 11:45 PM, Felipe Balbi wrote:
> Hi,
>
> On Fri, Mar 02, 2012 at 05:50:23PM +0100, Benoit Cousson wrote:
>> Card detect IRQ from the TWL6030 used to be provided to the MMC
>> controller code using a statically allocated IRQ scheme:
>>
>>    card_detect_irq = TWL6030_IRQ_BASE + MMCDETECT_INTR_OFFSET;
>>
>> This is no longer valid in a SPARSE_IRQ context since there is no more
>> pre-defined TWL6030_IRQ_BASE.
>>
>> Return the proper card detect IRQ value in the twl6030_mmc_card_detect_config
>> that will be called from the MMC controller.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Felipe Balbi<balbi@ti.com>
>> Cc: Tony Lindgren<tony@atomide.com>
>> Cc: Rajendra Nayak<rnayak@ti.com>
>
> Reviewed-by: Felipe Balbi<balbi@ti.com>
>
>> ---
>>   drivers/mfd/twl6030-irq.c |    3 ++-
>>   1 files changed, 2 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
>> index a1c7183..4a63de2 100644
>> --- a/drivers/mfd/twl6030-irq.c
>> +++ b/drivers/mfd/twl6030-irq.c
>> @@ -308,7 +308,8 @@ int twl6030_mmc_card_detect_config(void)
>>   									ret);
>>   		return ret;
>>   	}
>> -	return 0;
>> +
>> +	return twl6030_irq_base + MMCDETECT_INTR_OFFSET;
>>   }
>>   EXPORT_SYMBOL(twl6030_mmc_card_detect_config);
>
> At some point this twl6030_mmc_card_detect_config() needs to vanish in
> favor of a better mechanism. Maybe passing the GPIO number an requiring
> the driver to request the GPIO, set its direction and use it as IRQ
> line.
>
> the only problem would arise if we end up hooking the Card Detect pin to
> a real IRQ line, but then we can use a flag to differentiate.

Shouldn't this be hidden from the driver completely if the card detect
pin is a GPIO or connected to a real IRQ line? And the board/DT handle 
this instead of the driver knowing when to do a gpio_to_irq()?
But I see thats not the case with most mmc drivers, not just OMAP, I
wonder why.

>
