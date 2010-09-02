From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 2 Sep 2010 09:43:53 +0100
Subject: [PATCH] ARM: Implement cpu_v7_reset.
In-Reply-To: <20100902050349.GA14214@pengutronix.de>
References: <1283349719-21115-1-git-send-email-linus.walleij@stericsson.com>
	<4C7EC313.7050705@codeaurora.org>
	<20100902050349.GA14214@pengutronix.de>
Message-ID: <20100902084353.GB26319@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 02, 2010 at 07:03:49AM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> > > +#ifdef CONFIG_MMU
> > > +	mcr     p15, 0, ip, c8, c7, 0           @ invalidate I & D TLBs
> > > +#endif
> > > +	mrc     p15, 0, ip, c1, c0, 0           @ ctrl register
> > > +	bic     ip, ip, #0x000f                 @ ............wcam
> > > +	bic     ip, ip, #0x1100                 @ ...i...s........
> > > +	mcr     p15, 0, ip, c1, c0, 0           @ ctrl register
> > 
> > On a related note, I was always a bit confused since proc-v6 and proc-v7
> > don't turn off the MMU in their cpu_reset functions, which doesn't seem
> > correct with respect to Documentation/arm/Booting. Is it necessary to
> > turn off the MMU when kexec'ing the kernel? Last time I tried kexec'ing
> > on a v6 it worked fine without turning off the MMU.
> The boot process isn't that strict.

Wrong.  The boot process _is_ that strict.  If the MMU is left on, you
need to have page tables present, and ensure that these aren't overwritten.
We make no guarantees on that, and there's no way to tell the following
kernel not to touch that area.

The only thing that's guaranteed is to turn the MMU off, as per the boot
process.

What just happens to work does not mean that "it's not that strict".
