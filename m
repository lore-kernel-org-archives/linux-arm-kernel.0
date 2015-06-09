From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 9 Jun 2015 14:23:08 +0200
Subject: [PATCH v2] mtd: nand: Sunxi calculate timing cfg
In-Reply-To: <1433849498-3270-1-git-send-email-r.spliet@ultimaker.com>
References: <1433849498-3270-1-git-send-email-r.spliet@ultimaker.com>
Message-ID: <20150609142308.0fd0952a@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Roy,

On Tue,  9 Jun 2015 13:31:38 +0200
Roy Spliet <r.spliet@ultimaker.com> wrote:

For the patch title, could you use the "mtd: nand: sunxi: " prefix,
then a short description of what you're modifying ("fix TIMING_CFG
calculation" for example).

> Values derived from the A83 user manual

The commit message should describe what you're doing. You can specify
where you retrieved the relevant information from, but that's not
enough.

> 
> V2: fix crippled comments

Put the changelog...

> 
> Signed-off-by: Roy Spliet <r.spliet@ultimaker.com>
> ---

... here, so that it doesn't appear in the final commit.

>  drivers/mtd/nand/sunxi_nand.c | 42 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 37 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index 6f93b29..86de7e3 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -208,6 +208,7 @@ struct sunxi_nand_hw_ecc {
>   * @nand:		base NAND chip structure
>   * @mtd:		base MTD structure
>   * @clk_rate:		clk_rate required for this NAND chip
> + * @timing_cfg		TIMING_CFG register value for this NAND chip
>   * @selected:		current active CS
>   * @nsels:		number of CS lines required by the NAND chip
>   * @sels:		array of CS lines descriptions
> @@ -217,6 +218,7 @@ struct sunxi_nand_chip {
>  	struct nand_chip nand;
>  	struct mtd_info mtd;
>  	unsigned long clk_rate;
> +	u32 timing_cfg;
>  	int selected;
>  	int nsels;
>  	struct sunxi_nand_chip_sel sels[0];
> @@ -403,6 +405,7 @@ static void sunxi_nfc_select_chip(struct mtd_info *mtd, int chip)
>  		}
>  	}
>  
> +	writel(sunxi_nand->timing_cfg, nfc->regs + NFC_REG_TIMING_CFG);
>  	writel(ctl, nfc->regs + NFC_REG_CTL);
>  
>  	sunxi_nand->selected = chip;
> @@ -807,10 +810,28 @@ static int sunxi_nfc_hw_syndrome_ecc_write_page(struct mtd_info *mtd,
>  	return 0;
>  }
>  
> +static const s32 tWB_lut[]  = {6, 12, 16, 20, -1};
> +static const s32 tRHW_lut[] = {4,  8, 12, 20, -1};

Nitpick: if you want to align the assignment, use tab instead of spaces
(I'm personally not a big fan of these sort of alignment).

> +
> +static s32 sunxi_nand_lookup_timing(const s32 *lut, lut, u32 period, u32 clk_period)

I'm not sure the period name is appropriate here, what you're actually
passing is the timing you're expecting.
How about renaming it 'min_timing'

> +{
> +	u32 clks = (period + clk_period - 1) / clk_period;

	u32 clks = DIV_ROUND_UP(period, clk_period);

And again, IMO the variable name does not match what it's really
encoding. How about div or divisor ?

> +	int i;
> +
> +	for (i = 0; lut[i] != -1; i++) {

I'd prefer to have the lut_size passed in argument instead of this -1
entry. Note that you'll be able to use the ARRAY_SIZE macro when
calling the sunxi_nand_lookup_timing() function:

sunxi_nand_lookup_timing(tRHW_lut,
			 ARRAY_SIZE(tRHW_lut),
			 timings->tRHW_min,
			 min_clk_period);

> +		if (clks <= lut[i])
> +			return i;
> +	}
> +
> +	/* Return max value */
> +	return i - 1;

Shouldn't we complain and fail (instead of silently returning the last
entry) if we didn't find any suitable value ?
I mean, if we configure the controller with invalid timings, we might
encounter some trouble when launching specific operations.

> +}
> +
>  static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>  				       const struct nand_sdr_timings *timings)
>  {
>  	u32 min_clk_period = 0;
> +	u32 tWB, tADL, tWHR, tRHW, tCAD;
>  
>  	/* T1 <=> tCLS */
>  	if (timings->tCLS_min > min_clk_period)
> @@ -872,6 +893,20 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>  	if (timings->tWC_min > (min_clk_period * 2))
>  		min_clk_period = DIV_ROUND_UP(timings->tWC_min, 2);
>  
> +	/* T16 - T19 + tCAD */
> +	tWB  = sunxi_nand_lookup_timing(tWB_lut, timings->tWB_max,
> +			min_clk_period);

Please align min_clk_period argument on the opening parenthesis (the
same comments applies in other places).

> +	tADL = DIV_ROUND_UP(timings->tADL_min, min_clk_period) >> 3;
> +	tWHR = DIV_ROUND_UP(timings->tWHR_min, min_clk_period) >> 3;
> +	tRHW = sunxi_nand_lookup_timing(tRHW_lut, timings->tRHW_min,
> +			min_clk_period);
> +	tCAD = 0x7;
> +	chip->timing_cfg = (tWB & 0x3) |
> +			   (tADL & 0x3) << 2 |
> +			   (tWHR & 0x3) << 4 |
> +			   (tRHW & 0x3) << 6 |
> +			   (tCAD & 0x7) << 8;
> +	/* \todo A83 has some more bits for CDQSS, CS, CLHZ, CCS, WC */

Use the "TODO:" or "FIXME:" keywords so that people greping on these
pattern will be able to find them.

>  
>  	/* Convert min_clk_period from picoseconds to nanoseconds */
>  	min_clk_period = DIV_ROUND_UP(min_clk_period, 1000);
> @@ -884,8 +919,6 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>  	 */
>  	chip->clk_rate = (2 * NSEC_PER_SEC) / min_clk_period;
>  
> -	/* TODO: configure T16-T19 */
> -
>  	return 0;
>  }
>  
> @@ -1168,6 +1201,7 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  
>  	chip->nsels = nsels;
>  	chip->selected = -1;
> +	chip->timing_cfg = 0x7ff;
>  
>  	for (i = 0; i < nsels; i++) {
>  		ret = of_property_read_u32_index(np, "reg", i, &tmp);
> @@ -1377,11 +1411,9 @@ static int sunxi_nfc_probe(struct platform_device *pdev)
>  	platform_set_drvdata(pdev, nfc);
>  
>  	/*
> -	 * TODO: replace these magic values with proper flags as soon as we
> -	 * know what they are encoding.
> +	 * TODO: replace this magic values with EDO flag
>  	 */
>  	writel(0x100, nfc->regs + NFC_REG_TIMING_CTL);
> -	writel(0x7ff, nfc->regs + NFC_REG_TIMING_CFG);

Are you planning to post another patch defining the EDO mode flag and
using it instead of keeping this magic value (note that I'm not
asking you to make this change in the same patch, but that would be
great to have it in the same patch series) ?

Thanks.

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
