From: grinberg@compulab.co.il (Igor Grinberg)
Date: Thu, 13 Jan 2011 18:24:49 +0200
Subject: [PATCH 1/2] arm: omap3: cm-t3517: rtc fix
In-Reply-To: <1294935890-31160-1-git-send-email-grinberg@compulab.co.il>
References: <1294935890-31160-1-git-send-email-grinberg@compulab.co.il>
Message-ID: <1294935890-31160-2-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix rtc gpios and mux

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 5b0c777..1706df0 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -124,8 +124,9 @@ static inline void cm_t3517_init_hecc(void) {}
 #if defined(CONFIG_RTC_DRV_V3020) || defined(CONFIG_RTC_DRV_V3020_MODULE)
 #define RTC_IO_GPIO		(153)
 #define RTC_WR_GPIO		(154)
-#define RTC_RD_GPIO		(160)
+#define RTC_RD_GPIO		(53)
 #define RTC_CS_GPIO		(163)
+#define RTC_CS_EN_GPIO		(160)
 
 struct v3020_platform_data cm_t3517_v3020_pdata = {
 	.use_gpio	= 1,
@@ -145,6 +146,16 @@ static struct platform_device cm_t3517_rtc_device = {
 
 static void __init cm_t3517_init_rtc(void)
 {
+	int err;
+
+	err = gpio_request(RTC_CS_EN_GPIO, "rtc cs en");
+	if (err) {
+		pr_err("CM-T3517: rtc cs en gpio request failed: %d\n", err);
+		return;
+	}
+
+	gpio_direction_output(RTC_CS_EN_GPIO, 1);
+
 	platform_device_register(&cm_t3517_rtc_device);
 }
 #else
@@ -256,11 +267,19 @@ static void __init cm_t3517_init_irq(void)
 static struct omap_board_mux board_mux[] __initdata = {
 	/* GPIO186 - Green LED */
 	OMAP3_MUX(SYS_CLKOUT2, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
-	/* RTC GPIOs: IO, WR#, RD#, CS# */
+
+	/* RTC GPIOs: */
+	/* IO - GPIO153 */
 	OMAP3_MUX(MCBSP4_DR, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+	/* WR# - GPIO154 */
 	OMAP3_MUX(MCBSP4_DX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
-	OMAP3_MUX(MCBSP_CLKS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+	/* RD# - GPIO53 */
+	OMAP3_MUX(GPMC_NCS2, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+	/* CS# - GPIO163 */
 	OMAP3_MUX(UART3_CTS_RCTX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+	/* CS EN - GPIO160 */
+	OMAP3_MUX(MCBSP_CLKS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+
 	/* HSUSB1 RESET */
 	OMAP3_MUX(UART2_TX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 	/* HSUSB2 RESET */
-- 
1.7.2.5
