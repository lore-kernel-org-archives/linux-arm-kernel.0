From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 28 May 2015 10:04:28 +0200
Subject: [PATCH 2/2] mmc: sunxi: Also set SDXC_LOW_POWER_ON
In-Reply-To: <CAPDyKFrvB1AZGdvQ1fb6ShC8v-3DbVabiki13L8gG7M2saJALA@mail.gmail.com>
References: <cover.1432491958.git.hramrach@gmail.com>	<29e003a6fb8253b1e103f341405d4e8322e3edc2.1432491958.git.hramrach@gmail.com>	<5562C90D.8070507@redhat.com>
 <CAPDyKFrvB1AZGdvQ1fb6ShC8v-3DbVabiki13L8gG7M2saJALA@mail.gmail.com>
Message-ID: <5566CC0C.1050103@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 28-05-15 10:02, Ulf Hansson wrote:
> On 25 May 2015 at 09:02, Hans de Goede <hdegoede@redhat.com> wrote:
>> Hi,
>>
>> On 24-05-15 20:04, Michal Suchanek wrote:
>>>
>>> The function sunxi_mmc_oclk_onoff filters out the SDXC_LOW_POWER_ON flag
>>> but never sets it.
>>>
>>> Set SDXC_LOW_POWER_ON when oclk is disabled.
>>
>>
>> Nack, looking at the datasheet I do not thing this patch actually
>> does anything, according to the datasheet setting this bit to 1 results
>> in: "Turn off card clock when FSM in IDLE state", iow this does mmc clock
>> gating on idle automatically in hardware, since we completely disable the
>> clock on clock-off by clearing SDXC_CARD_CLOCK_ON setting this bit on
>> clock-off is a nop.
>>
>> We could consider actually setting this to safe power when setting the clock
>> on, for doing that it would be good to look at the android code and see if
>> it ever sets this bit and if so when.
>>
>> WRT CONFIG_MMC_CLKGATE we are probably better off using SDXC_LOW_POWER_ON
>> then that when it is enabled. So maybe we should set SDXC_LOW_POWER_ON
>> based on #ifdef WRT CONFIG_MMC_CLKGATE, and have some way to tell the
>> mmc core to not do clock gating on this host ?
>
> I am planning to remove the entire thing for CONFIG_MMC_CLKGATE, maybe
> it's time to do that now!?

Removing it now sounds like a good plan to me, we would still need
to look into maybe enabling SDXC_LOW_POWER_ON on sunxi in some cases
to save power, but that is an orthogonal problem.

Regards,

Hans
