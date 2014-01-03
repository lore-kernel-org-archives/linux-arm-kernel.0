From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Fri, 03 Jan 2014 17:48:57 +0100
Subject: [PATCH RFC 27/46] imx-drm: convert to componentised device support
In-Reply-To: <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
References: <20140102212528.GD7383@n2100.arm.linux.org.uk>
 <E1VypoB-0007FJ-PA@rmk-PC.arm.linux.org.uk>
Message-ID: <1388767737.19394.32.camel@pizza.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

I've tested this series on a BD-SL (SabreLite) with HDMI. Right now
the HPD signal doesn't seem to work, but after overwriting the
connection check, I got a stable and correct picture on the monitor:

 arch/arm/boot/dts/imx6q-sabrelite.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index f004913..cf9b3f5 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -50,6 +50,12 @@
 		};
 	};
 
+	imx-drm {
+		compatible = "fsl,imx-drm";
+		crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+		connectors = <&hdmi>;
+	};
+
 	sound {
 		compatible = "fsl,imx6q-sabrelite-sgtl5000",
 			     "fsl,imx-audio-sgtl5000";
@@ -93,6 +99,12 @@
 	status = "okay";
 };
 
+&hdmi {
+	status = "okay";
+	ddc = <&i2c2>;
+	crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+};
+
 &i2c1 {
 	status = "okay";
 	clock-frequency = <100000>;
@@ -108,6 +120,13 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2_2>;
+};
+
 &iomuxc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_hog>;
-- 
1.8.5.1

Am Donnerstag, den 02.01.2014, 21:28 +0000 schrieb Russell King:
> Use the componentised device support for imx-drm.  This requires all
> the sub-components and the master device to register with the component
> device support.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts        |   10 ++-
>  arch/arm/boot/dts/imx53-m53evk.dts         |    8 ++-
>  arch/arm/boot/dts/imx53-mba53.dts          |    6 ++
>  arch/arm/boot/dts/imx53-qsb.dts            |    8 ++-
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi     |    6 ++
>  drivers/staging/imx-drm/imx-drm-core.c     |  105 ++++++++++++++++++++++-----
>  drivers/staging/imx-drm/imx-ldb.c          |   40 ++++++++---
>  drivers/staging/imx-drm/imx-tve.c          |   63 +++++++++++------
>  drivers/staging/imx-drm/ipuv3-crtc.c       |   46 +++++++++----
>  drivers/staging/imx-drm/parallel-display.c |   30 ++++++--
>  10 files changed, 242 insertions(+), 80 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index be1407cf5abd..6ff15a0eacb3 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -21,7 +21,7 @@
>  		reg = <0x90000000 0x20000000>;
>  	};
>  
> -	display at di0 {
> +	display0: display at di0 {
>  		compatible = "fsl,imx-parallel-display";
>  		crtcs = <&ipu 0>;
[...]

Before moving imx-drm out of staging, I'd like to get rid of the
unfortunate 'crtcs' property. I'd rather prefer the components to be
connected with a device tree graph. I'm not quite sure if the DI0/1
should have their own device tree node inside the IPU node or if they
should just appear directly as two of four ports of the IPU (the other
two being CSI0/1). In the latter case, for example:

 arch/arm/boot/dts/imx6q.dtsi           | 32 ++++++++++++++++++++++++++++++--
 arch/arm/boot/dts/imx6qdl.dtsi         | 33 ++++++++++++++++++++++++++++++++-
 drivers/staging/imx-drm/imx-drm-core.c | 44 ++++++++++++++++++++++++++++++++------------
 3 files changed, 94 insertions(+), 15 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 187fe33..93f4721 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -132,13 +132,30 @@
 		};
 
 		ipu2: ipu at 02800000 {
-			#crtc-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,imx6q-ipu";
 			reg = <0x02800000 0x400000>;
 			interrupts = <0 8 0x4 0 7 0x4>;
 			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 4>;
+
+			port at 2 {
+				reg = <2>;
+
+				ipu2_di0_hdmi: endpoint {
+					remote-endpoint = <&hdmi_mux_2>;
+				};
+			};
+
+			port at 3 {
+				reg = <3>;
+
+				ipu2_di1_hdmi: endpoint {
+					remote-endpoint = <&hdmi_mux_3>;
+				};
+			};
 		};
 	};
 };
