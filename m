From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 3 Oct 2011 09:30:20 +0200
Subject: [PATCH] clocksource: fixup ux500 build problems
Message-ID: <mailman.163.1317627492.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on a patch from Arnd Bergmann this fixes up the build
problem of assigning a non-existing global when the ux500 PRCMU
timer is not linked in by passing its base address to the init
function. We also add a missing <linux/errno.h> inclusion and
staticize the dummy function.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-ux500/timer.c               |    9 ++++++---
 drivers/clocksource/clksrc-dbx500-prcmu.c |    6 ++++--
 include/linux/clksrc-dbx500-prcmu.h       |    6 ++----
 3 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 08c55a5..aea467d 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -5,6 +5,7 @@
  * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson
  */
 #include <linux/io.h>
+#include <linux/errno.h>
 #include <linux/clksrc-dbx500-prcmu.h>

 #include <asm/localtimer.h>
@@ -16,18 +17,20 @@

 static void __init ux500_timer_init(void)
 {
+       void __iomem *prcmu_timer_base;
+
        if (cpu_is_u5500()) {
 #ifdef CONFIG_LOCAL_TIMERS
                twd_base =3D __io_address(U5500_TWD_BASE);
 #endif
                mtu_base =3D __io_address(U5500_MTU0_BASE);
-               clksrc_dbx500_timer_base =3D
__io_address(U5500_PRCMU_TIMER_3_BASE);
+               prcmu_timer_base =3D __io_address(U5500_PRCMU_TIMER_3_BASE)=
;
        } else if (cpu_is_u8500()) {
 #ifdef CONFIG_LOCAL_TIMERS
                twd_base =3D __io_address(U8500_TWD_BASE);
 #endif
                mtu_base =3D __io_address(U8500_MTU0_BASE);
-               clksrc_dbx500_timer_base =3D
__io_address(U8500_PRCMU_TIMER_4_BASE);
+               prcmu_timer_base =3D __io_address(U8500_PRCMU_TIMER_4_BASE)=
;
        } else {
                ux500_unknown_soc();
        }
@@ -50,7 +53,7 @@ static void __init ux500_timer_init(void)
         */

        nmdk_timer_init();
-       clksrc_dbx500_prcmu_init();
+       clksrc_dbx500_prcmu_init(prcmu_timer_base);
 }

 static void ux500_timer_reset(void)
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c
b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 0ac5093..59feefe 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -31,7 +31,7 @@

 #define SCHED_CLOCK_MIN_WRAP 131072 /* 2^32 / 32768 */

-void __iomem *clksrc_dbx500_timer_base;
+static void __iomem *clksrc_dbx500_timer_base;

 static cycle_t clksrc_dbx500_prcmu_read(struct clocksource *cs)
 {
@@ -79,8 +79,10 @@ static void notrace
clksrc_dbx500_prcmu_update_sched_clock(void)
 }
 #endif

-void __init clksrc_dbx500_prcmu_init(void)
+void __init clksrc_dbx500_prcmu_init(void __iomem *base)
 {
+       clksrc_dbx500_timer_base =3D base;
+
        /*
         * The A9 sub system expects the timer to be configured as
         * a continous looping timer.
diff --git a/include/linux/clksrc-dbx500-prcmu.h
b/include/linux/clksrc-dbx500-prcmu.h
index d1e9504..4fb8119 100644
--- a/include/linux/clksrc-dbx500-prcmu.h
+++ b/include/linux/clksrc-dbx500-prcmu.h
@@ -11,12 +11,10 @@
 #include <linux/init.h>
 #include <linux/io.h>

-extern void __iomem *clksrc_dbx500_timer_base;
-
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU
-void __init clksrc_dbx500_prcmu_init(void);
+void __init clksrc_dbx500_prcmu_init(void __iomem *base);
 #else
-void __init clksrc_dbx500_prcmu_init(void) {}
+static inline void __init clksrc_dbx500_prcmu_init(void __iomem *base) {}
 #endif

 #endif
--=20
1.7.3.2

I will send a new pull request separately.

Thanks!
Linus Walleij
