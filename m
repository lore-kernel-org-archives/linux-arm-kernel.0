From: lauri.hintsala@bluegiga.com (Lauri Hintsala)
Date: Mon, 17 Sep 2012 16:43:35 +0300
Subject: [PATCH] mmc: mxs-mmc: implement broken-cd
In-Reply-To: <505096EF.8060208@bluegiga.com>
References: <1347018317-2222-1-git-send-email-lauri.hintsala@bluegiga.com>
 <20120910060840.GT26709@S2101-09.ap.freescale.net>
 <504DBB10.9030702@bluegiga.com>
 <CAKGA1bm990BXJuZ=sQFgaciJxeP_ytPV2tfm1rHi=s=w7b-OYg@mail.gmail.com>
 <505096EF.8060208@bluegiga.com>
Message-ID: <50572907.6000700@bluegiga.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Is it OK to use broken-cd? broken-cd feature is documented as "There is 
no card detection available; polling must be used". In this case the 
card detect is not broken but it is unrouted so it is unavailable.

Documentation about broken-cd has been added by commit:
https://git.kernel.org/?p=linux/kernel/git/cjb/mmc.git;a=commitdiff;h=abe1e05da365350ac282ba5f6831aae13d97074e

Any tips about power management implementation are welcome if I have to 
use PM instead of polling method.

Regards,
Lauri


On 09/12/2012 05:06 PM, Lauri Hintsala wrote:
> Hi,
>
> On 09/10/2012 05:58 PM, Matt Sealey wrote:
>> I think this describes three use cases which are different, as Shawn
>> said we have here;
>>
>> * missing card detect support (card detect is not wired so it's
>> impossible to tell, and the controller doesn't support the SD standard
>> card detection)
>> * non-removable device
>> * broken card detect support
>>
>> The third one is what the property sounds like it describes, but this
>> is not the use case you are describing at all. This kind of property
>> naming is more like describing "card detect doesn't operate reliably"
>> which is true of i.MX devices with certain versions of the eSDHC and
>> uSDHC controllers, where non-GPIO card detection interferes with SDIO
>> interrupts, but in this case a board designer should add a real card
>> detect pin to the board (most more expensive push-push SD card slots
>> come with a pin you can wire for CD). In cases where errata is
>> published after boards are shipped, broken-cd is a meaningful
>> description when described in the absense of a gpio cd description, or
>> presence of some cd-handled-internally style property (forgive me for
>> not cross-referencing the FSL definition for this property, we don't
>> use it here at Genesi since all our boards have GPIO CD)
>>
>> It seems your device is a combination of the top two in the list, it
>> is not down to a broken feature at all, but one that should be
>> possible to not implement for devices which are permanently connected.
>> A non-removable device should be able to be powered down, at least
>> using runtime PM or clock gating (if this works, remember to whitelist
>> the card for clock gating!) but card detect shouldn't be used in this
>> case to detect if the card is powered or not (this is a problem for
>> your card controller and card driver state tracker. The MMC subsystem
>> already tracks this state fairly well for power management).
>
> Do you mean the polling mode shouldn't been used to detect if the device
> is powered?
>
> Is there any examples how PM support could be implemented? I'm not
> familiar with PM subsystem. How is it done in practice? Should I play
> with fixed regulators?
>
> BR,
> Lauri
>
>
>> I would refrain from calling a feature "broken card detect" if there
>> is actually no breakage involved especially if it would be more
>> prudent instead look into how to figure out how to track power
>> management state properly without cluttering the device tree.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
