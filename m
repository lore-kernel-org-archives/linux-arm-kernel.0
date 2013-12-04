From: horms@verge.net.au (Simon Horman)
Date: Wed, 4 Dec 2013 15:26:07 +0900
Subject: [GIT PULL 00/28] Renesas ARM based SoC updates for v3.14
In-Reply-To: <20131204011745.GD20332@quad.lixom.net>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
 <20131204011745.GD20332@quad.lixom.net>
Message-ID: <20131204062605.GA6283@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 05:17:45PM -0800, Olof Johansson wrote:
> Hi Simon,
> 
> On Mon, Dec 02, 2013 at 11:18:47AM +0900, Simon Horman wrote:
> > Hi Kevin, Hi Olof, Hi Arnd,
> > 
> > please consider these Renesas ARM based SoC updates for v3.14.
> > 
> > This pull-request is based on "[GIT PULL 00/16] Renesas ARM based SoC
> > defconfig updates for v3.14" (tag: renesas-defconfig-for-v3.14) which I
> > send a pull-request for on Thursday. The reason for this is to include
> > defconfig updates for the emma2 based kzm9d which are required in order to
> > avoid a build regression when using the defconfig for that board.
> 
> If you can get a build regression due to an outdated defconfig, then you're
> likely missing some dependencies in your Kconfig? You could hit the same state
> of configurations through randconfig. So I think fixing the dependencies is
> better than relying on the defconfig branch in this case.
> 
> Would you mind doing it that way instead? It'd reduce our dependencies and in
> general it's a more appropriate approach.

The problem that I was trying to address was that
"ARM: shmobile: Remove legacy KZM9D board code" removes
legacy board code and thus the following line from
arch/arm/mach-shmobile/Makefile.boot

loadaddr-$(CONFIG_MACH_KZM9D) += 0x40008000

My understanding is that a result of this change is that
CONFIG_AUTO_ZRELADDR is now needed in order for the kernel
to compile.

Is it appropriate to set CONFIG_AUTO_ZRELADDR in Kconfig?
Or is there another approach that I could take?

> > This pull-request also includes defconfig changes related to renaming
> > ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY. These are also to avoid build
> > regressions when using defconfigs.
> 
> So what happens if someone has an old defconfig in their build environment
> (i.e. hosted outside of the kernel tree), will they see breakage?

Yes, I believe so.

> If so, you should probably add a new option ARCH_SHMOBILE_MULTI or similar.

We have added ARCH_SHMOBILE_MULTI.

The changelog entry describes the motivation for the change as well as I
could.  My view on this is that its global change that avoids an even more
widespread global change.

    From:  Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

    ARM: Rename ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY

    SH-Mobile platforms are transitioning from non-multiplatform to
    multiplatform kernel. A new ARCH_SHMOBILE_MULTI configuration symbol has
    been created to group all multiplatform-enabled SH-Mobile SoCs. The
    existing ARCH_SHMOBILE configuration symbol groups SoCs that haven't
    been converted yet.

    This arrangement works fine for the arch/ code, but lots of drivers
    needed on both ARCH_SHMOBILE and ARCH_SHMOBILE_MULTI depend on
    ARCH_SHMOBILE only. In order to avoid changing them, rename
    ARCH_SHMOBILE to ARCH_SHMOBILE_LEGACY, and create a new boolean
    ARCH_SHMOBILE configuration symbol that is selected by both
    ARCH_SHMOBILE_LEGACY and ARCH_SHMOBILE_MULTI.

    Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
    Acked-by: Magnus Damm <damm@opensource.se>
    Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

> We had similar issues with the first attempt to go multiplatform on Exynos,
> some existing defconfigs wouldn't build a usable kernel any more due to new
> options, so Arnd had to do it the other way (that code is still unmerged
> though).
