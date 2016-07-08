From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 21:47:38 +0900
Subject: [PATCH v5] clk: exynos5433: remove CLK_IGNORE_UNUSED flag from SPI
 clocks
Message-ID: <1467982058-14339-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit b82ec4e and a9e93e8 have added support in the spi device
driver for the three clock lines required by the SPI controller
and handles the dependency between the three (by not disabling
any after resume).

This way none of the SPI clocks require any criticality: remove,
then the CLK_IGNORE_UNUSED flag for the SPI related clocks.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---

Hi,

With this, I hope to have reached the end of this patch series :)

After some discussions with Tomasz first and Sylwester later, we
agreed to move all the clock management to the spi driver, here
are the patches that do that:

  http://marc.info/?l=linux-kernel&m=146787645626318&w=2
  http://marc.info/?l=linux-kernel&m=146798033221943&w=2

With the above modifications to the spi driver we don't need any
of the SPI related clocks to be marked either as critical or as
ignore unused.

Thanks,
Andi

 drivers/clk/samsung/clk-exynos5433.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index c3a5318..fb19525 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -1661,8 +1661,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
 	GATE(CLK_SCLK_IOCLK_SPI2, "sclk_ioclk_spi2", "ioclk_spi2_clk_in",
 			ENABLE_SCLK_PERIC, 13, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_SPI1, "sclk_ioclk_spi1", "ioclk_spi1_clk_in",
-			ENABLE_SCLK_PERIC, 12,
-			CLK_IGNORE_UNUSED | CLK_SET_RATE_PARENT, 0),
+			ENABLE_SCLK_PERIC, 12, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_SPI0, "sclk_ioclk_spi0", "ioclk_spi0_clk_in",
 			ENABLE_SCLK_PERIC, 11, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_IOCLK_I2S1_BCLK, "sclk_ioclk_i2s1_bclk",
@@ -1677,7 +1676,7 @@ static struct samsung_gate_clock peric_gate_clks[] __initdata = {
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
