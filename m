From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 04 Dec 2012 20:35:29 -0700
Subject: [PATCH] Add support for generic BCM SoC chipsets
In-Reply-To: <509FA975.6060203@broadcom.com>
References: <1352391196-9984-1-git-send-email-csd@broadcom.com>
 <509C7771.9020400@wwwdotorg.org> <509FA975.6060203@broadcom.com>
Message-ID: <50BEC101.5090905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2012 06:34 AM, Christian Daudt wrote:
> On 12-11-08 07:24 PM, Stephen Warren wrote:
...
>> Is the intent for this to support other BCM SoCs in the future, such as
>> the bcm2835 in the Raspberry Pi, and the mach-bcm476x which Domenico
>> Andreoli recently sent patches for? It'd be awesome if Broadcom could
>> provide MMC and USB drivers for the bcm2835 for example.
>
> Yes and no :) The intent is to support other BCM SoCs in the future, but
> Broadcom has a fair number of ARM based SoCs. My primary focus is on the
> ones from my group within Broadcom (mobile SoCs), but the plan is to
> bring in others as feasible, and collaborate with other upstreaming work
> being done for BCM SoCs.
>
> As for bcm2835 MMC and USB, we will be upstreaming MMC and USB bcm281xx
> as part of this effort and while I haven't checked the bcm2835 guts (it
> comes from a different team within Broadcom) I suspect it might share
> the same IP blocks, which would make it fairly easy to extend our work
> to add 2835 support. Stay tuned !

So, the bcm2835/Raspberry Pi port is at the stage where MMC and/or USB
drivers would be the next useful thing to upstream. However, in order to
use those blocks, we should really get communication with the VideoCore
working in order to ensure that power and clocks to those modules are
configured and enabled.

This begs a few questions

* Do all/most Broadcom SoCs have a VideoCore.

* If so, does the VC typically have complete control over the clock and
power/reset trees? Or, are you planning to control these aspects from
Linux on the SoCs you're working on upstreaming? If so, is there
publicly accessible documentation for your SoC, and is it possible to
release similar docs for the 2835?

* If the VC controls this, how standardized is the communication
mechanism with the VC; do all SoCs have the same mailbox HW, use the
same format for the messages passed through the mailbox, and for mailbox
channels where the message is a pointer to the message buffer, do they
use the same format for that message buffer?

I note that the earlier Raspberry Pi firmwares didn't include support
for the so-called "property mailbox" channel[1]; it was added in later
firmwares. So I assume this is something custom for the Raspberry Pi.
That'd be a pity since this message format fixed some nasty issues with
the other non-property mailbox messages, at least for power control...

Overall, I'm wondering whether the Raspberry Pi upstreaming efforts
should just hold off completely until you've got more of the
BCM11351/... stuff upstream and simply add that to the Raspberry Pi DT,
or whether this aspect won't be re-usable at all.

If there isn't any commonality now in the VC firmware responsibilities
and/or message formats, would it be possible to create some kind of
standard interface to the firmware, and builds of the firmware that
implement that, for upstreaming purposes?

[1] https://github.com/raspberrypi/firmware/wiki/Mailbox-property-interface

Thanks for any information!
