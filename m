From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 31 Mar 2016 06:58:11 +0000
Subject: [PATCH v3 1/2] dmaengine: vdma: Add 64 bit addressing support
 to the driver
In-Reply-To: <20160329185531.GA19517@rob-hp-laptop>
References: <1458897378-3852-1-git-send-email-appanad@xilinx.com>
 <20160329185531.GA19517@rob-hp-laptop>
Message-ID: <C246CAC1457055469EF09E3A7AC4E11A4A57155C@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

	Thanks for the review...

> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: Wednesday, March 30, 2016 12:26 AM
> To: Appana Durga Kedareswara Rao
> Cc: pawel.moll at arm.com; mark.rutland at arm.com;
> ijc+devicetree at hellion.org.uk; galak at codeaurora.org; Michal Simek; Soren
> Brinkmann; vinod.koul at intel.com; dan.j.williams at intel.com; Anurag Kumar
> Vulisha; Appana Durga Kedareswara Rao; moritz.fischer at ettus.com;
> laurent.pinchart at ideasonboard.com; luis at debethencourt.com; Srikanth
> Vemula; Anirudha Sarangi; dmaengine at vger.kernel.org;
> devicetree at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v3 1/2] dmaengine: vdma: Add 64 bit addressing support to
> the driver
> 
> On Fri, Mar 25, 2016 at 02:46:18PM +0530, Kedareswara rao Appana wrote:
> > This VDMA  is a soft ip, which can be programmed to support
> > 32 bit addressing or greater than 32 bit addressing.
> >
> > When the VDMA ip is configured for 32 bit address space the buffer
> > address is specified by a single register (0x5C for MM2S and 0xAC for
> > S2MM channel).
> >
> > When the  VDMA core is configured for an address space greater than 32
> > then each buffer address is specified by a combination of two
> > registers.
> >
> > The first register specifies the LSB 32 bits of address, while the
> > next register specifies the MSB 32 bits of address.
> >
> > For example, 5Ch will specify the LSB 32 bits while 60h will specify
> > the MSB 32 bits of the first start address.
> > So we need to program two registers at a time.
> >
> > This patch adds the 64 bit addressing support to the vdma driver.
> >
> > Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> > Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> > ---
> > Changes for v3:
> > --> Improved commit message as suggested by vinod.
> > --> removed unnecessary braces for single line if conditions.
> > Changes for v2:
> > ---> Added dma-ranges property in device tree as suggested by Arnd
> Bergmann.
> > ---> Added device tree property(xlnx,addrwidth) for an identification
> > ---> of whether
> >      the IP block itself is configured in 64-bit or 32-bit mode as suggested by
> >      Laurent Pinchart.
> > ---> Modified the driver code based on the xlnx,addrwidth.
> >
> >  .../devicetree/bindings/dma/xilinx/xilinx_vdma.txt |  4 ++
> >  drivers/dma/Kconfig                                |  2 +-
> >  drivers/dma/xilinx/xilinx_vdma.c                   | 73 +++++++++++++++++++---
> >  3 files changed, 70 insertions(+), 9 deletions(-)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > index e4c4d47..a86737c 100644
> > --- a/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > +++ b/Documentation/devicetree/bindings/dma/xilinx/xilinx_vdma.txt
> > @@ -8,6 +8,8 @@ Required properties:
> >  - #dma-cells: Should be <1>, see "dmas" property below
> >  - reg: Should contain VDMA registers location and length.
> >  - xlnx,num-fstores: Should be the number of framebuffers as configured in
> h/w.
> > +- xlnx,addrwidth: Should be the vdma addressing size in bits(ex: 32 bits).
> > +- dma-ranges: Should be as the following <dma_addr cpu_addr max_len>.
> 
> Doesn't the log2 of the dma-ranges size provide you with the address width?

VDMA IP configurable for 32-bit or 64-bit addressing.

In any of the configuration I mean if it is a 32-bit or 64-bit addressing there is a flexibility for the vdma to choose the
Memory range supported by the VDMA...

For example if vdma is configured for 40-bit addressing.

Theoretically it can access memory up to 1TB if it is true we can get the
Address width using log2 of the dma-ranges size as you mentioned above.

But in real use case user won't map the entire memory
He will map only the memory of his own choice...

For example user mapped 2GB then dma-ranges property will be like below.

dma-ranges = <0x00000000 0x00000000  0x80000000>;

In this case log2 of the dma-ranges size won't give exact value for address width.
That's why used separate h/w property for getting address width of the IP...

Thanks,
Kedar.

> 
> >  - dma-channel child node: Should have at least one channel and can have up
> to
> >  	two channels per device. This node specifies the properties of each
> >  	DMA channel (see child node properties below).
> > @@ -41,8 +43,10 @@ axi_vdma_0: axivdma at 40030000 {
> >  	compatible = "xlnx,axi-vdma-1.00.a";
> >  	#dma_cells = <1>;
> >  	reg = < 0x40030000 0x10000 >;
> > +	dma-ranges = <0x00000000 0x00000000 0x40000000>;
> >  	xlnx,num-fstores = <0x8>;
> >  	xlnx,flush-fsync = <0x1>;
> > +	xlnx,addrwidth = <0x20>;
> >  	dma-channel at 40030000 {
> >  		compatible = "xlnx,axi-vdma-mm2s-channel";
> >  		interrupts = < 0 54 4 >;
