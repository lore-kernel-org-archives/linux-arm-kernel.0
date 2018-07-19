From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Thu, 19 Jul 2018 21:38:23 +0200
Subject: [PATCH] ARM: dts: imx6: RDU2: fix irq type for mv88e6xxx switch
Message-ID: <20180719193823.9486-1-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Marvell switches report their interrupts in a level sensitive way.
When using edge sensitive detection a race condition in the interrupt
handler of the swich might result in the OS to miss all future events
which might make the switch non-functional.

The problem is that both mv88e6xxx_g2_irq_thread_fn() and
mv88e6xxx_g1_irq_thread_work() sample the irq cause register
(MV88E6XXX_G2_INT_SRC and MV88E6XXX_G1_STS respectively) once and then
handle the observed sources. If after sampling but before all observed
irq sources are handled a new irq source gets active this is not noticed
by the handler which returns unsuspecting, but the interrupt line stays
active which prevents the edge detector to kick in.

All device trees but imx6qdl-zii-rdu2 get this right (most of them by
not specifying an interrupt parent). So fix imx6qdl-zii-rdu2
accordingly.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: kernel at pengutronix.de
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
index 19a075aee19e..f14df0baf2ab 100644
--- a/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-zii-rdu2.dtsi
@@ -692,7 +692,7 @@
 			dsa,member = <0 0>;
 			eeprom-length = <512>;
 			interrupt-parent = <&gpio6>;
-			interrupts = <3 IRQ_TYPE_EDGE_FALLING>;
+			interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
 
-- 
2.18.0
