From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 22 Sep 2015 11:20:06 +0200
Subject: [PATCH v2 03/10] ARM: marvell/dt: add crypto related nodes to armada
 370 dtsi
In-Reply-To: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1439885341-14644-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1442913606-12732-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnaud Ebalard <arno@natisbad.org>

Add crypto related nodes in armada-370.dtsi.

Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---

Changes since v1:
- add a comment explaining why we reserve 32 bytes in the crypto SRAM

 arch/arm/boot/dts/armada-370.dtsi | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370.dtsi b/arch/arm/boot/dts/armada-370.dtsi
index 53a1a5a..1652b59 100644
--- a/arch/arm/boot/dts/armada-370.dtsi
+++ b/arch/arm/boot/dts/armada-370.dtsi
@@ -319,6 +319,38 @@
 			ethernet at 74000 {
 				compatible = "marvell,armada-370-neta";
 			};
+
+			crypto at 90000 {
+				compatible = "marvell,armada-370-crypto";
+				reg = <0x90000 0x10000>;
+				reg-names = "regs";
+				interrupts = <48>;
+				clocks = <&gateclk 23>;
+				clock-names = "cesa0";
+				marvell,crypto-srams = <&crypto_sram>;
+				marvell,crypto-sram-size = <0x7e0>;
+			};
+		};
+
+		crypto_sram: sa-sram {
+			compatible = "mmio-sram";
+			reg = <MBUS_ID(0x09, 0x01) 0 0x800>;
+			reg-names = "sram";
+			clocks = <&gateclk 23>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 MBUS_ID(0x09, 0x01) 0 0x800>;
+
+			/*
+			 * The Armada 370 has an erratum preventing the use of
+			 * the standard workflow for CPU idle support (relying
+			 * on the BootROM code to enter/exit idle state).
+			 * Reserve some amount of the crypto SRAM to put the
+			 * cpuidle workaround.
+			 */
+			idle-sram at 0 {
+				reg = <0x0 0x20>;
+			};
 		};
 	};
 };
-- 
1.9.1
