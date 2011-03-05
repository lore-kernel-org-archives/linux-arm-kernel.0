From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 6 Mar 2011 00:40:19 +0800
Subject: [PATCH 1/4] ARM: mxs: add helper macro for pad control
In-Reply-To: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
References: <1299343222-30670-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <1299343222-30670-2-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is to add pad control helper macro to make the code easy
to read.  The need is being seen when adding pad definitions for
LCDIF which gets ~30 pads to define.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
 arch/arm/mach-mxs/include/mach/iomux.h |    3 +
 arch/arm/mach-mxs/mach-mx23evk.c       |   16 ++----
 arch/arm/mach-mxs/mach-mx28evk.c       |   82 +++++++++++---------------------
 3 files changed, 37 insertions(+), 64 deletions(-)

diff --git a/arch/arm/mach-mxs/include/mach/iomux.h b/arch/arm/mach-mxs/include/mach/iomux.h
index fe558e3..7abdf58 100644
--- a/arch/arm/mach-mxs/include/mach/iomux.h
+++ b/arch/arm/mach-mxs/include/mach/iomux.h
@@ -91,6 +91,9 @@ typedef u32 iomux_cfg_t;
 #define MXS_PAD_PULLUP	((PAD_PULLUP << MXS_PAD_PULL_SHIFT) | \
 					MXS_PAD_PULL_VALID_MASK)
 
