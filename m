From: yong.deng@magewell.com (Yong)
Date: Thu, 28 Dec 2017 09:05:27 +0800
Subject: [PATCH v4 1/2] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
In-Reply-To: <20171226215537.cmn4l7k2w764yrsg@rob-hp-laptop>
References: <1513935689-35415-1-git-send-email-yong.deng@magewell.com>
 <20171226215537.cmn4l7k2w764yrsg@rob-hp-laptop>
Message-ID: <20171228090527.59d207e03f08a81f51497b9c@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 26 Dec 2017 15:55:37 -0600
Rob Herring <robh@kernel.org> wrote:

> On Fri, Dec 22, 2017 at 05:41:29PM +0800, Yong Deng wrote:
> > Add binding documentation for Allwinner V3s CSI.
> > 
> > Signed-off-by: Yong Deng <yong.deng@magewell.com>
> > ---
> >  .../devicetree/bindings/media/sun6i-csi.txt        | 51 ++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > new file mode 100644
> > index 0000000..b5bfe3f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > @@ -0,0 +1,51 @@
> > +Allwinner V3s Camera Sensor Interface
> > +------------------------------
> > +
> > +Required properties:
> > +  - compatible: value must be "allwinner,sun8i-v3s-csi"
> > +  - reg: base address and size of the memory-mapped region.
> > +  - interrupts: interrupt associated to this IP
> > +  - clocks: phandles to the clocks feeding the CSI
> > +    * bus: the CSI interface clock
> > +    * mod: the CSI module clock
> > +    * ram: the CSI DRAM clock
> > +  - clock-names: the clock names mentioned above
> > +  - resets: phandles to the reset line driving the CSI
> > +
> > +- ports: A ports node with endpoint definitions as defined in
> > +  Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +  Currently, the driver only support the parallel interface. So, a single port
> > +  node with one endpoint and parallel bus is supported.
> 
> What the driver supports is not relevant. Please document what the h/w 
> has.

OK.

> 
> > +
> > +Example:
> > +
> > +	csi1: csi at 1cb4000 {
> > +		compatible = "allwinner,sun8i-v3s-csi";
> > +		reg = <0x01cb4000 0x1000>;
> > +		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +		clocks = <&ccu CLK_BUS_CSI>,
> > +			 <&ccu CLK_CSI1_SCLK>,
> > +			 <&ccu CLK_DRAM_CSI>;
> > +		clock-names = "bus", "mod", "ram";
> > +		resets = <&ccu RST_BUS_CSI>;
> > +
> > +		port {
> 
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> 
> These are not needed with a single endpoint.

OK.

> 
> > +
> > +			/* Parallel bus endpoint */
> > +			csi1_ep: endpoint {
> > +				remote-endpoint = <&adv7611_ep>;
> > +				bus-width = <16>;
> > +				data-shift = <0>;
> > +
> > +				/* If hsync-active/vsync-active are missing,
> > +				   embedded BT.656 sync is used */
> > +				hsync-active = <0>; /* Active low */
> > +				vsync-active = <0>; /* Active low */
> > +				data-active = <1>;  /* Active high */
> > +				pclk-sample = <1>;  /* Rising */
> > +			};
> > +		};
> > +	};
> > +
> > -- 
> > 1.8.3.1
> > 


Thanks,
Yong
