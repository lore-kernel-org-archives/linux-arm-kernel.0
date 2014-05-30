From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 30 May 2014 07:43:10 -0600
Subject: [RFC PATCH 10/11] coresight: adding support for beagleXM
In-Reply-To: <1401457391-12242-1-git-send-email-mathieu.poirier@linaro.org>
References: <1401457391-12242-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1401457391-12242-11-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Currently supporting ETM and ETB.  Support for TPIU
and SDTI are yet to be added.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 447e714..b39bede 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -86,6 +86,36 @@
 		reset-gpios = <&gpio5 19 GPIO_ACTIVE_LOW>; /* gpio_147 */
 		vcc-supply = <&hsusb2_power>;
 	};
+
+	coresight {
+		compatible = "arm,coresight";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		clocks = <&emu_src_ck>;
+		ranges;
+
+		etb: etb at 540000000 {
+			compatible = "arm,coresight-etb";
+			reg = <0x5401b000 0x1000>;
+
+			coresight-id = <0>;
+			coresight-name = "coresight-etb";
+			coresight-nr-inports = <1>;
+			coresight-default-sink;
+		};
+
+		etm at 54010000 {
+			compatible = "arm,coresight-etm";
+			reg = <0x54010000 0x1000>;
+
+			coresight-id = <1>;
+			coresight-name = "coresight-etm";
+			coresight-nr-inports = <0>;
+			coresight-outports = <0>;
+			coresight-child-list = <&etb>;
+			coresight-child-ports = <0>;
+		};
+	};
 };
 
 &omap3_pmx_wkup {
-- 
1.9.1
