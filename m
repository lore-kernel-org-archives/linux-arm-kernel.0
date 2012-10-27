From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 27 Oct 2012 10:02:10 +0100
Subject: [GIT PULL] omap plat header removal for v3.8 merge window, part1
In-Reply-To: <20121026223848.GY11908@atomide.com>
References: <20121019023300.GN30550@atomide.com>
 <201210261402.19759.arnd@arndb.de> <20121026170949.GF11908@atomide.com>
 <201210261728.22132.arnd@arndb.de> <20121026175537.GL11908@atomide.com>
 <20121026223848.GY11908@atomide.com>
Message-ID: <20121027090210.GJ28061@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 03:38:49PM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [121026 10:57]:
> > * Arnd Bergmann <arnd@arndb.de> [121026 10:30]:
> > > 
> > > Well, once CONFIG_MULTIPLATFORM gets enabled, the mach/*.h files are
> > > not visible to drivers any more, but they are still visible to files
> > > in plat-omap if you add a line like
> > > 
> > > ccflags-$(CONFIG_ARCH_OMAP2) := -I$(srctree)/arch/arm/mach-omap2/include
> > > ccflags-$(CONFIG_ARCH_OMAP1) := -I$(srctree)/arch/arm/mach-omap1/include
> > > 
> > > to arch/arm/plat-omap/Makefile. That is how the other multiplatform
> > > Makefiles do it. If a driver writer really wants to cheat, they can of
> > > course do the same thing in their directory, but they can also do
> > > #include "../../../../arch/arm/mach-omap2/foo.h"
> > 
> > OK thanks for clarifying that. Sounds like that can be used to
> > fix up the relative includes for plat-omap. I'll do some patches
> > for that after we have the #include <plat/*.h> and #include <mach/*.h>
> > issue sorted out.
> 
> Here's a patch for that. It's against what I have queued up in
> omap-for-v3.8/cleanup-headers. Does that look OK to you?
> 
> Regards,
> 
> Tony
> 
> 
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 26 Oct 2012 15:06:40 -0700
> Subject: [PATCH] ARM: OMAP: Fix relative includes for plat-omap with ccflags
> 
> As suggested by Arnd Bergmann <arnd@arndb.de>, we can keep
> these headers local to arch/arm/*omap*/ by modifying the
> ccflags in plat/omap/Makefile.
> 
> Note that eventually even most of these will go away
> as things like SRAM and PRCM become just regular device
> drivers.
> 
> Also note that this will not fix plat/cpu.h, but that
> will be removed anyways as soon as the drivers are
> fixed.
> 
> While at it, also sort the includes the standard way.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> diff --git a/arch/arm/mach-omap1/Makefile b/arch/arm/mach-omap1/Makefile
> index cd169c3..03b1e80 100644
> --- a/arch/arm/mach-omap1/Makefile
> +++ b/arch/arm/mach-omap1/Makefile
> @@ -2,6 +2,8 @@
>  # Makefile for the linux kernel.
>  #
>  
> +ccflags-$(CONFIG_ARCH_OMAP) := -I$(srctree)/arch/arm
> +

Rather than moving all the files from plat-omap/include/plat into plat-omap
and then having all these totally disgusting relative includes, why don't
you add to these makefiles:

ccflags += -I$(srctree)/arch/arm/plat-omap/include

and avoid all that include moving and all the include name fixup?
