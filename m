From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2010 12:50:02 +0000
Subject: [PATCH 3/7] ARM: U300: set f_max to 24 MHz for MMCI
In-Reply-To: <A6D19A13FE030A409EC4362C172E091F0E9355A2@eseldmw101.eemea.ericsson.se>
References: <1266537931-12560-1-git-send-email-linus.walleij@stericsson.com>
	<20100221210740.GA3528@n2100.arm.linux.org.uk>
	<A6D19A13FE030A409EC4362C172E091F0E9355A2@eseldmw101.eemea.ericsson.se>
Message-ID: <20100224125002.GA19641@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2010 at 09:42:57PM +0100, Linus Walleij wrote:
> Actually no, not on the U300. On the RealView etc, yes.
> 
> Because we have this (see mmci_set_clkreg()):
> 
> if (host->hw_designer == AMBA_VENDOR_ST)
> 	clk |= MCI_FCEN; /* Bug fix in ST IP block */
> 
> This enables HW flow control on the block, and holds back
> reads/writes so it doesn't over/underruns.

Pierre used to argue that stopping the clock to the card was a bad
thing, which is probably based on his experience dealing with SD/SDIO
cards - so really the overrun/underrun problem is not a bug with the
hardware.

I had a MMC card completely destroyed by the PXA MCI hardware (to the
point that it lost its identification), and never worked out why - I
do seem to remember that the spec does not permit the stopping of the
card clock with a command in progress.  Since that time I vowed to
stay clear of the MMC/SD/SDIO crap again - in my view the whole design
is far too fragile and implementations on both sides are too buggy for
safe and reliable use.

I'm not sure at the moment where we go with these DMA patches - I was
working on AACI to add DMA support there, until the ALSA developers
totally and utterly crapped my work there by making changes to the
driver behind my back - I've not got the motivation to undo all the
shite they changed to get things back into a reasonable shape yet.

So I'm just going to sit on the AMBA DMA stuff for the time being.
