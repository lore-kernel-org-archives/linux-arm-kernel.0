From: csd@broadcom.com (Christian Daudt)
Date: Wed, 5 Dec 2012 00:36:50 -0800
Subject: [PATCH] Add support for generic BCM SoC chipsets
In-Reply-To: <50BEC101.5090905@wwwdotorg.org>
References: <1352391196-9984-1-git-send-email-csd@broadcom.com>
 <509C7771.9020400@wwwdotorg.org> <509FA975.6060203@broadcom.com>
 <50BEC101.5090905@wwwdotorg.org>
Message-ID: <50BF07A2.9010208@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12-12-04 07:35 PM, Stephen Warren wrote:
> On 11/11/2012 06:34 AM, Christian Daudt wrote:
>> On 12-11-08 07:24 PM, Stephen Warren wrote:
> ...
>>> Is the intent for this to support other BCM SoCs in the future, such as
>>> the bcm2835 in the Raspberry Pi, and the mach-bcm476x which Domenico
>>> Andreoli recently sent patches for? It'd be awesome if Broadcom could
>>> provide MMC and USB drivers for the bcm2835 for example.
>> Yes and no :) The intent is to support other BCM SoCs in the future, but
>> Broadcom has a fair number of ARM based SoCs. My primary focus is on the
>> ones from my group within Broadcom (mobile SoCs), but the plan is to
>> bring in others as feasible, and collaborate with other upstreaming work
>> being done for BCM SoCs.
>>
>> As for bcm2835 MMC and USB, we will be upstreaming MMC and USB bcm281xx
>> as part of this effort and while I haven't checked the bcm2835 guts (it
>> comes from a different team within Broadcom) I suspect it might share
>> the same IP blocks, which would make it fairly easy to extend our work
>> to add 2835 support. Stay tuned !
> So, the bcm2835/Raspberry Pi port is at the stage where MMC and/or USB
> drivers would be the next useful thing to upstream. However, in order to
> use those blocks, we should really get communication with the VideoCore
> working in order to ensure that power and clocks to those modules are
> configured and enabled.
Cool. I've started a rewrite of our sdhci driver for upstreaming.
>
> This begs a few questions
>
> * Do all/most Broadcom SoCs have a VideoCore.
The mobile ones yes, there are a few different versions of videocore. 
But I'm pretty sure that the version in bcm2835 is identical or almost 
identical to the version in the mobile SoCs I'm upstreaming.
>
> * If so, does the VC typically have complete control over the clock and
> power/reset trees? Or, are you planning to control these aspects from
> Linux on the SoCs you're working on upstreaming? If so, is there
> publicly accessible documentation for your SoC, and is it possible to
> release similar docs for the 2835?
As far as I know, the bcm2835 design in which the videocore has control 
over the SoC is unique to that model. No other Broadcom SoCs follow that 
design - or at least none of the mobile SoCs that I work on. As for 
documentation, there is no publicly available doc on the soc I'm working 
on. I don't know the state of the 2835 documentation - that comes from a 
different group within Broadcom.

> * If the VC controls this, how standardized is the communication
> mechanism with the VC; do all SoCs have the same mailbox HW, use the
> same format for the messages passed through the mailbox, and for mailbox
> channels where the message is a pointer to the message buffer, do they
> use the same format for that message buffer?
>
> I note that the earlier Raspberry Pi firmwares didn't include support
> for the so-called "property mailbox" channel[1]; it was added in later
> firmwares. So I assume this is something custom for the Raspberry Pi.
> That'd be a pity since this message format fixed some nasty issues with
> the other non-property mailbox messages, at least for power control...
As I mentioned above, the 2835 architecture does not follow the design 
used on the mobile SoCs. It is unique as far as I know. The mobile SoCs 
I'm upstreaming boot from the ARM core and the videcore does, well, 
video stuff :) My (very vague) understanding of the 2835 is that it 
boots from videocore, and the videocore retains a number of 
responsibilities.

> Overall, I'm wondering whether the Raspberry Pi upstreaming efforts
> should just hold off completely until you've got more of the
> BCM11351/... stuff upstream and simply add that to the Raspberry Pi DT,
> or whether this aspect won't be re-usable at all.
It is hard to say at this point what the commonality is - I honestly am 
not that familiar with the 2835. I do suspect that a number of drivers 
will be similar in that they start from common IP blocks, but they are 
connected differently in the different SoCs and thus the drivers won't 
be identical. But it's just a suspicion at this point.
  I have purchased a few Raspberry PIs for my team so that we can 
familiarize ourselves a bit more with it though :) I think that once we 
have a basic working set upstreamed (basic clocks, emmc/sd, gpio, and a 
couple of others), we can then take a look at the 2835 as to how 
applicable what we've upstreamed is for it. I can't give you a timeframe 
for this though so I don't know if you want to wait for it or not.
> If there isn't any commonality now in the VC firmware responsibilities
> and/or message formats, would it be possible to create some kind of
> standard interface to the firmware, and builds of the firmware that
> implement that, for upstreaming purposes?
I'll try to understand better the 2835 in the next few weeks so I can 
provide more meaningful responses. Maybe it'll be my Christmas reading 
material...

  Cheers,
    csd

> [1] https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface
>
> Thanks for any information!
>