@@ -162,5 +179,16 @@
 
 &hdmi {
 	compatible = "fsl,imx6q-hdmi";
-	crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+
+	port at 2 {
+		hdmi_mux_2: endpoint {
+			remote-endpoint = <&ipu2_di0_hdmi>;
+		};
+	};
+
+	port at 3 {
+		hdmi_mux_3: endpoint {
+			remote-endpoint = <&ipu2_di1_hdmi>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 930ebe0..d9cb9a3 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1369,12 +1369,26 @@
 			};
 
 			hdmi: hdmi at 0120000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x00120000 0x9000>;
 				interrupts = <0 115 0x04>;
 				gpr = <&gpr>;
 				clocks = <&clks 123>, <&clks 124>;
 				clock-names = "iahb", "isfr";
 				status = "disabled";
+
+				port at 0 {
+					hdmi_mux_0: endpoint {
+						remote-endpoint = <&ipu1_di0_hdmi>;
+					};
+				};
+
+				port at 1 {
+					hdmi_mux_1: endpoint {
+						remote-endpoint = <&ipu1_di1_hdmi>;
+					};
+				};
 			};
 
 			dcic1: dcic at 020e4000 {
@@ -1643,13 +1657,30 @@
 		};
 
 		ipu1: ipu at 02400000 {
-			#crtc-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,imx6q-ipu";
 			reg = <0x02400000 0x400000>;
 			interrupts = <0 6 0x4 0 5 0x4>;
 			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
+
+			port at 2 {
+				reg = <2>;
+
+				ipu1_di0_hdmi: endpoint {
+					remote-endpoint = <&hdmi_mux_0>;
+				};
+			};
+
+			port at 3 {
+				reg = <3>;
+
+				ipu1_di1_hdmi: endpoint {
+					remote-endpoint = <&hdmi_mux_1>;
+				};
+			};
 		};
 	};
 };
diff --git a/drivers/staging/imx-drm/imx-drm-core.c b/drivers/staging/imx-drm/imx-drm-core.c
index 2490dc3..2c20434 100644
--- a/drivers/staging/imx-drm/imx-drm-core.c
+++ b/drivers/staging/imx-drm/imx-drm-core.c
@@ -23,6 +23,7 @@
 #include <drm/drm_crtc_helper.h>
 #include <drm/drm_gem_cma_helper.h>
 #include <drm/drm_fb_cma_helper.h>
+#include <media/v4l2-of.h>
 
 #include "imx-drm.h"
 
