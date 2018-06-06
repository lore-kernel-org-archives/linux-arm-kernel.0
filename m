From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 6 Jun 2018 19:02:03 +0300
Subject: [PATCH][next] pinctrl: pinctrl-single: add allocation failure
 checking of saved_vals
In-Reply-To: <20180606134338.4645-1-colin.king@canonical.com>
References: <20180606134338.4645-1-colin.king@canonical.com>
Message-ID: <CAHp75Vd0Djw+nDN7u=-CLEfdDGA5QTsMueOb9EZLNnCDgso5fA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 6, 2018 at 4:43 PM, Colin King <colin.king@canonical.com> wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently saved_vals is being allocated and there is no check for
> failed allocation (which is more likely than normal when using
> GFP_ATOMIC).  Fix this by checking for a failed allocation and
> propagating this error return down the the caller chain.
>
> Detected by CoverityScan, CID#1469841 ("Dereference null return value")
>
> Fixes: 88a1dbdec682 ("pinctrl: pinctrl-single: Add functions to save and restore pinctrl context")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/pinctrl/pinctrl-single.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
> index 9c3c00515aa0..0905ee002041 100644
> --- a/drivers/pinctrl/pinctrl-single.c
> +++ b/drivers/pinctrl/pinctrl-single.c
> @@ -1588,8 +1588,11 @@ static int pcs_save_context(struct pcs_device *pcs)
>
>         mux_bytes = pcs->width / BITS_PER_BYTE;
>
> -       if (!pcs->saved_vals)
> +       if (!pcs->saved_vals) {
>                 pcs->saved_vals = devm_kzalloc(pcs->dev, pcs->size, GFP_ATOMIC);

> +               if (!pcs->saved_vals)
> +                       return -ENOMEM;

Wouldn't make sense to move it out of the first condition?

Something like

if (!foo)
 foo = ...malloc(...);
if (!foo)
 return ...


> +       }
>
>         switch (pcs->width) {
>         case 64:
> @@ -1649,8 +1652,13 @@ static int pinctrl_single_suspend(struct platform_device *pdev,
>         if (!pcs)
>                 return -EINVAL;
>
> -       if (pcs->flags & PCS_CONTEXT_LOSS_OFF)
> -               pcs_save_context(pcs);
> +       if (pcs->flags & PCS_CONTEXT_LOSS_OFF) {
> +               int ret;
> +
> +               ret = pcs_save_context(pcs);
> +               if (ret < 0)
> +                       return ret;
> +       }
>
>         return pinctrl_force_sleep(pcs->pctl);
>  }



-- 
With Best Regards,
Andy Shevchenko
