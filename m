From: chirantan@chromium.org (Chirantan Ekbote)
Date: Tue,  3 Jun 2014 11:48:19 -0700
Subject: [PATCH] arm: mct: Don't reset the counter during boot and resume
Message-ID: <1401821299-24431-1-git-send-email-chirantan@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unfortunately on some exynos systems, resetting the mct counter also
resets the architected timer counter.  This can cause problems if the
architected timer driver has already been initialized because the kernel
will think that the counter has wrapped around, causing a big jump in
printk timestamps and delaying any scheduled clock events until the
counter reaches the value it had before it was reset.

The kernel code makes no assumptions about the initial value of the mct
counter so there is no reason from a software perspective to clear the
counter before starting it.  This also fixes the problems described in
the previous paragraph.

Cc: Olof Johansson <olof@lixom.net>
Cc: Doug Anderson <dianders@chromium.org>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
---
 drivers/clocksource/exynos_mct.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index acf5a32..9b4a0ae 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -152,13 +152,10 @@ static void exynos4_mct_write(unsigned int value, unsigned long offset)
 }
 
 /* Clocksource handling */
-static void exynos4_mct_frc_start(u32 hi, u32 lo)
+static void exynos4_mct_frc_start(void)
 {
 	u32 reg;
 
-	exynos4_mct_write(lo, EXYNOS4_MCT_G_CNT_L);
-	exynos4_mct_write(hi, EXYNOS4_MCT_G_CNT_U);
-
 	reg = __raw_readl(reg_base + EXYNOS4_MCT_G_TCON);
 	reg |= MCT_G_TCON_START;
 	exynos4_mct_write(reg, EXYNOS4_MCT_G_TCON);
@@ -180,7 +177,7 @@ static cycle_t exynos4_frc_read(struct clocksource *cs)
 
 static void exynos4_frc_resume(struct clocksource *cs)
 {
-	exynos4_mct_frc_start(0, 0);
+	exynos4_mct_frc_start();
 }
 
 struct clocksource mct_frc = {
@@ -194,7 +191,7 @@ struct clocksource mct_frc = {
 
 static void __init exynos4_clocksource_init(void)
 {
-	exynos4_mct_frc_start(0, 0);
+	exynos4_mct_frc_start();
 
 	if (clocksource_register_hz(&mct_frc, clk_rate))
 		panic("%s: can't register clocksource\n", mct_frc.name);
-- 
1.9.1.423.g4596e3a
