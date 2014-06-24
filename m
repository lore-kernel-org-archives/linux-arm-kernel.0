From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jun 2014 15:57:23 +0200
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <20140624134249.GB4489@arm.com>
References: <7416978.W29blLsymn@wuerfel> <20140624134249.GB4489@arm.com>
Message-ID: <4163058.utc3hnZrND@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 14:42:49 Catalin Marinas wrote:
> On Tue, Jun 24, 2014 at 02:17:06PM +0100, Arnd Bergmann wrote:
> > Since 3.16, we have the ability to build a multiplatform kernel
> > that includes both kirkwood (feroceon) and some other ARMv5 CPU.
> > 
> > I accidentally stumbled over a bug in the VFP code that looks
> > like it will break at least ARM9 VFP support if CPU_FEROCEON
> > is also enabled, introduced by this (old) commit:
> 
> I would argue that the bug is in the CPU (feroceon). See the end of this
> email:
> 
> http://www.spinics.net/lists/arm-kernel/msg41460.html
> 
> and my follow-up. Basically you can't avoid the conditional compilation
> as Feroceon doesn't follow the VFP sub-architecture spec and doesn't
> present itself as a different CPU from an _ARM_ 9. Unless things have
> changed with Marvell's hardware implementation and they got a new id, I
> suggest you don't enable this for multi-platform.

We only support multiplatform configurations with Feroceon variants
that identify as Marvell-made, not the fake ARM CPU ID, and we already
rely on detecting the correct CPU type in other places, so we can e.g.
set up the cache correctly.

For all I can tell, the problem now exists only if you enable the
kirkwood platform, which does have its own ID. If this gets made
conditional on the CPU ID, we probably still also need to leave your
existing hack in place for the case of CONFIG_CPU_FEROCEON_OLD_ID
on a feroceon-only kernel.

	Arnd
