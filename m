From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Sep 2012 01:45:11 +0100
Subject: [PATCH] ARM: Dove: allow PCI to be disabled
In-Reply-To: <20120909210126.GM4575@titan.lakedaemon.net>
References: <E1TAnGn-00086i-Lb@rmk-PC.arm.linux.org.uk>
 <20120909204705.GD3451@lunn.ch>
 <20120909205521.GI13739@n2100.arm.linux.org.uk>
 <20120909210126.GM4575@titan.lakedaemon.net>
Message-ID: <20120910004511.GN13739@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 09, 2012 at 05:01:26PM -0400, Jason Cooper wrote:
> On Sun, Sep 09, 2012 at 09:55:21PM +0100, Russell King - ARM Linux wrote:
> > On Sun, Sep 09, 2012 at 10:47:05PM +0200, Andrew Lunn wrote:
> > > On Sun, Sep 09, 2012 at 08:34:13PM +0100, Russell King wrote:
> > > > Allow PCI support for Dove to be disabled.  Some platforms do not have
> > > > anything connected to the PCIe ports, so requiring PCI support to be
> > > > built into the kernel just wastes space, and presents a lot more config
> > > > options than are necessary.
> > > > 
> > > > However, select USB_ARCH_HAS_EHCI so that we can still have EHCI
> > > > support.
> > > 
> > > Hi Russel
> > > 
> > > I have a patch in GregKH usb-next which also ensures USB_ARCH_HAS_EHCI
> > > is selected.
> > > 
> > > http://git.kernel.org/?p=linux/kernel/git/gregkh/usb.git;a=commitdiff;h=ba2f9dff6c914b91005f687a9d75c8eac110d323
> > > 
> > > So we might not need your select as well, although it does not harm.
> > 
> > That depends on how this patch is handled.  If it gets into mainline via
> > a separate path to GregKH's USB tree, then it must be kept together as
> > otherwise it _will_ cause regressions - namely EHCI becomes impossible
> > to select when PCI=n.  That in turn makes the CuBox (and probably other
> > Dove platforms) a rather useless di
> [message trucated, I need to working on file locking for my email
> auto-flagging script... :-/]
> 
> greg just pulled Andrew's patch into his usb tree within the past few
> days.  Russell, would you prefer to submit this to greg's usb tree, or
> resend without USB_ARCH_HAS_EHCI?

I thought I'd already answered the latter point.

As I said, it breaks the patch to remove that select, so it can not be
removed.  Removing it will create regressions - can I be any more clear
about that.  So no, I will not remove that select statement because I
can't without _breaking_ my Dove builds here.

I don't think submitting this patch to Greg's USB tree is also appropriate
either, it's clearly ARM specific in nature, or even PCI specific.  It
isn't a USB patch.  Neither is a patch changing a USB setting in
arch/arm/Kconfig.  If any tree, these patches should be going through
arm-soc.
