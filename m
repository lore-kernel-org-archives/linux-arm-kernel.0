From: balbi@ti.com (Felipe Balbi)
Date: Sun, 2 Oct 2011 21:56:09 +0300
Subject: [PATCH 15/30] usb/musb: use a Kconfig choice to pick the right
	DMA method
In-Reply-To: <1757336.Qk72n3s00p@wuerfel>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-16-git-send-email-arnd@arndb.de>
	<20111002161447.GC12323@n2100.arm.linux.org.uk>
	<1757336.Qk72n3s00p@wuerfel>
Message-ID: <20111002185608.GA25690@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Oct 02, 2011 at 08:00:31PM +0200, Arnd Bergmann wrote:
> On Sunday 02 October 2011 17:14:47 Russell King - ARM Linux wrote:
> > On Sun, Oct 02, 2011 at 04:45:45PM +0200, Arnd Bergmann wrote:
> > > The logic to allow only one DMA driver in MUSB is currently
> > > flawed, because it also allows picking no DMA driver at all
> > > and also not selecting PIO mode.
> > > 
> > > Using a choice statement makes this foolproof for now and
> > > also simplifies the Makefile.
> > > 
> > > Unfortunately, we will have to revisit this when we start
> > > supporting multiple ARM platforms in a single kernel binary,
> > > because at that point we will actually need to select
> > > multiple DMA drivers and pick the right one at run-time.
> > 
> > I thought there was some work going on to convert this to use the
> > dmaengine stuff?
> 
> That would certainly be the best solution here, I wasn't aware
> that it has already been discussed.
> 
> Unfortunately, even with the dma parts out of the way there is
> a lot that needs to be done to make musb, ehci or ohci
> really cross-platform. Right now, you can only have one
> platform driver glue for each of those drivers, and they

that's not true for musb. I can already compile am35x and omap2430
together. TUSB is a different story though. With a small effort, we
could also allow DaVinci and the like to compile cleanly and work.

> should eventually be converted to a large library module for
> the core, with independent platform driver front-end, similar

that's how MUSB works now and that's what I have been discussing with
Alan Stern for the past month or so, wrt to *HCI. There are even patches
floating on linux-usb right now trying to hash out the problems.

Maybe you should have consulted the maintainers of those drivers before
making such statements.

MUSB is not the best example because of its history. I understand the
DMA part is still really messy, but we have been working very hard to
hash the problems and still allow new glue layers to be merged.

How about taking a sneak pick at what the code does right now ? As of
today, I can even even have *all* UDC controller drivers into one kernel
and I generally compile x86 with all controllers available. There's some
very small work that has to be done on each of the UDC drivers to remove
any references to <arch/..> <asm/..> and <plat/..> headers but that work
in in progress.

Also, when sending USB patches, be sure to Cc linux-usb at vger where most
of the discussion is happening.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111002/f1746536/attachment.sig>