+/* generic pad control used in most cases */
+#define MXS_PAD_CTRL	(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL)
+
 #define MXS_IOMUX_PAD(_bank, _pin, _muxsel, _ma, _vol, _pull)		\
 		(((iomux_cfg_t)(_bank) << MXS_PAD_BANK_SHIFT) |		\
 		((iomux_cfg_t)(_pin) << MXS_PAD_PIN_SHIFT) |		\
diff --git a/arch/arm/mach-mxs/mach-mx23evk.c b/arch/arm/mach-mxs/mach-mx23evk.c
index 0737ce2..d724054 100644
--- a/arch/arm/mach-mxs/mach-mx23evk.c
+++ b/arch/arm/mach-mxs/mach-mx23evk.c
@@ -28,18 +28,14 @@
 
 static const iomux_cfg_t mx23evk_pads[] __initconst = {
 	/* duart */
-	MX23_PAD_PWM0__DUART_RX | MXS_PAD_4MA,
-	MX23_PAD_PWM1__DUART_TX | MXS_PAD_4MA,
+	MX23_PAD_PWM0__DUART_RX | MXS_PAD_CTRL,
+	MX23_PAD_PWM1__DUART_TX | MXS_PAD_CTRL,
 
 	/* auart */
-	MX23_PAD_AUART1_RX__AUART1_RX |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX23_PAD_AUART1_TX__AUART1_TX |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX23_PAD_AUART1_CTS__AUART1_CTS |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX23_PAD_AUART1_RTS__AUART1_RTS |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX23_PAD_AUART1_RX__AUART1_RX | MXS_PAD_CTRL,
+	MX23_PAD_AUART1_TX__AUART1_TX | MXS_PAD_CTRL,
+	MX23_PAD_AUART1_CTS__AUART1_CTS | MXS_PAD_CTRL,
+	MX23_PAD_AUART1_RTS__AUART1_RTS | MXS_PAD_CTRL,
 };
 
 static void __init mx23evk_init(void)
diff --git a/arch/arm/mach-mxs/mach-mx28evk.c b/arch/arm/mach-mxs/mach-mx28evk.c
index 1f0b708..987e3d5 100644
--- a/arch/arm/mach-mxs/mach-mx28evk.c
+++ b/arch/arm/mach-mxs/mach-mx28evk.c
@@ -33,68 +33,42 @@
 
 static const iomux_cfg_t mx28evk_pads[] __initconst = {
 	/* duart */
-	MX28_PAD_PWM0__DUART_RX |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX28_PAD_PWM1__DUART_TX |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_PWM0__DUART_RX | MXS_PAD_CTRL,
+	MX28_PAD_PWM1__DUART_TX | MXS_PAD_CTRL,
 
 	/* auart0 */
-	MX28_PAD_AUART0_RX__AUART0_RX |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX28_PAD_AUART0_TX__AUART0_TX |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX28_PAD_AUART0_CTS__AUART0_CTS |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX28_PAD_AUART0_RTS__AUART0_RTS |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_AUART0_RX__AUART0_RX | MXS_PAD_CTRL,
+	MX28_PAD_AUART0_TX__AUART0_TX | MXS_PAD_CTRL,
+	MX28_PAD_AUART0_CTS__AUART0_CTS | MXS_PAD_CTRL,
+	MX28_PAD_AUART0_RTS__AUART0_RTS | MXS_PAD_CTRL,
 	/* auart3 */
-	MX28_PAD_AUART3_RX__AUART3_RX |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX28_PAD_AUART3_TX__AUART3_TX |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX28_PAD_AUART3_CTS__AUART3_CTS |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
-	MX28_PAD_AUART3_RTS__AUART3_RTS |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_AUART3_RX__AUART3_RX | MXS_PAD_CTRL,
+	MX28_PAD_AUART3_TX__AUART3_TX | MXS_PAD_CTRL,
+	MX28_PAD_AUART3_CTS__AUART3_CTS | MXS_PAD_CTRL,
+	MX28_PAD_AUART3_RTS__AUART3_RTS | MXS_PAD_CTRL,
 
+#define MXS_PAD_FEC	(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP)
 	/* fec0 */
-	MX28_PAD_ENET0_MDC__ENET0_MDC |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_MDIO__ENET0_MDIO |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_RX_EN__ENET0_RX_EN |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_RXD0__ENET0_RXD0 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_RXD1__ENET0_RXD1 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_TX_EN__ENET0_TX_EN |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_TXD0__ENET0_TXD0 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_TXD1__ENET0_TXD1 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET_CLK__CLKCTRL_ENET |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_ENET0_MDC__ENET0_MDC | MXS_PAD_FEC,
+	MX28_PAD_ENET0_MDIO__ENET0_MDIO | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RX_EN__ENET0_RX_EN | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RXD0__ENET0_RXD0 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RXD1__ENET0_RXD1 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TX_EN__ENET0_TX_EN | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TXD0__ENET0_TXD0 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TXD1__ENET0_TXD1 | MXS_PAD_FEC,
+	MX28_PAD_ENET_CLK__CLKCTRL_ENET | MXS_PAD_FEC,
 	/* fec1 */
-	MX28_PAD_ENET0_CRS__ENET1_RX_EN |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_RXD2__ENET1_RXD0 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_RXD3__ENET1_RXD1 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_COL__ENET1_TX_EN |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_TXD2__ENET1_TXD0 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
-	MX28_PAD_ENET0_TXD3__ENET1_TXD1 |
-		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
+	MX28_PAD_ENET0_CRS__ENET1_RX_EN | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RXD2__ENET1_RXD0 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_RXD3__ENET1_RXD1 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_COL__ENET1_TX_EN | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TXD2__ENET1_TXD0 | MXS_PAD_FEC,
+	MX28_PAD_ENET0_TXD3__ENET1_TXD1 | MXS_PAD_FEC,
 	/* phy power line */
-	MX28_PAD_SSP1_DATA3__GPIO_2_15 |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_SSP1_DATA3__GPIO_2_15 | MXS_PAD_CTRL,
 	/* phy reset line */
-	MX28_PAD_ENET0_RX_CLK__GPIO_4_13 |
-		(MXS_PAD_4MA | MXS_PAD_3V3 | MXS_PAD_NOPULL),
+	MX28_PAD_ENET0_RX_CLK__GPIO_4_13 | MXS_PAD_CTRL,
 };
 
 /* fec */
-- 
1.7.1
