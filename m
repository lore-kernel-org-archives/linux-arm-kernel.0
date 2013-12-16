From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Mon, 16 Dec 2013 03:31:29 +0000
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <20131213125129.GV18380@S2101-09.ap.freescale.net>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
Message-ID: <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > -	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
> > > -				sgtl5000->supplies);
> > > -	if (!ret)
> > > -		external_vddd = 1;
> > > -	else {
> > > +	/* External VDDD only works before revision 0x11 */
> > > +	if (sgtl5000->revision < 0x11) {
> > > +		vddd = regulator_get_optional(codec->dev, "VDDD");
> > > +		if (IS_ERR(vddd)) {
> > > +			/* See if it's just not registered yet */
> > > +			if (PTR_ERR(vddd) == -EPROBE_DEFER)
> > > +				return -EPROBE_DEFER;
> > > +		} else {
> > > +			external_vddd = 1;
> > > +			regulator_put(vddd);
> > > +		}
> >
> > Shouldn't we handle other errors ?
> 
> We do not really care other errors.  In case that an external VDDD is present
> on hardware design but regulator_get_optional("VDDD") still fails for some
> other reason, we should turn to use the internal LDO anyway rather than simply
> failing out.
> 
> > We can see that from the regulator_get_optional()-->_regulator_get(),
> > there are many other errors maybe returned. Not considering other
> > error cases, If the dt is used here, only ERR_PTR(-ENODEV) will be
> > returned if the external VDDD is absent, and only this case the
> > ERR_PTR(_ENODEV) error will be returned, Or if dt is not used and
> > there has no external VDDD was found, the
> > ERR_PTR(-EPROBE_DEFER) will be returned.
> >
> > So, if the external VDDD is not used, only ERR_PTR(-ENODEV) and
> > ERR_PTR(-EPROBE_DEFER) maybe returned ignoring other errors.
> >
> > How about the following ?
> > -----------------
> > +	if (IS_ERR(vddd)) {
> > +		/* See if it's just not registered yet */
> > +		if (PTR_ERR(vddd) != -ENODEV)
> > +			return PTR_ERR(vddd);
> 
> Just for example, if PTR_ERR(vddd) is -EBUSY here, instead of failing out, why
> do not we switch to internal LDO for continuing the probe?
> 

Yes, sounds perfect.

Well, the regulator_get_optional() is still needed to improve.
For instance, if dts is not used for one platform and the external VDDD supply is
absent. The regulator_get_optional() will return -EPROBE_DEFER, so the SGTL5000's
probe, and then the SGTL5000 will do the deferral probe, and this time the same
-EPROBE_DEFER error will return again. 
Where should this special handling be dealt with ? Is here or regulator_get_optional()
will be better ?


Thanks,

--
Xiubo
