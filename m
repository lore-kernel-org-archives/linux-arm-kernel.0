From: tony@atomide.com (Tony Lindgren)
Date: Mon, 2 Aug 2010 15:52:24 +0300
Subject: [PATCH v7 0/3] omap3 nand: cleanup exiting platform related code
In-Reply-To: <1278666886-30293-1-git-send-email-s-ghorai@ti.com>
References: <1278666886-30293-1-git-send-email-s-ghorai@ti.com>
Message-ID: <20100802125224.GJ12293@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sukumar Ghorai <s-ghorai@ti.com> [100709 12:09]:
>    The following set of patches applies on top of for-next branch.
> 	http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git
>    Patches verified on: omap3430-SDP, omap3630-sdp, zoom3 and beagle board
> 
>    And these are the patches required to address the following input -
>      1. The NAND driver needs to stop tinkering with the GPMC registers
> 	The omap General Purpose Memory Controller (GPMC) registers are omap
>         specific, and not driver specific. Tinkering with these registers can
>         cause issues with the other devices on the GPMC.
> 
>      2. Passing hardcoded GPMC_CS0_BASE needs to go from the board files
> 	Passing hardcoded GPMC virtual addressess is sure way to mess up things.
>         This should all become unnecessary once the NAND drivers stops messing
>         with the GPMC registers directly.

Thanks, I'll add this series into omap-for-linus.

Regards,

Tony

>      Discussion: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg27630.html
> 
>    No code change from previous version.
>    Looping linux-arm-kernel mailing list with new version.
> 
>    Changes in this series -
> 	gpmc_hwcontrol() function in gpmc.c, break into various small function.
>    v6: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg31936.html
> 
>   Unused function removed.
>   v5: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg30305.html
> 		
>   Functions related to ecc and prefetch engine are optimized.
>   v4: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg29458.html
> 
>   Few functionality was missing  like - There should be some locking as only
>    one chipselect can use the ECC or prefetch engine at a time. If you have
>    NAND in two chipselects, bad things would happen.
>   v3: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg28715.html
> 
>   Additionally, it was needed to implement more functions for the platform
>   init code to use.
>   v2: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg28467.html
> 	
>   v1: http://www.mail-archive.com/linux-omap at vger.kernel.org/msg28164.html
> 
> 
> Sukumar Ghorai (3):
> 	omap3 gpmc: functionality enhancement
> 	omap3 nand: cleanup virtual address usages
> 	omap3 nand: fix issue in board file to detect nand
>  arch/arm/mach-omap2/board-cm-t35.c         |   20 +--
>  arch/arm/mach-omap2/board-devkit8000.c     |   25 +---
>  arch/arm/mach-omap2/board-omap3beagle.c    |   24 +---
>  arch/arm/mach-omap2/board-omap3touchbook.c |   25 +---
>  arch/arm/mach-omap2/board-overo.c          |   24 +---
>  arch/arm/mach-omap2/board-sdp-flash.c      |    5 -
>  arch/arm/mach-omap2/gpmc-nand.c            |   38 +---
>  arch/arm/mach-omap2/gpmc.c                 |  285 ++++++++++++++++++++++++++--
>  arch/arm/plat-omap/include/plat/gpmc.h     |   42 ++++-
>  arch/arm/plat-omap/include/plat/nand.h     |    6 +-
>  drivers/mtd/nand/omap2.c                   |  218 ++++++----------------
>  11 files changed, 371 insertions(+), 341 deletions(-)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
