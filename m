From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 22 Oct 2012 14:12:19 +0000
Subject: [GIT PULL] Renesas ARM-based SoC defconfig for v3.8
In-Reply-To: <20121022015126.GA10587@verge.net.au>
References: <1350448698-26985-1-git-send-email-horms@verge.net.au>
 <20121022003350.GL2509@verge.net.au> <20121022015126.GA10587@verge.net.au>
Message-ID: <201210221412.19486.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(adding Nico, who did a lot of the work to get rid of PLAT_PHYS_OFFSET)

On Monday 22 October 2012, Simon Horman wrote:
> On Mon, Oct 22, 2012 at 09:33:51AM +0900, Simon Horman wrote:
> > On Fri, Oct 19, 2012 at 08:18:50AM +0000, Arnd Bergmann wrote:
> > > On Friday 19 October 2012, Simon Horman wrote:
> > > > * A more significant problem seems to be the use of CONFIG_MEMORY_START
> > > >   to define PLAT_PHYS_OFFSET in arch/arm/mach-shmobile/include/mach/memory.h
> > > > 
> > > >   I'm not sure that I see an easy way to get around this one.
> > > 
> > > ARM_PATCH_PHYS_VIRT should take care of this, have you tried it?
> 
> I believe that this leaves mach-shmobile with three areas
> where CONFIG_MEMORY_START/PLAT_PHYS_OFFSET is used.

Hmm, I just noticed that in fact shmobile is the only remaining
platform that uses CONFIG_MEMORY_START with a per-board or per-soc
setting.

> * arch/arm/mach-shmobile/headsmp.S
> 
>   This uses PLAT_PHYS_OFFSET.
> 
>   I believe this can be replaced with a run-time calculation. Though I
>   haven't thought about the details yet.
> 
> * arch/arm/boot/compressed/head-shmobile.S
> 
>   This makes use of CONFIG_MEMORY_START.
> 
>   This is only used if CONFIG_ZBOOT_ROM is set.
> 
>   I'm unsure if this can be replaced with a run-time calculation or not.
>   But regardless it is only used if CONFIG_ZBOOT_ROM is set, which is not
>   the default at this time.

Right, you can probably make CONFIG_ZBOOT_ROM_MMCIF and
CONFIG_ZBOOT_ROM_SH_MOBILE_SDHI depend on !ARM_PATCH_PHYS_VIRT

> * arch/arm/mach-shmobile/Makefile.boot
> 
>  This makes use of CONFIG_MEMORY_START to set zreladdr.
> 
>  I believe that the solution to this is to make use of CONFIG_AUTO_ZRELADDR.
>  However, it is not yet clear to me how that can be used in conjunction
>  with a uImage.  As I understand it the boot loader on many of our boards,
>  including the Marzen board which is my first target for this work, boot
>  uImage imagess.

If this doesn't work, we probably also need to find a solution to
build multiple uImage files from the same vmlinux when building a
multiplatform kernel.

	Arnd
