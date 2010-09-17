From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Sep 2010 16:36:43 +0100
Subject: [linux-pm] [PATCH] opp: introduce library for device-specific OPPs
In-Reply-To: <1284686973-13993-1-git-send-email-nm@ti.com>
References: <1284686973-13993-1-git-send-email-nm@ti.com>
Message-ID: <20100917153643.GC29739@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 16, 2010 at 08:29:33PM -0500, Nishanth Menon wrote:

> +struct opp_def {
> +	unsigned long freq;
> +	unsigned long u_volt;
> +
> +	bool enabled;
> +};

It might be clearer to use some term other than enabled in the code -
when reading I wasn't immediately sure if enabled meant that it was
available to be selected or if it was the active operating point.  How
about 'allowed' (though I'm not 100% happy with that)?

> +static inline int opp_add(struct device *dev, const struct opp_def *opp_def)
> +{
> +	return ERR_PTR(-EINVAL);
> +}

Mismatch with the return type and value here.

> +/**
> + * opp_enable() - Enable a specific OPP
> + * @opp:	Pointer to opp
> + *
> + * Enables a provided opp. If the operation is valid, this returns 0, else the
> + * corresponding error value.
> + *
> + * OPP used here is from the the opp_is_valid/opp_has_freq or other search
> + * functions
> + */
> +int opp_enable(struct opp *opp)
> +{
> +	if (unlikely(!opp || IS_ERR(opp))) {
> +		pr_err("%s: Invalid parameters being passed\n", __func__);
> +		return -EINVAL;
> +	}
> +
> +	if (!opp->enabled && opp->dev_opp)
> +		opp->dev_opp->enabled_opp_count++;
> +
> +	opp->enabled = true;
> +
> +	return 0;
> +}

When reading the description I'd expected to see some facility to
trigger selection of an active operating point in the library (possibly
as a separate call since you might have a bunch of operating points
being updated in quick succession) but it looks like that needs to be
supplied externally at the minute?
