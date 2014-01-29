From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 29 Jan 2014 10:56:42 -0700
Subject: [RFC PATCH v2 08/14] mtd: nand: add sunxi NAND flash controller
 support
In-Reply-To: <1391006064-28890-9-git-send-email-b.brezillon.dev@gmail.com>
References: <1391006064-28890-1-git-send-email-b.brezillon.dev@gmail.com>
 <1391006064-28890-9-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <20140129175641.GF1427@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 29, 2014 at 03:34:18PM +0100, Boris BREZILLON wrote:

> +static int sunxi_nand_chip_init_timings(struct sunxi_nand_chip *chip,
> +					struct device_node *np)
> +{
> +	const struct nand_sdr_timings *timings;
> +	u32 min_clk_period = 0;
> +	int ret;
> +
> +	ret = onfi_get_async_timing_mode(&chip->nand);
> +	if (ret == ONFI_TIMING_MODE_UNKNOWN) {
> +		ret = of_get_nand_onfi_timing_mode(np);
> +		if (ret < 0)
> +			return ret;
> +	}

[..]

> +static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
[..]
> +       ret = sunxi_nand_chip_init_timings(chip, np);
> +       if (ret)
> +               return ret;
[..]
> +       ret = nand_scan_ident(mtd, nsels, NULL);

This ordering looks a bit problematic, will onfi_get_async_timing_mode
ever return anything other than ONFI_TIMING_MODE_UNKNOWN if it is
called before nand_scan_ident ? What sets clk_rate to non-zero if there
is no DT property?

For a flow that uses onfi_get_async_timing_mode rather than DT the
driver should set the interface to timing mode 0 (slowest) and then
call nand_scan_ident, and then reset the interface to the detected
timing mode.

Maybe this should be implemented in the core code through a new
callback (nand->set_timing_mode ?)

Regards,
Jason
