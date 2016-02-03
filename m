From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 Feb 2016 20:59:19 +0100
Subject: [PATCH v2 17/26] drm: sun4i: Add DT bindings documentation
In-Reply-To: <20160115031515.GA19797@rob-hp-laptop>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
 <1452785109-6172-18-git-send-email-maxime.ripard@free-electrons.com>
 <20160115031515.GA19797@rob-hp-laptop>
Message-ID: <20160203195919.GB3327@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Thu, Jan 14, 2016 at 09:15:15PM -0600, Rob Herring wrote:
> On Thu, Jan 14, 2016 at 04:25:00PM +0100, Maxime Ripard wrote:
> > The display pipeline of the Allwinner A10 is involving several loosely
> > coupled components.
> > 
> > Add a documentation for the bindings.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  .../bindings/display/sunxi/sun4i-drm.txt           | 228 +++++++++++++++++++++
> 
> drm is a linuxism. It shouldn't be used for binding doc.

Ack

> >  1 file changed, 228 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > new file mode 100644
> > index 000000000000..061bc87147a3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt
> > @@ -0,0 +1,228 @@
> > +Allwinner A10 Display Pipeline
> > +==============================
> > +
> > +The Allwinner A10 Display pipeline is composed of several components
> > +that are going to be documented below:
> > +
> > +TV Encoder
> > +----------
> > +
> > +The TV Encoder supports the composite and VGA output. It is one end of
> > +the pipeline.
> > +
> > +Required properties:
> > + - compatible: value should be "allwinner,sun4i-a10-tv-encoder".
> > + - reg: base address and size of memory-mapped region
> > + - clocks: the clocks driving the TV encoder
> > +
> > +- ports: A ports node with endpoint definitions as defined in
> > +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > +  first port should be the input endpoint.
> > +
> > +TCON
> > +----
> > +
> > +The TCON acts as a timing controller for RGB, LVDS and TV interfaces.
> > +
> > +Required properties:
> > + - compatible: value should be "allwinner,sun4i-a10-tcon".
> > + - reg: base address and size of memory-mapped region
> > + - interrupts: interrupt associated to this IP
> > + - clocks: phandles to the clocks feeding the TCON. Three are needed:
> > +   - 'ahb': the interface clocks
> > +   - 'tcon-ch0': The clock driving the TCON channel 0
> > +   - 'tcon-ch1': The clock driving the TCON channel 1
> > +
> > + - clock-names: the clock names mentioned above
> > + - clock-output-names: Name of the pixel clock created
> > +
> > +- ports: A ports node with endpoint definitions as defined in
> > +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > +  first port should be the input endpoint, the second one the output
> > +
> > +Optional properties:
> > +  - allwinner,panel: phandle to the panel used in our RGB interface
> > +
> > +
> > +Display Engine Backend
> > +----------------------
> > +
> > +The display engine backend exposes layers and sprites to the
> > +system.
> > +
> > +Required properties:
> > +  - compatible: value must be one of:
> > +    * allwinner,sun5i-a13-display-backend
> > +  - reg: base address and size of the memory-mapped region.
> > +  - clocks: phandles to the clocks feeding the frontend and backend
> > +    * ahb: the backend interface clock
> > +    * mod: the backend module clock
> > +    * ram: the backend DRAM clock
> > +  - clock-names: the clock names mentioned above
> > +  - resets: phandles to the reset controllers driving the backend
> > +
> > +- ports: A ports node with endpoint definitions as defined in
> > +  Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > +  first port should be the input endpoints, the second one the output
> > +
> > +Display Engine Frontend
> > +-----------------------
> > +
> > +The display engine frontend does formats conversion, scaling,
> > +deinterlacing and color space conversion.
> > +
> > +Required properties:
> > +  - compatible: value must be one of:
> > +    * allwinner,sun5i-a13-display-frontend
> > +  - reg: base address and size of the memory-mapped region.
> > +  - interrupts: interrupt associated to this IP
> > +  - clocks: phandles to the clocks feeding the frontend and backend
> 
> > +    * ahb: the backend interface clock
> > +    * mod: the backend module clock
> > +    * ram: the backend DRAM clock
> 
> should be frontend?

Yeah, stupid copy/paste mistake :/

> 
> > +  - clock-names: the clock names mentioned above
> > +  - resets: phandles to the reset controllers driving the backend
> 
> ditto
> 
> > +
> > +Display Engine Pipeline
> > +-----------------------
> > +
> > +The display engine pipeline (and its entry point, since it can be
> > +either directly the backend or the frontend) is represented as an
> > +extra node.
> > +
> > +Required properties:
> > +  - compatible: value must be one of:
> > +    * allwinner,sun5i-a13-display-engine
> > +  - allwinner,pipelines: list of phandle to the entry points of the
> > +    pipelines (either to the frontend or backend)
> > +
> > +Example:
> > +
> > +panel: panel {
> > +	compatible = "olimex,lcd-olinuxino-43-ts";
> 
> This should either be a child of what it is attached to or use of-graph.

You had a similar discussion with Thierry last time I sent it, and it
seemed to settle on keeping that property:

http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/382115.html

Has that changed?

> > +};
> > +
> > +tve0: tv-encoder at 01c0a000 {
> > +	compatible = "allwinner,sun4i-a10-tv-encoder";
> > +	reg = <0x01c0a000 0x1000>;
> > +	clocks = <&ahb_gates 34>;
> > +
> > +	port {
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +
> > +		tve0_in_tcon0: endpoint at 0 {
> > +			reg = <0>;
> 
> I would drop the reg where you only have 1 node for ports or endpoints.

Ok

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/441bf2b8/attachment-0001.sig>
