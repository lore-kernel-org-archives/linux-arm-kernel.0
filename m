From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 22 Apr 2016 05:36:29 +0000
Subject: [PATCH v6 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
 device tree binding documentation
In-Reply-To: <20160421134226.GA10399@rob-hp-laptop>
References: <1460710374-25077-1-git-send-email-appanad@xilinx.com>
 <20160421134226.GA10399@rob-hp-laptop>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A579D5E@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

	Thanks for the review...

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Thursday, April 21, 2016 7:12 PM
> To: Appana Durga Kedareswara Rao <appanad@xilinx.com>
> Cc: pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek
> <michals@xilinx.com>; Soren Brinkmann <sorenb@xilinx.com>;
> vinod.koul at intel.com; dan.j.williams at intel.com; Appana Durga Kedareswara
> Rao <appanad@xilinx.com>; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Anirudha
> Sarangi <anirudh@xilinx.com>; Punnaiah Choudary Kalluri
> <punnaia@xilinx.com>; devicetree at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> dmaengine at vger.kernel.org
> Subject: Re: [PATCH v6 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
> device tree binding documentation
> 
> On Fri, Apr 15, 2016 at 02:22:53PM +0530, Kedareswara rao Appana wrote:
> > Device-tree binding documentation for Xilinx zynqmp dma engine used in
> > Zynq UltraScale+ MPSoC.
> >
> > Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes in v6:
> > - Removed desc-axi-cache/dst-axi-cache/src-axi-cache properties
> >   from the binding doc as it allow broken combinations when dma-coherent
> >   is set as suggested by Rob.
> > - Fixed minor comments given by Rob related coding(lower case DT node
> name).
> > Changes in v5:
> > - Use dma-coherent flag for coherent transfers as suggested by rob.
> > - Removed unnecessary properties from binding doc as suggested by Rob.
> > Changes in v4:
> > - None
> > Changes in v3:
> > - None
> > Changes in v2:
> > - None.
> >
> >  .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  | 44
> ++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> >
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> > new file mode 100644
> > index 0000000..f0f0b54
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> > @@ -0,0 +1,44 @@
> > +Xilinx ZynqMP DMA engine, it does support memory to memory transfers,
> > +memory to device and device to memory transfers. It also has flow
> > +control and rate control support for slave/peripheral dma access.
> > +
> > +Required properties:
> > +- compatible		: Should be "xlnx,zynqmp-dma-1.0"
> > +- reg			: Memory map for gdma/adma module access.
> > +- interrupt-parent	: Interrupt controller the interrupt is routed through
> > +- interrupts		: Should contain DMA channel interrupt.
> > +- xlnx,bus-width	: Axi buswidth in bits. Should contain 128 or 64
> 
> I think how this is getting used by the driver is wrong.
> {src,dst}_addr_widths are supposed to be a bitmask of supported slave
> device register widths. You aren't doing a bitmask and you are also
> saying you only support slaves with 8 or 16 byte data registers which is
> somewhat rare. It may happen to work because 128/8 == BIT(4). However,
> the documentation for the field is contradictory in that it says 1,2,4
> or 8 byte widths are supported, but the enum has more sizes.


The DMA supports an AXI bus width of 128/64 bits only.
Please refer IP data sheet. http://www.xilinx.com/support/documentation/user_guides/ug1085-zynq-ultrascale-trm.pdf Page No: 359(DMA Over fetch section).

That's why during probe we are making the dma_device supported source and destination address widths accordingly based on the DT property.

Snap shot of driver code from the probe:
       struct dma_device *p; 
       p->dst_addr_widths = zdev->chan->bus_width / 8;
       p->src_addr_widths = zdev->chan->bus_width / 8;

Where bus_width property is read from the probe.
err = of_property_read_u32(node, "xlnx,bus-width", &chan->bus_width)

Cheers!,
Kedar...

> 
> Rob
