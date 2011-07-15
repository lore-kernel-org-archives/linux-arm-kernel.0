From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 15 Jul 2011 21:33:12 +0200
Subject: [PATCH REPOST] ARM: fix regression in IXP4xx clocksource
Message-ID: <m3zkkfpcef.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Cochran <richardcochran@gmail.com>

Commit 234b6ceddb4fc2a4bc5b9a7670f070f6e69e0868

   clocksource: convert ARM 32-bit up counting clocksources

broke the build for ixp4xx and made big endian operation impossible.
This commit restores the original behaviour.

Signed-off-by: Richard Cochran <richard.cochran@omicron.at>
Signed-off-by: Krzysztof Ha?asa <khc@pm.waw.pl>

diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 74ed81a..0777257 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -419,14 +419,20 @@ static void notrace ixp4xx_update_sched_clock(void)
 /*
  * clocksource
  */
+
+static cycle_t ixp4xx_clocksource_read(struct clocksource *c)
+{
+	return *IXP4XX_OSTS;
+}
+
 unsigned long ixp4xx_timer_freq = IXP4XX_TIMER_FREQ;
 EXPORT_SYMBOL(ixp4xx_timer_freq);
 static void __init ixp4xx_clocksource_init(void)
 {
 	init_sched_clock(&cd, ixp4xx_update_sched_clock, 32, ixp4xx_timer_freq);
 
-	clocksource_mmio_init(&IXP4XX_OSTS, "OSTS", ixp4xx_timer_freq, 200, 32,
-			clocksource_mmio_readl_up);
+	clocksource_mmio_init(NULL, "OSTS", ixp4xx_timer_freq, 200, 32,
+			ixp4xx_clocksource_read);
 }
 
 /*


-- 
Krzysztof Halasa
