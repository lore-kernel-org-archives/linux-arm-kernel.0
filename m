From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 6 Sep 2016 10:23:02 +0200
Subject: [PATCH 1/2] mtd: nand: automate NAND timings selection
In-Reply-To: <1472820149-24241-2-git-send-email-s.hauer@pengutronix.de>
References: <1472820149-24241-1-git-send-email-s.hauer@pengutronix.de>
 <1472820149-24241-2-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160906082302.4itzqv4ldd3foazu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On Fri, Sep 02, 2016 at 02:42:28PM +0200, Sascha Hauer wrote:
> +static int nand_configure_data_interface(struct mtd_info *mtd)
> +{
> +	struct nand_chip *chip = mtd_to_nand(mtd);
> +	struct nand_data_interface *conf;
> +	int modes, mode, ret = -EINVAL;
> +	uint8_t tmode_param[ONFI_SUBFEATURE_PARAM_LEN] = { };
> +	int i;
> +
> +	conf = kzalloc(sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	/* TODO: support DDR interfaces */
> +	conf->type = NAND_SDR_IFACE;
> +
> +	/*
> +	 * First try to identify the best timings from ONFI parameters and
> +	 * if the NAND does not support ONFI, fallback to the default ONFI
> +	 * timing mode.
> +	 */
> +	modes = onfi_get_async_timing_mode(chip);
> +	if (modes == ONFI_TIMING_MODE_UNKNOWN) {
> +		mode = chip->onfi_timing_mode_default;
> +		conf->timings.sdr =
> +				*onfi_async_timing_mode_to_sdr_timings(mode);
> +
> +		ret = nand_check_data_interface(mtd, conf);
> +	} else {
> +		for (mode = fls(modes) - 1; mode >= 0; mode--) {
> +			conf->timings.sdr =
> +				*onfi_async_timing_mode_to_sdr_timings(mode);
> +
> +			ret = nand_check_data_interface(mtd, conf);
> +			if (!ret)
> +				break;
> +		}
> +	}

I wonder if this works good for non ONFI NANDs. In the ONFI case we
iterate over all modes supported by the NAND until we find one that also
suits the driver. By doing so we inherently assume that not all drivers
support all modes. In the non ONFI case instead we hardcode a single
timing into the nand_id table, what if the driver does not support this
timing? It will fail in this case without ever trying slower timings.
Shouldn't we encode the mode bitmask into the nand_id table rather than
a single timing?
I cannot find a chip in the nand_id table which actually sets
onfi_timing_mode_default, but since you introduced the field in the
nand_id table with commit 57a94e24bc92 you can probably tell me more.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
