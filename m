From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 22 Feb 2010 21:42:57 +0100
Subject: [PATCH 3/7] ARM: U300: set f_max to 24 MHz for MMCI
In-Reply-To: <20100221210740.GA3528@n2100.arm.linux.org.uk>
References: <1266537931-12560-1-git-send-email-linus.walleij@stericsson.com>
	<20100221210740.GA3528@n2100.arm.linux.org.uk>
Message-ID: <A6D19A13FE030A409EC4362C172E091F0E9355A2@eseldmw101.eemea.ericsson.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Russell]
> On Fri, Feb 19, 2010 at 01:05:31AM +0100, Linus Walleij wrote:
> > @@ -101,6 +101,7 @@ int __devinit mmc_init(struct amba_device *adev)
> >  	 * we have a regulator we can control instead.
> >  	 */
> >  	/* Nominally 2.85V on our platform */
> > +	mmci_card->mmc0_plat_data.f_max = 24000000;
> 
> I bet setting this without DMA support leads to overruns/underruns on
> the interface.

Actually no, not on the U300. On the RealView etc, yes.

Because we have this (see mmci_set_clkreg()):

if (host->hw_designer == AMBA_VENDOR_ST)
	clk |= MCI_FCEN; /* Bug fix in ST IP block */

This enables HW flow control on the block, and holds back
reads/writes so it doesn't over/underruns.

We experienced the problem years ago, and reported to
ST Microelectronics, who fixed it in the next hardware
revision. All present U300 platforms have this fixed.
But the clk framework restricts it to 18.9 MHz.

Linus Walleij
