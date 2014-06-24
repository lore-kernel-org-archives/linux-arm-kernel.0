From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 16:32:20 +0200
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <20140624142505.GF4489@arm.com>
References: <7416978.W29blLsymn@wuerfel>
 <20140624141423.GP32514@n2100.arm.linux.org.uk>
 <20140624142505.GF4489@arm.com>
Message-ID: <5647865.08hn2WHr6u@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 15:25:05 Catalin Marinas wrote:
> On Tue, Jun 24, 2014 at 03:14:23PM +0100, Russell King - ARM Linux wrote:
> > On Tue, Jun 24, 2014 at 03:10:56PM +0100, Catalin Marinas wrote:
> > > On Tue, Jun 24, 2014 at 03:04:14PM +0100, Nicolas Pitre wrote:
> > > > On Tue, 24 Jun 2014, Catalin Marinas wrote:
> > > > Only the early revision did hijack the ARM9 ID but still. We certainly 
> > > > can determine at run time if the platform being booted is equiped with a 
> > > > Feroceon before user space is started.  In that case I'd suggest some 
> > > > runtime code patching to branch to some out-of-line assembly code for 
> > > > Feroceon.
> > > 
> > > You don't even need to branch to out of line assembly, just branch over
> > > the imprecise VFP abort handling in arch/arm/vfp/vfphw.S.
> > 
> > This is not just about VFP - it's much bigger than that.  Feroceon can't
> > use proc-arm926.S (it has errata in the cache maintanence instructions)
> > which also need handing.  That's why we have a separate implementation
> > (proc-feroceon.S) so that ARM926 is not hurt by this stupidity.
> 
> As Arnd suggested, we could enable multi-platform only for newer
> Feroceon chips which presumably have different id, keeping
> CONFIG_CPU_FEROCEON_OLD_ID disabled.

Note that we do disable CONFIG_CPU_FEROCEON_OLD_ID for both
kirkwood_defconfig and mvebu_v5_defconfig, and we don't even
support multiplatform on orion5x (yet), which is the platform
that needs CONFIG_CPU_FEROCEON_OLD_ID. It would be good to know
if all Orion5x suffer from this problem, or just the older ones.
I'm also not sure about mv78xx0, but it's possible we won't need
to care about that one much longer.

> The VFP code needs to be changed to
> depend on CPU_FEROCEON_OLD_ID, otherwise do proper id checking.

Right, that is all I was asking for.

> Are there other places where we need to check for CPU_FEROCEON_OLD_ID?

For all I can tell, the VFP assembly is the only code that doesn't use the
proc-feroceon.S abstraction.

	Arnd
