From: sebras@gmail.com (Sebastian Rasmussen)
Date: Sun, 23 Oct 2011 02:31:39 +0200
Subject: [PATCH] mmc: mmci: Improve runtime PM support
In-Reply-To: <CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
References: <1319210754-22775-1-git-send-email-ulf.hansson@stericsson.com>
	<20111021173637.GG21648@n2100.arm.linux.org.uk>
	<CAKnu2MrOriMzJH9NcwUivWa0cinASa6wrRf4a69si4WUs-aTrQ@mail.gmail.com>
Message-ID: <CAAgDR1OT=+xgQTNwmTz=9XwzpbhjeZ6F-mxnVGhOAPSAR3JiFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> Err, no.  You're not allowed to power down the card between commands
> unless the card has been removed or been has finished with.
>
> If you power down the card (which you _are_ doing by writing zero to
> the MMCIPOWER register), then you have to do a full setup of the card
> when you resume.

MCIPower is according to ARM PL180 TRM signalling to an external power
supply to turn on/off (MCIPWR), whether to use open-drain (MCIROD),
what voltage to use (MCIVDD) and whether the card is clocked (MCICLK).

According ST-Ericsson's public PL180 derivative spec[1] it seems to work
roughly in same way (but renaming the register SDI_PWR and the signals
SDIPWR & SDICLK). However, there is no SDIVDD as the derivative can not
signal desired voltage level externally (there are no bits in SDI_PWR for this).
This makes it plausible that SDIPWR may not be routed externally either.
Can you verify this as there are no signal routing diagrams in the spec..?

This leads me to believe that writing 0 to SDI_PWR/MMC in actual practice
doesn't really do much but disabling the clock to the card (and for
ST-Ericsson's PL180, disable direction signalling to the external level
shifter). Clearing bit 8 of MCIClock/SDI_CLKCR also disables the clock.

I guess the patch would appeal more to Russell if mmci_runtime_suspend()
only cleared MCIMask0/SDI_MASK0 and MCIClock/SDI_CLKCR and left
MCIPower/SDI_PWR unchanged. It may be the case that the signal direction
bits need to be cleared for the ST-Ericsson PL180, but I haven't yet verified
this on my Snowball dev board yet.

 / Sebastian

[1] http://www.stericsson.com/developers/DM00030004_AP9500_reference_manual_rev1.pdf
