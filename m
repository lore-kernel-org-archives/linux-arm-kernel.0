From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 12 Nov 2015 15:12:48 +0100
Subject: [PATCH] stmmac: avoid ipq806x constant overflow warning
Message-ID: <4391788.dtYArQ4mVi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building dwmac-ipq806x on a 64-bit architecture produces a harmless
warning from gcc:

stmmac/dwmac-ipq806x.c: In function 'ipq806x_gmac_probe':
include/linux/bitops.h:6:19: warning: overflow in implicit constant conversion [-Woverflow]
  val = QSGMII_PHY_CDR_EN |
stmmac/dwmac-ipq806x.c:333:8: note: in expansion of macro 'QSGMII_PHY_CDR_EN'
 #define QSGMII_PHY_CDR_EN   BIT(0)
 #define BIT(nr)   (1UL << (nr))

The compiler warns about the fact that a 64-bit literal is passed
into a function that takes a 32-bit argument. I could not fully understand
why it warns despite the fact that this number is always small enough
to fit, but changing the use of BIT() macros into the equivalent hexadecimal
representation avoids the warning

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: b1c17215d718 ("stmmac: add ipq806x glue layer")
---
This came up on the arm64 allmodconfig build

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
index 9d89bdbf029f..4abd9b0b542a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-ipq806x.c
@@ -77,11 +77,11 @@
 /* Only GMAC1/2/3 support SGMII and their CTL register are not contiguous */
 #define QSGMII_PHY_SGMII_CTL(x)			((x == 1) ? 0x134 : \
 						 (0x13c + (4 * (x - 2))))
-#define QSGMII_PHY_CDR_EN			BIT(0)
-#define QSGMII_PHY_RX_FRONT_EN			BIT(1)
-#define QSGMII_PHY_RX_SIGNAL_DETECT_EN		BIT(2)
-#define QSGMII_PHY_TX_DRIVER_EN			BIT(3)
-#define QSGMII_PHY_QSGMII_EN			BIT(7)
+#define QSGMII_PHY_CDR_EN			0x01u
+#define QSGMII_PHY_RX_FRONT_EN			0x02u
+#define QSGMII_PHY_RX_SIGNAL_DETECT_EN		0x04u
+#define QSGMII_PHY_TX_DRIVER_EN			0x08u
+#define QSGMII_PHY_QSGMII_EN			0x80u
 #define QSGMII_PHY_PHASE_LOOP_GAIN_OFFSET	12
 #define QSGMII_PHY_PHASE_LOOP_GAIN_MASK		0x7
 #define QSGMII_PHY_RX_DC_BIAS_OFFSET		18
