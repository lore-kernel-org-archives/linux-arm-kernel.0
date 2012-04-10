From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 10 Apr 2012 09:36:26 -0600
Subject: [PATCH] pinctrl: implement pinctrl deferred probing
In-Reply-To: <1334045048-15566-1-git-send-email-linus.walleij@stericsson.com>
References: <1334045048-15566-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <4F84537A.2020300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/10/2012 02:04 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> If drivers try to obtain pinctrl handles for a pin controller that
> has not yet registered to the subsystem, we need to be able to
> back out and retry with deferred probing. So let's return
> -EPROBE_DEFER whenever this location fails.
> 
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This looks fine, except:

> @@ -521,8 +521,11 @@ static int add_setting(struct pinctrl *p, struct pinctrl_map const *map)
>  		dev_err(p->dev, "unknown pinctrl device %s in map entry",
>  			map->ctrl_dev_name);

Perhaps this dev_err (and the one in the other hunk) should be
downgraded to warn/info/debug?

> +		/*
> +		 * OK let us guess that the driver is not there yet, and
> +		 * let's defer obtaining this pinctrl handle to later...
> +		 */
> +		return -EPROBE_DEFER;
>  	}
