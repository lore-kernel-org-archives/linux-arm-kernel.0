From: dianders@chromium.org (Douglas Anderson)
Date: Wed,  9 May 2018 13:05:28 -0700
Subject: [PATCH] arm64: dts: sdm845: Fix xo_board clock name and speed
Message-ID: <20180509200528.233451-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RPMh clock driver assumes that the xo_board clock is named
"xo_board", not "xo-board".  Add a "clock-output-names" property to
the device tree to get the right name.

Also add the proper speed for the xo-clock as 38400000.  This is
internally divided in RPMh clock driver to get "bi_tcxo" at 19200000.

After this change the clock tree in /sys/kernel/debug/clk/clk_summary
looks much better.

NOTES:
- Technically you could argue that this clock could belong in board
  .dts files, not in the SoC one.  However at the moment it's believed
  that 100% of sdm845 boards will have an external clock at 38.4.  It
  can always be moved later if necessary.
- We could rename the "xo-board" device tree node to "xo_board" to
  achieve the same effect as this patch.  Presumably device-tree folks
  would rather keep node names using dashes though.
- We could change the RPMh clock driver to use a dash to achieve the
  same effect as this patch, but all other clocks in the clock tree
  use underscores.  It seems silly to change just this one.

Fixes: 7bafa643647f ("arm64: dts: sdm845: Add minimal dts/dtsi files for sdm845 SoC and MTP")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 arch/arm64/boot/dts/qcom/sdm845.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index 486ace9a9e8b..4945f8cccd6c 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -137,7 +137,8 @@
 		xo_board: xo-board {
 			compatible = "fixed-clock";
 			#clock-cells = <0>;
-			clock-frequency = <19200000>;
+			clock-frequency = <38400000>;
+			clock-output-names = "xo_board";
 		};
 
 		sleep_clk: sleep-clk {
-- 
2.17.0.441.gb46fe60e1d-goog
