From: jacopo@jmondi.org (jacopo mondi)
Date: Fri, 23 Nov 2018 08:45:14 +0100
Subject: [PATCH v12 1/2] dt-bindings: media: Add Allwinner V3s Camera
 Sensor Interface (CSI)
In-Reply-To: <308184907.pMD7ZDI2dr@avalon>
References: <1540887143-27904-1-git-send-email-yong.deng@magewell.com>
 <308184907.pMD7ZDI2dr@avalon>
Message-ID: <20181123074514.GB6788@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

On Tue, Oct 30, 2018 at 03:06:24PM +0200, Laurent Pinchart wrote:
> Hi Yong,
>
> Thank you for the patch.
>
> On Tuesday, 30 October 2018 10:12:23 EET Yong Deng wrote:
> > Add binding documentation for Allwinner V3s CSI.
> >
> > Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Yong Deng <yong.deng@magewell.com>
>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
> > ---
> >  .../devicetree/bindings/media/sun6i-csi.txt        | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/sun6i-csi.txt
> >
> > diff --git a/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > b/Documentation/devicetree/bindings/media/sun6i-csi.txt new file mode
> > 100644
> > index 000000000000..443e18c181b3
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/sun6i-csi.txt
> > @@ -0,0 +1,56 @@
> > +Allwinner V3s Camera Sensor Interface
> > +-------------------------------------
> > +
> > +Allwinner V3s SoC features a CSI module(CSI1) with parallel interface.
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
> > +The CSI node should contain one 'port' child node with one child 'endpoint'
> > +node, according to the bindings defined in
> > +Documentation/devicetree/bindings/media/video-interfaces.txt.
> > +
> > +Endpoint node properties for CSI
> > +---------------------------------
> > +See the video-interfaces.txt for a detailed description of these
> > properties. +- remote-endpoint	: (required) a phandle to the bus receiver's
> > endpoint +			   node
> > +- bus-width:		: (required) must be 8, 10, 12 or 16
> > +- pclk-sample		: (optional) (default: sample on falling edge)
> > +- hsync-active		: (required; parallel-only)
> > +- vsync-active		: (required; parallel-only)
> > +
> > +Example:
> > +
> > +csi1: csi at 1cb4000 {
> > +	compatible = "allwinner,sun8i-v3s-csi";
> > +	reg = <0x01cb4000 0x1000>;
> > +	interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > +	clocks = <&ccu CLK_BUS_CSI>,
> > +		 <&ccu CLK_CSI1_SCLK>,
> > +		 <&ccu CLK_DRAM_CSI>;
> > +	clock-names = "bus", "mod", "ram";
> > +	resets = <&ccu RST_BUS_CSI>;
> > +
> > +	port {
> > +		/* Parallel bus endpoint */
> > +		csi1_ep: endpoint {
> > +			remote-endpoint = <&adv7611_ep>;
> > +			bus-width = <16>;
> > +
> > +			/* If hsync-active/vsync-active are missing,
> > +			   embedded BT.656 sync is used */

Am I confused? The properties description defines [v|h]sync-active as
required, but the example reports that they can be omitted to use
BT.656 synchronization.

Which one of the following is correct?
1) [h|v]sync-active are mandatory: no BT.656 support can be selected.
2) [h|v]sync-active are optional, and if not specified BT.656 is
   selected.
3) I am confused.

Thanks
   j

> > +			hsync-active = <0>; /* Active low */
> > +			vsync-active = <0>; /* Active low */
> > +			pclk-sample = <1>;  /* Rising */
> > +		};
> > +	};
> > +};
>
>
> --
> Regards,
>
> Laurent Pinchart
>
>
>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181123/dcb47582/attachment.sig>