@@ -420,9 +421,23 @@ EXPORT_SYMBOL_GPL(imx_drm_remove_crtc);
  * or removed once the DRM device has been fully initialised.
  */
 static uint32_t imx_drm_find_crtc_mask(struct imx_drm_device *imxdrm,
-	void *cookie, int id)
+	struct device_node *endpoint)
 {
+	struct device_node *remote_port;
+	void *cookie;
 	unsigned i;
+	int id = 0;
+
+	remote_port = v4l2_of_get_remote_port(endpoint);
+	if (remote_port)
+		of_property_read_u32(remote_port, "reg", &id);
+	else
+		return 0;
+	cookie = remote_port->parent;
+	of_node_put(remote_port);
+
+	/* IPU specific: CSI0/1 at 0/1, DI0/1 at 2/3 */
+	id -= 2;
 
 	for (i = 0; i < MAX_CRTC; i++) {
 		struct imx_drm_crtc *imx_drm_crtc = imxdrm->crtc[i];
@@ -438,24 +453,21 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 	struct drm_encoder *encoder, struct device_node *np)
 {
 	struct imx_drm_device *imxdrm = drm->dev_private;
+	struct device_node *ep, *last_ep = NULL;
 	uint32_t crtc_mask = 0;
 	int i, ret = 0;
 
 	for (i = 0; !ret; i++) {
-		struct of_phandle_args args;
 		uint32_t mask;
-		int id;
 
-		ret = of_parse_phandle_with_args(np, "crtcs", "#crtc-cells", i,
-						 &args);
-		if (ret == -ENOENT)
+		ep = v4l2_of_get_next_endpoint(np, last_ep);
+		if (last_ep)
+			of_node_put(last_ep);
+		if (!ep)
 			break;
-		if (ret < 0)
-			return ret;
 
-		id = args.args_count > 0 ? args.args[0] : 0;
-		mask = imx_drm_find_crtc_mask(imxdrm, args.np, id);
-		of_node_put(args.np);
+		/* CSI */
+		mask = imx_drm_find_crtc_mask(imxdrm, ep);
 
 		/*
 		 * If we failed to find the CRTC(s) which this encoder is
@@ -463,12 +475,20 @@ int imx_drm_encoder_parse_of(struct drm_device *drm,
 		 * not been registered yet.  Defer probing, and hope that
 		 * the required CRTC is added later.
 		 */
-		if (mask == 0)
+		if (mask == 0) {
+			of_node_put(ep);
 			return -EPROBE_DEFER;
+		}
 
 		crtc_mask |= mask;
+		last_ep = ep;
 	}
 
+	if (ep)
+		of_node_put(ep);
+	if (i == 0)
+		return -ENOENT;
+
 	encoder->possible_crtcs = crtc_mask;
 
 	/* FIXME: this is the mask of outputs which can clone this output. */
-- 
1.8.5.1

diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
index 187fe33..93f4721 100644
--- a/arch/arm/boot/dts/imx6q.dtsi
+++ b/arch/arm/boot/dts/imx6q.dtsi
@@ -132,13 +132,30 @@
 		};
 
 		ipu2: ipu at 02800000 {
-			#crtc-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,imx6q-ipu";
 			reg = <0x02800000 0x400000>;
 			interrupts = <0 8 0x4 0 7 0x4>;
 			clocks = <&clks 133>, <&clks 134>, <&clks 137>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 4>;
+
+			port at 2 {
+				reg = <2>;
+
+				ipu2_di0_hdmi: endpoint {
+					remote-endpoint = <&hdmi_mux_2>;
+				};
+			};
+
+			port at 3 {
+				reg = <3>;
+
+				ipu2_di1_hdmi: endpoint {
+					remote-endpoint = <&hdmi_mux_3>;
+				};
+			};
 		};
 	};
 };
@@ -162,5 +179,16 @@
 
 &hdmi {
 	compatible = "fsl,imx6q-hdmi";
-	crtcs = <&ipu1 0>, <&ipu1 1>, <&ipu2 0>, <&ipu2 1>;
+
+	port at 2 {
+		hdmi_mux_2: endpoint {
+			remote-endpoint = <&ipu2_di0_hdmi>;
+		};
+	};
+
+	port at 3 {
+		hdmi_mux_3: endpoint {
+			remote-endpoint = <&ipu2_di1_hdmi>;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 930ebe0..d9cb9a3 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -1369,12 +1369,26 @@
 			};
 
 			hdmi: hdmi at 0120000 {
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x00120000 0x9000>;
 				interrupts = <0 115 0x04>;
 				gpr = <&gpr>;
 				clocks = <&clks 123>, <&clks 124>;
 				clock-names = "iahb", "isfr";
 				status = "disabled";
+
+				port at 0 {
+					hdmi_mux_0: endpoint {
+						remote-endpoint = <&ipu1_di0_hdmi>;
+					};
+				};
+
+				port at 1 {
+					hdmi_mux_1: endpoint {
+						remote-endpoint = <&ipu1_di1_hdmi>;
+					};
+				};
 			};
 
 			dcic1: dcic at 020e4000 {
@@ -1643,13 +1657,30 @@
 		};
 
 		ipu1: ipu at 02400000 {
-			#crtc-cells = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
 			compatible = "fsl,imx6q-ipu";
 			reg = <0x02400000 0x400000>;
 			interrupts = <0 6 0x4 0 5 0x4>;
 			clocks = <&clks 130>, <&clks 131>, <&clks 132>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
+
+			port at 2 {
+				reg = <2>;
+
+				ipu1_di0_hdmi: endpoint {
+					remote-endpoint = <&hdmi_mux_0>;
+				};
+			};
+
+			port at 3 {
+				reg = <3>;
+
+				ipu1_di1_hdmi: endpoint {
+					remote-endpoint = <&hdmi_mux_1>;
+				};
+			};
 		};
 	};
 };

The IPU ports 0 and 1 would be reserved for a future patch that adds CSI
support. This would allow to connect all input and output components in
the device tree to the IPU using a single abstraction and stop leaking
linux specific terms into the device tree.

regards
Philipp
