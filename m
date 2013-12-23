From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 23 Dec 2013 11:27:38 -0800
Subject: [PATCH 2/2] clk: versatile: fixup IM-PD1 clock implementation
In-Reply-To: <1385326744-16445-1-git-send-email-linus.walleij@linaro.org>
References: <1385326744-16445-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20131223192738.25490.99299@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2013-11-24 12:59:04)
> Register both VCO clocks, give per-logical module unique names
> to the clocks so we can have several IM-PD1's connected (in
> theory). Implement all the fixed-factor clocks as children of
> VCO2.
> 
> Tested by using the UARTs and the PL181 MMC block on the IM-PD1,
> works flawlessly.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Mike Turquette <mturquette@linaro.org>

> ---
> Hi Mike, if you're happy with this, I'd like an ACK to carry it
> through the ARM SoC tree.
> ---
>  drivers/clk/versatile/clk-impd1.c | 86 ++++++++++++++++++++++++++++++++-------
>  1 file changed, 71 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/clk/versatile/clk-impd1.c b/drivers/clk/versatile/clk-impd1.c
> index b693a2bbf25a..844f8d711a12 100644
> --- a/drivers/clk/versatile/clk-impd1.c
> +++ b/drivers/clk/versatile/clk-impd1.c
> @@ -1,6 +1,6 @@
>  /*
>   * Clock driver for the ARM Integrator/IM-PD1 board
> - * Copyright (C) 2012 Linus Walleij
> + * Copyright (C) 2012-2013 Linus Walleij
>   *
>   * This program is free software; you can redistribute it and/or modify
>   * it under the terms of the GNU General Public License version 2 as
> @@ -18,20 +18,28 @@
>  #include "clk-icst.h"
>  
>  struct impd1_clk {
> -       struct clk *vcoclk;
> +       char *vco1name;
> +       struct clk *vco1clk;
> +       char *vco2name;
> +       struct clk *vco2clk;
> +       struct clk *mmciclk;
> +       char *uartname;
>         struct clk *uartclk;
> -       struct clk_lookup *clks[3];
> +       char *spiname;
> +       struct clk *spiclk;
> +       char *scname;
> +       struct clk *scclk;
> +       struct clk_lookup *clks[6];
>  };
>  
> +/* One entry for each connected IM-PD1 LM */
>  static struct impd1_clk impd1_clks[4];
>  
>  /*
> - * There are two VCO's on the IM-PD1 but only one is used by the
> - * kernel, that is why we are only implementing the control of
> - * IMPD1_OSC1 here.
> + * There are two VCO's on the IM-PD1
>   */
>  
> -static const struct icst_params impd1_vco_params = {
> +static const struct icst_params impd1_vco1_params = {
>         .ref            = 24000000,     /* 24 MHz */
>         .vco_max        = ICST525_VCO_MAX_3V,
>         .vco_min        = ICST525_VCO_MIN,
> @@ -44,11 +52,29 @@ static const struct icst_params impd1_vco_params = {
>  };
>  
>  static const struct clk_icst_desc impd1_icst1_desc = {
> -       .params = &impd1_vco_params,
> +       .params = &impd1_vco1_params,
>         .vco_offset = IMPD1_OSC1,
>         .lock_offset = IMPD1_LOCK,
>  };
>  
> +static const struct icst_params impd1_vco2_params = {
> +       .ref            = 24000000,     /* 24 MHz */
> +       .vco_max        = ICST525_VCO_MAX_3V,
> +       .vco_min        = ICST525_VCO_MIN,
> +       .vd_min         = 12,
> +       .vd_max         = 519,
> +       .rd_min         = 3,
> +       .rd_max         = 120,
> +       .s2div          = icst525_s2div,
> +       .idx2s          = icst525_idx2s,
> +};
> +
> +static const struct clk_icst_desc impd1_icst2_desc = {
> +       .params = &impd1_vco2_params,
> +       .vco_offset = IMPD1_OSC2,
> +       .lock_offset = IMPD1_LOCK,
> +};
> +
>  /**
>   * integrator_impd1_clk_init() - set up the integrator clock tree
>   * @base: base address of the logic module (LM)
> @@ -66,16 +92,39 @@ void integrator_impd1_clk_init(void __iomem *base, unsigned int id)
>         }
>         imc = &impd1_clks[id];
>  
> -       clk = icst_clk_register(NULL, &impd1_icst1_desc, "icst1", base);
> +       imc->vco1name = kasprintf(GFP_KERNEL, "lm%x-vco1", id);
> +       clk = icst_clk_register(NULL, &impd1_icst1_desc, imc->vco1name, base);
>         imc->vco1clk = clk;
>         imc->clks[0] = clkdev_alloc(clk, NULL, "lm%x:01000", id);
>  
> -       /* UART reference clock */
> -       clk = clk_register_fixed_rate(NULL, "uartclk", NULL, CLK_IS_ROOT,
> -                               14745600);
> +       /* VCO2 is also called "CLK2" */
> +       imc->vco2name = kasprintf(GFP_KERNEL, "lm%x-vco2", id);
> +       clk = icst_clk_register(NULL, &impd1_icst2_desc, imc->vco2name, base);
> +       imc->vco2clk = clk;
> +
> +       /* MMCI uses CLK2 right off */
> +       imc->clks[1] = clkdev_alloc(clk, NULL, "lm%x:00700", id);
> +
> +       /* UART reference clock divides CLK2 by a fixed factor 4 */
> +       imc->uartname = kasprintf(GFP_KERNEL, "lm%x-uartclk", id);
> +       clk = clk_register_fixed_factor(NULL, imc->uartname, imc->vco2name,
> +                                  CLK_IGNORE_UNUSED, 1, 4);
>         imc->uartclk = clk;
> -       imc->clks[1] = clkdev_alloc(clk, NULL, "lm%x:00100", id);
> -       imc->clks[2] = clkdev_alloc(clk, NULL, "lm%x:00200", id);
> +       imc->clks[2] = clkdev_alloc(clk, NULL, "lm%x:00100", id);
> +       imc->clks[3] = clkdev_alloc(clk, NULL, "lm%x:00200", id);
> +
> +       /* SPI PL022 clock divides CLK2 by a fixed factor 64 */
> +       imc->spiname = kasprintf(GFP_KERNEL, "lm%x-spiclk", id);
> +       clk = clk_register_fixed_factor(NULL, imc->spiname, imc->vco2name,
> +                                  CLK_IGNORE_UNUSED, 1, 64);
> +       imc->clks[4] = clkdev_alloc(clk, NULL, "lm%x:00300", id);
> +
> +       /* Smart Card clock divides CLK2 by a fixed factor 4 */
> +       imc->scname = kasprintf(GFP_KERNEL, "lm%x-scclk", id);
> +       clk = clk_register_fixed_factor(NULL, imc->scname, imc->vco2name,
> +                                  CLK_IGNORE_UNUSED, 1, 4);
> +       imc->scclk = clk;
> +       imc->clks[5] = clkdev_alloc(clk, NULL, "lm%x:00600", id);
>  
>         for (i = 0; i < ARRAY_SIZE(imc->clks); i++)
>                 clkdev_add(imc->clks[i]);
> @@ -92,6 +141,13 @@ void integrator_impd1_clk_exit(unsigned int id)
>  
>         for (i = 0; i < ARRAY_SIZE(imc->clks); i++)
>                 clkdev_drop(imc->clks[i]);
> +       clk_unregister(imc->spiclk);
>         clk_unregister(imc->uartclk);
> -       clk_unregister(imc->vcoclk);
> +       clk_unregister(imc->vco2clk);
> +       clk_unregister(imc->vco1clk);
> +       kfree(imc->scname);
> +       kfree(imc->spiname);
> +       kfree(imc->uartname);
> +       kfree(imc->vco2name);
> +       kfree(imc->vco1name);
>  }
> -- 
> 1.8.3.1
> 
