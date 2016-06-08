From: matthew@mattleach.net (Matthew Leach)
Date: Wed,  8 Jun 2016 19:30:58 +0100
Subject: [RFC PATCH 03/15] clk: samsung: exynos4: fixup reg access on be
In-Reply-To: <20160608183110.13851-1-matthew@mattleach.net>
References: <20160608183110.13851-1-matthew@mattleach.net>
Message-ID: <20160608183110.13851-4-matthew@mattleach.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the byte-order aware big endian accessors, allowing for kernels
running under big-endian.

Signed-off-by: Matthew Leach <matthew@mattleach.net>
---
CC: Sylwester Nawrocki <s.nawrocki@samsung.com>
CC: Tomasz Figa <tomasz.figa@gmail.com>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@codeaurora.org>
CC: Kukjin Kim <kgene@kernel.org>
CC: Krzysztof Kozlowski <k.kozlowski@samsung.com>
CC: linux-samsung-soc at vger.kernel.org
CC: linux-clk at vger.kernel.org
CC: linux-arm-kernel at lists.infradead.org
CC: linux-kernel at vger.kernel.org
---
 drivers/clk/samsung/clk-exynos4.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 7b3d0f9..35a977d 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -1375,12 +1375,12 @@ static void __init exynos4x12_core_down_clock(void)
 	if (num_possible_cpus() == 4)
 		tmp |= PWR_CTRL1_USE_CORE3_WFE | PWR_CTRL1_USE_CORE2_WFE |
 		       PWR_CTRL1_USE_CORE3_WFI | PWR_CTRL1_USE_CORE2_WFI;
-	__raw_writel(tmp, reg_base + PWR_CTRL1);
+	writel_relaxed(tmp, reg_base + PWR_CTRL1);
 
 	/*
 	 * Disable the clock up feature in case it was enabled by bootloader.
 	 */
-	__raw_writel(0x0, reg_base + E4X12_PWR_CTRL2);
+	writel_relaxed(0x0, reg_base + E4X12_PWR_CTRL2);
 }
 
 #define E4210_CPU_DIV0(apll, pclk_dbg, atb, periph, corem1, corem0)	\
-- 
2.8.3
