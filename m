From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 18 Jan 2010 16:32:12 +0000
Subject: [PATCH] regulator: mc13783: consider Power Gates as digital
	regulators.
In-Reply-To: <1263830523.3632.22.camel@realization>
References: <1263830523.3632.22.camel@realization>
Message-ID: <20100118163212.GA32045@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 05:02:03PM +0100, Alberto Panizzo wrote:

> +int mc13783_state_powermisc_pwgt;
> +int mc13783_reg_rmw_powermisc(struct mc13783 *mc13783, u32 mask, u32 val)

You're missing some statics here and some whitespace to separate the
function from the variable.

> +	/* Update the stored state for Power Gates.
> +	 * As from specs the meaning is inverted (0: en, 1: dis) */
> +	if (mask & MC13783_REG_POWERMISC_PWGTSPI_M)
> +		mc13783_state_powermisc_pwgt =
> +			(mc13783_state_powermisc_pwgt & ~mask) |
> +			((val ^ mask) & MC13783_REG_POWERMISC_PWGTSPI_M);

Could this code be written in a clearer fashion?  The bit manipluation
isn't entirely obvious, especially given the multiple masks in use...

> +	ret = mc13783_reg_read(mc13783, MC13783_REG_POWERMISC, &valread);
> +	if (ret)
> +		return ret;
> +
> +	valread = (valread & ~mask) | val;
> +
> +	/* Re propose the stored state for Power Gates */
> +	valread = (valread & ~MC13783_REG_POWERMISC_PWGTSPI_M) |
> +						mc13783_state_powermisc_pwgt;

...and this further mainpulation.
