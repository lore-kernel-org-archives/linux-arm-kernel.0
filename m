From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 21 Aug 2015 02:01:59 +0300
Subject: [PATCH] dmaengine: vdma: Add 64 bit addressing support to the
 driver
In-Reply-To: <3802E9A6666DF54886E2B9CBF743BA9801BF8264@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1438775257-3511-1-git-send-email-anuragku@xilinx.com>
 <2214014.FVHbR3JRBK@avalon>
 <3802E9A6666DF54886E2B9CBF743BA9801BF8264@XAP-PVEXMBX01.xlnx.xilinx.com>
Message-ID: <2348343.VuhoH7scrX@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anurag,

On Thursday 20 August 2015 10:47:48 Anurag Kumar Vulisha wrote:
> On Thursday, August 20, 2015 2:41 PM Anurag Kumar Vulisha wrote:
> > On Wednesday 05 August 2015 17:17:37 Anurag Kumar Vulisha wrote:
> >> This patch adds the 64 bit addressing support to the vdma driver.
> >> 
> >> Signed-off-by: Anurag Kumar Vulisha <anuragku@xilinx.com>
> >> ---
> >> 
> >> drivers/dma/Kconfig              |    2 +-
> >> drivers/dma/xilinx/xilinx_vdma.c |   36 +++++++++++++++++++++++++------
> >>
> >> 2 files changed, 31 insertions(+), 7 deletions(-)

[snip]

> >> diff --git a/drivers/dma/xilinx/xilinx_vdma.c
> >> b/drivers/dma/xilinx/xilinx_vdma.c index d8434d4..3dcbd29 100644
> >> --- a/drivers/dma/xilinx/xilinx_vdma.c
> >> +++ b/drivers/dma/xilinx/xilinx_vdma.c

[snip]

> >> @@ -272,6 +276,20 @@ static inline void vdma_desc_write(struct
> >> xilinx_vdma_chan *chan, u32 reg, vdma_write(chan, chan->desc_offset +
> >> reg, value);  }
> >> 
> >> +#if defined(CONFIG_PHYS_ADDR_T_64BIT) static inline void
> >> +vdma_desc_write_64(struct xilinx_vdma_chan *chan, u32
> >> reg,
> >> +				 u64 value)
> >> +{
> >> +	/* Write the lsb 32 bits*/
> >> +	writel(lower_32_bits(value),
> >> +			chan->xdev->regs + chan->desc_offset + reg);
> >> +
> >> +	/* Write the msb 32 bits */
> >> +	writel(upper_32_bits(value),
> >> +			chan->xdev->regs + chan->desc_offset + reg + 4);
> > 
> > So the CPU can't perform 64-bit register access ?
> 
> We are trying to write at a register address(0x5c) which is not aligned on
> 8 bytes boundary.So if I try to use 64 bit write on it, unalignment fault
> will be generated. Because of this we are using two separate 32  bit
> writes.

Broken hardware design. Fair enough :-)

> > How is 64 bit DMA addressing implemented ? Can you use a 64-bit VDMA on
> > a 32- bit platform with LPAE ? Can you use a 32-bit VDMA on a 64-bit
> > platform ? Given that VDMA is an IP core you can instantiate in the
> > programmable logic I expect some level of flexibility to be possible, but
> > this patch doesn't seem to support it. Please provide more context to
> > allow a proper review (and please include it in the commit message of v2).
> 
> The VDMA core is a soft ip, which can be programmed to support both 32 bit
> and 64 bit addressing.When the VDMA core is configured for 32 bit address
> space , transfer start address is specified by a single register.
> 
> When the  VDMA core is configured for an address space greater than 32, each
> start address is specified by a combination of two registers.The first
> register specifies the LSB 32 bits of address, while the next register
> specifies the MSB 32 bits of address.For example,5Ch will specify the LSB
> bits while 60h will specify the MSB bits of the first start address. So we
> need to program two registers at a time.
> 
> Yes,64 bit vdma can be used on 32 bit platform and 32 bit vdma can also be
> used on 64 bit platform.As far as i know , there is no use case where 64
> bit dma can be used on 32 bit platform.Please correct me if i am wrong.

I'm not sure what the use cases would be, but it makes me feel uncomfortable 
to decide on whether the VDMA is 32 or 64 bits based on the type of CPU.

As the VDMA flavour is selected at synthesis time, how about specifying it in 
DT instead ? You could just add an address-width property.

-- 
Regards,

Laurent Pinchart
