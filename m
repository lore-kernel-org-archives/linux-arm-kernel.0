From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 27 Oct 2016 09:42:03 +0200
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161026225413.GA6220@obsidianresearch.com>
References: <20161026225413.GA6220@obsidianresearch.com>
Message-ID: <bdae79f1-dfed-d735-cb49-9ce8aa0b6e4f@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27.10.2016 00:54, Jason Gunthorpe wrote:
> There is no sense in sending a bitstream we know will not work, and
> with the variety of options for bitstream generation in Xilinx tools
> it is not terribly clear or very well documented what the correct
> input should be, especially since auto-detection was removed from this
> driver.
> 
> All Zynq full configuration bitstreams must start with the sync word in
> the correct byte order.
> 
> Zynq is also only able to DMA dword quantities, so bitstreams must be
> a multiple of 4 bytes. This also fixes a DMA-past the end bug.
> 
> Signed-off-by: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
> ---
>  drivers/fpga/zynq-fpga.c | 25 ++++++++++++++++---------
>  1 file changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fpga/zynq-fpga.c b/drivers/fpga/zynq-fpga.c
> index c2fb4120bd62..46a38772e7ee 100644
> --- a/drivers/fpga/zynq-fpga.c
> +++ b/drivers/fpga/zynq-fpga.c
> @@ -184,12 +184,26 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  
>  	priv = mgr->priv;
>  
> +	/* All valid bitstreams are multiples of 32 bits */
> +	if ((count % 4) != 0)
> +		return -EINVAL;
> +
>  	err = clk_enable(priv->clk);
>  	if (err)
>  		return err;
>  
>  	/* don't globally reset PL if we're doing partial reconfig */
>  	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> +		/* Sanity check the proposed bitstream. It must start with the
> +		 * sync word in the correct byte order and be a multiple of 4
> +		 * bytes.
> +		 */
> +		if (count <= 4 || buf[0] != 0x66 || buf[1] != 0x55 ||
> +		    buf[2] != 0x99 || buf[3] != 0xaa) {
> +			err = -EINVAL;
> +			goto out_err;
> +		}

I am not quite sure about this and I didn't try it on real hw.
But minimum bitstream size 52+B and more likely much more than this.

This is taken from u-boot source code and this is full BIN header.
The code above is checking only the last word.

#define DUMMY_WORD      0xffffffff

/* Xilinx binary format header */
static const u32 bin_format[] = {
        DUMMY_WORD, /* Dummy words */
        DUMMY_WORD,
        DUMMY_WORD,
        DUMMY_WORD,
        DUMMY_WORD,
        DUMMY_WORD,
        DUMMY_WORD,
        DUMMY_WORD,
        0x000000bb, /* Sync word */
        0x11220044, /* Sync word */
        DUMMY_WORD,
        DUMMY_WORD,
        0xaa995566, /* Sync word */
};

Thanks,
Michal
