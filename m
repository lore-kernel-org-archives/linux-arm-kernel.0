From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Apr 2010 19:21:24 +0100
Subject: [PATCH 4/4] ASoC: enable wm8753 in aspenite
In-Reply-To: <s2g771cded01003310548udc9ff8b8u35736bd95038f92c@mail.gmail.com>
References: <s2g771cded01003310548udc9ff8b8u35736bd95038f92c@mail.gmail.com>
Message-ID: <20100401182124.GB26650@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 31, 2010 at 08:48:58AM -0400, Haojian Zhuang wrote:

> +/* Seek the index of MCLK configuration table */
> +static int pxa168_seek_mclk_conf(int rate, int format, int channel)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mclk_conf); i++) {
> +		if ((mclk_conf[i].rate == rate)
> +			&& (mclk_conf[i].format == format)
> +			&& (mclk_conf[i].channel == channel))
> +			return i;
> +	}
> +	return -EINVAL;
> +}

> +/* Get the MCLK frequency */
> +static int pxa168_get_mclk(int i)
> +{
> +	if ((i < 0) || (i >= ARRAY_SIZE(mclk_conf)))
> +		return -EINVAL;
> +	return mclk_conf[i].mclk;
> +}

This stuff probably shouldn't be in the machine driver since pretty much
all machine drivers are going to want exactly the same code - it should
be in the library code.  Probably best to have them take hw_params
rather than require the machine driver to decode the format, rate and
channel since that'll save a bit of per driver boiler plate if they
don't otherwise need that information.

As I said last time ideally machine drivers shouldn't have to see this
at all, of course.

Otherwise this series all looks basically OK.  Liam is travelling at the
minute so it'll probably be the weekend at the earliest (more likely
early next week) before he has a chance to look at it.
