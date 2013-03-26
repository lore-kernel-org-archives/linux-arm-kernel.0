From: durgadoss.r@intel.com (R, Durgadoss)
Date: Tue, 26 Mar 2013 09:10:55 +0000
Subject: [PATCH 1/4] thermal: Add driver for Armada 370/XP SoC thermal
 management
In-Reply-To: <20130326085924.GA2454@localhost>
References: <1364225229-2857-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1364225229-2857-2-git-send-email-ezequiel.garcia@free-electrons.com>
 <4D68720C2E767A4AA6A8796D42C8EB59C587D8@BGSMSX101.gar.corp.intel.com>
 <20130326085924.GA2454@localhost>
Message-ID: <4D68720C2E767A4AA6A8796D42C8EB59C591A5@BGSMSX101.gar.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Ezequiel Garcia [mailto:ezequiel.garcia at free-electrons.com]
> Sent: Tuesday, March 26, 2013 2:29 PM
> To: R, Durgadoss
> Cc: linux-arm-kernel at lists.infradead.org; linux-pm at vger.kernel.org; Lior
> Amsalem; Nobuhiro Iwamatsu; Zhang, Rui; Sebastian Hesselbarth; Andrew
> Lunn; Thomas Petazzoni; Gregory Clement; Jason Cooper
> Subject: Re: [PATCH 1/4] thermal: Add driver for Armada 370/XP SoC thermal
> management
> 
> Hi Durgadoss,
> 
> On Mon, Mar 25, 2013 at 05:27:24PM +0000, R, Durgadoss wrote:
> [...]
> > > +static void armadaxp_init_sensor(struct armada_thermal_priv *priv)
> > > +{
> > > +	unsigned long reg;
> > > +
> > > +	/* ??? */
> > > +	reg = readl_relaxed(priv->control);
> > > +	reg |= PMU_TDC0_OTF_CAL_MASK;
> > > +	writel(reg, priv->control);
> > > +
> > > +	/* Reference calibration value */
> > > +	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
> > > +	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> > > +	writel(reg, priv->control);
> >
> > I see these two blocks of code being the same for the below
> > function as well. Any specific reason for not making this block
> > as a common function and calling it from both the
> > _init_sensor functions ?
> >
> 
> I think it's more clear if we define one init_sensor function per SoC.
> The common code is really little and factor that out seems to me like
> too much modularization.

I would leave it up to you, then.

> 
> > > +
> > > +	/* Reset the sensor */
> > > +	reg = readl_relaxed(priv->control);
> > > +	writel((reg | PMU_TDC0_SW_RST_MASK), priv->control);
> > > +
> > > +	writel(reg, priv->control);
> > > +
> > > +	/* Enable the sensor */
> > > +	reg = readl_relaxed(priv->sensor);
> > > +	reg &= ~PMU_TM_DISABLE_MASK;
> > > +	writel(reg, priv->sensor);
> > > +}
> > > +
> > > +static void armada370_init_sensor(struct armada_thermal_priv *priv)
> > > +{
> > > +	unsigned long reg;
> > > +
> > > +	/* ??? */
> > > +	reg = readl_relaxed(priv->control);
> > > +	reg |= PMU_TDC0_OTF_CAL_MASK;
> > > +	writel(reg, priv->control);
> > > +
> > > +	/* Reference calibration value */
> > > +	reg &= ~PMU_TDC0_REF_CAL_CNT_MASK;
> > > +	reg |= (0xf1 << PMU_TDC0_REF_CAL_CNT_OFFS);
> > > +	writel(reg, priv->control);
> > > +
> > > +	/* ??? */
> > > +	reg &= ~PMU_TDC0_START_CAL_MASK;
> > > +	writel(reg, priv->control);
> > > +
> > > +	/* FIXME: Why do we need this delay? */
> > > +	mdelay(10);
> > > +}
> > > +
> > > +static bool armada_is_valid(struct armada_thermal_priv *priv)
> > > +{
> > > +	unsigned long reg = readl_relaxed(priv->sensor);
> > > +
> > > +	return (reg >> THERMAL_VALID_OFFSET) & THERMAL_VALID_MASK;
> > > +}
> > > +
> > > +static int armada_get_temp(struct thermal_zone_device *thermal,
> > > +			  unsigned long *temp)
> > > +{
> > > +	struct armada_thermal_priv *priv = thermal->devdata;
> > > +	unsigned long reg;
> > > +
> > > +	/* Valid check */
> > > +	if (priv->ops->is_valid && !priv->ops->is_valid(priv)) {
> > > +		dev_err(&thermal->device,
> > > +			"Temperature sensor reading not valid\n");
> > > +		return -EIO;
> > > +	}
> > > +
> > > +	reg = (readl_relaxed(priv->sensor) >> THERMAL_TEMP_OFFSET) &
> >
> > Can we have the readl_relaxed call as a separate statement ?
> >
> 
> Why would we want that? Do you think it'll be more readable?

Yes,

> 
> > > +		THERMAL_TEMP_MASK;
> > > +	*temp = (3153000000UL - (10000000UL*reg)) / 13825;
> >
> > If I substitute 1 for 'reg' I get  227341.7721...
> > Does this mean the temperature is 227 C ??
> >
> 
> Yes, I guess so.
> 
> > If you have the info, can you add a comment on what is the
> > valid range that 'reg' can take ?
> >
> 
> No, I don't have the info. I guess that the valid range 'reg'
> can take are the values that span a temperature between 25 ?C (or
> lower if it's winter) and when your CPU is on fire :-)
> 
> > Also, Is the resulting temperature
> > in MillidegreeCelsius ? If so, please add a comment saying so.
> >
> 
> Yes, the resulting temperature is in millidegree celsius,
> as required by the thermal framework:

ok.

Thanks,
Durga
