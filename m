From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 2 Jul 2015 17:06:27 +0300
Subject: [PATCH v2 12/20] ARM: DTS: am437x-gp-evm: McASP1 node for audio
 support
In-Reply-To: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
References: <1435845995-19085-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1435845995-19085-13-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add node for McASP1 along with the needed pinctrl entries.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am437x-gp-evm.dts | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 32446c079fd3..98fcf6f17961 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -398,6 +398,24 @@
 			0x234 (PIN_OUTPUT_PULLDOWN | MUX_MODE0) /* uart3_rtsn.uart3_rtsn */
 		>;
 	};
+
+	mcasp1_pins: mcasp1_pins {
+		pinctrl-single,pins = <
+			0x108 (PIN_OUTPUT_PULLDOWN | MUX_MODE4)	/* mii1_col.mcasp1_axr2 */
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_crs.mcasp1_aclkx */
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* mii1_rxerr.mcasp1_fsx */
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE4)	/* rmii1_ref_clk.mcasp1_axr3 */
+		>;
+	};
+
+	mcasp1_sleep_pins: mcasp1_sleep_pins {
+		pinctrl-single,pins = <
+			0x108 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x10c (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x110 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+			0x144 (PIN_INPUT_PULLDOWN | MUX_MODE7)
+		>;
+	};
 };
 
 &i2c0 {
@@ -805,3 +823,20 @@
 		};
 	};
 };
+
+&mcasp1 {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&mcasp1_pins>;
+	pinctrl-1 = <&mcasp1_sleep_pins>;
+
+	status = "okay";
+
+	op-mode = <0>; /* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	/* 4 serializers */
+	serial-dir = <  /* 0: INACTIVE, 1: TX, 2: RX */
+		0 0 1 2
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
-- 
2.4.5
