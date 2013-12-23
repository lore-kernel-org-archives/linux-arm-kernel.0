From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 23 Dec 2013 09:48:10 +0100
Subject: [PATCH 2/3] ARM: mvebu: fix register length for Armada XP PMSU
In-Reply-To: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1387788491-3168-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1387788491-3168-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The per-CPU PMSU registers documented in the datasheet start at
0x22100 and the last register for CPU3 is at 0x22428. However, the DT
informations use <0x22100 0x430>, which makes the region end at
0x22530 and not 0x22430.

Moreover, looking at the datasheet, we can see that the registers for
CPU0 start at 0x22100, for CPU1 at 0x22200, for CPU2 at 0x22300 and
for CPU3 at 0x22400. It seems clear that 0x100 bytes of registers have
been used per CPU.

Therefore, this commit reduces the length of the PMSU per-CPU register
area from the incorrect 0x430 bytes to a more logical 0x400 bytes.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/boot/dts/armada-xp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp.dtsi b/arch/arm/boot/dts/armada-xp.dtsi
index 281c644..aa49f17 100644
--- a/arch/arm/boot/dts/armada-xp.dtsi
+++ b/arch/arm/boot/dts/armada-xp.dtsi
@@ -48,7 +48,7 @@
 
 			armada-370-xp-pmsu at 22000 {
 				compatible = "marvell,armada-370-xp-pmsu";
-				reg = <0x22100 0x430>, <0x20800 0x20>;
+				reg = <0x22100 0x400>, <0x20800 0x20>;
 			};
 
 			serial at 12200 {
-- 
1.8.3.2
