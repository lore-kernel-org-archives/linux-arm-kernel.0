From: jacopo+renesas@jmondi.org (Jacopo Mondi)
Date: Wed,  4 Oct 2017 17:40:57 +0200
Subject: [PATCH] arm: dts: gr-peach: Reduce extal_clk resolution
Message-ID: <1507131657-6414-1-git-send-email-jacopo+renesas@jmondi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The system clock described by extal_clk is reported to have a frequency
of 13.333 Mhz and is correctly described by gr-peach device tree.

However, when enabling a RIIC device the following error is reported by
drivers/i2c/busses/i2c-riic.c

"invalid parent clk (33332500). Must be 33325000Hz"

As RIIC devices have a clock source obtained by dividing by 12 the
system clock, the resulting value is not accepted by the driver
(which clearly states not to support any frequency except the reported
33325000Hz one).

Hence, reduce the system clock accuracy to a value which makes
frequencies obtained through division accepted by RIIC driver.

Please note that other r7s72100 boards, such as Genmai, report the same
"reduced accuracy" frequency, even if their external clock sources are
effectively 13.333Mhz as gr-peach one.

Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
---
 arch/arm/boot/dts/r7s72100-gr-peach.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r7s72100-gr-peach.dts b/arch/arm/boot/dts/r7s72100-gr-peach.dts
index a1c5e88..20309ac 100644
--- a/arch/arm/boot/dts/r7s72100-gr-peach.dts
+++ b/arch/arm/boot/dts/r7s72100-gr-peach.dts
@@ -71,7 +71,7 @@
 };

 &extal_clk {
-	clock-frequency = <13333000>;
+	clock-frequency = <13330000>;
 };

 &usb_x1_clk {
--
2.7.4
