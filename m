From: liviu.dudau@arm.com (Liviu Dudau)
Date: Wed, 29 Aug 2018 09:51:55 +0100
Subject: [PATCH 1/2] drm/bridge: Add virtual display DT bindings
In-Reply-To: <20180829081637eucas1p21ebead8d65d823a3cb2bec8839600573~PTPFKjnEJ1080610806eucas1p23@eucas1p2.samsung.com>
References: <CGME20180824122324epcas3p2922f3e5415dacf4c89cfb136fa5c77b2@epcas3p2.samsung.com>
 <20180824122308.3092-1-linus.walleij@linaro.org>
 <20180827115302eucas1p24d36cfaf9835ccb217ac81e508484aa1~Ou5eTkYW-3006130061eucas1p2Z@eucas1p2.samsung.com>
 <20180828143546.GG907@e110455-lin.cambridge.arm.com>
 <20180829081637eucas1p21ebead8d65d823a3cb2bec8839600573~PTPFKjnEJ1080610806eucas1p23@eucas1p2.samsung.com>
Message-ID: <20180829085155.GJ907@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 10:16:34AM +0200, Andrzej Hajda wrote:
> On 28.08.2018 16:35, Liviu Dudau wrote:
> > Hi Andrzej,
> >
> > Chirping in, as it was originally my work that Linus is adopting.
> >
> > On Mon, Aug 27, 2018 at 01:53:00PM +0200, Andrzej Hajda wrote:
> >> On 24.08.2018 14:23, Linus Walleij wrote:
> >>> This adds bindings for a virtual display to be used with displays
> >>> inside entirely virtual environments which do not emulate things
> >>> like monitors but just need timing information to be supplied to
> >>> its display controller.
> >>>
> >>> This is inspired by earlier work by Liviu Dudau.
> >> If this is pure virtual then it should be connected to other pure
> >> virtual components.
> > Any reason why you think this is the only way this should be connected?
> 
> I think pure virtual sink device cannot be connected to real pins of
> source device :)

I guess I have a wider view on what a source device can be. :)

> Either source exposes some virtual interfaces either its output will go
> to /dev/null, it would be good to know which case author want to address
> with these patches.

Two scenarios where this is useful: in an emulator (like QEMU or Arm's
RTSM) the CRTC device is being emulated, but the rest of the display
chain is being shortcut by reading the framebuffer data assigned to the
CRTC and displaying it directly (either by using an X11 window, or by
streaming it out to a VNC client). Or you have some real hardware, where
the real pins are connected to a bridge, but the bridge is under the
control of the firmware and can only be configured by it, without any
API to interact with from the kernel side. In that case the best you can
do is to put in the device tree a description of what the firmware did
and use that.

> 
> > My original implementation (and I haven't seen anything in this patch
> > that would invalidate it) assumed that the virtual bridge can be used by
> > any driver that uses the component framework. Hiding implementation
> > details is one of the benefits of using the component framework, so I
> > don't see what you gain by restricting connection to only other pure
> > virtual components.
> 
> I suppose these patches were created for some reason, so more
> explanation will be helpful.
> 
> >
> >> What will be this virtual bridge attached to? I expect some virtual
> >> encoder, virtual crtc? If yes then why don't you create whole virtual
> >> drm pipeline in one patchset?
> > This comment is probably more relevant to patch 2/2, but I agree that
> > it probably needs a virtual encoder. As for the CRTC, it should work
> > with any real DRM driver, AFAICT.
> 
> I do not think so, I guess it could work with sources which do not
> communicate with sinks, ie. they have only output pins - in such case
> video stream will not be visible, is this something we want? Why?
> In case source expects some signals on pins connected to sink, it could
> be problematic.

It is not about how the hardware is connected, it is about discoverability
and the ability to control some of the parts in the chain. When that ability
is missing, you are forced to emulate the parts with a "virtual" bridge.

Best regards,
Liviu

> 
> >
> >> Could you describe more what do you want to do.
> > He wants to enable the PL110 DRM driver on systems that lack a way of
> > detecting the actual encoder and connector being used (either because
> > there is none and they are emulated in software that doesn't mimic the
> > HW behaviour, or because the way you access the HW is done in a way that
> > doesn't model easily in the current DRM framework: by firmware, for
> > example).
> 
> And finally here is real reason to cope with. Since Linus also explained
> it in separate mail I will continue the thread with answering to his mail.
> 
> 
> Regards
> Andrzej
> 
> >
> > Best regards,
> > Liviu
> >
> >> And one more thing, you are defining virtual panel but you are using
> >> drm_bridge framework, why not drm_panel?
> >>
> >> Regards
> >> Andrzej
> >>
> >>> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> >>> Cc: Ryan Harkin <ryan.harkin@linaro.org>
> >>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> >>> ---
> >>>  .../display/bridge/virtual-display-bridge.txt | 62 +++++++++++++++++++
> >>>  1 file changed, 62 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/display/bridge/virtual-display-bridge.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/display/bridge/virtual-display-bridge.txt b/Documentation/devicetree/bindings/display/bridge/virtual-display-bridge.txt
> >>> new file mode 100644
> >>> index 000000000000..ea4f5a91ab94
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/display/bridge/virtual-display-bridge.txt
> >>> @@ -0,0 +1,62 @@
> >>> +Virtual Display Bridge
> >>> +
> >>> +This represents a display that is contained within an emulated
> >>> +environment.
> >>> +
> >>> +This means that the display engine mainly expects some timing
> >>> +parameters to be written into it, and after that the emulator will
> >>> +respond by creating a virtual display with the requested
> >>> +resolution characteristics.
> >>> +
> >>> +As the operating system cannot "detect" such a display, rather the
> >>> +emulator will respond to what the controller outputs, a
> >>> +chicken-and-egg problem needs to be solved: the resolution and
> >>> +timing characteristics need to be defined and set up somewhere.
> >>> +
> >>> +The virtual display bridge solves this by defining a bridge with
> >>> +all timing characteristics encoded into the device tree node.
> >>> +
> >>> +Required properies:
> >>> +- compatible: shall be "virtual-display-bridge"
> >>> +
> >>> +Required subnodes:
> >>> +- display-timings: contains in turn a display timing node
> >>> +  see display-timing.txt
> >>> +- ports: contains the display ports, see media/video-interfaces.txt
> >>> +
> >>> +Example:
> >>> +
> >>> +bridge {
> >>> +	compatible = "virtual-display-bridge";
> >>> +	#address-cells = <1>;
> >>> +	#size-cells = <0>;
> >>> +
> >>> +	display-timings {
> >>> +		/* Some standard VGA timing */
> >>> +		timing0 {
> >>> +			clock-frequency = <23750>;
> >>> +			hactive = <640>;
> >>> +			vactive = <480>;
> >>> +			hfront-porch = <48>;
> >>> +			hback-porch = <16>;
> >>> +			hsync-len = <96>;
> >>> +			vfront-porch = <33>;
> >>> +			vback-porch = <9>;
> >>> +			vsync-len = <3>;
> >>> +			vrefresh = <60>;
> >>> +		};
> >>> +	};
> >>> +
> >>> +	ports {
> >>> +		#address-cells = <1>;
> >>> +		#size-cells = <0>;
> >>> +
> >>> +		port at 0 {
> >>> +			reg = <0>;
> >>> +
> >>> +			display_bridge_in: endpoint {
> >>> +				remote-endpoint = <&foo>;
> >>> +			};
> >>> +		};
> >>> +	};
> >>> +};
> >>
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
