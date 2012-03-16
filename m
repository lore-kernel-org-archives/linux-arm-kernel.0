From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 16 Mar 2012 14:46:28 +0100
Subject: [PATCH 0/2] omap: board file changes to support dynamic irq alloc
In-Reply-To: <1331900647-3508-1-git-send-email-tarun.kanti@ti.com>
References: <1331900647-3508-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <4F634434.3080707@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarun,

On 3/16/2012 1:24 PM, Tarun Kanti DebBarma wrote:
> These two patches incorporate changes to OMAP1 and OMAP2 platforms
> board files whereby older references to OMAP_GPIO_IRQ macro are
> now replaced with gpio_to_irq(), thereby getting rid of static
> irq references.

Thanks for the board fix / cleanup.

...

>   arch/arm/mach-omap1/board-h2.c               |    8 ++++----
>   arch/arm/mach-omap1/board-h3.c               |    8 ++++----
>   arch/arm/mach-omap1/board-htcherald.c        |    6 +++---
>   arch/arm/mach-omap1/board-innovator.c        |    4 ++--
>   arch/arm/mach-omap1/board-nokia770.c         |    1 +
>   arch/arm/mach-omap1/board-osk.c              |   12 ++++++------
>   arch/arm/mach-omap1/board-palmte.c           |    2 +-
>   arch/arm/mach-omap1/board-palmtt.c           |    2 +-
>   arch/arm/mach-omap1/board-palmz71.c          |    2 +-
>   arch/arm/mach-omap1/board-voiceblue.c        |   16 +++++++---------
>   arch/arm/mach-omap2/board-2430sdp.c          |    2 +-
>   arch/arm/mach-omap2/board-4430sdp.c          |    2 +-
>   arch/arm/mach-omap2/board-apollon.c          |    6 ++++--
>   arch/arm/mach-omap2/board-devkit8000.c       |    3 ++-
>   arch/arm/mach-omap2/board-h4.c               |    2 +-
>   arch/arm/mach-omap2/board-omap3evm.c         |    2 +-
>   arch/arm/mach-omap2/board-omap4panda.c       |    2 +-
>   arch/arm/mach-omap2/board-rx51-peripherals.c |    3 ++-
>   arch/arm/mach-omap2/board-zoom-debugboard.c  |    3 ++-
>   arch/arm/mach-omap2/board-zoom-peripherals.c |    6 ++++--
>   arch/arm/mach-omap2/common-board-devices.c   |    2 +-

I guess, you should be able to remove even the MACRO definition? 

diff --git a/arch/arm/plat-omap/include/plat/gpio.h b/arch/arm/plat-omap/include/plat/gpio.h
index 9e86ee0..d4df414 100644
--- a/arch/arm/plat-omap/include/plat/gpio.h
+++ b/arch/arm/plat-omap/include/plat/gpio.h
@@ -158,10 +158,6 @@
 #define OMAP_MPUIO(nr)         (OMAP_MAX_GPIO_LINES + (nr))
 #define OMAP_GPIO_IS_MPUIO(nr) ((nr) >= OMAP_MAX_GPIO_LINES)
 
-#define OMAP_GPIO_IRQ(nr)      (OMAP_GPIO_IS_MPUIO(nr) ? \
-                                IH_MPUIO_BASE + ((nr) & 0x0f) : \
-                                IH_GPIO_BASE + (nr))
-
 #define METHOD_MPUIO           0
 #define METHOD_GPIO_1510       1
 #define METHOD_GPIO_1610       2


It will avoid that people use it going forward.

Regards,
Benoit
