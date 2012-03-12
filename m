From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Mar 2012 15:04:43 -0600
Subject: [PATCH] pinctrl: fix error path in pinconf_map_to_setting()
In-Reply-To: <1331584870-10077-1-git-send-email-linus.walleij@stericsson.com>
References: <1331584870-10077-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F5E64EB.6050200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/12/2012 02:41 PM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> The code was using the union member
> setting->data.configs.group_or_pin to store a potential
> error code, but since that member is unsigned the
> < 0 comparison was not true, letting errors pass thru,

"thru" is a pet peeve of mine; it'd be great to spell this correctly as
"through".

> ending up as mapped to pin "-22". Fix this up and print
> the error.

Oops. Sorry about that.

> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
...
> -		setting->data.configs.group_or_pin =
> -			pin_get_from_name(pctldev,
> -					  map->data.configs.group_or_pin);
> -		if (setting->data.configs.group_or_pin < 0)
> -			return setting->data.configs.group_or_pin;
> +		ret = pin_get_from_name(pctldev,
> +					map->data.configs.group_or_pin);
> +		if (ret < 0) {

"ret" here is named "pin" other places pin_get_from_name() is called,
and that naming seems to make a bit more sense here too.

Otherwise,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
