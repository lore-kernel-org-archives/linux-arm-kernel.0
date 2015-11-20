From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 20 Nov 2015 09:12:40 +0900
Subject: [PATCH v2 1/2] clk: samsung: Don't build ARMv8 clock drivers on ARMv7
In-Reply-To: <1447978361-18010-1-git-send-email-k.kozlowski@samsung.com>
References: <1447978361-18010-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1447978361-18010-2-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the Exynos5433 (ARMv8 SoC) clock driver depends on ARCH_EXYNOS
so it is built also on ARMv7. This does not bring any kind of benefit.
There won't be a single kernel image for ARMv7 and ARMv8 SoCs (like
multi_v7 for ARMv7).

Instead build clock drivers only for respective SoC's architecture.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Alim Akhtar <alim.akhtar@samsung.com>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>

---

Changes since v1:
1. Use one Kconfig symbol for clocks of all ARM64 SoCs (after
   discussion): EXYNOS_ARM64_COMMON_CLK.
2. Minor cleanups after Tomasz's comments.
3. Added tags: Chanwoo's, Sylwester's, Alim's and Tomasz's (the tags
   were given for v1 but assuming that change from 1. is not major
   enough to require re-tagging).
---
 drivers/clk/samsung/Kconfig  | 6 ++++++
 drivers/clk/samsung/Makefile | 4 ++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/Kconfig b/drivers/clk/samsung/Kconfig
index 84196ecdaa12..3a2c032965e6 100644
--- a/drivers/clk/samsung/Kconfig
+++ b/drivers/clk/samsung/Kconfig
@@ -2,6 +2,7 @@ config COMMON_CLK_SAMSUNG
 	bool
 	select COMMON_CLK
 
+# ARM SoCs:
 config S3C2410_COMMON_CLK
 	bool
 	select COMMON_CLK_SAMSUNG
@@ -24,3 +25,8 @@ config S3C2443_COMMON_CLK
 	bool
 	select COMMON_CLK_SAMSUNG
 
+# ARM64 SoCs (e.g. Exynos5433, Exynos7):
+config EXYNOS_ARM64_COMMON_CLK
+	def_bool ARCH_EXYNOS
+	depends on ARM64 || COMPILE_TEST
+	select COMMON_CLK_SAMSUNG
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
1.9.1
