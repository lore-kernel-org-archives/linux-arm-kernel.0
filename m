From: t.figa@samsung.com (Tomasz Figa)
Date: Mon, 15 Apr 2013 16:42:01 +0200
Subject: [PATCH v2 2/3] ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
In-Reply-To: <1366036922-4103-1-git-send-email-t.figa@samsung.com>
References: <1366036922-4103-1-git-send-email-t.figa@samsung.com>
Message-ID: <1366036922-4103-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch extends exynos_init_time() function to handle Exynos4210 rev0
SoC, which differs in availability of system timers and needs different
clocksource initialization.

This makes it possible to use exynos_init_time() function as init_time
callback for all Exynos-based boards, including Universal_C210, which
originally had to use samsung_timer_init().

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/mach-exynos/common.c              | 6 +++++-
 arch/arm/mach-exynos/mach-universal_c210.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/common.c b/arch/arm/mach-exynos/common.c
index b65229d..ec596fc 100644
--- a/arch/arm/mach-exynos/common.c
+++ b/arch/arm/mach-exynos/common.c
@@ -51,6 +51,7 @@
 #include <plat/fimc-core.h>
 #include <plat/iic-core.h>
 #include <plat/tv-core.h>
+#include <plat/samsung-time.h>
 #include <plat/spi-core.h>
 #include <plat/regs-serial.h>
 
@@ -457,7 +458,10 @@ void __init exynos_init_time(void)
 		exynos4_clk_init(NULL);
 		exynos4_clk_register_fixed_ext(xxti_f, xusbxti_f);
 #endif
-		mct_init();
+		if (soc_is_exynos4210() && samsung_rev() == EXYNOS4210_REV_0)
+			samsung_timer_init();
+		else
+			mct_init();
 	}
 }
 
diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 020e1f4..a728812 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -1177,7 +1177,7 @@ MACHINE_START(UNIVERSAL_C210, "UNIVERSAL_C210")
 	.map_io		= universal_map_io,
 	.init_machine	= universal_machine_init,
 	.init_late	= exynos_init_late,
-	.init_time	= samsung_timer_init,
+	.init_time	= exynos_init_time,
 	.reserve        = &universal_reserve,
 	.restart	= exynos4_restart,
 MACHINE_END
-- 
1.8.1.5
