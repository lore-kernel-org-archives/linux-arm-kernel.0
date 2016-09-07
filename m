From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 7 Sep 2016 16:36:15 +0200
Subject: [PATCH 3/7] mtd: nand: automate NAND timings selection
In-Reply-To: <20160907154114.1aae0462@bbrezillon>
References: <1473250902-31139-1-git-send-email-s.hauer@pengutronix.de>
 <1473250902-31139-4-git-send-email-s.hauer@pengutronix.de>
 <20160907154114.1aae0462@bbrezillon>
Message-ID: <20160907143615.cholyvh6zyk7rnfj@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 03:41:14PM +0200, Boris Brezillon wrote:
> On Wed,  7 Sep 2016 14:21:38 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > 
> > The NAND framework provides several helpers to query timing modes supported
> > by a NAND chip, but this implies that all NAND controller drivers have
> > to implement the same timings selection dance. Also currently NAND
> > devices can be resetted at arbitrary places which also resets the timing
> > for ONFI chips to timing mode 0.
> > 
> > Provide a common logic to select the best timings based on ONFI or
> > ->onfi_timing_mode_default information. Hook this into nand_reset()  
> > to make sure the new timing is applied each time during a reset.
> > 
> > NAND controller willing to support timings adjustment should just
> > implement the ->setup_data_interface() method.
> > 
> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  drivers/mtd/nand/nand_base.c | 134 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/mtd/nand.h     |  12 ++--
> >  2 files changed, 142 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> > index 1f704cc..c9bc988 100644
> > --- a/drivers/mtd/nand/nand_base.c
> > +++ b/drivers/mtd/nand/nand_base.c
> > @@ -948,6 +948,130 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
> >  }
> >  
> >  /**
> > + * nand_reset_data_interface - Reset data interface and timings
> > + * @chip: The NAND chip
> > + *
> > + * Reset the Data interface and timings to ONFI mode 0.
> > + *
> > + * Returns 0 for success or negative error code otherwise.
> > + */
> > +static int nand_reset_data_interface(struct nand_chip *chip)
> > +{
> > +	struct mtd_info *mtd = &chip->mtd;
> > +	struct nand_data_interface *conf;
> > +	int ret;
> > +
> > +	if (!chip->setup_data_interface)
> > +		return 0;
> > +
> > +	conf = kzalloc(sizeof(*conf), GFP_KERNEL);
> > +	if (!conf)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * The ONFI specification says:
> > +	 * "
> > +	 * To transition from NV-DDR or NV-DDR2 to the SDR data
> > +	 * interface, the host shall use the Reset (FFh) command
> > +	 * using SDR timing mode 0. A device in any timing mode is
> > +	 * required to recognize Reset (FFh) command issued in SDR
> > +	 * timing mode 0.
> > +	 * "
> > +	 *
> > +	 * Configure the data interface in SDR mode and set the
> > +	 * timings to timing mode 0.
> > +	 */
> > +
> > +	conf->type = NAND_SDR_IFACE,
> > +	conf->timings.sdr = *onfi_async_timing_mode_to_sdr_timings(0);
> > +
> > +	ret = chip->setup_data_interface(mtd, conf, false);
> > +	if (ret)
> > +		pr_err("Failed to configure data interface to SDR timing mode 0\n");
> 
> I just realized that going back to timing mode 0 is not needed if your
> chip is not ONFI or JEDEC compliant. But that's not really an issue.
> 
> > +
> > +	kfree(conf);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * nand_setup_data_interface - Setup the best data interface and timings
> > + * @chip: The NAND chip
> > + *
> > + * Find and configure the best data interface and NAND timings supported by
> > + * the chip and the driver.
> > + * First tries to retrieve supported timing modes from ONFI information,
> > + * and if the NAND chip does not support ONFI, relies on the
> > + * ->onfi_timing_mode_default specified in the nand_ids table.
> > + *
> > + * Returns 0 for success or negative error code otherwise.
> > + */
> > +static int nand_setup_data_interface(struct nand_chip *chip)
> > +{
> > +	struct mtd_info *mtd = &chip->mtd;
> > +	struct nand_data_interface *conf;
> > +	int modes, mode, ret;
> > +
> > +	if (!chip->setup_data_interface)
> > +		return 0;
> > +
> > +	/*
> > +	 * First try to identify the best timings from ONFI parameters and
> > +	 * if the NAND does not support ONFI, fallback to the default ONFI
> > +	 * timing mode.
> > +	 */
> > +	modes = onfi_get_async_timing_mode(chip);
> > +	if (modes == ONFI_TIMING_MODE_UNKNOWN) {
> > +		if (!chip->onfi_timing_mode_default)
> > +			return 0;
> > +
> > +		modes = GENMASK(chip->onfi_timing_mode_default, 0);
> > +	}
> 
> This implementation is assuming the chip is either ONFI compliant or
> not compliant with JEDEC and ONFI, but JEDEC chips also provides
> 'timing modes', except it's called 'speed grades'. Not sure how they
> match to the ONFI timing modes, and I'm definitely not asking you to
> support that right now, but that would be good to split the different
> cases (ONFI compliant, JEDEC compliant and not compliant with JEDEC or
> ONFI) in different functions.
> 
> Those functions would just fill in the nand_data_interface object, and 
> nand_setup_data_interface() (or nand_select_data_interface(), if we
> decide to split the logic in 2 different functions as suggested below)
> would call one of them depending on the ->{jedec,onfo}_version values.
> 
> > +
> > +	conf = kzalloc(sizeof(*conf), GFP_KERNEL);
> > +	if (!conf)
> > +		return -ENOMEM;
> > +
> > +	ret = -EINVAL;
> > +	for (mode = fls(modes) - 1; mode >= 0; mode--) {
> > +		conf->type = NAND_SDR_IFACE,
> > +		conf->timings.sdr = *onfi_async_timing_mode_to_sdr_timings(mode);
> > +
> > +		ret = chip->setup_data_interface(mtd, conf, true);
> > +		if (!ret) {
> > +			chip->onfi_timing_mode_default = mode;
> > +			break;
> > +		}
> > +	}
> > +
> > +	if (ret)
> > +		goto err;
> 
> The data interface config selection only has to be done once: when you
> discover/init the chip...
> 
> > +
> > +	/*
> > +	 * Ensure the timing mode has been changed on the chip side
> > +	 * before changing timings on the controller side.
> > +	 */
> > +	if (chip->onfi_version) {
> > +		uint8_t tmode_param[ONFI_SUBFEATURE_PARAM_LEN] = {
> > +			chip->onfi_timing_mode_default,
> > +		};
> > +
> > +		ret = chip->onfi_set_features(mtd, chip,
> > +				ONFI_FEATURE_ADDR_TIMING_MODE,
> > +				tmode_param);
> > +		if (ret)
> > +			goto err;
> > +	}
> > +
> > +	ret = chip->setup_data_interface(mtd, conf, false);
> 
> ... but the setup will be done each time you reset the chip.
> 
> Maybe that's what you were trying to explain me yesterday.

Indeed.

> 
> Anyway, I really think we should keep the default/best data interface
> config in nand_chip so that we can later re-use it without have to go
> through the supported timing detection logic.

Ok, I think now we are understanding each other. So I keep two timing
instances in struct nand_chip, one for initialization and one optimized
timing. They both get initialized once during chip detection and can be
reused when needed.

Note that the default timing is the same for all chips, so I decided to
turn the onfi_sdr_timings table into struct nand_data_interface so that
I can access this default timing without having to allocate an instance
for each chip.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
