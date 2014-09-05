From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Fri,  5 Sep 2014 16:23:53 +1000
Subject: [PATCH] ARM: MVEBU: Netgear RN102: Use Hardware BCH ECC
Message-ID: <1409898233-9273-1-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bootloader on the Netgear ReadyNAS RN102 uses Hardware BCH ECC
(strength = 4), while the pxa3xx NAND driver by default uses 
Hamming ECC (strength = 1).

This patch changes the ECC mode on these machines to match that
of the bootloader and of the stock firmware, so that for example
updating the kernel is possible without requiring a serial
connection.

This patch depends on commit 5b3e507 (mtd: nand: pxa3xx: Use ECC
strength and step size devicetree binding)

Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
---
 arch/arm/boot/dts/armada-370-netgear-rn102.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/armada-370-netgear-rn102.dts b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
index d6d572e..285524f 100644
--- a/arch/arm/boot/dts/armada-370-netgear-rn102.dts
+++ b/arch/arm/boot/dts/armada-370-netgear-rn102.dts
@@ -143,6 +143,10 @@
 				marvell,nand-enable-arbiter;
 				nand-on-flash-bbt;
 
+				/* Use Hardware BCH ECC */
+				nand-ecc-strength = <4>;
+				nand-ecc-step-size = <512>;
+
 				partition at 0 {
 					label = "u-boot";
 					reg = <0x0000000 0x180000>;  /* 1.5MB */
-- 
1.8.5.5
