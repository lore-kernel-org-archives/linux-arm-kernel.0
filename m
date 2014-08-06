From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Aug 2014 22:59:10 +0200
Subject: [PATCH v3 1/6] usb: host: usb-st-common: Add common code required
 by ohci-st and ehci-st
In-Reply-To: <1407344589-24863-2-git-send-email-peter.griffin@linaro.org>
References: <1407344589-24863-1-git-send-email-peter.griffin@linaro.org>
 <1407344589-24863-2-git-send-email-peter.griffin@linaro.org>
Message-ID: <201408062259.10697.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 August 2014, Peter Griffin wrote:
> +int st_usb_platform_power_on(struct st_platform_priv *priv)
> +{
> +	int clk, ret;
> +
> +	if (priv->pwr) {
> +		ret = reset_control_deassert(priv->pwr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (priv->rst) {
> +		ret = 
> (priv->rst);
> +		if (ret)
> +			goto err_assert_power;
> +	}

I wouldn't make these optional, just call the functions
unconditionally and fail the probe function if they are
not available.

I'm not sure if it's worth keeping these functions in a
common file. You are adding complexity this way and I don't
think you are even saving a significant number of code lines
compared to just having two copies of them.

> +EXPORT_SYMBOL(st_usb_platform_power_on);

If you want to keep them, it would be best to make

	Arnd
