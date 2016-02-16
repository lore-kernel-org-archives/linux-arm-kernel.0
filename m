From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 16 Feb 2016 15:20:31 +0900
Subject: [PATCH v5 2/3] clk: samsung: Don't build ARMv8 clock drivers on ARMv7
In-Reply-To: <1455603632-11158-1-git-send-email-k.kozlowski@samsung.com>
References: <1455603632-11158-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1455603632-11158-3-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the Exynos5433 (ARMv8 SoC) clock driver depends on ARCH_EXYNOS
so it is built also on ARMv7. This does not bring any kind of benefit.
There won't be a single kernel image for ARMv7 and ARMv8 SoCs (like
multi_v7 for ARMv7).

Instead build clock drivers only for respective SoC's architecture.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Changes since v4:
1. Move ARM64 clock entry just before COMMON_CLK_SAMSUNG to make it more
   consistent with selecting behavior. Newer platforms just select
   COMMON_CLK_SAMSUNG. Only S3C24XX select specific clock symbols.
2. Re-work behaviour on COMPILE_TEST=y to fix ignored compilation
   when COMPILE_TEST=y but COMMON_CLK_SAMSUNG=n.
   The COMMON_CLK_SAMSUNG=y is necessary always to compile ARM64 clocks.
3. I received reviews and tests (Chanwoo, Javier, Andi, Stephen - thank
   you guys!)... but the patch is now different so I decided to drop
   them. I am kindly asking for review/testing (again...).

Changes since v3:
1. Rebase on next-20160127.

Changes since v2:
1. Follow Arnd's advice making EXYNOS_ARM64_COMMON_CLK user-visible when
   COMPILE_TEST is enabled.
2. Dropped accumulated tags because the logic is now different.

Changes since v1:
1. Use one Kconfig symbol for clocks of all ARM64 SoCs (after
   discussion): EXYNOS_ARM64_COMMON_CLK.
2. Minor cleanups after Tomasz's comments.
3. Added tags: Chanwoo's, Sylwester's, Alim's and Tomasz's (the tags
   were given for v1 but assuming that change from 1. is not major
   enough to require re-tagging).
---
 drivers/clk/samsung/Kconfig  | 10 +++++++++-
 drivers/clk/samsung/Makefile |  4 ++--
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index dd6093a33f84..20c5fe92ab4a 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -1,6 +1,15 @@
+# Recent Exynos platforms should just select COMMON_CLK_SAMSUNG:
 config COMMON_CLK_SAMSUNG
 	bool "Samsung Exynos clock controller support" if COMPILE_TEST
+	# Clocks on ARM64 SoCs (e.g. Exynos5433, Exynos7) are chosen by
+	# EXYNOS_ARM64_COMMON_CLK to avoid building them on ARMv7:
+	select EXYNOS_ARM64_COMMON_CLK if ARM64 && ARCH_EXYNOS
 
+config EXYNOS_ARM64_COMMON_CLK
+	bool "Samsung Exynos ARMv8-family clock controller support" if COMPILE_TEST
+	depends on COMMON_CLK_SAMSUNG
+
+# For S3C24XX platforms, select following symbols:
 config S3C2410_COMMON_CLK
 	bool "Samsung S3C2410 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
@@ -22,4 +31,3 @@ config S3C2412_COMMON_CLK
 config S3C2443_COMMON_CLK
 	bool "Samsung S3C2443 clock controller support" if COMPILE_TEST
 	select COMMON_CLK_SAMSUNG
-
diff --git a/drivers/clk/samsung/Makefile b/drivers/clk/samsung/Makefile
index 5f6833ea355d..fc367d4b2902 100644
--- a/drivers/clk/samsung/Makefile
+++ b/drivers/clk/samsung/Makefile
@@ -10,11 +10,11 @@ obj-$(CONFIG_SOC_EXYNOS5250)	+= clk-exynos5250.o
 obj-$(CONFIG_SOC_EXYNOS5260)	+= clk-exynos5260.o
 obj-$(CONFIG_SOC_EXYNOS5410)	+= clk-exynos5410.o
 obj-$(CONFIG_SOC_EXYNOS5420)	+= clk-exynos5420.o
-obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos5433.o
+obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos5433.o
 obj-$(CONFIG_SOC_EXYNOS5440)	+= clk-exynos5440.o
 obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-audss.o
 obj-$(CONFIG_ARCH_EXYNOS)	+= clk-exynos-clkout.o
-obj-$(CONFIG_ARCH_EXYNOS7)	+= clk-exynos7.o
+obj-$(CONFIG_EXYNOS_ARM64_COMMON_CLK)	+= clk-exynos7.o
 obj-$(CONFIG_S3C2410_COMMON_CLK)+= clk-s3c2410.o
 obj-$(CONFIG_S3C2410_COMMON_DCLK)+= clk-s3c2410-dclk.o
 obj-$(CONFIG_S3C2412_COMMON_CLK)+= clk-s3c2412.o
-- 
2.5.0
