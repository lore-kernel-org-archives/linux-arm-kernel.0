From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Wed, 13 Jun 2018 13:51:44 -0700
Subject: [PATCH 04/10] Input: ams_delta_serio: Replace power GPIO with
 regulator
In-Reply-To: <2655614.ErW8VuCT6r@z50>
References: <20180609140224.32606-1-jmkrzyszt@gmail.com>
 <20180609140224.32606-4-jmkrzyszt@gmail.com>
 <20180612221724.GB38773@dtor-ws> <2655614.ErW8VuCT6r@z50>
Message-ID: <20180613205144.GB62746@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 03:01:05AM +0200, Janusz Krzysztofik wrote:
> On Wednesday, June 13, 2018 12:17:24 AM CEST Dmitry Torokhov wrote:
> > On Sat, Jun 09, 2018 at 04:02:18PM +0200, Janusz Krzysztofik wrote:
> > > ...
> > > +	priv->vcc = devm_regulator_get(&pdev->dev, "vcc");
> > > +	if (IS_ERR(priv->vcc)) {
> > > +		err = PTR_ERR(priv->vcc);
> > > +		dev_err(&pdev->dev, "regulator request failed (%d)\n", err);
> > > +		/* Fail softly if the regulator is not available yet */
> > > +		if (err == -ENODEV)
> > > +			err = -EPROBE_DEFER;
> > 
> > Hmm, if regulator is not ready yet, devm_regulator_get() should be
> > returning -EPROBE_DEFER already, we should not have to convert -ENODEV
> > to -EPROBE_DEFER...
> 
> Regulator is not ready because its initialization at subsys_initcall is 
> deferred by not ready GPIO pin, that in turn is caused by gpio-mmio driver, 
> unlike many other GPIO drivers, registered as late as at device_initcall.
> 
> I agree devm_regulator_get() could return -EPROBE_DEFER in this case, but I 
> can see it does that only when of_get_regulator() indicates the regulator 
> should exist. In non-dt case there is apparently no way to justify if it 
> should unless its consumer supply table was already in place. For that,  
> registration of that table would have to be independent of successful 
> registration of the regulator itself while it's not. Maybe it should, but 
> that's a separate topic for a separate discussion, I think.
> 
> > Is it because we have_full_constraints() returns false? You might need
> > to add call to regulator_has_full_constraints() to your board file.
> 
> If have_full_constraints() returned true before the regulator or its consumer 
> supply table is ready, devm_regulator_get() would happily return a dummy 
> regulator and our keyboard would never get its power.
> 
> I'm afraid we have to live with that return code conversion as long as the 
> only user of this driver is not migrated to dt.

OK, fair enough. Can you please add a comment to that effect?

Thanks.

-- 
Dmitry
