From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Wed, 10 Sep 2014 18:55:41 +1000
Subject: [PATCH reword] ARM: MVEBU: Netgear RN102: Use Hardware BCH ECC
Message-ID: <1410339341-3372-1-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The bootloader on the Netgear ReadyNAS RN102 uses Hardware BCH ECC
(strength = 4), while the pxa3xx NAND driver by default uses 
Hamming ECC (strength = 1).

This patch changes the ECC mode on these machines to match that
of the bootloader and of the stock firmware. That way, it is
now possible to update the kernel from userland (e.g. using
standard tools from mtd-utils package); u-boot will happily
load and boot it.

Fixes: 92beaccd8b49 ("ARM: mvebu: Enable NAND controller in ReadyNAS 102 .dts file")
Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Tested-by: Arnaud Ebalard <arno@natisbad.org>
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
