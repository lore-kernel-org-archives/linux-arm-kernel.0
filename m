From: eric.nelson@boundarydevices.com (Eric Nelson)
Date: Sun, 05 Apr 2015 18:25:35 -0700
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabrelite: add supported LVDS displays
In-Reply-To: 1424422420.3137.7.camel@pengutronix.de
Message-ID: <5521E08F.3060407@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

Sorry for the delayed response. I missed your reply and Shawn pointed
it out.

On Feb. 20, 2015, 8:53 a.m., Philipp Zabel wrote:
>
> Am Donnerstag, den 19.02.2015, 16:53 -0700 schrieb Eric Nelson:
>
>> The BD-SL-i.MX6 (SABRE Lite board) supports three companion displays:
>> 	Okaya 1024x600
>> 	Hannstar 1024x768
>> 	LG 1280x800
>> 
>> This patch adds timing entries into the LDB device tree and aliasesl
>> for them and HDMI to make it easy for the boot loader to configure them.
>>
>> Signed-off-by: Eric Nelson <eric.nelson@boundarydevices.com>
> 
> Could you please have a look at the simple-panel driver and add these
> panels there instead? This allows to handle enable/disable timings,
> backlights and regulators or enable GPIOs properly.
> 
> I have a patch to add drm_panel support to the imx-ldb driver (see
> below). It depends on this of-graph series:
> 
>     https://lkml.org/lkml/2015/1/22/104
> 

The use of simple panel seems to add and remove functionality:
	- adds backlight, regulators and enable GPIOs!
	- loses the ability to express timings in DT

> regards
> Philipp
> 
> -----8<-----
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Date: Thu, 6 Mar 2014 14:54:39 +0100
> Subject: [PATCH] drm/imx: imx-ldb: add drm_panel support
> 
> This patch allows to optionally attach the lvds-channel to a panel
> supported by a drm_panel driver using of-graph bindings, instead of
> supplying the modes via display-timings in the device tree.
> 
> This depends on of_graph_get_port_by_id and uses the OF graph to
> link the optional DRM panel to the LDB lvds-channel. The output
> port number is 2 on devices without the external 4-port input
> multiplexer (i.MX5) and 4 on devices with the mux (i.MX6).
> 
> Before:
> 
> 	ldb {
> 		...
> 
> 		lvds-channel at 0 {
> 			...
> 
> 			display-timings {
> 				native-timing = <&timing1>;
> 				timing1: etm0700g0dh6 {
> 					hactive = <800>;
> 					vactive = <480>;
> 					clock-frequency = <33260000>;
> 					hsync-len = <128>;
> 					hback-porch = <88>;
> 					hfront-porch = <40>;
> 					vsync-len = <2>;
> 					vback-porch = <33>;
> 					vfront-porch = <10>;
> 					hsync-active = <0>;
> 					vsync-active = <0>;
> 					...
> 				};
> 			};
> 			...
> 		};
> 	};
> 
> After:
> 	ldb {
> 		...
> 
> 		lvds-channel at 0 {
> 			...
> 

Using port here to point at the panel seems to conflict
with the use of ports to point at the IPU.

> 			port at 4 {
> 				reg = <4>;
> 
> 				lvds_out: endpoint {
> 					remote_endpoint = <&panel_in>;
> 				};
> 			};
> 		};
> 	};
> 
> 	panel {
> 		compatible = "edt,etm0700g0dh6", "simple-panel";
> 		...
> 

And why would the panel need to point back to the LVDS
channel?

> 		port {
> 			panel_in: endpoint {
> 				remote-endpoint = <&lvds_out>;
> 			};
> 		};
> 	}; 
> 

Do you have a working example of how this should be used?

My attempts to follow the notes above results in a failure
to find a crtc for the LVDS channel.

Please advise,


Eric Nelson
