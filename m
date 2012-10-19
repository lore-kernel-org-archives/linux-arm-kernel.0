From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 19 Oct 2012 10:18:47 -0600
Subject: [PATCH v2] pinctrl: reserve pins when states are activated
In-Reply-To: <1350651909-5337-1-git-send-email-linus.walleij@stericsson.com>
References: <1350651909-5337-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <50817D67.10900@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/19/2012 07:05 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> This switches the way that pins are reserved for multiplexing:
> 
> We used to do this when the map was parsed, at the creation of
> the settings inside the pinctrl handle, in pinmux_map_to_setting().
> 
> However this does not work for us, because we want to use the
> same set of pins with different devices at different times: the

> diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c

> @@ -689,7 +691,6 @@ static void pinctrl_put_locked(struct pinctrl *p, bool inlist)
>  			case PIN_MAP_TYPE_MUX_GROUP:
>  				if (state == p->state)
>  					pinmux_disable_setting(setting);
> -				pinmux_free_setting(setting);

Personally, I would keep that function, and just remove the body. I
believe that even though it currently doesn't have to do anything, it
provides documentation for where any required cleanup would be placed if
needed in the future.

If you still want to remove the function, pinconf_free_setting() should
also be removed, since that's empty right now.

Irrespective,

Acked-by: Stephen Warren <swarren@nvidia.com>
