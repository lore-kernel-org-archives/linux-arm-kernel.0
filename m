From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 24 Jun 2014 15:35:03 +0100
Subject: VFP handling in multiplatform feroceon kernels
In-Reply-To: <20140624142505.GF4489@arm.com>
References: <7416978.W29blLsymn@wuerfel> <20140624134249.GB4489@arm.com>
 <alpine.LFD.2.11.1406240956540.16842@knanqh.ubzr>
 <20140624141056.GD4489@arm.com>
 <20140624141423.GP32514@n2100.arm.linux.org.uk>
 <20140624142505.GF4489@arm.com>
Message-ID: <20140624143503.GQ32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 03:25:05PM +0100, Catalin Marinas wrote:
> On Tue, Jun 24, 2014 at 03:14:23PM +0100, Russell King - ARM Linux wrote:
> > This is not just about VFP - it's much bigger than that.  Feroceon can't
> > use proc-arm926.S (it has errata in the cache maintanence instructions)
> > which also need handing.  That's why we have a separate implementation
> > (proc-feroceon.S) so that ARM926 is not hurt by this stupidity.
> 
> As Arnd suggested, we could enable multi-platform only for newer
> Feroceon chips which presumably have different id, keeping
> CONFIG_CPU_FEROCEON_OLD_ID disabled. The VFP code needs to be changed to
> depend on CPU_FEROCEON_OLD_ID, otherwise do proper id checking.
> 
> Are there other places where we need to check for CPU_FEROCEON_OLD_ID?

Then someone tries to boot on a Feroceon platform which is supported by
the kernel (because some versions have the CPUs with the new ID) but
they have an old ID, and they get the ARM926 code being used instead,
resulting in god knows what happening (I actually don't know, but given
that it's buggy cache ops, I suspect the result is some kind of data
corruption, which could result in filesystem corruption.)

My personal stance on this is that I did not want the ARM926 crap ID
ever merged into mainline.  Nicolas was (as ever) extremely forceful
over that and got his way.

The CPU/MMU stuff is already handled, but absolutely requires that
CPU_FEROCEON_OLD_ID is set correctly: you can't support both the old
Feroceon ID and ARM926 in the same kernel, it's one or the other.  So
either you enable this option and not boot the kernel on any ARM926
platform, or you keep it disabled and not boot it on anything using
the old plagerised ID.

As I point out, the problem is that if we build a kernel with ARM926
plus Feroceon support (thus including some of the Feroceon platforms),
and omitting the plagerised ID, how do we stop the potential data
corruption occuring should we boot on a Feroceon platform with the
old IDs.

It may be far better and less error prone just to say that we support
a single zImage containing ARM926 support _or_ a single zImage
containing Feroceon support, but not both ARM926 and (any) Feroceon
together.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
