From: andi.shyti@samsung.com (Andi Shyti)
Date: Mon, 27 Jun 2016 22:03:13 +0900
Subject: [PATCH v2 1/2] clk: exynos5433: do not use CLK_IGNORE_UNUSED for SPI
 clocks
Message-ID: <1467032594-7643-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The CLK_IGNORE_UNUSED flag has to be avoided whenever possible.
Use the CLK_IS_CRITICAL flag instead, which enables the clock line
during boot time.

While none of the SCLK_SPI need to be alive all the time as that
clock is handled by the SPI driver as a busclk whenever needed.

Suggested-by: Tomasz Figa <tomasz.figa@gmail.com>
Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---

Hi,

this patch comes after Tomasz's review where he discouraged from
using the CLK_IGNORE_UNUSED flag. Therefore I added one more
patch to the original where I remove that flag for the SPI1
whenever not necessary while I replace it with the
CLK_IS_CRITICAL for the ioclk.

This patch makes this driver the first using the "critical"
functionality :)

Andi

 drivers/clk/samsung/clk-exynos5433.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index 128527b..dcb4391 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -1655,7 +1655,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
 			ENABLE_SCLK_PERIC, 13, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_SPI1, "sclk_ioclk_spi1", "ioclk_spi1_clk_in",
 			ENABLE_SCLK_PERIC, 12,
-			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+			CLK_IS_CRITICAL | CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_SPI0, "sclk_ioclk_spi0", "ioclk_spi0_clk_in",
 			ENABLE_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_I2S1_BCLK, "sclk_ioclk_i2s1_bclk",
@@ -1670,7 +1670,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_SPI2, "sclk_spi2", "sclk_spi2_peric", ENABLE_SCLK_PERIC,
 			5, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPI1, "sclk_spi1", "sclk_spi1_peric", ENABLE_SCLK_PERIC,
-			4, CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+			4, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SPI0, "sclk_spi0", "sclk_spi0_peric", ENABLE_SCLK_PERIC,
 			3, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UART2, "sclk_uart2", "sclk_uart2_peric",
-- 
2.8.1
