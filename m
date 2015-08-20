From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Thu, 20 Aug 2015 10:47:48 +0000
Subject: [PATCH] dmaengine: vdma: Add 64 bit addressing support to the
 driver
In-Reply-To: <2214014.FVHbR3JRBK@avalon>
References: <1438775257-3511-1-git-send-email-anuragku@xilinx.com>
 <2214014.FVHbR3JRBK@avalon>
Message-ID: <3802E9A6666DF54886E2B9CBF743BA9801BF8264@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

> -----Original Message-----
> From: Anurag Kumar Vulisha
> Sent: Thursday, August 20, 2015 2:41 PM
> To: Anurag Kumar Vulisha
> Subject: RE:[PATCH] dmaengine: vdma: Add 64 bit addressing support to the
> driver
> 
> 
> Hi Anurag,
> 
> Thank you for the patch.
> 
> On Wednesday 05 August 2015 17:17:37 Anurag Kumar Vulisha wrote:
> > This patch adds the 64 bit addressing support to the vdma driver.
> >
> > Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> > ---
> >  drivers/dma/Kconfig              |    2 +-
> >  drivers/dma/xilinx/xilinx_vdma.c |   36
> ++++++++++++++++++++++++++++------
> >  2 files changed, 31 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig index
> > bda2cb0..a7cd0a8 100644
> > --- a/drivers/dma/Kconfig
> > +++ b/drivers/dma/Kconfig
> > @@ -398,7 +398,7 @@ config FSL_EDMA
> >
> >  config XILINX_VDMA
> >  	tristate "Xilinx AXI VDMA Engine"
> > -	depends on (ARCH_ZYNQ || MICROBLAZE)
> > +	depends on (ARCH_ZYNQ || MICROBLAZE || ARM64)
> >  	select DMA_ENGINE
> >  	help
> >  	  Enable support for Xilinx AXI VDMA Soft IP.
> > diff --git a/drivers/dma/xilinx/xilinx_vdma.c
> > b/drivers/dma/xilinx/xilinx_vdma.c index d8434d4..3dcbd29 100644
> > --- a/drivers/dma/xilinx/xilinx_vdma.c
> > +++ b/drivers/dma/xilinx/xilinx_vdma.c
> > @@ -98,7 +98,11 @@
> >  #define XILINX_VDMA_FRMDLY_STRIDE_FRMDLY_SHIFT	24
> >  #define XILINX_VDMA_FRMDLY_STRIDE_STRIDE_SHIFT	0
> >
> > +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
> 
> Strictly speaking that should be CONFIG_ARCH_DMA_ADDR_T_64BIT.
> 

Will change this in v2

> > +#define XILINX_VDMA_REG_START_ADDRESS(n)	(0x000c + 8 * (n))
> > +#else
> >  #define XILINX_VDMA_REG_START_ADDRESS(n)	(0x000c + 4 * (n))
> > +#endif
> >
> >  /* HW specific definitions */
> >  #define XILINX_VDMA_MAX_CHANS_PER_DEVICE	0x2
> > @@ -143,16 +147,16 @@
> >   * @next_desc: Next Descriptor Pointer @0x00
> >   * @pad1: Reserved @0x04
> >   * @buf_addr: Buffer address @0x08
> > - * @pad2: Reserved @0x0C
> > - * @vsize: Vertical Size @0x10
> > - * @hsize: Horizontal Size @0x14
> > + * @pad2: Reserved @0x10
> > + * @vsize: Vertical Size @0x14
> > + * @hsize: Horizontal Size @0x18
> >   * @stride: Number of bytes between the first
> > - *	    pixels of each horizontal line @0x18
> > + *	    pixels of each horizontal line @0x1C
> >   */
> >  struct xilinx_vdma_desc_hw {
> >  	u32 next_desc;
> >  	u32 pad1;
> > -	u32 buf_addr;
> > +	u64 buf_addr;
> 
> This will change the descriptor layout for 32-bit VDMA, I don't think that's
> right.
> 

Will change this in v2

> >  	u32 pad2;
> >  	u32 vsize;
> >  	u32 hsize;
> > @@ -272,6 +276,20 @@ static inline void vdma_desc_write(struct
> > xilinx_vdma_chan *chan, u32 reg, vdma_write(chan, chan->desc_offset +
> > reg, value);  }
> >
> > +#if defined(CONFIG_PHYS_ADDR_T_64BIT) static inline void
> > +vdma_desc_write_64(struct xilinx_vdma_chan *chan, u32
> > reg,
> > +				 u64 value)
> > +{
> > +	/* Write the lsb 32 bits*/
> > +	writel(lower_32_bits(value),
> > +			chan->xdev->regs + chan->desc_offset + reg);
> > +
> > +	/* Write the msb 32 bits */
> > +	writel(upper_32_bits(value),
> > +			chan->xdev->regs + chan->desc_offset + reg + 4);
> 
> So the CPU can't perform 64-bit register access ?
>

We are trying to write at a register address(0x5c) which is not aligned on
8 bytes boundary.So if I try to use 64 bit write on it, unalignment fault will
be generated. Because of this we are using two separate 32  bit writes. 
 
> How is 64 bit DMA addressing implemented ? Can you use a 64-bit VDMA on
> a 32- bit platform with LPAE ? Can you use a 32-bit VDMA on a 64-bit platform
> ?
> Given that VDMA is an IP core you can instantiate in the programmable logic I
> expect some level of flexibility to be possible, but this patch doesn't seem to
> support it. Please provide more context to allow a proper review (and please
> include it in the commit message of v2).
>

The VDMA core is a soft ip, which can be programmed to support both 32 bit and
64 bit addressing.When the VDMA core is configured for 32 bit address space ,
transfer start address is specified by a single register.

When the  VDMA core is configured for an address space greater than 32, each
start address is specified by a combination of two registers.The first register
specifies the LSB 32 bits of address, while the next register specifies the MSB
32 bits of address.For example,5Ch will specify the LSB bits while 60h will
specify the MSB bits of the first start address. So we need to program two
registers at a time.

Yes,64 bit vdma can be used on 32 bit platform and 32 bit vdma can also be used
on 64 bit platform.As far as i know , there is no use case where 64 bit dma can
be used on 32 bit platform.Please correct me if i am wrong.

> > +}
> > +#endif
> > +
> >  static inline u32 vdma_ctrl_read(struct xilinx_vdma_chan *chan, u32
> > reg)  {
> >  	return vdma_read(chan, chan->ctrl_offset + reg); @@ -700,9 +718,15
> > @@ static void xilinx_vdma_start_transfer(struct xilinx_vdma_chan
> > *chan) int i = 0;
> >
> >  		list_for_each_entry(segment, &desc->segments, node) {
> > -			vdma_desc_write(chan,
> > +#if defined(CONFIG_PHYS_ADDR_T_64BIT)
> > +			vdma_desc_write_64(chan,
> >
> 	XILINX_VDMA_REG_START_ADDRESS(i++),
> >  					segment->hw.buf_addr);
> > +#else
> > +			vdma_desc_write(chan,
> > +
> 	XILINX_VDMA_REG_START_ADDRESS(i++),
> > +					(u32)segment->hw.buf_addr);
> > +#endif
> >  			last = segment;
> >  		}
> 
> --

Thanks,
Anurag Kumar V
