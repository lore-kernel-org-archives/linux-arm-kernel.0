From: sboyd@kernel.org (Stephen Boyd)
Date: Mon, 19 Mar 2018 09:57:11 -0700
Subject: [PATCH v3 08/10] clk: qcom: Add ACD path to CPU clock driver for
 msm8996
In-Reply-To: <1518616792-29028-9-git-send-email-ilialin@codeaurora.org>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-9-git-send-email-ilialin@codeaurora.org>
Message-ID: <152147863176.242365.17292287330283256524@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Ilia Lin (2018-02-14 05:59:50)
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
> index b0a3b73..1552791 100644
> --- a/drivers/clk/qcom/clk-cpu-8996.c
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -17,6 +17,7 @@
>  #include <linux/regmap.h>
>  #include <linux/clk-provider.h>
>  #include "clk-alpha-pll.h"
> +#include <soc/qcom/kryo-l2-accessors.h>

Put this above local includes please.

>  
>  #define VCO(a, b, c) { \
>         .val = a,\
> @@ -29,6 +30,27 @@
>  #define ACD_INDEX              2
>  #define ALT_INDEX              3
>  #define DIV_2_THRESHOLD                600000000
> +#define PWRCL_REG_OFFSET 0x0
> +#define PERFCL_REG_OFFSET 0x80000
> +#define MUX_OFFSET     0x40
> +#define ALT_PLL_OFFSET 0x100
> +#define SSSCTL_OFFSET 0x160
> +/*
> +APCy_QLL_SSSCTL value:
> +SACDRCLEN=1
> +SSWEN=1
> +SSTRTEN=1
> +SSTPAPMSWEN=1
> +*/

Bad comment style and I have no idea what it means.

> +#define SSSCTL_VAL 0xF
> +
> +enum {
> +       APC_BASE,
> +       EFUSE_BASE,

Is this used? efuse should go through nvmem APIs.

> +       NUM_BASES
> +};
> +
> +static void __iomem *vbases[NUM_BASES];

Please just pass this to the function that uses it and drop EFUSE_BASE.

>  
>  static const u8 prim_pll_regs[PLL_OFF_MAX_REGS] = {
>         [PLL_OFF_L_VAL] = 0x04,
> @@ -399,10 +424,64 @@ struct clk_hw_clks {
>         return ret;
>  }
>  
> +#define CPU_AFINITY_MASK 0xFFF
> +#define PWRCL_CPU_REG_MASK 0x3
> +#define PERFCL_CPU_REG_MASK 0x103
> +
> +/* ACD static settings (HMSS HPG 7.2.2) */
> +#define L2ACDCR_REG 0x580ULL
> +#define L2ACDTD_REG 0x581ULL
> +#define L2ACDDVMRC_REG 0x584ULL
> +#define L2ACDSSCR_REG 0x589ULL
> +#define ACDTD_VAL 0x00006A11
> +#define ACDCR_VAL 0x002C5FFD
> +#define ACDSSCR_VAL 0x00000601
> +#define ACDDVMRC_VAL 0x000E0F0F

Please don't have #defines for random register settings. It just
obfuscates what's going on at the place where the define is used.

> +
> +static DEFINE_SPINLOCK(acd_lock);
> +
> +static void qcom_cpu_clk_msm8996_acd_init(void)
> +{
> +       u64 hwid;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&acd_lock, flags);
> +
> +       hwid = read_cpuid_mpidr() & CPU_AFINITY_MASK;
> +
> +       /* Program ACD Tunable-Length Delay (TLD) */
> +       set_l2_indirect_reg(L2ACDTD_REG, ACDTD_VAL);
> +       /* Initial ACD for *this* cluster */
> +       set_l2_indirect_reg(L2ACDDVMRC_REG, ACDDVMRC_VAL);
> +       /* Program ACD soft start control bits. */
> +       set_l2_indirect_reg(L2ACDSSCR_REG, ACDSSCR_VAL);

Please remove all useless comments, the code is obviously touching
registers.

> +
> +       if (PWRCL_CPU_REG_MASK == (hwid | PWRCL_CPU_REG_MASK)) {
> +               /* Enable Soft Stop/Start */

Sigh.

> +               if (vbases[APC_BASE])

When is this false?

> +                       writel_relaxed(SSSCTL_VAL, vbases[APC_BASE] +
> +                                       PWRCL_REG_OFFSET + SSSCTL_OFFSET);
> +               /* Ensure SSSCTL config goes through before enabling ACD. */
> +               mb();

Use writel instead.

> +               /* Program ACD control bits */
> +               set_l2_indirect_reg(L2ACDCR_REG, ACDCR_VAL);
> +       }
> +       if (PERFCL_CPU_REG_MASK == (hwid | PERFCL_CPU_REG_MASK)) { //else {

What is that '// else {' stuff?

> +               /* Program ACD control bits */
> +               set_l2_indirect_reg(L2ACDCR_REG, ACDCR_VAL);
> +               /* Enable Soft Stop/Start */
> +               if (vbases[APC_BASE])
> +                       writel_relaxed(SSSCTL_VAL, vbases[APC_BASE] +
> +                                       PERFCL_REG_OFFSET + SSSCTL_OFFSET);
> +               /* Ensure SSSCTL config goes through before enabling ACD. */
> +               mb();

Again, use writel.

> +       }
> +
> +       spin_unlock_irqrestore(&acd_lock, flags);
> +}
>  static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
>  {
>         int ret;
> -       void __iomem *base;
>         struct resource *res;
>         struct regmap *regmap_cpu;
>         struct clk_hw_clks *hws;
> @@ -415,17 +494,17 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
>         if (!data)
>                 return -ENOMEM;
>  
> -       hws = devm_kzalloc(dev, sizeof(*hws) + 2 * sizeof(struct clk_hw *),
> +       hws = devm_kzalloc(dev, sizeof(*hws) + 4 * sizeof(struct clk_hw *),
>                            GFP_KERNEL);
>         if (!hws)
>                 return -ENOMEM;
>  
>         res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -       base = devm_ioremap_resource(dev, res);
> -       if (IS_ERR(base))
> -               return PTR_ERR(base);
> +       vbases[APC_BASE] = devm_ioremap_resource(dev, res);
> +       if (IS_ERR(vbases[APC_BASE]))
> +               return PTR_ERR(vbases[APC_BASE]);
>  
> -       regmap_cpu = devm_regmap_init_mmio(dev, base,
> +       regmap_cpu = devm_regmap_init_mmio(dev, vbases[APC_BASE],
>                                            &cpu_msm8996_regmap_config);
>         if (IS_ERR(regmap_cpu))
>                 return PTR_ERR(regmap_cpu);

Cool, none of this diff is needed.

> @@ -433,6 +512,7 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
>         ret = qcom_cpu_clk_msm8996_register_clks(dev, hws, regmap_cpu);
>         if (ret)
>                 return ret;
> +       qcom_cpu_clk_msm8996_acd_init();

Pass base here.

>  
>         data->hws[0] = &pwrcl_pmux.clkr.hw;
>         data->hws[1] = &perfcl_pmux.clkr.hw;
