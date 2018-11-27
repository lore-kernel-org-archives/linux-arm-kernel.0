From: dbasehore@chromium.org (Derek Basehore)
Date: Tue, 27 Nov 2018 15:23:31 -0800
Subject: [PATCH] arm64: dts: rockchip: Add 32k clk on rk3399-gru
Message-ID: <20181127232331.49628-1-dbasehore@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the 32k clock to the RK3399 Gru board file. Even though it's
not directly used, muxes will end up traversing the entire clk tree on
calls to determine_rate if it doesn't exist. This is because the 32k
clk is listed as a possible parent on some clks. Since the clk doesn't
know about the 32k clk (it was never registered), it triggers a global
search for it. This can happen about 40 times per second, which isn't
great for power.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index ca07f6032200..a07aa4c570c0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -14,6 +14,13 @@
 		stdout-path = "serial2:115200n8";
 	};
 
+	ap_rtc_clk: ap-rtc-clk {
+		compatible = "fixed-clock";
+		clock-frequency = <32768>;
+		clock-output-names = "xin32k";
+		#clock-cells = <0>;
+	};
+
 	/*
 	 * Power Tree
 	 *
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog
