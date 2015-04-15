From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 15 Apr 2015 16:02:28 +0200
Subject: [PATCH 1/2] ARM: dts: imx6qdl-sabrelite: add supported LVDS
 displays
In-Reply-To: <552C1D9C.4090303@boundarydevices.com>
References: <5521E08F.3060407@boundarydevices.com>
 <1428920545.3192.41.camel@pengutronix.de>
 <552C1D9C.4090303@boundarydevices.com>
Message-ID: <1429106548.3480.43.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

Am Montag, den 13.04.2015, 12:48 -0700 schrieb Eric Nelson:
[...]
> The full DT for an LVDS channel looks like this:
> 
> ...	
> lvds-channel at 0 {
> 	#address-cells = <0x00000001>;
> 	#size-cells = <0x00000000>;
> 	...
> 	port at 0 {
> 		reg = <0x00000000>;
> 		endpoint {
> 			remote-endpoint = <0x00000013>;
> 			linux,phandle = <0x00000039>;
> 			phandle = <0x00000039>;
> 		};
> 	};
> 	port at 1 {
> ...	};
> 	port at 2 {
> ...	};
> 	port at 3 {
> ...	};
> 	port at 4 {
> 		reg = <0x00000004>;
> 		endpoint {
> 			remote-endpoint = <0x00000017>;
> 			linux,phandle = <0x00000053>;
> 			phandle = <0x00000053>;
> 		};
> 	};
> };
> 
> ports 0-3 refer to the LVDS mux and which IPU and display
> interface is connected up to the LVDS channel (i.e. the
> input to the LVDS display bridge) and port at 4 refer to the
> panel.

Yes. I still don't understand what you think is the problem with that.

> >>> [snip]
> >>>
> >>> 	panel {
> >>> 		compatible = "edt,etm0700g0dh6", "simple-panel";
> >>> 		...
> >>>
> >>
> >> And why would the panel need to point back to the LVDS
> >> channel?
> > 
> > This is the way the bindings are defined right now in
> > Documentation/devicetree/bindings/graph.txt, section "Links between
> > endpoints". The panel driver itself doesn't use the backlink, but the
> > endpoint needs to exist anyway.
> > 
> 
> Thanks for the reference.
> 
> I'm not following the rationale  since in this case, the communication
> needs seem to be uni-directional, but okay.

The binding as currently defined describes an undirected graph, set up
in a way that each node can find its peers without knowing anything
about the peer's bindings and without scanning the whole device tree.
So far there has been no consensus whether a direction should be added,
if it should be marked by leaving out one of the phandles, and if so,
what this direction should represent.

[...]
> This does give me a path to get the equivalent functionality
> as my original patches:
> 
> 	- (if needed) add displays to panel-simple.c
> 	- update DT in boot loader to fix up displays based on panel
> 	detection by setting the panel.compatible string value.
> 
> I am still left with a quandary, which relates to my comment about
> the port selection.
>
> With our current device tree, both the HDMI and LVDS devices
> are being mapped to IPU1/DI0 and the same DRM "card":
> 
> 	~# ls  /sys/class/graphics/fb0/device/drm/card0/card*
> 	card0-HDMI-A-1	card0-LVDS-1

There is only one "card" representing both IPUs and everything connected
to their DI outputs. Both connectors being mapped to the same frame
buffer is a property of drm_fb_helper_initial_config, as described in
its kerneldoc comment:

 "At the moment, this is a cloned configuration across all heads with
  a new framebuffer object as the backing store."

> Since the default i.MX6 graph appears to have links for all four LVDS
> mux options, and the path to binding to one of the IPU/DI -> LVDS
> channel mappings isn't clear to me.

All four LVDS mux options are connected in hardware, so that's what the
device tree describes. The path can be chosen dynamically via CRTC
modeset.

regards
Philipp
