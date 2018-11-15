From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 15 Nov 2018 20:04:24 +0100
Subject: [PATCH 1/5] dt-bindings: media: Add Allwinner A10 CSI binding
In-Reply-To: <20181113083855.s5jxrb32ru3myu3t@kekkonen.localdomain>
References: <cover.71b0f9855c251f9dc389ee77ee6f0e1fad91fb0b.1542097288.git-series.maxime.ripard@bootlin.com>
 <60494dd4245ab01473d074dc5cd46198a2181614.1542097288.git-series.maxime.ripard@bootlin.com>
 <20181113083855.s5jxrb32ru3myu3t@kekkonen.localdomain>
Message-ID: <20181115190424.gpuekifrjli5mu77@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sakari,

On Tue, Nov 13, 2018 at 10:38:55AM +0200, Sakari Ailus wrote:
> > +  - allwinner,has-isp: Whether the CSI controller has an ISP
> > +                       associated to it or not
> 
> Is the ISP a part of the same device? It sounds like that this is actually
> a different device if it contains an ISP as well, and that should be
> apparent from the compatible string. What do you think?

I guess we can see it as both. It seems to be the exact same register
set, except for the fact that the first instance has that ISP in
addition, and several channels, as you pointed out in your other mail.

What these channels are is not exactly clear. It looks like it's
related to the BT656 interface where you could interleave channel
bytes over the bus. I haven't really looked into it, and it doesn't
look like we have any code (or hardware) able to do that though.

> > +
> > +If allwinner,has-isp is set, an additional "isp" clock is needed,
> > +being a phandle to the clock driving the ISP.
> > +
> > +The CSI node should contain one 'port' child node with one child
> > +'endpoint' node, according to the bindings defined in
> > +Documentation/devicetree/bindings/media/video-interfaces.txt. The
> > +endpoint's bus type must be parallel or BT656.
> > +
> > +Endpoint node properties for CSI
> > +---------------------------------
> > +
> > +- remote-endpoint	: (required) a phandle to the bus receiver's endpoint
> > +			   node
> 
> Rob's opinion has been (AFAIU) that this is not needed as it's already a
> part of the graph bindings. Unless you want to say that it's required, that
> is --- the graph bindings document it as optional.

Ok, I'll remove it.

> > +- bus-width:		: (required) must be 8
> 
> If this is the only value the hardware supports, I don't see why you should
> specify it here.

Ditto :)

> > +- pclk-sample		: (optional) (default: sample on falling edge)
> > +- hsync-active		: (only required for parallel)
> > +- vsync-active		: (only required for parallel)
> > +
> > +Example:
> > +
> > +csi0: csi at 1c09000 {
> > +	compatible = "allwinner,sun7i-a20-csi",
> > +		     "allwinner,sun4i-a10-csi";
> > +	reg = <0x01c09000 0x1000>;
> > +	interrupts = <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>;
> > +	clocks = <&ccu CLK_AHB_CSI0>, <&ccu CLK_CSI0>,
> > +		 <&ccu CLK_CSI_SCLK>, <&ccu CLK_DRAM_CSI0>;
> > +	clock-names = "ahb", "mod", "isp", "ram";
> > +	resets = <&ccu RST_CSI0>;
> > +	allwinner,csi-channels = <4>;
> > +	allwinner,has-isp;
> > +	
> > +	port {
> > +		csi_from_ov5640: endpoint {
> > +                        remote-endpoint = <&ov5640_to_csi>;
> > +                        bus-width = <8>;
> > +                        data-shift = <2>;
> 
> data-shift needs to be documented above if it's relevant for the device.

It's not really related to the CSI device in that case but the sensor,
so I'll just leave it out.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181115/1afd6459/attachment-0001.sig>
