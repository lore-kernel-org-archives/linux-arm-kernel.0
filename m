From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 23 Nov 2011 10:20:28 +0000
Subject: [PATCH 04/17] ASoC: Add device tree binding for WM8903
In-Reply-To: <1322011285-4002-5-git-send-email-swarren@nvidia.com>
References: <1322011285-4002-1-git-send-email-swarren@nvidia.com>
 <1322011285-4002-5-git-send-email-swarren@nvidia.com>
Message-ID: <20111123102027.GB4332@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 06:21:12PM -0700, Stephen Warren wrote:

> +  - irq-active-low : Indicates whether the IRQ output should be active low
> +    (property present) or active high (property absent).

I think we ought to be coming up with a standard binding for this stuff 
rather than having every device defining it's own way of plugging the
interrupt lines together - many devices have lots of flexibility with
how their interrupt line signals for compatibility reasons.

> +  - gpio-cfg : A list of GPIO pin mux register values. The list must be 5
> +    entries long. If absent, no configuration of these registers is
> +    performed.

What's a "GPIO pin mux"?

> +	/* 0x8000 = Not configured */
> +	gpio-cfg = < 0x8000 0x8000 0 0x8000 0x8000 >;

The 0x8000 isn't documented in the binding and this doesn't seem
terribly idiomatic for device tree.

> -static void wm8903_init_gpio(struct snd_soc_codec *codec)
> +static void wm8903_init_gpio(struct snd_soc_codec *codec,
> +			     struct wm8903_platform_data *pdata)

Why?

>  static int wm8903_probe(struct snd_soc_codec *codec)
>  {
>  	struct wm8903_platform_data *pdata = dev_get_platdata(codec->dev);
> +	struct wm8903_platform_data lpdata;

Why and what is "lpdata" supposed to mean?

> +	if (!pdata && codec->dev->of_node) {
> +		lpdata.irq_active_low = 0;
> +		lpdata.micdet_cfg = 0;

This should be set by default.

> +		lpdata.micdet_delay = 100;
> +		lpdata.gpio_base = -1;

This means that the defaults are in different different places if we
have platform data and if we have device tree.  We should restructure
the code so that we only have defaults in one place.

> +		if (of_property_read_u32(np, "micdet-cfg", &val32) >= 0)
> +			lpdata.micdet_cfg = val32;

I'd rather have defaults as an else case I think.

> +#if defined(CONFIG_OF)

ifdef.
