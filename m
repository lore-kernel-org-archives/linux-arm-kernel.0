From: stillcompiling@gmail.com (Joshua Clayton)
Date: Wed, 9 Nov 2016 16:04:07 -0800
Subject: [PATCH fpga 2/9] fpga zynq: Check the bitstream for validity
In-Reply-To: <1478732303-13718-3-git-send-email-jgunthorpe@obsidianresearch.com>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-3-git-send-email-jgunthorpe@obsidianresearch.com>
Message-ID: <17912798-e55d-253f-42fc-c7287d067e00@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Minor comment below:

On 11/09/2016 02:58 PM, Jason Gunthorpe wrote:
> @@ -184,12 +197,28 @@ static int zynq_fpga_ops_write_init(struct fpga_manager *mgr, u32 flags,
>  
>  	priv = mgr->priv;
>  
> +	/* The hardware can only DMA multiples of 4 bytes, and we need at
> +	 * least the sync word and something else to do anything.
> +	 */
> +	if (count <= 4 || (count % 4) != 0) {
> +		dev_err(priv->dev,
> +			"Invalid bitstream size, must be multiples of 4 bytes\n");
> +		return -EINVAL;
> +	}
> +
>  	err = clk_enable(priv->clk);
>  	if (err)
>  		return err;
>  
>  	/* don't globally reset PL if we're doing partial reconfig */
>  	if (!(flags & FPGA_MGR_PARTIAL_RECONFIG)) {
> +		if (!zynq_fpga_has_sync(buf, count)) {
> +			dev_err(priv->dev,
> +				"Invalid bitstream, could not find a sync word. Bitstream must be a byte swaped .bin file\n");
Nitpick: byte swaped is a misspelling... and I'm not sure I like the second half of this message.
Maybe something like  "Bitstream must be lsb first" (if that is what is meant).
> +			err = -EINVAL;
> +			goto out_err;
> +		}
> +
>  		/* assert AXI interface resets */
>  		regmap_write(priv->slcr, SLCR_FPGA_RST_CTRL_OFFSET,
>  			     FPGA_RST_ALL_MASK);
>
Thanks,

Joshua
