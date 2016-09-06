From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 6 Sep 2016 17:15:46 +0200
Subject: [PATCH 4/7] mtd: nand: automate NAND timings selection
In-Reply-To: <20160906150458.hg32bkozupz3mvhu@pengutronix.de>
References: <1473158355-22451-1-git-send-email-s.hauer@pengutronix.de>
 <1473158355-22451-5-git-send-email-s.hauer@pengutronix.de>
 <20160906135807.29257d00@bbrezillon>
 <20160906140817.dil5noauumhfbtd3@pengutronix.de>
 <20160906165004.5566fb29@bbrezillon>
 <20160906150458.hg32bkozupz3mvhu@pengutronix.de>
Message-ID: <20160906171546.1c0e2a51@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Sep 2016 17:04:58 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:


> > > >     
> > > > > +{
> > > > > +	struct nand_chip *chip = mtd_to_nand(mtd);
> > > > > +	int modes, mode, ret;
> > > > > +	const struct nand_data_interface *conf;
> > > > > +
> > > > > +	/*
> > > > > +	 * First try to identify the best timings from ONFI parameters and
> > > > > +	 * if the NAND does not support ONFI, fallback to the default ONFI
> > > > > +	 * timing mode.
> > > > > +	 */
> > > > > +	modes = onfi_get_async_timing_mode(chip);
> > > > > +	if (modes == ONFI_TIMING_MODE_UNKNOWN)
> > > > > +		modes = GENMASK(chip->onfi_timing_mode_default, 0);
> > > > > +
> > > > > +	ret = -EINVAL;
> > > > > +	for (mode = fls(modes) - 1; mode >= 0; mode--) {
> > > > > +		conf = onfi_async_timing_mode_to_data_interface(mode);    
> > > > 
> > > > I'd still prefer to have conf allocated at the beginning of the
> > > > function and timings copied from
> > > > onfi_async_timing_mode_to_sdr_timings(mode), but maybe you can convince
> > > > me otherwise.    
> > > 
> > > Let me ask the other way round: If we need struct nand_data_interface to
> > > fully describe a timing, why don't we keep an array of these in the
> > > kernel? Having an array of struct nand_sdr_timings() means we always
> > > have to copy it to a bigger struct to make it usable.  
> > 
> > Actually, the plan is to let vendor specific code tweak the timings if
> > needed.
> > Some NANDs that do not support ONFI have to pick timing mode 0 because
> > one of their timing is not matching the ONFI spec. I'd like to let
> > the door to fined-grained timing tweaking open, and this is only
> > possible if the chip has its own nand_data_interface object (not the
> > const one defined in nand_timings.c).
> > 
> > Also note that some timings are not statically defined (like tPROG),
> > and are extracted from another ONFI field, and I'd like to add them to
> > the nand_sdr_timings struct, which again, is only possible if the
> > nand_chip has its own nand_data_interface instance.  
> 
> Hm, in the current series the nand_chip has it's own nand_data_interface
> instance, it's allocated in nand_find_data_interface().

Yes, but I thought you were suggesting to drop the allocation and
directly point to the static declaration returned by
onfi_async_timing_mode_to_data_interface().

> 
> >   
> > >   
> > > > > @@ -759,6 +759,10 @@ struct nand_chip {
> > > > >  	int (*onfi_get_features)(struct mtd_info *mtd, struct nand_chip *chip,
> > > > >  			int feature_addr, uint8_t *subfeature_para);
> > > > >  	int (*setup_read_retry)(struct mtd_info *mtd, int retry_mode);
> > > > > +	int (*setup_data_interface)(struct mtd_info *mtd,
> > > > > +				    const struct nand_data_interface *conf,
> > > > > +				    bool check_only);
> > > > > +
> > > > >  
> > > > >  	int chip_delay;
> > > > >  	unsigned int options;
> > > > > @@ -788,6 +792,8 @@ struct nand_chip {
> > > > >  		struct nand_jedec_params jedec_params;
> > > > >  	};
> > > > >  
> > > > > +	const struct nand_data_interface *data_iface;
> > > > > +    
> > > > 
> > > > How about making this field non-const so that you only allocate it once
> > > > and modify it when you switch from one mode to another.    
> > > 
> > > As said above, I need two different timings. If we modify this
> > > nand_data_interface instance twice during reset there's not much point
> > > in storing it in struct nand_chip at all. That was one variant I tried:
> > > Always calculcate the timing from the supported ONFI modes when we need
> > > it in nand_reset(). I stepped away from this variant because of the
> > > overhead.  
> > 
> > Yes, your device will be configured twice (first mode 0, then the
> > highest supported timing mode), but that does not mean you need to have
> > 2 instances of nand_data_interface.
> >   
> > ->data_iface should always be assigned to the current data interface  
> > config. If you reset the chip and go back to timing 0, then
> > chip->data_iface should be set to sdr mode timing zero, and once a
> > new timing mode is applied, it should be updated.
> > 
> > And yes, there's a small overhead (copying the nand_sdr_timings data
> > twice), but I'm pretty sure it's negligible compared to the whole NAND
> > chip init overhead.
> > And it's not like nand_reset() is called so regularly that it's useful
> > to optimize this kind of things.  
> 
> I haven't really thought about overhead in terms of burnt CPU cycles but
> more about how easy it is to follow the code.

Ok.

> Anyway, I do as you wish, expect a new series tomorrow ;)

Let's see how it looks like.

Thanks,

Boris
