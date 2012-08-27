From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 27 Aug 2012 09:27:55 +0100
Subject: [GIT PULL] io.h clean-up for PCI
In-Reply-To: <5016A0B8.5010607@gmail.com>
References: <50049285.1060100@gmail.com> <50130F36.4090902@gmail.com>
 <20120728143850.GA11713@mudshark.cambridge.arm.com>
 <50166A60.8000502@gmail.com> <20120730143119.GN6802@n2100.arm.linux.org.uk>
 <5016A0B8.5010607@gmail.com>
Message-ID: <20120827082755.GM18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 30, 2012 at 09:56:56AM -0500, Rob Herring wrote:
> On 07/30/2012 09:31 AM, Russell King - ARM Linux wrote:
> > On Mon, Jul 30, 2012 at 06:05:04AM -0500, Rob Herring wrote:
> >> On 07/28/2012 09:38 AM, Will Deacon wrote:
> >>> Hi Rob,
> >>>
> >>> On Fri, Jul 27, 2012 at 10:59:18PM +0100, Rob Herring wrote:
> >>>> Please pull updated io.h cleanup for PCI branch. I rebased this as the
> >>>> changes shifted things around a bit. This has the following changes:
> >>>>
> >>>> - Incorporated fixes from you and Stephen
> >>>> - Add early i/o mapping pci_map_io_early and enable on footbridge and
> >>>> integrator for VGA console
> >>>
> >>> Unfortunately, I still experience the same hang on integrator with this
> >>> revised patch series. Given the turnaround time for testing this, I don't
> >>> think this should block the series, but I would like to get to the bottom of
> >>> it if possible.
> >>>
> >>> I tried annotating the PCI code (including fault handlers) and the VGA
> >>> console code but I couldn't find the culprit. I suppose the next step is
> >>> JTAG, but that requires steal^Wborrowing some hardware from work.
> >>
> >> I did do some tests with qemu by adding i/o setup to integrator/cp.
> >> Without it, I would abort on 0xfee003xx (vga regs). Once I added the
> >> setup, I got to an abort on a PCI memory address which I did not setup.
> >>
> >> We can always revert integrator change if we can figure this out...
> > 
> > Err, Integrator/CP doesn't have PCI nor does it have VGA.  Only the
> > Integrator/AP has that.
> 
> Yes, I know. But there is no AP model within qemu. I added the mapping
> to AP and enabled VGA console to do some basic checks that i/o accesses
> happen. It didn't really have to be integrator platform at all for this
> test. I know it's not much of a test, but it's something beyond
> compiling and staring at the code.
> 
> I've also tested PCI i/o with versatile under qemu.

What's the conflict resolution for the fix for ioremap of phys 0 (posted
by me previously) and your reoganisation and creation of
vm_reserve_area_early() ?

Note that I'm taking the autobuilder offline until this is resolved because
the tree currently isn't in a buildable state because of this.
