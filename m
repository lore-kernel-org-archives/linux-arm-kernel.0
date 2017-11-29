From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Wed, 29 Nov 2017 14:54:58 +0800
Subject: [v2] arm: dts: ls1021a: fix the value of TMR_FIPER1
Message-ID: <20171129065458.4235-1-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The timer fixed interval period pulse generator register
is used to generate periodic pulses. The down count
register loads the value programmed in the fixed period
interval (FIPER). At every tick of the timer accumulator
overflow, the counter decrements by the value of
TMR_CTRL[TCLK_PERIOD]. It generates a pulse when the down
counter value reaches zero. It reloads the down counter
in the cycle following a pulse. To use the TMR_FIPER1
register to generate a 1 PPS event, the value
(10^9 nanoseconds) - TCLK_PERIOD should be programmed.
It should be 999999995 not 999999990 since TCLK_PERIOD
is 5.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- Added Shawn into cc list.
---
 arch/arm/boot/dts/ls1021a.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
index 64249726b3cb..a861a4b9e319 100644
--- a/arch/arm/boot/dts/ls1021a.dtsi
+++ b/arch/arm/boot/dts/ls1021a.dtsi
@@ -589,7 +589,7 @@
 			fsl,tclk-period = <5>;
 			fsl,tmr-prsc    = <2>;
 			fsl,tmr-add     = <0xaaaaaaab>;
-			fsl,tmr-fiper1  = <999999990>;
+			fsl,tmr-fiper1  = <999999995>;
 			fsl,tmr-fiper2  = <99990>;
 			fsl,max-adj     = <499999999>;
 		};
-- 
2.14.1
