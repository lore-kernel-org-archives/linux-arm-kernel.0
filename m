From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 6 Sep 2016 17:04:58 +0200
Subject: [PATCH 4/7] mtd: nand: automate NAND timings selection
In-Reply-To: <20160906165004.5566fb29@bbrezillon>
References: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
 <1473158355-22451-5-git-send-email-s.hauer@pengutronix.de>
 <20160906135807.29257d00@bbrezillon>
 <20160906140817.dil5noauumhfbtd3@pengutronix.de>
 <20160906165004.5566fb29@bbrezillon>
Message-ID: <20160906150458.hg32bkozupz3mvhu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 04:50:04PM +0200, Boris Brezillon wrote:
> On Tue, 6 Sep 2016 16:08:17 +0200
> Sascha Hauer <s.hauer@pengutronix.de> wrote:
> 
> > On Tue, Sep 06, 2016 at 01:58:07PM +0200, Boris Brezillon wrote:
> > > On Tue,  6 Sep 2016 12:39:12 +0200
> > > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > >   
> > > > From: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > 
> > > > The NAND framework provides several helpers to query timing modes supported
> > > > by a NAND chip, but this implies that all NAND controller drivers have
> > > > to implement the same timings selection dance. Also currently NAND
> > > > devices can be resetted at arbitrary places which also resets the timing
> > > > for ONFI chips to timing mode 0.
> > > > 
> > > > Provide a common logic to select the best timings based on ONFI or  
> > > > ->onfi_timing_mode_default information. Hook this into nand_reset()    
> > > > to make sure the new timing is applied each time during a reset.
> > > > 
> > > > NAND controller willing to support timings adjustment should just
> > > > implement the ->setup_data_interface() method.
> > > > 
> > > > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > ---
> > > >  drivers/mtd/nand/nand_base.c | 112 +++++++++++++++++++++++++++++++++++++++++++
> > > >  include/linux/mtd/nand.h     |  14 ++++--
> > > >  2 files changed, 122 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> > > > index 20151fc..37852e9 100644
> > > > --- a/drivers/mtd/nand/nand_base.c
> > > > +++ b/drivers/mtd/nand/nand_base.c
> > > > @@ -955,8 +955,63 @@ static int nand_wait(struct mtd_info *mtd, struct nand_chip *chip)
> > > >   */
> > > >  int nand_reset(struct mtd_info *mtd)
> > > >  {
> > > > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > > > +	int ret;
> > > > +
> > > > +	if (chip->setup_data_interface) {
> > > > +		struct nand_data_interface conf = {
> > > > +			.type = NAND_SDR_IFACE,
> > > > +			.timings.sdr = *onfi_async_timing_mode_to_sdr_timings(0),
> > > > +		};
> > > > +  
> > > 
> > > Let's try to avoid putting such a huge structure on the stack.  
> > 
> > I could do that by doing
> > 
> > 	const struct nand_data_interface *conf = onfi_async_timing_mode_to_data_interface(0);
> > 
> > But you just discussed this function away ;)
> > 
> > I need two different timings, first the ONFI timing mode 0 and then the
> > real timing. I wanted to avoid re-initializing the same timing struct
> > instance multiple times (twice in nand_reset() and two times again for
> > each additional chip in an array).
> > 
> > >   
> > > > +		/*
> > > > +		 * The ONFI specification says:
> > > > +		 * "
> > > > +		 * To transition from NV-DDR or NV-DDR2 to the SDR data
> > > > +		 * interface, the host shall use the Reset (FFh) command
> > > > +		 * using SDR timing mode 0. A device in any timing mode is
> > > > +		 * required to recognize Reset (FFh) command issued in SDR
> > > > +		 * timing mode 0.
> > > > +		 * "
> > > > +		 *
> > > > +		 * Configure the data interface in SDR mode and set the
> > > > +		 * timings to timing mode 0.
> > > > +		 */
> > > > +
> > > > +		ret = chip->setup_data_interface(mtd, &conf, false);
> > > > +		if (ret) {
> > > > +			pr_err("Failed to configure data interface to SDR timing mode 0\n");
> > > > +			return ret;
> > > > +		}
> > > > +	}  
> > > 
> > > Can you put this code in a separate function? I'd like to keep the
> > > nand_reset() function as small as possible.
> > > 
> > > How about nand_reset_data_interface()?  
> > 
> > Yes, can do. In that case I would move the test if setting the data
> > interface is supported to that function aswell. Are you okay with that?
> 
> Sure.
> 
> > 
> > 
> > >   
> > > > +
> > > >  	chip->cmdfunc(mtd, NAND_CMD_RESET, -1, -1);
> > > >  
> > > > +	/*
> > > > +	 * Setup the NAND interface (interface type + timings).
> > > > +	 */
> > > > +	if (chip->data_iface) {
> > > > +		uint8_t tmode_param[ONFI_SUBFEATURE_PARAM_LEN] = {
> > > > +			chip->onfi_timing_mode_default,
> > > > +		};
> > > > +
> > > > +		/*
> > > > +		 * Ensure the timing mode has be changed on the chip side  
> > > 					      ^ been  
> > > > +		 * before changing timings on the controller side.
> > > > +		 */
> > > > +		if (chip->onfi_version) {
> > > > +			ret = chip->onfi_set_features(mtd, chip,
> > > > +					ONFI_FEATURE_ADDR_TIMING_MODE,
> > > > +					tmode_param);
> > > > +			if (ret)
> > > > +				return ret;
> > > > +		}
> > > > +
> > > > +		ret = chip->setup_data_interface(mtd, chip->data_iface, false);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +	}
> > > > +  
> > > 
> > > Ditto: nand_setup_data_interface()?
> > >   
> > > >  	return 0;
> > > >  }
> > > >  
> > > > @@ -3335,6 +3390,54 @@ static void nand_onfi_detect_micron(struct nand_chip *chip,
> > > >  	chip->setup_read_retry = nand_setup_read_retry_micron;
> > > >  }
> > > >  
> > > > +/**
> > > > + * nand_find_data_interface - Find the best data interface and timings
> > > > + * @mtd: MTD device structure
> > > > + *
> > > > + * Try to find the best data interface and NAND timings supported by the
> > > > + * chip and the driver.
> > > > + * First tries to retrieve supported timing modes from ONFI information,
> > > > + * and if the NAND chip does not support ONFI, relies on the
> > > > + * ->onfi_timing_mode_default specified in the nand_ids table.
> > > > + *
> > > > + * Returns 0 for success or negative error code otherwise.
> > > > + */
> > > > +static int nand_find_data_interface(struct mtd_info *mtd)  
> > > 
> > > How about nand_init_data_interface() or nand_init_data_iface_config()?
> > >   
> > > > +{
> > > > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > > > +	int modes, mode, ret;
> > > > +	const struct nand_data_interface *conf;
> > > > +
> > > > +	/*
> > > > +	 * First try to identify the best timings from ONFI parameters and
> > > > +	 * if the NAND does not support ONFI, fallback to the default ONFI
> > > > +	 * timing mode.
> > > > +	 */
> > > > +	modes = onfi_get_async_timing_mode(chip);
> > > > +	if (modes == ONFI_TIMING_MODE_UNKNOWN)
> > > > +		modes = GENMASK(chip->onfi_timing_mode_default, 0);
> > > > +
> > > > +	ret = -EINVAL;
> > > > +	for (mode = fls(modes) - 1; mode >= 0; mode--) {
> > > > +		conf = onfi_async_timing_mode_to_data_interface(mode);  
> > > 
> > > I'd still prefer to have conf allocated at the beginning of the
> > > function and timings copied from
> > > onfi_async_timing_mode_to_sdr_timings(mode), but maybe you can convince
> > > me otherwise.  
> > 
> > Let me ask the other way round: If we need struct nand_data_interface to
> > fully describe a timing, why don't we keep an array of these in the
> > kernel? Having an array of struct nand_sdr_timings() means we always
> > have to copy it to a bigger struct to make it usable.
> 
> Actually, the plan is to let vendor specific code tweak the timings if
> needed.
> Some NANDs that do not support ONFI have to pick timing mode 0 because
> one of their timing is not matching the ONFI spec. I'd like to let
> the door to fined-grained timing tweaking open, and this is only
> possible if the chip has its own nand_data_interface object (not the
> const one defined in nand_timings.c).
> 
> Also note that some timings are not statically defined (like tPROG),
> and are extracted from another ONFI field, and I'd like to add them to
> the nand_sdr_timings struct, which again, is only possible if the
> nand_chip has its own nand_data_interface instance.

Hm, in the current series the nand_chip has it's own nand_data_interface
instance, it's allocated in nand_find_data_interface().

> 
> > 
> > > > @@ -759,6 +759,10 @@ struct nand_chip {
> > > >  	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
> > > >  			int feature_addr, uint8_t *subfeature_para);
> > > >  	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
> > > > +	int (*setup_data_interface)(struct mtd_info *mtd,
> > > > +				    const struct nand_data_interface *conf,
> > > > +				    bool check_only);
> > > > +
> > > >  
> > > >  	int chip_delay;
> > > >  	unsigned int options;
> > > > @@ -788,6 +792,8 @@ struct nand_chip {
> > > >  		struct nand_jedec_params jedec_params;
> > > >  	};
> > > >  
> > > > +	const struct nand_data_interface *data_iface;
> > > > +  
> > > 
> > > How about making this field non-const so that you only allocate it once
> > > and modify it when you switch from one mode to another.  
> > 
> > As said above, I need two different timings. If we modify this
> > nand_data_interface instance twice during reset there's not much point
> > in storing it in struct nand_chip at all. That was one variant I tried:
> > Always calculcate the timing from the supported ONFI modes when we need
> > it in nand_reset(). I stepped away from this variant because of the
> > overhead.
> 
> Yes, your device will be configured twice (first mode 0, then the
> highest supported timing mode), but that does not mean you need to have
> 2 instances of nand_data_interface.
> 
> ->data_iface should always be assigned to the current data interface
> config. If you reset the chip and go back to timing 0, then
> chip->data_iface should be set to sdr mode timing zero, and once a
> new timing mode is applied, it should be updated.
> 
> And yes, there's a small overhead (copying the nand_sdr_timings data
> twice), but I'm pretty sure it's negligible compared to the whole NAND
> chip init overhead.
> And it's not like nand_reset() is called so regularly that it's useful
> to optimize this kind of things.

I haven't really thought about overhead in terms of burnt CPU cycles but
more about how easy it is to follow the code.
Anyway, I do as you wish, expect a new series tomorrow ;)

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
