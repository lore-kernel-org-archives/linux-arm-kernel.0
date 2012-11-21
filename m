From: mturquette@ti.com (Mike Turquette)
Date: Wed, 21 Nov 2012 11:09:22 -0800
Subject: [PATCH 2/3 v3] clk: make ICST driver handle the VCO registers
In-Reply-To: <1353448864-13253-1-git-send-email-linus.walleij@linaro.org>
References: <1353448864-13253-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20121121190922.21126.7846@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Linus Walleij (2012-11-20 14:01:04)
> It turns out that all platforms using the ICST VCO are really
> just touching two registers, and in the same way as well: one
> register with the VCO configuration as such, and one lock register
> that makes it possible to write to the VCO.
> 
> Factor this register read/write into the ICST driver so we can
> reuse it in the IM-PD1 driver.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Taken into clk-next.

Thanks,
Mike

> ---
> ChangeLog v2->v3:
> - Actually SQUASH the freaking patches too, so we convert all
>   users of the ICST VCO in this patch. Since the commit
>   message was somehow preserved I must have been messing with
>   my git in some strange way.
> ---
>  drivers/clk/versatile/clk-icst.c       | 60 +++++++++++++++++++++++++++++-----
>  drivers/clk/versatile/clk-icst.h       | 14 ++++++--
>  drivers/clk/versatile/clk-integrator.c | 45 +++----------------------
>  drivers/clk/versatile/clk-realview.c   | 57 ++++++++------------------------
>  4 files changed, 81 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/clk/versatile/clk-icst.c b/drivers/clk/versatile/clk-icst.c
> index 23d2d7e..67ccf4a 100644
> --- a/drivers/clk/versatile/clk-icst.c
> +++ b/drivers/clk/versatile/clk-icst.c
> @@ -17,33 +17,74 @@
>  #include <linux/clkdev.h>
>  #include <linux/err.h>
>  #include <linux/clk-provider.h>
> +#include <linux/io.h>
>  
>  #include "clk-icst.h"
>  
>  /**
>   * struct clk_icst - ICST VCO clock wrapper
>   * @hw: corresponding clock hardware entry
> + * @vcoreg: VCO register address
> + * @lockreg: VCO lock register address
>   * @params: parameters for this ICST instance
>   * @rate: current rate
> - * @setvco: function to commit ICST settings to hardware
>   */
>  struct clk_icst {
>         struct clk_hw hw;
> +       void __iomem *vcoreg;
> +       void __iomem *lockreg;
>         const struct icst_params *params;
>         unsigned long rate;
> -       struct icst_vco (*getvco)(void);
> -       void (*setvco)(struct icst_vco);
>  };
>  
>  #define to_icst(_hw) container_of(_hw, struct clk_icst, hw)
>  
> +/**
> + * vco_get() - get ICST VCO settings from a certain register
> + * @vcoreg: register containing the VCO settings
> + */
> +static struct icst_vco vco_get(void __iomem *vcoreg)
> +{
> +       u32 val;
> +       struct icst_vco vco;
> +
> +       val = readl(vcoreg);
> +       vco.v = val & 0x1ff;
> +       vco.r = (val >> 9) & 0x7f;
> +       vco.s = (val >> 16) & 03;
> +       return vco;
> +}
> +
> +/**
> + * vco_set() - commit changes to an ICST VCO
> + * @locreg: register to poke to unlock the VCO for writing
> + * @vcoreg: register containing the VCO settings
> + * @vco: ICST VCO parameters to commit
> + */
> +static void vco_set(void __iomem *lockreg,
> +                       void __iomem *vcoreg,
> +                       struct icst_vco vco)
> +{
> +       u32 val;
> +
> +       val = readl(vcoreg) & ~0x7ffff;
> +       val |= vco.v | (vco.r << 9) | (vco.s << 16);
> +
> +       /* This magic unlocks the VCO so it can be controlled */
> +       writel(0xa05f, lockreg);
> +       writel(val, vcoreg);
> +       /* This locks the VCO again */
> +       writel(0, lockreg);
> +}
> +
> +
>  static unsigned long icst_recalc_rate(struct clk_hw *hw,
>                                       unsigned long parent_rate)
>  {
>         struct clk_icst *icst = to_icst(hw);
>         struct icst_vco vco;
>  
> -       vco = icst->getvco();
> +       vco = vco_get(icst->vcoreg);
>         icst->rate = icst_hz(icst->params, vco);
>         return icst->rate;
>  }
> @@ -66,7 +107,7 @@ static int icst_set_rate(struct clk_hw *hw, unsigned long rate,
>  
>         vco = icst_hz_to_vco(icst->params, rate);
>         icst->rate = icst_hz(icst->params, vco);
> -       icst->setvco(vco);
> +       vco_set(icst->vcoreg, icst->lockreg, vco);
>         return 0;
>  }
>  
> @@ -76,8 +117,9 @@ static const struct clk_ops icst_ops = {
>         .set_rate = icst_set_rate,
>  };
>  
> -struct clk * __init icst_clk_register(struct device *dev,
> -                                     const struct clk_icst_desc *desc)
> +struct clk *icst_clk_register(struct device *dev,
> +                       const struct clk_icst_desc *desc,
> +                       void __iomem *base)
>  {
>         struct clk *clk;
>         struct clk_icst *icst;
> @@ -95,8 +137,8 @@ struct clk * __init icst_clk_register(struct device *dev,
>         init.num_parents = 0;
>         icst->hw.init = &init;
>         icst->params = desc->params;
> -       icst->getvco = desc->getvco;
> -       icst->setvco = desc->setvco;
> +       icst->vcoreg = base + desc->vco_offset;
> +       icst->lockreg = base + desc->lock_offset;
>  
>         clk = clk_register(dev, &icst->hw);
>         if (IS_ERR(clk))
> diff --git a/drivers/clk/versatile/clk-icst.h b/drivers/clk/versatile/clk-icst.h
> index 71b4c56..dad51b6 100644
> --- a/drivers/clk/versatile/clk-icst.h
> +++ b/drivers/clk/versatile/clk-icst.h
> @@ -1,10 +1,18 @@
>  #include <asm/hardware/icst.h>
>  
> +/**
> + * struct clk_icst_desc - descriptor for the ICST VCO
> + * @params: ICST parameters
> + * @vco_offset: offset to the ICST VCO from the provided memory base
> + * @lock_offset: offset to the ICST VCO locking register from the provided
> + *     memory base
> + */
>  struct clk_icst_desc {
>         const struct icst_params *params;
> -       struct icst_vco (*getvco)(void);
> -       void (*setvco)(struct icst_vco);
> +       u32 vco_offset;
> +       u32 lock_offset;
>  };
>  
>  struct clk *icst_clk_register(struct device *dev,
> -                             const struct clk_icst_desc *desc);
> +                             const struct clk_icst_desc *desc,
> +                             void __iomem *base);
> diff --git a/drivers/clk/versatile/clk-integrator.c b/drivers/clk/versatile/clk-integrator.c
> index 3c816ae..08593b4 100644
> --- a/drivers/clk/versatile/clk-integrator.c
> +++ b/drivers/clk/versatile/clk-integrator.c
> @@ -10,7 +10,7 @@
>  #include <linux/clk.h>
>  #include <linux/clkdev.h>
>  #include <linux/err.h>
> -#include <linux/io.h>
> +#include <linux/platform_data/clk-integrator.h>
>  
>  #include <mach/hardware.h>
>  #include <mach/platform.h>
> @@ -22,42 +22,6 @@
>   * Inspired by portions of:
>   * plat-versatile/clock.c and plat-versatile/include/plat/clock.h
>   */
> -#define CM_LOCK                (__io_address(INTEGRATOR_HDR_BASE)+INTEGRATOR_HDR_LOCK_OFFSET)
> -#define CM_AUXOSC      (__io_address(INTEGRATOR_HDR_BASE)+0x1c)
> -
> -/**
> - * cp_auxvco_get() - get ICST VCO settings for the Integrator/CP
> - * @vco: ICST VCO parameters to update with hardware status
> - */
> -static struct icst_vco cp_auxvco_get(void)
> -{
> -       u32 val;
> -       struct icst_vco vco;
> -
> -       val = readl(CM_AUXOSC);
> -       vco.v = val & 0x1ff;
> -       vco.r = (val >> 9) & 0x7f;
> -       vco.s = (val >> 16) & 03;
> -       return vco;
> -}
> -
> -/**
> - * cp_auxvco_set() - commit changes to Integrator/CP ICST VCO
> - * @vco: ICST VCO parameters to commit
> - */
> -static void cp_auxvco_set(struct icst_vco vco)
> -{
> -       u32 val;
> -
> -       val = readl(CM_AUXOSC) & ~0x7ffff;
> -       val |= vco.v | (vco.r << 9) | (vco.s << 16);
> -
> -       /* This magic unlocks the CM VCO so it can be controlled */
> -       writel(0xa05f, CM_LOCK);
> -       writel(val, CM_AUXOSC);
> -       /* This locks the CM again */
> -       writel(0, CM_LOCK);
> -}
>  
>  static const struct icst_params cp_auxvco_params = {
>         .ref            = 24000000,
> @@ -73,8 +37,8 @@ static const struct icst_params cp_auxvco_params = {
>  
>  static const struct clk_icst_desc __initdata cp_icst_desc = {
>         .params = &cp_auxvco_params,
> -       .getvco = cp_auxvco_get,
> -       .setvco = cp_auxvco_set,
> +       .vco_offset = 0x1c,
> +       .lock_offset = INTEGRATOR_HDR_LOCK_OFFSET,
>  };
>  
>  /*
> @@ -114,6 +78,7 @@ void __init integrator_clk_init(bool is_cp)
>         clk_register_clkdev(clk, NULL, "sp804");
>  
>         /* ICST VCO clock used on the Integrator/CP CLCD */
> -       clk = icst_clk_register(NULL, &cp_icst_desc);
> +       clk = icst_clk_register(NULL, &cp_icst_desc,
> +                               __io_address(INTEGRATOR_HDR_BASE));
>         clk_register_clkdev(clk, NULL, "clcd");
>  }
> diff --git a/drivers/clk/versatile/clk-realview.c b/drivers/clk/versatile/clk-realview.c
> index fd2dbdb..cda07e7 100644
> --- a/drivers/clk/versatile/clk-realview.c
> +++ b/drivers/clk/versatile/clk-realview.c
> @@ -21,38 +21,6 @@
>   * Implementation of the ARM RealView clock trees.
>   */
>  
> -static void __iomem *sys_lock;
> -static void __iomem *sys_vcoreg;
> -
> -/**
> - * realview_oscvco_get() - get ICST OSC settings for the RealView
> - */
> -static struct icst_vco realview_oscvco_get(void)
> -{
> -       u32 val;
> -       struct icst_vco vco;
> -
> -       val = readl(sys_vcoreg);
> -       vco.v = val & 0x1ff;
> -       vco.r = (val >> 9) & 0x7f;
> -       vco.s = (val >> 16) & 03;
> -       return vco;
> -}
> -
> -static void realview_oscvco_set(struct icst_vco vco)
> -{
> -       u32 val;
> -
> -       val = readl(sys_vcoreg) & ~0x7ffff;
> -       val |= vco.v | (vco.r << 9) | (vco.s << 16);
> -
> -       /* This magic unlocks the CM VCO so it can be controlled */
> -       writel(0xa05f, sys_lock);
> -       writel(val, sys_vcoreg);
> -       /* This locks the CM again */
> -       writel(0, sys_lock);
> -}
> -
>  static const struct icst_params realview_oscvco_params = {
>         .ref            = 24000000,
>         .vco_max        = ICST307_VCO_MAX,
> @@ -65,10 +33,16 @@ static const struct icst_params realview_oscvco_params = {
>         .idx2s          = icst307_idx2s,
>  };
>  
> -static const struct clk_icst_desc __initdata realview_icst_desc = {
> +static const struct clk_icst_desc __initdata realview_osc0_desc = {
>         .params = &realview_oscvco_params,
> -       .getvco = realview_oscvco_get,
> -       .setvco = realview_oscvco_set,
> +       .vco_offset = REALVIEW_SYS_OSC0_OFFSET,
> +       .lock_offset = REALVIEW_SYS_LOCK_OFFSET,
> +};
> +
> +static const struct clk_icst_desc __initdata realview_osc4_desc = {
> +       .params = &realview_oscvco_params,
> +       .vco_offset = REALVIEW_SYS_OSC4_OFFSET,
> +       .lock_offset = REALVIEW_SYS_LOCK_OFFSET,
>  };
>  
>  /*
> @@ -78,13 +52,6 @@ void __init realview_clk_init(void __iomem *sysbase, bool is_pb1176)
>  {
>         struct clk *clk;
>  
> -       sys_lock = sysbase + REALVIEW_SYS_LOCK_OFFSET;
> -       if (is_pb1176)
> -               sys_vcoreg = sysbase + REALVIEW_SYS_OSC0_OFFSET;
> -       else
> -               sys_vcoreg = sysbase + REALVIEW_SYS_OSC4_OFFSET;
> -
> -
>         /* APB clock dummy */
>         clk = clk_register_fixed_rate(NULL, "apb_pclk", NULL, CLK_IS_ROOT, 0);
>         clk_register_clkdev(clk, "apb_pclk", NULL);
> @@ -116,7 +83,11 @@ void __init realview_clk_init(void __iomem *sysbase, bool is_pb1176)
>         clk_register_clkdev(clk, NULL, "sp804");
>  
>         /* ICST VCO clock */
> -       clk = icst_clk_register(NULL, &realview_icst_desc);
> +       if (is_pb1176)
> +               clk = icst_clk_register(NULL, &realview_osc0_desc, sysbase);
> +       else
> +               clk = icst_clk_register(NULL, &realview_osc4_desc, sysbase);
> +
>         clk_register_clkdev(clk, NULL, "dev:clcd");
>         clk_register_clkdev(clk, NULL, "issp:clcd");
>  }
> -- 
> 1.7.11.7
