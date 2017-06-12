From: slongerbeam@gmail.com (Steve Longerbeam)
Date: Mon, 12 Jun 2017 11:23:58 -0700
Subject: [PATCH 05/11] ARM: dts: imx6qdl-sabrelite: remove erratum ERR006687
 workaround
In-Reply-To: <1497291844-14632-1-git-send-email-steve_longerbeam@mentor.com>
References: <1497291844-14632-1-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <1497291844-14632-6-git-send-email-steve_longerbeam@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a pin conflict with GPIO_6. This pin functions as a power
input pin to the OV5642 camera sensor, but ENET uses it as the h/w
workaround for erratum ERR006687, to wake-up the ARM cores on normal
RX and TX packet done events. So we need to remove the h/w workaround
to support the OV5642. The result is that the CPUidle driver will no
longer allow entering the deep idle states on the sabrelite.

This is a partial revert of

commit 6261c4c8f13e ("ARM: dts: imx6qdl-sabrelite: use GPIO_6 for FEC
			interrupt.")
commit a28eeb43ee57 ("ARM: dts: imx6: tag boards that have the HW workaround
			for ERR006687")

Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
---
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 8413179..89dce27 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -270,9 +270,6 @@
 	txd1-skew-ps = <0>;
 	txd2-skew-ps = <0>;
 	txd3-skew-ps = <0>;
-	interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
-			      <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
-	fsl,err006687-workaround-present;
 	status = "okay";
 };
 
@@ -373,7 +370,6 @@
 				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b030
 				/* Phy reset */
 				MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x000b0
-				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 			>;
 		};
 
-- 
2.7.4
