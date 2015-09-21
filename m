From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 21 Sep 2015 21:27:12 +0530
Subject: [PATCH v2] dmaengine: vdma: Add 64 bit addressing support to the
 driver
In-Reply-To: <1440690558-39822-1-git-send-email-anuragku@xilinx.com>
References: <1440690558-39822-1-git-send-email-anuragku@xilinx.com>
Message-ID: <20150921155712.GN2381@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 27, 2015 at 09:19:18PM +0530, Anurag Kumar Vulisha wrote:
> This VDMA  is a soft ip, which can be programmed to support
> 32 bit addressing or greater than 32 bit addressing.
> 
> When the VDMA ip is configured for 32 bit address space the
> transfer start address is specified by a single register.

would be good to specfiy which one

> When the  VDMA core is configured for an address space greater
> than 32 then each start address is specified by a combination
> of two registers. The first register specifies the LSB 32 bits
> of address, while the next register specifies the MSB 32 bits
> of address.For example,5Ch will specify the LSB 32 bits while
> 60h will specify the MSB 32 bits of the first start address.So
> we need to program two registers at a time.

can we have spaces after full stops and commas!

> +/* Since vdma driver is trying to write to a register offset which is not a
> + * multiple of 64 bits(ex : 0x5c), we are writing as two separate 32 bits
> + * instead of a single 64 bit register write.
> + */

This is not kernel style for multi-lines, pls refer to
Documentation/CodingStyle

> +
> +static inline void vdma_desc_write_64(struct xilinx_vdma_chan *chan, u32 reg,
> +				 u32 value_lsb, u32 value_msb)
> +{
> +	/* Write the lsb 32 bits*/
> +	writel(value_lsb, chan->xdev->regs + chan->desc_offset + reg);
> +
> +	/* Write the msb 32 bits */
> +	writel(value_msb, chan->xdev->regs + chan->desc_offset + reg + 4);

why not writeq

> +	err = of_property_read_u32(node, "xlnx,addrwidth", &addr_width);
> +
> +	if (err < 0) {
> +		/* Setting addr_width property to default 32 bits */
> +		addr_width = 32;
> +	}

braces for a single line statement! Also space is redandant before if
condition

-- 
~Vinod
