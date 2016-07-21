From: zyw@rock-chips.com (Chris Zhong)
Date: Thu, 21 Jul 2016 21:13:26 +0800
Subject: [v6 PATCH 4/6] arm64: dts: rockchip: add Type-C phy for RK3399
In-Reply-To: <1469106808-28297-1-git-send-email-zyw@rock-chips.com>
References: <1469106808-28297-1-git-send-email-zyw@rock-chips.com>
Message-ID: <1469106808-28297-5-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are 2 Type-C phy on RK3399, they are almost same, except the
address of register. They support USB3.0 Type-C and DisplayPort1.3
Alt Mode on USB Type-C. Register a phy, supply it to USB3 controller
and DP controller.

Signed-off-by: Chris Zhong <zyw@rock-chips.com>
---

Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None
Changes in v1: None

 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 44 ++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 0af03a3..7095ddf 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -952,6 +952,50 @@
 		};
 	};
 
+	tcphy0: phy at ff7c0000 {
+		compatible = "rockchip,rk3399-typec-phy";
+		reg = <0x0 0xff7c0000 0x0 0x40000>;
+		rockchip,grf = <&grf>;
+		#phy-cells = <0>;
+		clocks = <&cru SCLK_UPHY0_TCPDCORE>,
+			 <&cru SCLK_UPHY0_TCPDPHY_REF>;
+		clock-names = "tcpdcore", "tcpdphy-ref";
+		assigned-clocks = <&cru SCLK_UPHY0_TCPDCORE>;
+		assigned-clock-rates = <50000000>;
+		resets = <&cru SRST_UPHY0>,
+			 <&cru SRST_UPHY0_PIPE_L00>,
+			 <&cru SRST_P_UPHY0_TCPHY>;
+		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
+		rockchip,typec-conn-dir = <0xe580 0 16>;
+		rockchip,usb3tousb2-en = <0xe580 3 19>;
+		rockchip,external-psm = <0xe588 14 30>;
+		rockchip,pipe-status = <0xe5c0 0 0>;
+		rockchip,uphy-dp-sel = <0x6268 19 19>;
+		status = "disabled";
+	};
+
+	tcphy1: phy at ff800000 {
+		compatible = "rockchip,rk3399-typec-phy";
+		reg = <0x0 0xff800000 0x0 0x40000>;
+		rockchip,grf = <&grf>;
+		#phy-cells = <0>;
+		clocks = <&cru SCLK_UPHY1_TCPDCORE>,
+			 <&cru SCLK_UPHY1_TCPDPHY_REF>;
+		clock-names = "tcpdcore", "tcpdphy-ref";
+		assigned-clocks = <&cru SCLK_UPHY1_TCPDCORE>;
+		assigned-clock-rates = <50000000>;
+		resets = <&cru SRST_UPHY1>,
+			 <&cru SRST_UPHY1_PIPE_L00>,
+			 <&cru SRST_P_UPHY1_TCPHY>;
+		reset-names = "uphy", "uphy-pipe", "uphy-tcphy";
+		rockchip,typec-conn-dir = <0xe58c 0 16>;
+		rockchip,usb3tousb2-en = <0xe58c 3 19>;
+		rockchip,external-psm = <0xe594 14 30>;
+		rockchip,pipe-status = <0xe5c0 16 16>;
+		rockchip,uphy-dp-sel = <0x6268 3 19>;
+		status = "disabled";
+	};
+
 	watchdog at ff840000 {
 		compatible = "snps,dw-wdt";
 		reg = <0x0 0xff840000 0x0 0x100>;
-- 
2.6.3
