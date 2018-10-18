From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 18 Oct 2018 11:57:06 +0200
Subject: [PATCH v4 4/6] clocksource: exynos_mct: Add arch_timer cooperation
 mode for ARM64
In-Reply-To: <20181018095708.1527-1-m.szyprowski@samsung.com>
References: <20181018095708.1527-1-m.szyprowski@samsung.com>
 <CGME20181018095717eucas1p20a7d2d2b1b18ae60a4893a8e3d8c19f9@eucas1p2.samsung.com>
Message-ID: <20181018095708.1527-5-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get ARM Architected Timers working on Samsung Exynos SoCs, one has to
first configure and enable Exynos Multi-Core Timer, because they both
share some common hardware blocks (global system counter). This patch
adds a mode of cooperation with arch_timer driver, so kernel can use
CP15 based timer interface via arch_timer driver, which is mandatory
on ARM64. In such mode MCT driver only enables its clocks and starts
global timer. Everything else will be handled by arch_timer driver.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/clocksource/exynos_mct.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 4c886ff2941a..1f5249fb25fd 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -606,6 +606,16 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	if (ret)
 		return ret;
 
+	if (IS_ENABLED(CONFIG_ARM64) && IS_ENABLED(CONFIG_ARM_ARCH_TIMER)) {
+		struct device_node *np = of_find_compatible_node(NULL, NULL,
+							     "arm,armv8-timer");
+		if (np) {
+			of_node_put(np);
+			exynos4_mct_frc_start();
+			return 0;
+		}
+	}
+
 	ret = exynos4_timer_interrupts(np, int_type);
 	if (ret)
 		return ret;
-- 
2.17.1
