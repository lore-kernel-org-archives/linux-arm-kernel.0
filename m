From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 6 Sep 2016 14:01:24 +0200
Subject: [PATCH 5/7] mtd: nand: sunxi: switch from manual to automated
 timing config
In-Reply-To: <1473158355-22451-6-git-send-email-s.hauer@pengutronix.de>
References: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
 <1473158355-22451-6-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160906140124.6414c855@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  6 Sep 2016 12:39:13 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> The NAND framework is now able to select the best NAND timings for us.
> All we have to do is implement a ->setup_data_interface() function to
> apply those timings and remove the timing selection code from the sunxi
> driver.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/sunxi_nand.c | 77 +++++++++----------------------------------
>  1 file changed, 15 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/mtd/nand/sunxi_nand.c b/drivers/mtd/nand/sunxi_nand.c
> index e414b31..ee42b8c 100644
> --- a/drivers/mtd/nand/sunxi_nand.c
> +++ b/drivers/mtd/nand/sunxi_nand.c
> @@ -1572,14 +1572,23 @@ static int _sunxi_nand_lookup_timing(const s32 *lut, int lut_size, u32 duration,
>  #define sunxi_nand_lookup_timing(l, p, c) \
>  			_sunxi_nand_lookup_timing(l, ARRAY_SIZE(l), p, c)
>  
> -static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
> -				       const struct nand_sdr_timings *timings)
> +static int sunxi_nfc_setup_data_interface(struct mtd_info *mtd,
> +					    const struct nand_data_interface *conf,
> +					    bool check_only)
>  {
> +	struct nand_chip *nand = mtd_to_nand(mtd);
> +	struct sunxi_nand_chip *chip = to_sunxi_nand(nand);
>  	struct sunxi_nfc *nfc = to_sunxi_nfc(chip->nand.controller);
> +	const struct nand_sdr_timings *timings;
>  	u32 min_clk_period = 0;
>  	s32 tWB, tADL, tWHR, tRHW, tCAD;
>  	long real_clk_rate;
>  
> +	if (conf->type != NAND_SDR_IFACE)
> +		return -ENOTSUPP;
> +
> +	timings = &conf->timings.sdr;

Can we hide this behind an accessor (nand_get_sdr_timings())? I know I'm
picky, but I've had so many drivers to patch in the past because of
internal reorganization, and I'd like to avoid that in the future.

> +
>  	/* T1 <=> tCLS */
>  	if (timings->tCLS_min > min_clk_period)
>  		min_clk_period = timings->tCLS_min;
> @@ -1679,6 +1688,9 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>  		return tRHW;
>  	}
>  
> +	if (check_only)
> +		return 0;
> +
>  	/*
>  	 * TODO: according to ONFI specs this value only applies for DDR NAND,
>  	 * but Allwinner seems to set this to 0x7. Mimic them for now.
> @@ -1712,44 +1724,6 @@ static int sunxi_nand_chip_set_timings(struct sunxi_nand_chip *chip,
>  	return 0;
>  }
>  
> -static int sunxi_nand_chip_init_timings(struct sunxi_nand_chip *chip,
> -					struct device_node *np)
> -{
> -	struct mtd_info *mtd = nand_to_mtd(&chip->nand);
> -	const struct nand_sdr_timings *timings;
> -	int ret;
> -	int mode;
> -
> -	mode = onfi_get_async_timing_mode(&chip->nand);
> -	if (mode == ONFI_TIMING_MODE_UNKNOWN) {
> -		mode = chip->nand.onfi_timing_mode_default;
> -	} else {
> -		uint8_t feature[ONFI_SUBFEATURE_PARAM_LEN] = {};
> -		int i;
> -
> -		mode = fls(mode) - 1;
> -		if (mode < 0)
> -			mode = 0;
> -
> -		feature[0] = mode;
> -		for (i = 0; i < chip->nsels; i++) {
> -			chip->nand.select_chip(mtd, i);
> -			ret = chip->nand.onfi_set_features(mtd,	&chip->nand,
> -						ONFI_FEATURE_ADDR_TIMING_MODE,
> -						feature);
> -			chip->nand.select_chip(mtd, -1);
> -			if (ret)
> -				return ret;
> -		}
> -	}
> -
> -	timings = onfi_async_timing_mode_to_sdr_timings(mode);
> -	if (IS_ERR(timings))
> -		return PTR_ERR(timings);
> -
> -	return sunxi_nand_chip_set_timings(chip, timings);
> -}
> -
>  static int sunxi_nand_ooblayout_ecc(struct mtd_info *mtd, int section,
>  				    struct mtd_oob_region *oobregion)
>  {
> @@ -1975,7 +1949,6 @@ static int sunxi_nand_ecc_init(struct mtd_info *mtd, struct nand_ecc_ctrl *ecc,
>  static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  				struct device_node *np)
>  {
> -	const struct nand_sdr_timings *timings;
>  	struct sunxi_nand_chip *chip;
>  	struct mtd_info *mtd;
>  	struct nand_chip *nand;
> @@ -2065,25 +2038,11 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  	nand->read_buf = sunxi_nfc_read_buf;
>  	nand->write_buf = sunxi_nfc_write_buf;
>  	nand->read_byte = sunxi_nfc_read_byte;
> +	nand->setup_data_interface = sunxi_nfc_setup_data_interface;
>  
>  	mtd = nand_to_mtd(nand);
>  	mtd->dev.parent = dev;
>  
> -	timings = onfi_async_timing_mode_to_sdr_timings(0);
> -	if (IS_ERR(timings)) {
> -		ret = PTR_ERR(timings);
> -		dev_err(dev,
> -			"could not retrieve timings for ONFI mode 0: %d\n",
> -			ret);
> -		return ret;
> -	}
> -
> -	ret = sunxi_nand_chip_set_timings(chip, timings);
> -	if (ret) {
> -		dev_err(dev, "could not configure chip timings: %d\n", ret);
> -		return ret;
> -	}
> -
>  	ret = nand_scan_ident(mtd, nsels, NULL);
>  	if (ret)
>  		return ret;
> @@ -2096,12 +2055,6 @@ static int sunxi_nand_chip_init(struct device *dev, struct sunxi_nfc *nfc,
>  
>  	nand->options |= NAND_SUBPAGE_READ;
>  
> -	ret = sunxi_nand_chip_init_timings(chip, np);
> -	if (ret) {
> -		dev_err(dev, "could not configure chip timings: %d\n", ret);
> -		return ret;
> -	}
> -
>  	ret = sunxi_nand_ecc_init(mtd, &nand->ecc, np);
>  	if (ret) {
>  		dev_err(dev, "ECC init failed: %d\n", ret);
