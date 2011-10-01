From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 01 Oct 2011 18:00:31 +0200
Subject: [GIT PULL] ux500-timers
In-Reply-To: <201109302228.46572.arnd@arndb.de>
References: <CACRpkdbCZwSdXzqvPCrGagaikc53xLyDTQaZMRtuyqo9vw=Yng@mail.gmail.com>
	<201109302228.46572.arnd@arndb.de>
Message-ID: <1422315.r6YLuIojzy@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 September 2011 22:28:46 Arnd Bergmann wrote:
> 
> > The following changes since commit d93dc5c4478c1fd5de85a3e8aece9aad7bbae044:
> > 
> >   Linux 3.1-rc7 (2011-09-21 16:58:15 -0700)
> > 
> > are available in the git repository at:
> >   git://git.linaro.org/people/triad/linux-stericsson.git ux500-nomadik-timers
> 
> pulled into a new top-level next/timer branch.

Hi Linus,

It caused a few build regressions:

- missing include of errno.h
- clksrc_dbx500_prcmu_init stub needs to be static inline, or it causes a
  link failure.
- clksrc_dbx500_timer_base may be initialized when it's not actually linked in

For the last one, I think it would actually be best to make the timer 
a platform_device and pass the address in platform_data or device tree
property, or alternatively make it an argument to clksrc_dbx500_prcmu_init
and make the variable static.

Please send a new pull request with these things fixed, either with
patches on top or replacing the original ones, whichever you prefer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/arch/arm/mach-ux500/timer.c b/arch/arm/mach-ux500/timer.c
index 08c55a5..fbbbe0b 100644
--- a/arch/arm/mach-ux500/timer.c
+++ b/arch/arm/mach-ux500/timer.c
@@ -5,6 +5,7 @@
  * Author: Mattias Wallin <mattias.wallin@stericsson.com> for ST-Ericsson
  */
 #include <linux/io.h>
+#include <linux/errno.h>
 #include <linux/clksrc-dbx500-prcmu.h>
 
 #include <asm/localtimer.h>
@@ -14,6 +15,8 @@
 #include <mach/setup.h>
 #include <mach/hardware.h>
 
+void __iomem *clksrc_dbx500_timer_base;
+
 static void __init ux500_timer_init(void)
 {
 	if (cpu_is_u5500()) {
diff --git a/drivers/clocksource/clksrc-dbx500-prcmu.c b/drivers/clocksource/clksrc-dbx500-prcmu.c
index 0ac5093..d5f7847 100644
--- a/drivers/clocksource/clksrc-dbx500-prcmu.c
+++ b/drivers/clocksource/clksrc-dbx500-prcmu.c
@@ -31,8 +31,6 @@
 
 #define SCHED_CLOCK_MIN_WRAP 131072 /* 2^32 / 32768 */
 
-void __iomem *clksrc_dbx500_timer_base;
-
 static cycle_t clksrc_dbx500_prcmu_read(struct clocksource *cs)
 {
 	u32 count, count2;
diff --git a/include/linux/clksrc-dbx500-prcmu.h b/include/linux/clksrc-dbx500-prcmu.h
index d1e9504..9f733cb 100644
--- a/include/linux/clksrc-dbx500-prcmu.h
+++ b/include/linux/clksrc-dbx500-prcmu.h
@@ -16,7 +16,7 @@ extern void __iomem *clksrc_dbx500_timer_base;
 #ifdef CONFIG_CLKSRC_DBX500_PRCMU
 void __init clksrc_dbx500_prcmu_init(void);
 #else
-void __init clksrc_dbx500_prcmu_init(void) {}
+static inline void __init clksrc_dbx500_prcmu_init(void) {}
 #endif
 
 #endif
