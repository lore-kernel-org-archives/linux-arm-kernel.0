From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 11 Jan 2013 21:22:10 +0100
Subject: [PATCH v2] drivers/pinctrl: grab default handles from device core
In-Reply-To: <50EF3BAF.4010200@wwwdotorg.org>
References: <1355343907-11535-1-git-send-email-linus.walleij@stericsson.com>
 <50EF27B4.60608@wwwdotorg.org> <50EF3BAF.4010200@wwwdotorg.org>
Message-ID: <CACRpkdaHL=fj6f6a0AH0DaYzxRCen28rUv46O8yZ00gu81n1+Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 11:07 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> I see that an attempt was made to solve this problem, in the patch
> immediately preceding this one (at least, as applied in the pinctrl
> tree). However, that patch only addresses the case where the pin
> controller is being looked up in the map, and not the case when
> converting device tree to the map in the first place. The patch below
> solves this:
>
> diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
> index fe2d1af..fd40a11 100644
> --- a/drivers/pinctrl/devicetree.c
> +++ b/drivers/pinctrl/devicetree.c
> @@ -141,6 +141,11 @@ static int dt_to_map_one_config(struct pinctrl *p,
> const char *statename,
>                 pctldev = find_pinctrl_by_of_node(np_pctldev);
>                 if (pctldev)
>                         break;
> +               /* Do not defer probing of hogs (circular loop) */
> +               if (np_pctldev == p->dev->of_node) {
> +                       of_node_put(np_pctldev);
> +                       return -ENODEV;
> +               }
>         }
>         of_node_put(np_pctldev);

OK I've duplicated this, will send out as patch.

Yours,
Linus Walleij
