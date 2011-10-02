From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 02 Oct 2011 21:44:26 +0200
Subject: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
In-Reply-To: <20111002185608.GA25690@legolas.emea.dhcp.ti.com>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1757336.Qk72n3s00p@wuerfel>
	<20111002185608.GA25690@legolas.emea.dhcp.ti.com>
Message-ID: <1546914.88vcgxkfJf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 02 October 2011 21:56:09 Felipe Balbi wrote:
> 
> > Unfortunately, even with the dma parts out of the way there is
> > a lot that needs to be done to make musb, ehci or ohci
> > really cross-platform. Right now, you can only have one
> > platform driver glue for each of those drivers, and they
> 
> that's not true for musb. I can already compile am35x and omap2430
> together. TUSB is a different story though. With a small effort, we
> could also allow DaVinci and the like to compile cleanly and work.

Ok, good.

> > should eventually be converted to a large library module for
> > the core, with independent platform driver front-end, similar
> 
> that's how MUSB works now and that's what I have been discussing with
> Alan Stern for the past month or so, wrt to *HCI. There are even patches
> floating on linux-usb right now trying to hash out the problems.

Ah, glad to see that is happening. I can probably get rid of a bunch
of randconfig patches I have for those then.

> Maybe you should have consulted the maintainers of those drivers before
> making such statements.
>
> MUSB is not the best example because of its history. I understand the
> DMA part is still really messy, but we have been working very hard to
> hash the problems and still allow new glue layers to be merged.

Sorry if I have made my statement sound like an accusation, it wasn't
meant as one, merely as a sigh at having identified yet another area
that needs to be changed in order to have cross-platform ARM kernels
working in every case.
 
> How about taking a sneak pick at what the code does right now ? As of
> today, I can even even have all UDC controller drivers into one kernel
> and I generally compile x86 with all controllers available. There's some
> very small work that has to be done on each of the UDC drivers to remove
> any references to <arch/..> <asm/..> and <plat/..> headers but that work
> in in progress.

I didn't really see any problems with UDC at all. What I saw were a lot
of build problems with the musb host side, and I rewrote this patch half
a dozen times before I ended up with a version that consistently built
without making the code look worse.

I also agree that the musb implementation is less of a problem than
ohci/ehci in its current form, as it already is layered in the right
way. I did not attempt to turn the Kconfig 'choice' statement there
into a flat list though, so I wouldn't know what problems to expect.

	Arnd
