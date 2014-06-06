From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Jun 2014 22:39 +0200
Subject: [PATCH] ARM: fix MPU build error after meminfo removal
In-Reply-To: <20140606110657.GH23430@n2100.arm.linux.org.uk>
References: <4797611.zvigUZsBv3@wuerfel>
 <20140606110657.GH23430@n2100.arm.linux.org.uk>
Message-ID: <4972295.r6xld2rRkU@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding linux-arm-kernel mailing list, sorry for missing it in the inital
post. Also adding devicetree mailing list]

On Friday 06 June 2014 12:06:57 Russell King - ARM Linux wrote:
> On Fri, Jun 06, 2014 at 01:01:21PM +0200, Arnd Bergmann wrote:
> > I ran into a new build error while doing randconfig builds today,
> > which was introduced by 1c2f87c2256 ("ARM: 8025/1: Get rid of meminfo"):
> 
> This kind of problem is why we need more nommu platforms merged into the
> kernel - and my position on that is that nommu do *not* qualify for the
> "must be DT" restriction.
> 
> Many of the nommu platforms have very little memory that doing anything
> but building for the specific platform doesn't make that much sense (it
> may make sense to build for a group of common SoC platforms, but not
> more than that.)  Hence, I believe the DT demand is an unreasonable
> restriction upon them.

I don't think it's unreasonable, but we can definitely discuss it some
more. I've just build-tested the two nommu platforms we have in the kernel,
at91x40 and efm32 and found this size difference between DT-enabled
and disabled builds:

EFM32, DT enabled

   text    data     bss     dec     hex filename
2338464  101184   42620 2482268  25e05c obj-tmp/vmlinux


EFM32, DT disabled, no board file

   text    data     bss     dec     hex filename
2282264   96896   42204 2421364  24f274 obj-tmp/vmlinux

at91x40, DT enabled
   text    data     bss     dec     hex filename
1569156   74540   52988 1696684  19e3ac obj-tmp/vmlinux

at91x40, DT disabled
   text    data     bss     dec     hex filename
1498748   72184   53320 1624252  18c8bc obj-tmp/vmlinux

That is 60 to 70 KB on object size, plus whatever the
runtime data structures take, minus the board file.
In total, I'd expect around 100KB overhead for DT enablement,
most of it in ROM for XIP_KERNEL users.

I agree that this is a significant amount for a tightly constraint
system, and we have to weigh that carefully against the overall
picture. Another way of looking at the overhead is by comparing
it to the usual bloat we accumulate. I expect that within one to
three years, the kernel will grow by the same amount that DT
adds, so for a given feature set, removing DT from the picture
extends the lifetime of a platform by those years.

We have been enforcing the DT-only rule rather strictly in the
past for new platforms, for two reasons:

a) making exceptions for some people often leads to other people
   asking for more exceptions. We are probably at the point now
   where this is no longer a problem for DT, as it is widely
   established now: all new platform submissions are using it,
   so we could have a special rule about NOMMU if we all agree
   it's a good idea.

b) There is a hope that we can at some point in the future make
   everything DT-only on ARM, after all platforms that anyone still
   cares about have been converted to DT and the others have been
   removed. This may be 5-10 years in the future, since there are
   still platforms that people are using but not actively converting
   to DT (e.g. sa1100 or ixp4xx).

Relaxing the rules for new platforms probably means we are giving
up on the goal of ever going to DT-only for ARM. It may be that it
was an unrealistic goal to start with, but I think we need a broader
consensus among developers before we do that.

One thing we can probably do is enable both DT and ATAGS based
booting for the platform, so you can disable DT for the most
tightly constrained machines, but still allow getting upstream
support for a new board without necessarily adding a board file.

I'm definitely all for adding new platforms when they have an
active maintainer.

> I've said this before - I have an Oki M675001 based nommu platform, which
> is ARM7TDMI based, and I have patches for that which I've been carrying
> locally since 2011.  I /could/ add it into my test farm and have it
> running nightly tests /if/ mainline kernels supported it, but they don't,
> so I don't.
> 
> We either /need/ to get more support for these platforms, or get rid of
> nommu support on ARM altogether as it's a source of repeated problems
> like this - we only ever find problems with nommu after the fact.

One thing I'd like to do that would have helped here is improve
build testing support by making it possible to build ARCH_MULTIPLATFORM
with MMU disabled, and get things like multi_v5_defconfig with MMU
turned off into automated build bots. I realize that there is very
little incentive to actually run a nommu kernel with support for
multiple platforms in production, and in most cases it won't work
because CONFIG_DRAM_BASE doesn't match, but it still seems like the
right approach to allow it, and put new nommu platforms into
ARCH_MULTIPLATFORM from the start.

> So, I want one of two things to happen: either more nommu platforms merged
> (preferably ones that we can boot test) or we delete nommu support.
> Continuing as we are is not an option.

One note about this: it doesn't have to be all-or-nothing, as we have
three or four classes of nommu chips. The ARM7TDMI (and to a lesser
degree ARM9TDMI, ARM1156T2 and FA510) was extremely popular in the old
days but is getting rarely used in new designs running Linux, and
replaced by Cortex-M class cores. Emcraft is probably the company with
the best NOMMU ARM Linux support now, and they only support Cortex-M3/M4
based SoCs (and use an ancient kernel), see http://www.emcraft.com/products.
With the current hype around 'Internet-of-things', we'll likely see
more people work on ARMv7-M Linux.

Neither of those however would have caught the particular bug I found,
as that is only for ARMv7-R. I believe there were at some point patches
to support actual ARMv7-R hardware but what we have upstream is incomplete
because you can't build an upstream kernel that runs on a real system.
ARMv8-R seems very interesting to support in the future, but no hardware
has been announced.

By architecture level, I'd say:

* ARMv7-M: keep it, as we just merged efm32 support, merge more if possible.
* ARMv4T/V5: either drop it after at91 becomes multiplatform and we remove
  at91x40 support, or merge your Lapis ML675001 support
* ARMv7-R: See if anyone is interested on working on it again, otherwise
  we can probably remove the bits we have.
* ARMv6/v7-A: no idea, it doesn't seem that useful, probably depends on
  what we do with ARMv4T/V5 and ARMv7-R.
* ARMv8-R: wait what happens.

	Arnd
