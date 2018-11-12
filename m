From: ryder.lee@mediatek.com (Ryder Lee)
Date: Mon, 12 Nov 2018 09:28:08 +0800
Subject: [PATCH v1 3/3] arm64: dts: mt7622: Drop the general purpose timer node
In-Reply-To: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
References: <30f4a4110190a175307ac4dfebc98ffe96c44b90.1541643419.git.ryder.lee@mediatek.com>
Message-ID: <17fde639c7d37f9cfabab230379913e652cf869a.1541643419.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The crash http://termbin.com/zitb is caused by the timer register
into system in early pahse during kernel boot, but the clock
sources didn't get ready at that time.

A better way is to switch to use CLK_OF_DECLARE() in driver for things
that need them early, but this node is actually useless in MT7622.
So we drop it.

Fixes: 9cc7f0de9e67 ("arm64: dts: mt7622: add timer, CCI-400 and PMU nodes")
Cc: stable at vger.kernel.org
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622.dtsi | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index fe0c875..14a1028 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -227,16 +227,6 @@
 		#reset-cells = <1>;
 	};
 
-	timer: timer at 10004000 {
-		compatible = "mediatek,mt7622-timer",
-			     "mediatek,mt6577-timer";
-		reg = <0 0x10004000 0 0x80>;
-		interrupts = <GIC_SPI 152 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&infracfg CLK_INFRA_APXGPT_PD>,
-			 <&topckgen CLK_TOP_RTC>;
-		clock-names = "system-clk", "rtc-clk";
-	};
-
 	scpsys: scpsys at 10006000 {
 		compatible = "mediatek,mt7622-scpsys",
 			     "syscon";
-- 
1.9.1
