From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 28 Feb 2017 06:14:20 +0100
Subject: [PATCH 4/4] ARM: dts: rockchip: Make uartpll a child of the gpll on
 rk3036
In-Reply-To: <20170228051420.7214-1-heiko@sntech.de>
References: <20170228051420.7214-1-heiko@sntech.de>
Message-ID: <20170228051420.7214-5-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The shared uart-pll is normally a child of the apll that can get changed
by cpu frequency scaling. So move it away to the more stable gpll to
make sure the uart doesn't break on cpu frequency changes.

This turned up during the 4.11 merge-window when commit
6a171b299379 ("serial: 8250_dw: Allow hardware flow control to be used")
added general termios enablement making the uart on rk3036 change
frequency and thus making it susceptible for the frequency scaling issue.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3036.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index ff9b90bfaefd..6442023854c5 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -310,8 +310,9 @@
 		rockchip,grf = <&grf>;
 		#clock-cells = <1>;
 		#reset-cells = <1>;
-		assigned-clocks = <&cru PLL_GPLL>;
-		assigned-clock-rates = <594000000>;
+		assigned-clocks = <&cru PLL_GPLL>, <&cru SCLK_UARTPLL>;
+		assigned-clock-rates = <594000000>, <0>;
+		assigned-clock-parents = <0>, <&cru PLL_GPLL>;
 	};
 
 	grf: syscon at 20008000 {
-- 
2.11.0
