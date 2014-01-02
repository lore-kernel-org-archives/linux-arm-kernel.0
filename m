From: balbi@ti.com (Felipe Balbi)
Date: Thu, 2 Jan 2014 16:01:01 -0600
Subject: [RFT/RFC/PATCH 00/31] arm: omap: irq: cleanup INTC driver
In-Reply-To: <20131223173409.GA10536@saruman.home>
References: <1384970958-4118-1-git-send-email-balbi@ti.com>
 <20131219184815.GU27438@atomide.com>
 <20131219232153.GE707@saruman.home>
 <20131221005309.GH26054@atomide.com>
 <20131223173409.GA10536@saruman.home>
Message-ID: <20140102220101.GA8652@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 23, 2013 at 11:34:09AM -0600, Felipe Balbi wrote:
> On Fri, Dec 20, 2013 at 04:53:09PM -0800, Tony Lindgren wrote:
> > * Felipe Balbi <balbi@ti.com> [131219 15:23]:
> > > On Thu, Dec 19, 2013 at 10:48:15AM -0800, Tony Lindgren wrote:
> > > > * Felipe Balbi <balbi@ti.com> [131120 10:10]:
> > > > > Afte these patches, we're very close to being able
> > > > > to move arch/arm/mach-omap2/irq.c to drivers/irqchip/irq-intc.c
> > > > 
> > > > That would be nice :)

added a few patches on top of my branch removing all arch/arm/
dependencies and moving the driver to drivers/irqchip/irq-omap-intc.c

> > > > > Note that I have only boot tested these on AM335x Bone Black
> > > > > (with a small fix for fixed regulator which should be in
> > > > > the mailing list already), so I'd need help testing all
> > > > > other impacted platforms, specially when it comes to PM.
> > > > 
> > > > Sorry have not had much of a chance to test these with PM with
> > > > all the fixes needed for omap3 DT mode. Tried testing these
> > > > just now, but I get:
> > > > 
> > > > arch/arm/mach-omap2/board-generic.c:134: error: ?omap_intc_of_init? undeclared here (not in a function)
> > > 
> > > some of your other changes messed it up, I have not references of
> > > omap_intc_of_init() in my branch, because that's one of the things I'm
> > > dropping from DT-based boots.
> > > 
> > > Can you see which patch added a new omap_intc_of_init() call ? Or maybe
> > > tell me which branch I should rebase on top of ?
> > 
> > OK I tried against v3.13-rc4, it's the 3517 changes that caused
> > it. Looks like that can be just removed, and then there are some
> > trivial n8x0 merge conflicts. And n8x0 boots too.
> > 
> > But looks like omap3 off-idle hangs after hitting idle with these,
> 
> could it be we're racing between irq_chip.suspend() and hwmod's
> _disable() calls ?

So there are a few possibilities here (and having an OMAP3 platform at
home would help a lot):

a. We're either killing INTC inside hwmod before irq_chip suspend is
	called.

b. We could be calling irq_chip's resume before INTC is enabled again

c. We're loosing interrupts (??)

I might have a really old beagleboard somewhere around, if I do, I'll
try to to boot it up again and track down this regression. Would be
great to see these patches reaching mainline.

> > so a bit more work is needed. Maybe also rebase these against
> > omap-for-v3.14/dt too?
> 
> Will do.

Rebased on top of omap-for-v3.14/omap3-board-removal. Patches are on my
k.org tree:

git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git wip/omap-fix-intc

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140102/b38f0700/attachment.sig>
