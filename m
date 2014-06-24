From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 24 Jun 2014 15:57:12 +0200
Subject: [PATCH 3/6] clk: samsung: exynos4: Remove SRC_MASK_ISP gates
In-Reply-To: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
Message-ID: <1403618235-19353-4-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ISP special clocks have dedicated gating registers and so MUX SRC_MASK
register should not be used. This patch fixes the problem of
Exynos4x12-based boards freezing on system suspend, because those
mux outputs need not to be masked while suspending.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Cc: Mike Turquette <mturquette@linaro.org>
---
 drivers/clk/samsung/clk-exynos4.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 4f150c9..7f4a473 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -925,21 +925,13 @@ static struct samsung_gate_clock exynos4x12_gate_clks[] __initdata = {
 	GATE(CLK_RTC, "rtc", "aclk100", E4X12_GATE_IP_PERIR, 15,
 			0, 0),
 	GATE(CLK_KEYIF, "keyif", "aclk100", E4X12_GATE_IP_PERIR, 16, 0, 0),
-	GATE(CLK_SCLK_PWM_ISP, "sclk_pwm_isp", "div_pwm_isp",
-			E4X12_SRC_MASK_ISP, 0, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_SPI0_ISP, "sclk_spi0_isp", "div_spi0_isp_pre",
-			E4X12_SRC_MASK_ISP, 4, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_SPI1_ISP, "sclk_spi1_isp", "div_spi1_isp_pre",
-			E4X12_SRC_MASK_ISP, 8, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_UART_ISP, "sclk_uart_isp", "div_uart_isp",
-			E4X12_SRC_MASK_ISP, 12, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_PWM_ISP_SCLK, "pwm_isp_sclk", "sclk_pwm_isp",
+	GATE(CLK_PWM_ISP_SCLK, "pwm_isp_sclk", "div_pwm_isp",
 			E4X12_GATE_IP_ISP, 0, 0, 0),
-	GATE(CLK_SPI0_ISP_SCLK, "spi0_isp_sclk", "sclk_spi0_isp",
+	GATE(CLK_SPI0_ISP_SCLK, "spi0_isp_sclk", "div_spi0_isp_pre",
 			E4X12_GATE_IP_ISP, 1, 0, 0),
-	GATE(CLK_SPI1_ISP_SCLK, "spi1_isp_sclk", "sclk_spi1_isp",
+	GATE(CLK_SPI1_ISP_SCLK, "spi1_isp_sclk", "div_spi1_isp_pre",
 			E4X12_GATE_IP_ISP, 2, 0, 0),
-	GATE(CLK_UART_ISP_SCLK, "uart_isp_sclk", "sclk_uart_isp",
+	GATE(CLK_UART_ISP_SCLK, "uart_isp_sclk", "div_uart_isp",
 			E4X12_GATE_IP_ISP, 3, 0, 0),
 	GATE(CLK_WDT, "watchdog", "aclk100", E4X12_GATE_IP_PERIR, 14, 0, 0),
 	GATE(CLK_PCM0, "pcm0", "aclk100", E4X12_GATE_IP_MAUDIO, 2,
-- 
1.9.3
