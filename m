From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 24 Feb 2010 22:25:37 +0100
Subject: [PATCH 3/7] ARM: U300: set f_max to 24 MHz for MMCI
In-Reply-To: <20100224125002.GA19641@n2100.arm.linux.org.uk>
References: <1266537931-12560-1-git-send-email-linus.walleij@stericsson.com>
	<20100221210740.GA3528@n2100.arm.linux.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E9355A2@eseldmw101.eemea.ericsson.se>
	<20100224125002.GA19641@n2100.arm.linux.org.uk>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E964212@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK I have now investigated this MMCI HW flow control mentioned
earlier (Dan, this may be outside your interests, sorry in that
case):

> > if (host->hw_designer == AMBA_VENDOR_ST)
> > 	clk |= MCI_FCEN; /* Bug fix in ST IP block */
> > 
> > This enables HW flow control on the block, and holds back
> > reads/writes so it doesn't over/underruns.
>
> Pierre used to argue that stopping the clock to the card was a bad
> thing, which is probably based on his experience dealing with SD/SDIO
> cards - so really the overrun/underrun problem is not a bug with the
> hardware.

Yep this is achieved by gating the clocks to the card indeed.
It will gate all clocks to the card, not just one, so MCIFBCLK
(i.e. the feedback clock from the card), MCICLKOUT (output to
the feedback loop) and MCICLK (main card clock) are all gated.

This has been in widespread use on the U300 platform under another
OS however, and no big problems have been reported. I believe this
is because we only have this platform fitted with uSD-cards in
practice, and those are late to the MMC/SD-show and may thus be
tolerant to this behaviour, something that may not apply to the
MMC cards of old times.

Another place where we use PL180 is with eMMC:s and here we
know the exact card in use, and we know that it will tolerate
this behaviour.

So for us this frequency and HW gating seems to be acceptable
in practice though in theory we could solder in an MMC card holder
to the PL180.

Linus Walleij
