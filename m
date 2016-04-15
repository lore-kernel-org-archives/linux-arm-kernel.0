From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 15 Apr 2016 08:52:33 +0000
Subject: [PATCH v5 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
 device tree binding documentation
In-Reply-To: <20160414150413.GA24644@rob-hp-laptop>
References: <1460524609-8722-1-git-send-email-appanad@xilinx.com>
 <20160414150413.GA24644@rob-hp-laptop>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57739E@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

	Thanks for the review...

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Thursday, April 14, 2016 8:34 PM
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
> Subject: Re: [PATCH v5 1/2] Documentation: DT: dma: Add Xilinx zynqmp dma
> device tree binding documentation
> 
> On Wed, Apr 13, 2016 at 10:46:48AM +0530, Kedareswara rao Appana wrote:
> > Device-tree binding documentation for Xilinx zynqmp dma engine used in
> > Zynq UltraScale+ MPSoC.
> >
> > Signed-off-by: Punnaiah Choudary Kalluri <punnaia@xilinx.com>
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
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
> >  .../devicetree/bindings/dma/xilinx/zynqmp_dma.txt  | 50
> ++++++++++++++++++++++
> >  1 file changed, 50 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> >
> > diff --git a/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> > new file mode 100644
> > index 0000000..4ad0aea40
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/zynqmp_dma.txt
> > @@ -0,0 +1,50 @@
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
> > +- clock-names		: List of input clocks "clk_main", "clk_apb"
> > +			  (see clock bindings for details)
> > +
> > +Optional properties:
> > +- xlnx,include-sg	: Indicates the controller to operate in simple or
> > +			  scatter gather dma mode
> > +- xlnx,ratectrl		: Scheduling interval in terms of clock cycles for
> > +			  source AXI transaction
> > +- xlnx,overfetch	: Tells whether the channel is allowed to over
> > +			  fetch the data
> > +- xlnx,src-issue	: Number of AXI outstanding transactions on source
> side
> > +- xlnx,desc-axi-cache	: AXI cache bits to be used for descriptor fetch
> > +- xlnx,src-axi-cache	: AXI cache bits to be used for data read
> > +- xlnx,dst-axi-cache	: AXI cache bits to be used for data write
> 
> Shouldn't you be able to derive these values from whether dma-coherent
> is set. To put it another way, allowing setting both allows for lots of
> broken combinations.

Ok will remove these properties and will set these cache bits only 
When dma-coherent is present in the driver.

> 
> > +- xlnx,src-burst-len	: AXI length for data read. Support only power of
> > +			  2 values.
> > +- xlnx,dst-burst-len	: AXI length for data write. Support only power of
> > +			  2 values.
> 
> What unit? Seems to be beats from the example. I would suggest bytes
> instead.

Bytes only will fix in next version...


> 
> > +- dma-coherent		: Present if dma operations are coherent.
> > +
> > +Example:
> > +++++++++
> > +fpd_dma_chan1: dma at FD500000 {
> 
> lowercase address.

Will fix in next version.
> 
> > +	compatible = "xlnx,zynqmp-dma-1.0";
> > +	reg = <0x0 0xFD500000 0x1000>;
> > +	interrupt-parent = <&gic>;
> > +	interrupts = <0 117 4>;
> > +	clock-names = "clk_main", "clk_apb";
> > +	xlnx,bus-width = <128>;
> > +	xlnx,include-sg;
> > +	xlnx,overfetch;
> > +	dma-coherent;
> > +	xlnx,ratectrl = <0>;
> > +	xlnx,src-issue = <16>;
> > +	xlnx,desc-axi-cache = <0xFF>;
> > +	xlnx,src-axi-cache = <0xFF>;
> > +	xlnx,dst-axi-cache = <0xFF>;
> 
> Last I checked, AXI only has 4 cache bits.

Hmm wrong example anyway will remove these properties in the next version...

Regards,
Kedar.

> 
> > +	xlnx,src-burst-len = <4>;
> > +	xlnx,dst-burst-len = <4>;
> > +};
> > --
> > 2.1.2
> >
