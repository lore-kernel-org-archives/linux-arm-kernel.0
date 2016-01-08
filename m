From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 8 Jan 2016 18:13:06 +0100
Subject: [PATCH RFC 0/2] Add a display driver to the Allwinner H3
In-Reply-To: <20160106212046.GD9631@lukather>
References: <cover.1452021349.git.moinejf@free.fr>
 <20160106212046.GD9631@lukather>
Message-ID: <20160108181306.4a5a7370f0e3f3daa7c9e285@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jan 2016 22:20:46 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > As there is no documentation about the DE2 nor about the HDMI which
> > are found in the H3, this driver has been built from Allwiiner's
> > sources.
> 
> That's unfortunate :/
> 
> Have you checked in the A64 BSP if there was some useful information?

Same as the H3: no more information about the display system.

> > So, there may be license problems, especially for the file
> > de2_hdmi_h3.c which contains a lot of magic values.
> 
> I guess it's the biggest issue with your code right now. What licenses
> issues are we talking about here?

The documentation about the H3, as the other Allwinner documentations,
starts with:

	This documentation is the original work and copyrighted
	property of Allwinner Technology ("Allwinner"). Reproduction in
	whole or in part must obtain the written approval of Allwinner
	and give clear acknowledgement to the copyright owner.

Then, the DE2 sources contain only:

	All Winner Tech, All Right Reserved. 2014-2015 Copyright (c)

Eventually, there is no copyright/author/history in the HDMI sources.

> Remember that having your Signed-off-by tag on a commit means that you
> certify that you have the right to submit the patch under the license
> you indicate in the files added and / or modified.
> 
> If you don't have such right, for example because you don't have the
> right and / or authorization from the initial author to re-license
> that code, you cannot put your SoB.

OK, sorry. So, please, ignore the whole patch series.

> > The associated DT and documentation will be submitted when the H3 DTs
> > will be in the kernel.
> 
> Having the DT binding documentation would really help in the review.

Here it is, as a sunxi specific documentation, but it could be generic.

--- /dev/null	1970-01-01 01:00:10.240000002 +0100
+++ Documentation/devicetree/bindings/display/sunxi.txt	2016-01-08 17:48:01.775903901 +0100
@@ -0,0 +1,107 @@
+Allwinner sunxi display subsystem
+=================================
+
+The sunxi display subsystems contain a display controller (DE),
+one or two LCD controllers (TCON) and their external interfaces.
+
+Display controller
+==================
+
+Required properties:
+
+- compatible: value should be one of the following
+		"allwinner,sun8i-h3-display-engine"
+
+- clocks: must include clock specifiers corresponding to entries in the
+		clock-names property.
+
+- clock-names: must contain
+		gate: for DE activation
+		clock: DE clock
+
+- resets: phandle to the reset of the device
+
+- ports: phandle's to the LCD ports
+
+LCD controller
+==============
+
+Required properties:
+
+- compatible: value should be one of the following
+		"allwinner,sun8i-h3-lcd"
+
+- clocks: must include clock specifiers corresponding to entries in the
+		clock-names property.
+
+- clock-names: must contain
+		gate: for LCD activation
+		clock: pixel clock
+
+- resets: phandle to the reset of the device
+
+- port: port node with endpoint definitions as defined in
+	Documentation/devicetree/bindings/media/video-interfaces.txt
+
+HDMI support
+============
+
+Required properties:
+
+- compatible: value should be one of the following
+		"allwinner,sun8i-h3-hdmi"
+
+- clocks: must include clock specifiers corresponding to entries in the
+		clock-names property.
+
+- clock-names: must contain
+		gate: for HDMI activation
+		clock: pixel clock
+		ddc-clock: for the HDMI protocol
+
+- resets: one or two phandle's to the reset of the device
+
+- port: port node with endpoint definitions as defined in
+	Documentation/devicetree/bindings/media/video-interfaces.txt
+
+Example:
+
+	de: de-controller at 01000000 {
+		compatible = "allwinner,sun8i-h3-display-engine";
+		...
+		clocks = <&bus_gates 44>, <&de_clk>;
+		clock-names = "gate", "clock";
+		resets = <&bus_rst 44>;
+		ports = <&lcd0_p>;
+	};
+
+	lcd0: lcd-controller at 01c0c000 {
+		compatible = "allwinner,sun8i-h3-lcd";
+		...
+		clocks = <&bus_gates 35>, <&tcon0_clk>;
+		clock-names = "gate", "clock";
+		resets = <&bus_rst 35>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		lcd0_p: port {
+			lcd0_ep: endpoint {
+				remote-endpoint = <&hdmi_ep>;
+			};
+		};
+	};
+
+	hdmi: hdmi at 01ee0000 {
+		compatible = "allwinner,sun8i-h3-hdmi";
+		...
+		clocks = <&bus_gates 43>, <&hdmi_clk>,
+			 <&hdmi_slow_clk 31>;
+		clock-names = "gate", "clock", "ddc-clock";
+		resets = <&bus_rst 42>, <&bus_rst 43>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		port {
+			hdmi_ep: endpoint {
+				remote-endpoint = <&lcd0_ep>;
+			};
+		};
+	};

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
