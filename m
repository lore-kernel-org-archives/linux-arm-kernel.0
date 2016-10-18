From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 18 Oct 2016 16:35:57 +0100
Subject: [PATCH] ARM: sti: stih410-clocks: Add PROC_STFE as a critical clock
Message-ID: <1476804957-24000-1-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Once the ST frontend demux HW IP has been enabled, the clock can't
be disabled otherwise the system will hang and the board will
be unserviceable.

To allow balanced clock enable/disable calls in the driver we use
the critical clock infrastructure to take an extra reference on the
clock so the clock will never actually be disabled.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih410-clock.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 8598eff..07c8ef9 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -208,7 +208,8 @@
 						     "clk-clust-hades",
 						     "clk-hwpe-hades",
 						     "clk-fc-hades";
-				clock-critical = <CLK_ICN_CPU>,
+				clock-critical = <CLK_PROC_STFE>,
+						 <CLK_ICN_CPU>,
 						 <CLK_TX_ICN_DMU>,
 						 <CLK_EXT2F_A9>,
 						 <CLK_ICN_LMI>,
-- 
1.9.1
