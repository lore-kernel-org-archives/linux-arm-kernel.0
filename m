From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 13 Apr 2016 17:33:41 -0700
Subject: [PATCH v2] clk: let clk_disable() return immediately if clk is
 NULL or error
In-Reply-To: <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
References: <1459821083-28116-1-git-send-email-yamada.masahiro@socionext.com>
 <20160408003328.GA14441@codeaurora.org>
 <CAK7LNASW+D0B_k97r__AZeYDR5UqNPqn_j1aoQepHz-bGgV2ng@mail.gmail.com>
Message-ID: <20160414003341.GH14441@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/08, Masahiro Yamada wrote:
> 
> 
> This makes our driver programming life easier.
> 
> 
> For example, let's see drivers/tty/serial/8250/8250_of.c
> 
> 
> The "clock-frequency" DT property takes precedence over "clocks" property.
> So, it is valid to probe the driver with a NULL pointer for info->clk.
> 
> 
>         if (of_property_read_u32(np, "clock-frequency", &clk)) {
> 
>                 /* Get clk rate through clk driver if present */
>                 info->clk = devm_clk_get(&ofdev->dev, NULL);
>                 if (IS_ERR(info->clk)) {
>                         dev_warn(&ofdev->dev,
>                                 "clk or clock-frequency not defined\n");
>                         return PTR_ERR(info->clk);
>                 }
> 
>                 ret = clk_prepare_enable(info->clk);
>                 if (ret < 0)
>                         return ret;
> 
>                 clk = clk_get_rate(info->clk);
>         }
> 
> 
> As a result, we need to make sure the clk pointer is valid
> before calling clk_disable_unprepare().
> 
> 
> If we could support pointer checking in callees, we would be able to
> clean-up lots of clock consumers.
> 
> 

I'm not sure if you meant to use that example for the error
pointer case? It bails out if clk_get() returns an error pointer.

I'm all for a no-op in clk_disable()/unprepare() when the pointer
is NULL. But when it's an error pointer the driver should be
handling it and bail out before it would ever call enable/prepare
on it or disable/unprepare.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
