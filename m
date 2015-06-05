From: dianders@chromium.org (Doug Anderson)
Date: Fri, 5 Jun 2015 13:55:20 -0700
Subject: [PATCH v4 1/3] ARM: rockchip: fix the CPU soft reset
In-Reply-To: <1433523923-4755-2-git-send-email-wxt@rock-chips.com>
References: <1433523923-4755-1-git-send-email-wxt@rock-chips.com>
 <1433523923-4755-2-git-send-email-wxt@rock-chips.com>
Message-ID: <CAD=FV=XGOVpAA5+NQ8O910T=CPrYKfTseBXfNbR4EkenzDECaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Caesar,

On Fri, Jun 5, 2015 at 10:05 AM, Caesar Wang <wxt@rock-chips.com> wrote:
> +               if (!on)
> +                       reset_control_assert(rstc);
> +
> +               ret = regmap_update_bits(pmu, PMU_PWRDN_CON, BIT(pd), val);
> +               if (ret < 0) {
> +                       pr_err("%s: could not update power domain\n", __func__);
> +                       reset_control_put(rstc);
> +                       return ret;
> +               }
> +
>                 if (on)
>                         reset_control_deassert(rstc);
> -               else
> -                       reset_control_assert(rstc);

As Heiko indicated in the previous patchset, he thought it would be
nice to move the 'pmu_power_domain_is_on(pd)' to before you deasserted
reset.  ...but then I pointed out that you tested that in patch set #2
and it didn't work.

Talking to Heiko offline he thought that perhaps you could make
'pmu_power_domain_is_on(pd)' work if you increased your 'udelay(10);'
in rockchip_boot_secondary().  Perhaps the old
'pmu_power_domain_is_on' was acting like an extra bit of delay and
that's why moving it broke things.


I actually went back and tested patch set #2 and it worked for me, so
I couldn't test Heiko's theory.  Could you go and reproduce the
problem with patch set #2 again and then try increasing the udelay()
and see if your problems go away?  If that works, it might be a
slightly better solution.  Note that I think Heiko had a slightly
cleaner version of your patch set #2 that he posted in response to
your patch set #3.


-Doug
