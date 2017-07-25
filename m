From: ckeepax@opensource.cirrus.com (Charles Keepax)
Date: Tue, 25 Jul 2017 11:20:57 +0100
Subject: [PATCH v4 09/12] ASoC: wm9712: add ac97 new bus support
In-Reply-To: <20170724204928.29505-10-robert.jarzmik@free.fr>
References: <20170724204928.29505-1-robert.jarzmik@free.fr>
 <20170724204928.29505-10-robert.jarzmik@free.fr>
Message-ID: <20170725102057.hblyopxycgz55mr7@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 10:49:25PM +0200, Robert Jarzmik wrote:
> Add support for the new ac97 bus model, where devices are automatically
> discovered on AC-Links.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> ---
> +	} else {
> +		wm9712->ac97 = snd_soc_new_ac97_codec(codec, WM9712_VENDOR_ID,
> +						      WM9712_VENDOR_ID_MASK);
> +		if (IS_ERR(wm9712->ac97)) {
> +			ret = PTR_ERR(wm9712->ac97);
> +			dev_err(codec->dev,
> +				"Failed to register AC97 codec: %d\n", ret);
> +			return ret;
> +		}
> +
> +		regmap = regmap_init_ac97(wm9712->ac97, &wm9712_regmap_config);
> +		if (IS_ERR(regmap)) {
> +			ret = PTR_ERR(regmap);
> +			goto err_free_ac97_codec;

For the 9713 you had this wrapped in an ifdef? Why did it need an
ifdef there but doesn't for this driver?

Thanks,
Charles
