From: mathieu.poirier@linaro.org (mathieu.poirier at linaro.org)
Date: Fri, 27 Jun 2014 12:04:19 -0600
Subject: [PATCH 7/9 v2] coresight: adding support for beagle and beagleXM
In-Reply-To: <1403892261-25026-1-git-send-email-mathieu.poirier@linaro.org>
References: <1403892261-25026-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1403892261-25026-8-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mathieu Poirier <mathieu.poirier@linaro.org>

Currently supporting ETM and ETB.  Support for TPIU
and SDTI are yet to be added.

Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/omap3-beagle.dts    | 28 ++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index cf0be66..110ac3e 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -145,6 +145,34 @@
 			};
 		};
 	};
+
+	etb: etb at 5401b000 {
+		compatible = "arm,coresight-etb", "arm,primecell";
+		reg = <0x5401b000 0x1000>;
+
+		coresight-default-sink;
+		clocks = <&emu_src_ck>;
+		clock-names = "apb_pclk";
+		port {
+			etb_in: endpoint {
+				slave-mode;
+				remote-endpoint = <&etm_out>;
+			};
+		};
+	};
+
+	etm at 54010000 {
+		compatible = "arm,coresight-etm", "arm,primecell";
+		reg = <0x54010000 0x1000>;
+
+		clocks = <&emu_src_ck>;
+		clock-names = "apb_pclk";
+		port {
+			etm_out: endpoint {
+				remote-endpoint = <&etb_in>;
+			};
+		};
+	};
 };
 
 &omap3_pmx_wkup {
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 3c3e6da..dfd9a92 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -140,6 +140,34 @@
 			};
 		};
 	};
+
+	etb: etb at 540000000 {
+		compatible = "arm,coresight-etb", "arm,primecell";
+		reg = <0x5401b000 0x1000>;
+
+		coresight-default-sink;
+		clocks = <&emu_src_ck>;
+		clock-names = "apb_pclk";
+		port {
+			etb_in: endpoint {
+				slave-mode;
+				remote-endpoint = <&etm_out>;
+			};
+		};
+	};
+
+	etm at 54010000 {
+		compatible = "arm,coresight-etm", "arm,primecell";
+		reg = <0x54010000 0x1000>;
+
+		clocks = <&emu_src_ck>;
+		clock-names = "apb_pclk";
+		port {
+			etm_out: endpoint {
+				remote-endpoint = <&etb_in>;
+			};
+		};
+	};
 };
 
 &omap3_pmx_wkup {
-- 
1.9.1
