From: b-cousson@ti.com (Benoit Cousson)
Date: Thu, 1 Sep 2011 19:21:26 +0200
Subject: [PATCH 10/13] arm/dts: omap4-panda: Add twl6030 node
In-Reply-To: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
References: <1314897689-17791-1-git-send-email-b-cousson@ti.com>
Message-ID: <1314897689-17791-11-git-send-email-b-cousson@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the twl6030 node in i2c1 controller.

This is just the minimal support needed to boot OMAP4 boards
without any crash.
The support for all the features included in this MFD will be added
later.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/arm/boot/dts/omap4-panda.dts |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-panda.dts b/arch/arm/boot/dts/omap4-panda.dts
index 63ecf34..5c1c2a7 100644
--- a/arch/arm/boot/dts/omap4-panda.dts
+++ b/arch/arm/boot/dts/omap4-panda.dts
@@ -30,6 +30,29 @@
 
 &i2c1 {
 	clock-frequency = <400000>;
+
+	/*
+	 * Integrated Power Management Chip
+	 * http://www.ti.com/lit/ds/symlink/twl6030.pdf
+	 */
+	twl at 48 {
+		compatible = "ti,twl6030";
+		reg = <0x48>;
+		interrupts = <39>; /* IRQ_SYS_1N cascaded to gic */
+		interrupt-controller;
+		#interrupt-cells = <1>;
+		interrupt-parent = <&gic>;
+		/* twl is a MFD, so it will contain a bunch of sub-ips */
+		#address-cells = <1>;
+		#size-cells = <0>;
+		ranges = <0 0x48>;
+
+		twl_rtc {
+			compatible = "ti,twl_rtc";
+			interrupts = <11>;
+			reg = <0>;
+		};
+	};
 };
 
 &i2c2 {
-- 
1.7.0.4
