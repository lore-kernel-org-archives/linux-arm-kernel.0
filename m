From: s-anna@ti.com (Suman Anna)
Date: Tue, 22 Apr 2014 17:23:36 -0500
Subject: [PATCH 2/3] ARM: dts: OMAP2: Fix interrupts for OMAP2420 mailbox
In-Reply-To: <1398205417-1575-1-git-send-email-s-anna@ti.com>
References: <1398205417-1575-1-git-send-email-s-anna@ti.com>
Message-ID: <1398205417-1575-3-git-send-email-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mailbox module is capable of generating two interrupts
to MPU in OMAP2420, compared to one in OMAP2430. The second
interrupt is to handle interrupts from the additional IVA
processor present only on OMAP2420.

Move the current common mailbox DT node into the SoC
specific files to allow the above differentiation. Also,
added back the interrupt-names on OMAP2420, that were
previously defined in hwmod data.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 arch/arm/boot/dts/omap2.dtsi    | 7 -------
 arch/arm/boot/dts/omap2420.dtsi | 8 ++++++++
 arch/arm/boot/dts/omap2430.dtsi | 7 +++++++
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/omap2.dtsi b/arch/arm/boot/dts/omap2.dtsi
index 22f35ea..8f8c07d 100644
--- a/arch/arm/boot/dts/omap2.dtsi
+++ b/arch/arm/boot/dts/omap2.dtsi
@@ -71,13 +71,6 @@
 			interrupts = <58>;
 		};
 
-		mailbox: mailbox at 48094000 {
-			compatible = "ti,omap2-mailbox";
-			ti,hwmods = "mailbox";
-			reg = <0x48094000 0x200>;
-			interrupts = <26>;
-		};
-
 		intc: interrupt-controller at 1 {
 			compatible = "ti,omap2-intc";
 			interrupt-controller;
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap2420.dtsi
index 85b1fb0..2d99798 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -125,6 +125,14 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox at 48094000 {
+			compatible = "ti,omap2-mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>, <34>;
+			interrupt-names = "dsp", "iva";
+			ti,hwmods = "mailbox";
+		};
+
 		timer1: timer at 48028000 {
 			compatible = "ti,omap2420-timer";
 			reg = <0x48028000 0x400>;
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index d09697d..42d2c61 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -216,6 +216,13 @@
 			dma-names = "tx", "rx";
 		};
 
+		mailbox: mailbox at 48094000 {
+			compatible = "ti,omap2-mailbox";
+			reg = <0x48094000 0x200>;
+			interrupts = <26>;
+			ti,hwmods = "mailbox";
+		};
+
 		timer1: timer at 49018000 {
 			compatible = "ti,omap2420-timer";
 			reg = <0x49018000 0x400>;
-- 
1.9.2
