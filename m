From: r.sricharan@ti.com (sricharan)
Date: Fri, 11 Mar 2011 11:34:45 +0530
Subject: [PATCH V4 3/5] omap3: board-3430sdp: Initialise the serial pads.
In-Reply-To: <1299823486-27192-1-git-send-email-r.sricharan@ti.com>
References: <1299823486-27192-1-git-send-email-r.sricharan@ti.com>
Message-ID: <1299823486-27192-2-git-send-email-r.sricharan@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the mux framework to initialise the serial pads.

Signed-off-by: sricharan <r.sricharan@ti.com>
---
V1: Initial patch
V2: Remove flags that were to be used for only testing.
V3: Correct the off mode settings.
V4: Use the Macro to mux the static pads.

 arch/arm/mach-omap2/board-3430sdp.c |  102 ++++++++++++++++++++++++++++++++++-
 1 files changed, 101 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 5464bec..b391804 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -652,6 +652,106 @@ static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 static struct omap_board_mux board_mux[] __initdata = {
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
+
+static struct omap_device_pad serial1_pads[] __initdata = {
+	/*
+	 * Note that off output enable is an active low
+	 * signal. So setting this means pin is a
+	 * input enabled in off mode
+	 */
+	OMAP_MUX_STATIC("uart1_cts.uart1_cts",
+			 OMAP_PIN_INPUT |
+			 OMAP_PIN_OFF_INPUT_PULLDOWN |
+			 OMAP_OFFOUT_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart1_rts.uart1_rts",
+			 OMAP_PIN_OUTPUT |
+			 OMAP_OFF_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart1_rx.uart1_rx",
+			 OMAP_PIN_INPUT |
+			 OMAP_PIN_OFF_INPUT_PULLDOWN |
+			 OMAP_OFFOUT_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart1_tx.uart1_tx",
+			 OMAP_PIN_OUTPUT |
+			 OMAP_OFF_EN |
+			 OMAP_MUX_MODE0),
+};
+
+static struct omap_device_pad serial2_pads[] __initdata = {
+	OMAP_MUX_STATIC("uart2_cts.uart2_cts",
+			 OMAP_PIN_INPUT_PULLUP |
+			 OMAP_PIN_OFF_INPUT_PULLDOWN |
+			 OMAP_OFFOUT_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_rts.uart2_rts",
+			 OMAP_PIN_OUTPUT |
+			 OMAP_OFF_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_rx.uart2_rx",
+			 OMAP_PIN_INPUT |
+			 OMAP_PIN_OFF_INPUT_PULLDOWN |
+			 OMAP_OFFOUT_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart2_tx.uart2_tx",
+			 OMAP_PIN_OUTPUT |
+			 OMAP_OFF_EN |
+			 OMAP_MUX_MODE0),
+};
+
+static struct omap_device_pad serial3_pads[] __initdata = {
+	OMAP_MUX_STATIC("uart3_cts_rctx.uart3_cts_rctx",
+			 OMAP_PIN_INPUT_PULLDOWN |
+			 OMAP_PIN_OFF_INPUT_PULLDOWN |
+			 OMAP_OFFOUT_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_rts_sd.uart3_rts_sd",
+			 OMAP_PIN_OUTPUT |
+			 OMAP_OFF_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_rx_irrx.uart3_rx_irrx",
+			 OMAP_PIN_INPUT |
+			 OMAP_PIN_OFF_INPUT_PULLDOWN |
+			 OMAP_OFFOUT_EN |
+			 OMAP_MUX_MODE0),
+	OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
+			 OMAP_PIN_OUTPUT |
+			 OMAP_OFF_EN |
+			 OMAP_MUX_MODE0),
+};
+
+static struct omap_board_data serial1_data = {
+	.id		= 0,
+	.pads		= serial1_pads,
+	.pads_cnt	= ARRAY_SIZE(serial1_pads),
+};
+
+static struct omap_board_data serial2_data = {
+	.id		= 1,
+	.pads		= serial2_pads,
+	.pads_cnt	= ARRAY_SIZE(serial2_pads),
+};
+
+static struct omap_board_data serial3_data = {
+	.id		= 2,
+	.pads		= serial3_pads,
+	.pads_cnt	= ARRAY_SIZE(serial3_pads),
+};
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init_port(&serial1_data);
+	omap_serial_init_port(&serial2_data);
+	omap_serial_init_port(&serial3_data);
+}
+#else
+#define board_mux	NULL
+
+static inline void board_serial_init(void)
+{
+	omap_serial_init();
+}
 #endif
 
 /*
@@ -796,7 +896,7 @@ static void __init omap_3430sdp_init(void)
 	spi_register_board_info(sdp3430_spi_board_info,
 				ARRAY_SIZE(sdp3430_spi_board_info));
 	ads7846_dev_init();
-	omap_serial_init();
+	board_serial_init();
 	usb_musb_init(&musb_board_data);
 	board_smc91x_init();
 	board_flash_init(sdp_flash_partitions, chip_sel_3430, 0);
-- 
1.7.0.4
