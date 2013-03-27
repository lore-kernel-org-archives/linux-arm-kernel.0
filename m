From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 27 Mar 2013 11:37:45 +0000
Subject: [GIT PULL v2] Renesas ARM-based SoC board updates for v3.10
In-Reply-To: <CANqRtoT2gi4vObPwkRNkXkuCLWy0=otRqXedk32Wdgp+WS4vRg@mail.gmail.com>
References: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
 <201303221539.39742.arnd@arndb.de>
 <CANqRtoT2gi4vObPwkRNkXkuCLWy0=otRqXedk32Wdgp+WS4vRg@mail.gmail.com>
Message-ID: <201303271137.45652.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 March 2013, Magnus Damm wrote:
> On Sat, Mar 23, 2013 at 12:39 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Friday 22 March 2013, Simon Horman wrote:
> > I expect that in 3.10, we will have all ARMv6 and ARMv7 platforms converted,
> > with the exception of realview, mmp, s5p, msm, and shmobile. I'm sure we
> > can do realview and mmp for 3.11, possibly also s5p. For shmobile, I think
> > most of the work would be changing drivers/sh/clk to integrate into the common
> > clk framework, and you need to find a way to enable ARM_PATCH_PHYS_VIRT and
> > AUTO_ZRELADDR. Are those things you think can be done for 3.11?
> 
> Good to hear that most ARM platforms will be converted by v3.10. This
> is definitely something that I want to make happen for mach-shmobile
> as well.
> 
> Our biggest challenge now is the move to common clocks. I suspect that
> moving all our boards and SoCs to common clocks will take much longer
> than v3.11 I'm afraid.

Ok, I see. If you think it's not likely to be ready for 3.12, we might
need to discuss again whether there is another way of making the
common clk and the sh-clk code coexist. For instance, we could rename
all if the sh/shmobile specific clk functions and their users from
clk_* to shclk_*, and provide a thin wrapper around them that integrates
into common clk.
 
> Starting with something smaller like EMEV2 may be a good first step.
> So somehow I'd like to start converting them one by one, perhaps also
> moving over the converted SoCs/boards to CONFIG_ARCH_MULTIPLATFORM in
> an incremental fashion. Do you happen to have any example subarch that
> has been migrated in an increment fashion already?

We have had a few that were able to do both multiplatform and
single-platform for some time, but then changed to multiplatform-only.
I think mvebu and vt8500 are in this category.

> Regarding ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR, I believe those
> should be enabled for the mach-shmobile bits that are used with
> CONFIG_ARCH_MULTIPLATFORM. Best way forward there is TBD, any
> recommendations would be very welcome!

Yes, makes sense.

What I think you should do is rename CONFIG_ARCH_SHMOBILE to
CONFIG_ARCH_SHMOBILE_SINGLE, and add a new symbol in
arch/arm/mach-shmobile/Kconfig like

config ARCH_SHMOBILE
	bool "Renesas SH-Mobile / R-Mobile" if ARCH_MULTI_V6_V7
	default CONFIG_ARCH_SHMOBILE_SINGLE
        help
          Support for Renesas's SH-Mobile and R-Mobile ARM platforms.

This way, the platform is a non-exclusive option for the multiplatform
case, and a hidden enabled option when building CONFIG_ARCH_SHMOBILE_SINGLE.
Every machine that is not ready for multiplatform can then add "depends on
CONFIG_ARCH_SHMOBILE_SINGLE".

	Arnd
