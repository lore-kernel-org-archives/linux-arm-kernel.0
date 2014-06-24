From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 15:14:23 +0100
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <20140624141056.GD4489@arm.com>
References: <7416978.W29blLsymn@wuerfel> <20140624134249.GB4489@arm.com>
 <alpine.LFD.2.11.1406240956540.16842@knanqh.ubzr>
 <20140624141056.GD4489@arm.com>
Message-ID: <20140624141423.GP32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 03:10:56PM +0100, Catalin Marinas wrote:
> On Tue, Jun 24, 2014 at 03:04:14PM +0100, Nicolas Pitre wrote:
> > On Tue, 24 Jun 2014, Catalin Marinas wrote:
> > 
> > > On Tue, Jun 24, 2014 at 02:17:06PM +0100, Arnd Bergmann wrote:
> > > > Since 3.16, we have the ability to build a multiplatform kernel
> > > > that includes both kirkwood (feroceon) and some other ARMv5 CPU.
> > > > 
> > > > I accidentally stumbled over a bug in the VFP code that looks
> > > > like it will break at least ARM9 VFP support if CPU_FEROCEON
> > > > is also enabled, introduced by this (old) commit:
> > > 
> > > I would argue that the bug is in the CPU (feroceon). See the end of this
> > > email:
> > > 
> > > http://www.spinics.net/lists/arm-kernel/msg41460.html
> > > 
> > > and my follow-up. Basically you can't avoid the conditional compilation
> > > as Feroceon doesn't follow the VFP sub-architecture spec and doesn't
> > > present itself as a different CPU from an _ARM_ 9. Unless things have
> > > changed with Marvell's hardware implementation and they got a new id, I
> > > suggest you don't enable this for multi-platform.
> > 
> > Only the early revision did hijack the ARM9 ID but still. We certainly 
> > can determine at run time if the platform being booted is equiped with a 
> > Feroceon before user space is started.  In that case I'd suggest some 
> > runtime code patching to branch to some out-of-line assembly code for 
> > Feroceon.
> 
> You don't even need to branch to out of line assembly, just branch over
> the imprecise VFP abort handling in arch/arm/vfp/vfphw.S.

This is not just about VFP - it's much bigger than that.  Feroceon can't
use proc-arm926.S (it has errata in the cache maintanence instructions)
which also need handing.  That's why we have a separate implementation
(proc-feroceon.S) so that ARM926 is not hurt by this stupidity.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
