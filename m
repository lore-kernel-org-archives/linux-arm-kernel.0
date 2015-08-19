From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 19 Aug 2015 15:19:47 +0200
Subject: [PATCH 2/2] ARM: imx53: qsrb: fix PMIC interrupt level
In-Reply-To: <1439990387-8602-1-git-send-email-l.stach@pengutronix.de>
References: <1439990387-8602-1-git-send-email-l.stach@pengutronix.de>
Message-ID: <1439990387-8602-2-git-send-email-l.stach@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The MC34708 PMIC interrupt level is active high, but was set to
active low in the devicetree, probably as a result of a copy and
paste error from the QSB board.

This caused IRQ storms and led to the kernel disabling the PMIC
interrupt.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
---
 arch/arm/boot/dts/imx53-qsrb.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-qsrb.dts b/arch/arm/boot/dts/imx53-qsrb.dts
index 82d623d05915..bbb3f4b7a7fe 100644
--- a/arch/arm/boot/dts/imx53-qsrb.dts
+++ b/arch/arm/boot/dts/imx53-qsrb.dts
@@ -48,7 +48,7 @@
 		pinctrl-0 = <&pinctrl_pmic>;
 		reg = <0x08>;
 		interrupt-parent = <&gpio5>;
-		interrupts = <23 0x8>;
+		interrupts = <23 IRQ_TYPE_LEVEL_HIGH>;
 		regulators {
 			sw1_reg: sw1a {
 				regulator-name = "SW1";
-- 
2.4.6
