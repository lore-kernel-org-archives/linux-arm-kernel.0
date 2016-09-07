From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Wed, 7 Sep 2016 15:41:14 +0200
Subject: [PATCH 3/7] mtd: nand: automate NAND timings selection
In-Reply-To: <1473250902-31139-4-git-send-email-s.hauer@pengutronix.de>
References: <1473250902-31139-1-git-send-email-s.hauer@pengutronix.de>
 <1473250902-31139-4-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20160907154114.1aae0462@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed,  7 Sep 2016 14:21:38 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> From: Boris Brezillon <boris.brezillon@free-electrons.com>
> 
> The NAND framework provides several helpers to query timing modes supported
> by a NAND chip, but this implies that all NAND controller drivers have
> to implement the same timings selection dance. Also currently NAND
> devices can be resetted at arbitrary places which also resets the timing
> for ONFI chips to timing mode 0.
> 
> Provide a common logic to select the best timings based on ONFI or
> ->onfi_timing_mode_default information. Hook this into nand_reset()  
> to make sure the new timing is applied each time during a reset.
> 
> NAND controller willing to support timings adjustment should just
> implement the ->setup_data_interface() method.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/mtd/nand/nand_base.c | 134 +++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mtd/nand.h     |  12 ++--
>  2 files changed, 142 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> index 1f704cc..c9bc988 100644
> --- a/drivers/mtd/nand/nand_base.c
> +++ b/drivers/mtd/nand/nand_base.c
> @@ -948,6 +948,130 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
>  }
>  
>  /**
> + * nand_reset_data_interface - Reset data interface and timings
> + * @chip: The NAND chip
> + *
> + * Reset the Data interface and timings to ONFI mode 0.
> + *
> + * Returns 0 for success or negative error code otherwise.
> + */
> +static int nand_reset_data_interface(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = &chip->mtd;
> +	struct nand_data_interface *conf;
> +	int ret;
> +
> +	if (!chip->setup_data_interface)
> +		return 0;
> +
> +	conf = kzalloc(sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	/*
> +	 * The ONFI specification says:
> +	 * "
> +	 * To transition from NV-DDR or NV-DDR2 to the SDR data
> +	 * interface, the host shall use the Reset (FFh) command
> +	 * using SDR timing mode 0. A device in any timing mode is
> +	 * required to recognize Reset (FFh) command issued in SDR
> +	 * timing mode 0.
> +	 * "
> +	 *
> +	 * Configure the data interface in SDR mode and set the
> +	 * timings to timing mode 0.
> +	 */
> +
> +	conf->type = NAND_SDR_IFACE,
> +	conf->timings.sdr = *onfi_async_timing_mode_to_sdr_timings(0);
> +
> +	ret = chip->setup_data_interface(mtd, conf, false);
> +	if (ret)
> +		pr_err("Failed to configure data interface to SDR timing mode 0\n");

I just realized that going back to timing mode 0 is not needed if your
chip is not ONFI or JEDEC compliant. But that's not really an issue.

> +
> +	kfree(conf);
> +
> +	return ret;
> +}
> +
> +/**
> + * nand_setup_data_interface - Setup the best data interface and timings
> + * @chip: The NAND chip
> + *
> + * Find and configure the best data interface and NAND timings supported by
> + * the chip and the driver.
> + * First tries to retrieve supported timing modes from ONFI information,
> + * and if the NAND chip does not support ONFI, relies on the
> + * ->onfi_timing_mode_default specified in the nand_ids table.
> + *
> + * Returns 0 for success or negative error code otherwise.
> + */
> +static int nand_setup_data_interface(struct nand_chip *chip)
> +{
> +	struct mtd_info *mtd = &chip->mtd;
> +	struct nand_data_interface *conf;
> +	int modes, mode, ret;
> +
> +	if (!chip->setup_data_interface)
> +		return 0;
> +
> +	/*
> +	 * First try to identify the best timings from ONFI parameters and
> +	 * if the NAND does not support ONFI, fallback to the default ONFI
> +	 * timing mode.
> +	 */
> +	modes = onfi_get_async_timing_mode(chip);
> +	if (modes == ONFI_TIMING_MODE_UNKNOWN) {
> +		if (!chip->onfi_timing_mode_default)
> +			return 0;
> +
> +		modes = GENMASK(chip->onfi_timing_mode_default, 0);
> +	}

This implementation is assuming the chip is either ONFI compliant or
not compliant with JEDEC and ONFI, but JEDEC chips also provides
'timing modes', except it's called 'speed grades'. Not sure how they
match to the ONFI timing modes, and I'm definitely not asking you to
support that right now, but that would be good to split the different
cases (ONFI compliant, JEDEC compliant and not compliant with JEDEC or
ONFI) in different functions.

Those functions would just fill in the nand_data_interface object, and 
nand_setup_data_interface() (or nand_select_data_interface(), if we
decide to split the logic in 2 different functions as suggested below)
would call one of them depending on the ->{jedec,onfo}_version values.

> +
> +	conf = kzalloc(sizeof(*conf), GFP_KERNEL);
> +	if (!conf)
> +		return -ENOMEM;
> +
> +	ret = -EINVAL;
> +	for (mode = fls(modes) - 1; mode >= 0; mode--) {
> +		conf->type = NAND_SDR_IFACE,
> +		conf->timings.sdr = *onfi_async_timing_mode_to_sdr_timings(mode);
> +
> +		ret = chip->setup_data_interface(mtd, conf, true);
> +		if (!ret) {
> +			chip->onfi_timing_mode_default = mode;
> +			break;
> +		}
> +	}
> +
> +	if (ret)
> +		goto err;

The data interface config selection only has to be done once: when you
discover/init the chip...

> +
> +	/*
> +	 * Ensure the timing mode has been changed on the chip side
> +	 * before changing timings on the controller side.
> +	 */
> +	if (chip->onfi_version) {
> +		uint8_t tmode_param[ONFI_SUBFEATURE_PARAM_LEN] = {
> +			chip->onfi_timing_mode_default,
> +		};
> +
> +		ret = chip->onfi_set_features(mtd, chip,
> +				ONFI_FEATURE_ADDR_TIMING_MODE,
> +				tmode_param);
> +		if (ret)
> +			goto err;
> +	}
> +
> +	ret = chip->setup_data_interface(mtd, conf, false);

... but the setup will be done each time you reset the chip.

Maybe that's what you were trying to explain me yesterday.

Anyway, I really think we should keep the default/best data interface
config in nand_chip so that we can later re-use it without have to go
through the supported timing detection logic.


> +
> +err:
> +	kfree(conf);
> +
> +	return ret;
> +}
> +
> +/**
>   * nand_reset - Reset and initialize a NAND device
>   * @chip: The NAND chip
>   *
> @@ -955,8 +1079,18 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
>   */
>  int nand_reset(struct nand_chip *chip)
>  {
> +	int ret;
> +
> +	ret = nand_reset_data_interface(chip);
> +	if (ret)
> +		return ret;
> +
>  	chip->cmdfunc(&chip->mtd, NAND_CMD_RESET, -1, -1);
>  
> +	ret = nand_setup_data_interface(chip);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>  
> diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
> index f305bed..9f3d7be 100644
> --- a/include/linux/mtd/nand.h
> +++ b/include/linux/mtd/nand.h
> @@ -743,10 +743,9 @@ nand_get_sdr_timings(const struct nand_data_interface *conf)
>   *                      also from the datasheet. It is the recommended ECC step
>   *			size, if known; if unknown, set to zero.
>   * @onfi_timing_mode_default: [INTERN] default ONFI timing mode. This field is
> - *			      either deduced from the datasheet if the NAND
> - *			      chip is not ONFI compliant or set to 0 if it is
> - *			      (an ONFI chip is always configured in mode 0
> - *			      after a NAND reset)
> + * 			      set to the actually used ONFI mode if the chip is
> + * 			      ONFI compliant or deduced from the datasheet if
> + * 			      the NAND chip is not ONFI compliant.
>   * @numchips:		[INTERN] number of physical chips
>   * @chipsize:		[INTERN] the size of one chip for multichip arrays
>   * @pagemask:		[INTERN] page number mask = number of (pages / chip) - 1
> @@ -766,6 +765,7 @@ nand_get_sdr_timings(const struct nand_data_interface *conf)
>   * @read_retries:	[INTERN] the number of read retry modes supported
>   * @onfi_set_features:	[REPLACEABLE] set the features for ONFI nand
>   * @onfi_get_features:	[REPLACEABLE] get the features for ONFI nand
> + * @setup_data_interface: [OPTIONAL] setup the data interface and timing
>   * @bbt:		[INTERN] bad block table pointer
>   * @bbt_td:		[REPLACEABLE] bad block table descriptor for flash
>   *			lookup.
> @@ -812,6 +812,10 @@ struct nand_chip {
>  	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
>  			int feature_addr, uint8_t *subfeature_para);
>  	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
> +	int (*setup_data_interface)(struct mtd_info *mtd,
> +				    const struct nand_data_interface *conf,
> +				    bool check_only);
> +

I'd like to keep the current data_iface config in nand_chip. Just in
case we need to expose this information through debugfs.

>  
>  	int chip_delay;
>  	unsigned int options;
