From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  9 Apr 2015 16:58:43 +0200
Subject: [PATCH 2/2] crypto: marvell/CESA: update DT bindings documentation
In-Reply-To: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1428591523-1780-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1428591523-1780-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Document new compatible strings, document the new method to reference the
crypto SRAM and deprecate the old one and document the the 'clocks' and
'clock-names' properties.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 .../devicetree/bindings/crypto/mv_cesa.txt         | 50 ++++++++++++++++------
 1 file changed, 38 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/crypto/mv_cesa.txt b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
index 47229b1..4ce9bc5 100644
--- a/Documentation/devicetree/bindings/crypto/mv_cesa.txt
+++ b/Documentation/devicetree/bindings/crypto/mv_cesa.txt
@@ -1,20 +1,46 @@
 Marvell Cryptographic Engines And Security Accelerator
 
 Required properties:
-- compatible : should be "marvell,orion-crypto"
-- reg : base physical address of the engine and length of memory mapped
-        region, followed by base physical address of sram and its memory
-        length
-- reg-names : "regs" , "sram";
-- interrupts : interrupt number
+- compatible: should be one of the following string
+	      "marvell,orion-crypto"
+	      "marvell,kirkwood-crypto"
+	      "marvell,armada-370-crypto"
+	      "marvell,armada-xp-crypto"
+	      "marvell,armada-375-crypto"
+	      "marvell,armada-38x-crypto"
+- reg: base physical address of the engine and length of memory mapped
+       region
+- reg-names: "regs"
+- interrupts: interrupt number
+- clocks: reference to the crypto engines clocks. This property is not
+	  required for orion and kirkwood platforms
+- clock-names: "cesaX" and "cesazX", X should be replaced by the crypto engine
+	       id.
+	       This property is not required for the orion and kirkwoord
+	       platforms.
+	       "cesazX" clocks are not required on armada-370 platforms
+- marvell,crypto-srams: phandle to crypto SRAM definitions
+
+Optional properties:
+- marvell,crypto-sram-size: SRAM size reserved for crypto operations, if not
+			    specified the whole SRAM is used (2KB)
+
+Deprecated properties:
+- reg: base physical address of the engine and length of memory mapped
+       region, followed by base physical address of sram and its memory
+       length
+- reg-names: "regs" , "sram"
 
 Examples:
 
-	crypto at 30000 {
-		compatible = "marvell,orion-crypto";
-		reg = <0x30000 0x10000>,
-		      <0x4000000 0x800>;
-		reg-names = "regs" , "sram";
-		interrupts = <22>;
+	crypto at 90000 {
+		compatible = "marvell,armada-xp-crypto";
+		reg = <0x90000 0x10000>;
+		reg-names = "regs";
+		interrupts = <48>, <49>;
+		clocks = <&gateclk 23>, <&gateclk 23>;
+		clock-names = "cesa0", "cesa1";
+		marvell,crypto-srams = <&crypto_sram0>, <&crypto_sram1>;
+		marvell,crypto-sram-size = <0x600>;
 		status = "okay";
 	};
-- 
1.9.1
