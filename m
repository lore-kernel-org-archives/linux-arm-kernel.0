From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 24 Oct 2011 14:18:51 +0200
Subject: [PATCH] mmc: mmci: Improve runtime PM support
In-Reply-To: <4EA55076.2010701@stericsson.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
	<CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
	<4EA51C4A.7040802@stericsson.com>
	<20111024090432.GA9893@n2100.arm.linux.org.uk>
	<4EA53181.2050700@stericsson.com>
	<20111024094203.GI9893@n2100.arm.linux.org.uk>
	<4EA538A3.9070501@stericsson.com>
	<20111024101416.GK9893@n2100.arm.linux.org.uk>
	<4EA55076.2010701@stericsson.com>
Message-ID: <CACRpkdb7FwW=Qa2MiJkbezkBO3F+Y0j6-RWSiL8dfJXkbd4pHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2011 at 1:48 PM, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> [Russell]
>> The MCIPWR signal controls the external power switch. ?This is the only
>> signal for it. ?This is the only connection for it. ?There is no other
>> control form for this power switch.
>>
>
> Then we are only left to use the variant struct I believe. In principle, a
> flag in the variant struct, could indicate whether it is OK to disable the
> vcore regulator and thus clear the MCIPWR when doing runtime_suspend.

Yep I think the best could be to add some variant named
bool external_card_power; and then document in the kerneldoc that this
means the driver can clear MMCIPWR without risk of cutting the power
to the card.

This should be true for Ux500, U300 and Nomadik (just checked the designs -
they all have external regulators).

So the state save/restore and amba_vcore_disable(adev); should be done
only for those variants.

However this:

clk_disable(host->clk);

We ought to be able to do for *all* variants, provided we can create
pm_runtime_get/put and delay properly to cover all bus traffic
(looks like the patch already does that), plus all the time the card is
signalling busy. The best I can think of is to just return -EBUSY to runtime
PM like this:

if ((readl(base + MMCISTATUS) & (MCI_CMDACTIVE | MCI_TXACTIVE| MCI_RXACTIVE))
  return -EBUSY;

Yours,
Linus Walleij
