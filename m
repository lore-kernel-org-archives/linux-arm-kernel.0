From: sre@kernel.org (Sebastian Reichel)
Date: Wed, 31 Aug 2016 16:58:02 +0200
Subject: [PATCH v8 08/11] power: act8945a_charger: Add max current property
In-Reply-To: <1472109599-21915-9-git-send-email-wenyou.yang@atmel.com>
References: <1472109599-21915-1-git-send-email-wenyou.yang@atmel.com>
 <1472109599-21915-9-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160831145802.hmbnddaaif6y522t@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 25, 2016 at 03:19:56PM +0800, Wenyou Yang wrote:
> Add the power supply's current max property,
> POWER_SUPPLY_PROP_CURRENT_MAX.

[...]
  
> -	chglev_pin = of_get_named_gpio_flags(np,
> -				"active-semi,chglev-gpios", 0, &flags);
> -
> -	if (gpio_is_valid(chglev_pin)) {
> -		gpio_set_value(chglev_pin,
> -			       ((flags == OF_GPIO_ACTIVE_LOW) ? 0 : 1));
> +	charger->chglev_gpio = devm_gpiod_get(dev,
> +					      "active-semi,chglev", GPIOD_IN);
> +	if (PTR_ERR(charger->chglev_gpio) == -EPROBE_DEFER) {
> +		dev_info(dev, "probe retry requested for gpio \"chglev\"\n");
> +		return -EPROBE_DEFER;
> +	} else if (IS_ERR(charger->chglev_gpio)) {
> +		dev_err(dev, "unable to claim gpio \"chglev\"\n");
> +		charger->chglev_gpio = NULL;

Please also use devm_gpiod_get_optional() here (see previous patch).

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160831/eb415d50/attachment-0001.sig>
