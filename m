From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 24 Feb 2016 14:59:44 +0100
Subject: [PATCH 25/50] pinctrl: ish-pfc: Use devm_pinctrl_register() for
 pinctrl registration
In-Reply-To: <1456319775-3216-26-git-send-email-ldewangan@nvidia.com>
References: <1456319775-3216-1-git-send-email-ldewangan@nvidia.com>
 <1456319775-3216-26-git-send-email-ldewangan@nvidia.com>
Message-ID: <CAMuHMdVBjn02J1tAwXb7XQKQa3jk=D4LX-f-1cZ2wsjc3Gfxqw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laxman,

On Wed, Feb 24, 2016 at 2:15 PM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> Use devm_pinctrl_register() for pin control registration.
>
> Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-renesas-soc at vger.kernel.org

Thanks for your patch!

> index 87b0a59..f17b5fc 100644
> --- a/drivers/pinctrl/sh-pfc/pinctrl.c
> +++ b/drivers/pinctrl/sh-pfc/pinctrl.c
> @@ -692,19 +692,9 @@ int sh_pfc_register_pinctrl(struct sh_pfc *pfc)
>         pmx->pctl_desc.pins = pmx->pins;
>         pmx->pctl_desc.npins = pfc->info->nr_pins;
>
> -       pmx->pctl = pinctrl_register(&pmx->pctl_desc, pfc->dev, pmx);
> +       pmx->pctl = devm_pinctrl_register(pfc->dev, &pmx->pctl_desc, pmx);
>         if (IS_ERR(pmx->pctl))
>                 return PTR_ERR(pmx->pctl);
>
>         return 0;
>  }
> -
> -int sh_pfc_unregister_pinctrl(struct sh_pfc *pfc)
> -{
> -       struct sh_pfc_pinctrl *pmx = pfc->pinctrl;
> -
> -       pinctrl_unregister(pmx->pctl);
> -
> -       pfc->pinctrl = NULL;
> -       return 0;
> -}

There's no longer a need to have sh_pfc.pinctrl, so please remove that field
while you're at it.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
