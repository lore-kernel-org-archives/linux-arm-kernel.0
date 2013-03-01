From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Fri,  1 Mar 2013 10:36:09 +0200
Subject: [PATCH] arm: mvebu: Reduce reg-io-width with UARTs
Message-ID: <1362126969-32277-1-git-send-email-heikki.krogerus@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the reg-io-width to 1 byte represents more accurate
description of the HW.

This will fix an issue where UART driver causes kernel
panic during bootup. Gregory CLEMENT traced the issue to
autoconfig() in 8250.c, where the existence of FIFO is
checked from UART_IIR register. The register is now read as
32-bit value as the reg-io-width is set to 4-bytes. The
retuned value seems to contain bogus data for bits 31:8,
causing the issue.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
---
 arch/arm/boot/dts/armada-370-xp.dtsi |    4 ++--
 arch/arm/boot/dts/armada-xp.dtsi     |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/armada-370-xp.dtsi b/arch/arm/boot/dts/armada-370-xp.dtsi
index 6f1acc7..99afca4 100644
--- a/arch/arm/boot/dts/armada-370-xp.dtsi
+++ b/arch/arm/boot/dts/armada-370-xp.dtsi
@@ -54,7 +54,7 @@
 				reg = <0xd0012000 0x100>;
 				reg-shift = <2>;
 				interrupts = <41>;
-				reg-io-width = <4>;
+				reg-io-width = <1>;
 				status = "disabled";
 		};
 		serial at d0012100 {
@@ -62,7 +62,7 @@
 				reg = <0xd0012100 0x100>;
 				reg-shift = <2>;
 				interrupts = <42>;
-				reg-io-width = <4>;
+				reg-io-width = <1>;
 				status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 1443949..ca00d83 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -46,7 +46,7 @@
 				reg = <0xd0012200 0x100>;
 				reg-shift = <2>;
 				interrupts = <43>;
-				reg-io-width = <4>;
+				reg-io-width = <1>;
 				status = "disabled";
 		};
 		serial at d0012300 {
@@ -54,7 +54,7 @@
 				reg = <0xd0012300 0x100>;
 				reg-shift = <2>;
 				interrupts = <44>;
-				reg-io-width = <4>;
+				reg-io-width = <1>;
 				status = "disabled";
 		};
 
-- 
1.7.10.4
