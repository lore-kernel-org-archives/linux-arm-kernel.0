From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 07 Oct 2013 22:43:53 -0700
Subject: [PATCHv2 1/1] clk/zynq: Fix possible memory leak
In-Reply-To: <1381199144-5827-1-git-send-email-felipensp@gmail.com>
References: <1381199144-5827-1-git-send-email-felipensp@gmail.com>
Message-ID: <20131008054353.7445.57617@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Felipe Pena (2013-10-07 19:25:44)
> The zynq_clk_register_fclk function can leak memory (fclk_lock) when unable
> to alloc memory for fclk_gate_lock
> 
> Signed-off-by: Felipe Pena <felipensp@gmail.com>
> Acked-by: S?ren Brinkmann <soren.brinkmann@xilinx.com>

Taken into clk-next.

Thanks!
Mike

> ---
>  drivers/clk/zynq/clkc.c |   16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index cc40fe6..10772aa 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -117,13 +117,19 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
>                 goto err;
>         fclk_gate_lock = kmalloc(sizeof(*fclk_gate_lock), GFP_KERNEL);
>         if (!fclk_gate_lock)
> -               goto err;
> +               goto err_fclk_gate_lock;
>         spin_lock_init(fclk_lock);
>         spin_lock_init(fclk_gate_lock);
> 
>         mux_name = kasprintf(GFP_KERNEL, "%s_mux", clk_name);
> +       if (!mux_name)
> +               goto err_mux_name;
>         div0_name = kasprintf(GFP_KERNEL, "%s_div0", clk_name);
> +       if (!div0_name)
> +               goto err_div0_name;
>         div1_name = kasprintf(GFP_KERNEL, "%s_div1", clk_name);
> +       if (!div1_name)
> +               goto err_div1_name;
> 
>         clk = clk_register_mux(NULL, mux_name, parents, 4,
>                         CLK_SET_RATE_NO_REPARENT, fclk_ctrl_reg, 4, 2, 0,
> @@ -147,6 +153,14 @@ static void __init zynq_clk_register_fclk(enum zynq_clk fclk,
> 
>         return;
> 
> +err_div1_name:
> +       kfree(div0_name);
> +err_div0_name:
> +       kfree(mux_name);
> +err_mux_name:
> +       kfree(fclk_gate_lock);
> +err_fclk_gate_lock:
> +       kfree(fclk_lock);
>  err:
>         clks[fclk] = ERR_PTR(-ENOMEM);
>  }
> --
> 1.7.10.4
