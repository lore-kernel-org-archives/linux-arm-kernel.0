From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 13 Apr 2015 12:22:25 +0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabrelite: add supported LVDS
 displays
In-Reply-To: <5521E08F.3060407@boundarydevices.com>
References: <5521E08F.3060407@boundarydevices.com>
Message-ID: <1428920545.3192.41.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Am Sonntag, den 05.04.2015, 18:25 -0700 schrieb Eric Nelson:
> Hi Philipp,
> 
> Sorry for the delayed response. I missed your reply and Shawn pointed
> it out.
[...]
> The use of simple panel seems to add and remove functionality:
> 	- adds backlight, regulators and enable GPIOs!
> 	- loses the ability to express timings in DT

For the simple panel driver Thierry preferred to have a panel database
in the driver and uniquely identify the panel by its compatible value.
This will also allow to infer the data mapping and width from
the panel, and the panel timings are available for the next hardware to
reuse the same panel (however likely that is).

The old method with display-timings will stay available, but for
mainline I think it is better to add the panel to the driver.

> > After:
> > 	ldb {
> > 		...
> > 
> > 		lvds-channel at 0 {
> > 			...
> > 
> 
> Using port here to point at the panel seems to conflict
> with the use of ports to point at the IPU.

I'm sorry, I don't understand what you mean exactly. There are some
input ports (two on i.MX5, four on i.MX6) that are connected to the IPU,
and one output port that is connected to the panel, in that order by
convention. The port id 4 (reg = <4>) uniquely identifies the output
port on i.MX6.

> > 			port at 4 {
> > 				reg = <4>;
> > 
> > 				lvds_out: endpoint {
> > 					remote_endpoint = <&panel_in>;
> > 				};
> > 			};
> > 		};
> > 	};
> > 
> > 	panel {
> > 		compatible = "edt,etm0700g0dh6", "simple-panel";
> > 		...
> > 
> 
> And why would the panel need to point back to the LVDS
> channel?

This is the way the bindings are defined right now in
Documentation/devicetree/bindings/graph.txt, section "Links between
endpoints". The panel driver itself doesn't use the backlink, but the
endpoint needs to exist anyway.

> > 		port {
> > 			panel_in: endpoint {
> > 				remote-endpoint = <&lvds_out>;
> > 			};
> > 		};
> > 	}; 
> > 
> 
> Do you have a working example of how this should be used?
> 
> My attempts to follow the notes above results in a failure
> to find a crtc for the LVDS channel.
> 
> Please advise,

I have used this patch to connect a HannStar HSD070PWW1 LVDS panel to a
Nitrogen6X board:

-----8<-----
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 0821812..9e52adf 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -122,7 +122,7 @@
 		status = "okay";
 	};
 
-	backlight_lvds {
+	backlight_lvds: backlight_lvds {
 		compatible = "pwm-backlight";
 		pwms = <&pwm4 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -130,6 +130,17 @@
 		power-supply = <&reg_3p3v>;
 		status = "okay";
 	};
+
+	panel {
+		compatible = "hannstar,hsd070pww1";
+		backlight = <&backlight_lvds>;
+
+		port {
+			panel_in: endpoint {
+				remote-endpoint = <&lvds0_out>;
+			};
+		};
+	};
 };
 
 &audmux {
@@ -379,18 +390,11 @@
 		fsl,data-width = <18>;
 		status = "okay";
 
-		display-timings {
-			native-mode = <&timing0>;
-			timing0: hsd100pxn1 {
-				clock-frequency = <65000000>;
-				hactive = <1024>;
-				vactive = <768>;
-				hback-porch = <220>;
-				hfront-porch = <40>;
-				vback-porch = <21>;
-				vfront-porch = <7>;
-				hsync-len = <60>;
-				vsync-len = <10>;
+		port at 4 {
+			reg = <4>;
+
+			lvds0_out: endpoint {
+				remote-endpoint = <&panel_in>;
 			};
 		};
 	};
----->8-----

regards
Philipp
