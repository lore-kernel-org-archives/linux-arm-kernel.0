From: dianders@chromium.org (Doug Anderson)
Date: Tue, 21 Oct 2014 21:58:48 -0700
Subject: [PATCH v4 3/6] clk: rockchip: RK3288: add suspend and resume
In-Reply-To: <1413933902-25767-1-git-send-email-zyw@rock-chips.com>
References: <1413933461-25602-1-git-send-email-zyw@rock-chips.com>
 <1413933902-25767-1-git-send-email-zyw@rock-chips.com>
Message-ID: <CAD=FV=XFjL5ah854oaxpEpyGjJB-zRNw2nN73C0X9JaTs-Hjyw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chris,

On Tue, Oct 21, 2014 at 4:25 PM, Chris Zhong <zyw@rock-chips.com> wrote:
> +#ifdef CONFIG_PM_SLEEP
> +static void __iomem *rk3288_cru_base;
> +static const int rk3288_saved_cru_reg_ids[] = {
> +       RK3288_MODE_CON,
> +       RK3288_CLKSEL_CON(0),
> +       RK3288_CLKSEL_CON(1),
> +       RK3288_CLKSEL_CON(10),
> +       RK3288_CLKSEL_CON(33),
> +       RK3288_CLKSEL_CON(37),

I'm still not 100% certain why these registers were picked.  Are they
all needed?  Are we sure that no extras are needed?

I'll try to find some time to research, but if you happen to know the
answer that'd be nice.


> +};
> +
> +static u32 rk3288_saved_cru_regs[ARRAY_SIZE(rk3288_saved_cru_reg_ids)];
> +
> +/*
> + * cru will be set in maskrom when system wake up from fastboot
> + * mode in suspend,
> + * so the operation is saving the changed regs.
> + * The apll/cpll/gpll will be set into slow mode in maskrom.
> + * It is mean that resume code run in 24m quit slowly!

s/quit/quite

> + * so we must resume these plls as soon as possible.

This function doesn't actually resume PLLs, it just restores dividers / etc.


I will say that with this patch the "clk_summary" doesn't change
before and after suspend/resume.  Without this patch I see this diff
before/after:

<                 l2ram                     0            0   600000000
         0 0
<                 aclk_core_m0              0            0   600000000
         0 0
<                 aclk_core_mp              0            0   360000000
         0 0
<                 atclk                     0            0   360000000
         0 0
<                 pclk_dbg_pre              0            0   360000000
         0 0
<                    pclk_core_niu           0            0
360000000          0 0
<                    cs_dbg                 0            0   360000000
         0 0
<                    pclk_dbg               0            0   360000000
         0 0
---
>                 l2ram                     0            0  1800000000          0 0
>                 aclk_core_m0              0            0  1800000000          0 0
>                 aclk_core_mp              0            0  1800000000          0 0
>                 atclk                     0            0  1800000000          0 0
>                 pclk_dbg_pre              0            0  1800000000          0 0
>                    pclk_core_niu           0            0  1800000000          0 0
>                    cs_dbg                 0            0  1800000000          0 0
>                    pclk_dbg               0            0  1800000000          0 0
