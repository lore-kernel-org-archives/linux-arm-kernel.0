From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 22 Aug 2013 15:31:40 -0700
Subject: [PATCH 3/4] clk: mvebu: add missing iounmap
In-Reply-To: <1377175611-4241-4-git-send-email-jszhang@marvell.com>
References: <1377175611-4241-1-git-send-email-jszhang@marvell.com>
 <1377175611-4241-4-git-send-email-jszhang@marvell.com>
Message-ID: <20130822223140.8231.74026@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jisheng Zhang (2013-08-22 05:46:50)
> Add missing iounmap to setup error path.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Patch looks good with one minor nitpick below.

> @@ -145,10 +147,8 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
>         ctrl->num_gates = n;
>         ctrl->gates = kzalloc(ctrl->num_gates * sizeof(struct clk *),
>                               GFP_KERNEL);
> -       if (WARN_ON(!ctrl->gates)) {
> -               kfree(ctrl);
> -               return;
> -       }
> +       if (WARN_ON(!ctrl->gates))
> +               goto bail_out;
>  
>         for (n = 0; n < ctrl->num_gates; n++) {
>                 const char *parent =
> @@ -160,4 +160,10 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
>         }
>  
>         of_clk_add_provider(np, clk_gating_get_src, ctrl);
> +
> +       return;
> +bail_out:
> +       kfree(ctrl);
> +ctrl_out:
> +       iounmap(base);

bail_out is not the best name. How about gates_out?

Regards,
Mike
