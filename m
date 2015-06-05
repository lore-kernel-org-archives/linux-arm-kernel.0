From: dianders@chromium.org (Doug Anderson)
Date: Fri, 5 Jun 2015 09:28:42 -0700
Subject: [PATCH v3 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1433517104-7595-2-git-send-email-wxt@rock-chips.com>
References: <1433517104-7595-1-git-send-email-wxt@rock-chips.com>
 <1433517104-7595-2-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=WTGz9SYGap5V7YAWdJy_pOScivo6x66vni2-fW5Y7xNQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Fri, Jun 5, 2015 at 8:11 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> We need different orderings when turning a core on and turning a core
> off.  In one case we need to assert reset before turning power off.
> In ther other case we need to turn power on and the deassert reset.
>
> In general, the correct flow is:
>
> CPU off:
>     reset_control_assert
>     regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), BIT(pd))

Add: "ensure power domain is on" to this list.

> CPU on:
>     regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), 0)
>     reset_control_deassert

Add: "ensure power domain is on" to this list.

Adding the "ensure power domain is on" step helps document that patch
set version 2 is not what you want and that you thought about it.


> @@ -88,18 +88,24 @@ static int pmu_set_power_domain(int pd, bool on)
>                         return PTR_ERR(rstc);
>                 }
>
> -               if (on)
> -                       reset_control_deassert(rstc);
> -               else
> +               if (!on)
>                         reset_control_assert(rstc);
>
> -               reset_control_put(rstc);
> -       }
> +               ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
> +               if (ret < 0) {
> +                       pr_err("%s: could not update power domain\n", __func__);
> +                       reset_control_put(rstc);
> +                       return ret;
> +               }
>
> -       ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
> -       if (ret < 0) {
> -               pr_err("%s: could not update power domain\n", __func__);
> -               return ret;
> +               if (on)
> +                       reset_control_deassert(rstc);

I think you need a "reset_control_put(rstc);" here in the non-error case.

Otherwise this looks reasonable to me and you can add my Reviewed-by
tag.  I'll also kick off some tests with this series today to confirm
as well.

-Doug
