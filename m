From: sre@kernel.org (Sebastian Reichel)
Date: Tue, 23 Aug 2016 04:43:51 +0200
Subject: [PATCH v7 6/7] power: act8945a_charger: Add max current property
In-Reply-To: <1471848557-27278-7-git-send-email-wenyou.yang@atmel.com>
References: <1471848557-27278-1-git-send-email-wenyou.yang@atmel.com>
 <1471848557-27278-7-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160823024351.akwvobxzvwwhzwsq@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 22, 2016 at 02:49:16PM +0800, Wenyou Yang wrote:
> [...]
>
> -	chglev_pin = of_get_named_gpio_flags(np,
> -				"active-semi,chglev-gpios", 0, &flags);
> -
> -	if (gpio_is_valid(chglev_pin)) {
> -		gpio_set_value(chglev_pin,
> -			       ((flags == OF_GPIO_ACTIVE_LOW) ? 0 : 1));
> +	charger->chglev_gpio = gpiod_get(dev->parent,
> +					 "active-semi,chglev", GPIOD_IN);
> +	if (PTR_ERR(charger->chglev_gpio) == -EPROBE_DEFER) {
> +		dev_info(dev, "probe retry requested for gpio \"chglev\"\n");

missing return? You need to return EPROBE_DEFER in probe().

> +	} else if (IS_ERR(charger->chglev_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"chglev\"\n");
> +		charger->chglev_gpio = NULL;
>  	}
>  
> [...]

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160823/f6c2d445/attachment.sig>
