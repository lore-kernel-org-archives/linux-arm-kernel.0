From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 16 Jun 2014 16:32:24 +0200
Subject: [PATCH v3 10/19] clocksource: sh_tmu: Add DT support
In-Reply-To: <20140616083423.GE11582@verge.net.au>
References: <1402763021-4067-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1402763021-4067-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140616083423.GE11582@verge.net.au>
Message-ID: <3012797.FyNqyP1CPJ@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Monday 16 June 2014 17:34:23 Simon Horman wrote:
> On Sat, Jun 14, 2014 at 06:23:32PM +0200, Laurent Pinchart wrote:
> > Document DT bindings and parse them in the TMU driver.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> [snip]
> 
> > diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> > index ef8fb0b..2ece4ab 100644
> > --- a/drivers/clocksource/sh_tmu.c
> > +++ b/drivers/clocksource/sh_tmu.c

[snip]

> > @@ -509,23 +510,46 @@ static int sh_tmu_map_memory(struct sh_tmu_device
> > *tmu)
> >  	return 0;
> >  }
> > 
> > +static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
> > +{
> > +	struct device_node *np = tmu->pdev->dev.of_node;
> > +
> > +	tmu->num_channels = 3;
> > +	of_property_read_u32(np, "#renesas,channels", &tmu->num_channels);
> > +
> > +	if (tmu->num_channels != 2 && tmu->num_channels != 3) {
> > +		dev_err(&tmu->pdev->dev, "invalid number of channels %u\n",
> > +			tmu->num_channels);
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static int sh_tmu_setup(struct sh_tmu_device *tmu, struct platform_device
> >  *pdev) {
> > -	struct sh_timer_config *cfg = pdev->dev.platform_data;
> >  	const struct platform_device_id *id = pdev->id_entry;
> >  	unsigned int i;
> >  	int ret;
> > 
> > -	if (!cfg) {
> > -		dev_err(&tmu->pdev->dev, "missing platform data\n");
> > -		return -ENXIO;
> > -	}
> > -
> >  	tmu->pdev = pdev;
> >  	tmu->model = id->driver_data;
> >  	
> >  	raw_spin_lock_init(&tmu->lock);
> > 
> > +	if (IS_ENABLED(CONFIG_OF) && pdev->dev.of_node) {
> > +		ret = sh_tmu_parse_dt(tmu);
> > +		if (ret < 0)
> > +			return ret;
> > +	} else if (pdev->dev.platform_data) {
> > +		struct sh_timer_config *cfg = pdev->dev.platform_data;
> > +
> > +		tmu->num_channels = hweight8(cfg->channels_mask);
> > +	} else {
> > +		dev_err(&tmu->pdev->dev, "missing platform data\n");
> > +		return -ENXIO;
> > +	}
> > +
> > 
> >  	/* Get hold of clock. */
> >  	tmu->clk = clk_get(&tmu->pdev->dev, "fck");
> >  	if (IS_ERR(tmu->clk)) {
> 
> [snip]
> 
> I had a bit of trouble running this code and after some investigation
> it seems to me that in the case of using DT id will be NULL and
> thus things do not go well when id->driver_data is accessed.

Indeed. I wonder how I've missed that :-/ Anyway, I'll fix it and resubmit.

> The following incremental patch resolved the problem for me.
> 
> diff --git a/drivers/clocksource/sh_tmu.c b/drivers/clocksource/sh_tmu.c
> index 2ece4ab..3f90927 100644
> --- a/drivers/clocksource/sh_tmu.c
> +++ b/drivers/clocksource/sh_tmu.c
> @@ -523,6 +523,8 @@ static int sh_tmu_parse_dt(struct sh_tmu_device *tmu)
>  		return -EINVAL;
>  	}
> 
> +	tmu->model = SH_TMU;
> +
>  	return 0;
>  }
> 
> @@ -533,7 +535,6 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu,
> struct platform_device *pdev) int ret;
> 
>  	tmu->pdev = pdev;
> -	tmu->model = id->driver_data;
> 
>  	raw_spin_lock_init(&tmu->lock);
> 
> @@ -545,6 +546,7 @@ static int sh_tmu_setup(struct sh_tmu_device *tmu,
> struct platform_device *pdev) struct sh_timer_config *cfg =
> pdev->dev.platform_data;
> 
>  		tmu->num_channels = hweight8(cfg->channels_mask);
> +		tmu->model = id->driver_data;
>  	} else {
>  		dev_err(&tmu->pdev->dev, "missing platform data\n");
>  		return -ENXIO;

-- 
Regards,

Laurent Pinchart
