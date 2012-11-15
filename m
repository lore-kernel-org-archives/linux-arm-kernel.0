From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 15 Nov 2012 15:42:56 +0100
Subject: [PATCH 4/4] pinctrl: nomadik: Prevent NULL dereference if
 of_match_device returns NULL
In-Reply-To: <1352955365.6793.6.camel@phoenix>
References: <1352955096.6793.1.camel@phoenix> <1352955365.6793.6.camel@phoenix>
Message-ID: <CACRpkdbWqFrP7RvXbaR5Bcz1htCL_wSqwUvOi67LmoF_PBjvhg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2012 at 5:56 AM, Axel Lin <axel.lin@ingics.com> wrote:

> of_match_device() may return NULL.
>
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  drivers/pinctrl/pinctrl-nomadik.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-nomadik.c b/drivers/pinctrl/pinctrl-nomadik.c
> index 238060e..40bd1b3 100644
> --- a/drivers/pinctrl/pinctrl-nomadik.c
> +++ b/drivers/pinctrl/pinctrl-nomadik.c
> @@ -1863,9 +1863,14 @@ static int __devinit nmk_pinctrl_probe(struct platform_device *pdev)
>
>         if (platid)
>                 version = platid->driver_data;
> -       else if (np)
> -               version = (unsigned int)
> -                       of_match_device(nmk_pinctrl_match, &pdev->dev)->data;
> +       else if (np) {
> +               const struct of_device_id *match;
> +
> +               match = of_match_device(nmk_pinctrl_match, &pdev->dev);
> +               if (!match)
> +                       return -ENODEV;
> +               version = (unsigned int) match->data;
> +       }

AFAICT this can actually happen so patch applied, unless Lee
speaks against it.

Patches 1-3/4 are dropped though, as the maintainers didn't seem
to like them.

Yours,
Linus Walleij
