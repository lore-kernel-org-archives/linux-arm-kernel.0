From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 16:56:48 -0700
Subject: [PATCH v13 8/8] clk: qcom: Add ACD path to CPU clock driver for
 msm8996
In-Reply-To: <20180614215358.11264-9-ilia.lin@gmail.com>
References: <20180614215358.11264-1-ilia.lin@gmail.com>
 <20180614215358.11264-9-ilia.lin@gmail.com>
Message-ID: <153973420806.5275.356235896596182005@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting ilia.lin at gmail.com (2018-06-14 14:53:55)
> @@ -176,6 +183,9 @@ static struct clk_alpha_pll pwrcl_alt_pll = {
>         },
>  };
>  
> +void __iomem *base;
> +static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base);
> +

Why are we doing this?

> @@ -393,6 +404,10 @@ qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct regmap *regmap)
>         clk_alpha_pll_configure(&perfcl_alt_pll, regmap, &altpll_config);
>         clk_alpha_pll_configure(&pwrcl_alt_pll, regmap, &altpll_config);
>  
> +       /* Enable alt PLLs */
> +       clk_prepare_enable(pwrcl_alt_pll.clkr.hw.clk);
> +       clk_prepare_enable(perfcl_alt_pll.clkr.hw.clk);

Are the alt PLLs CLK_IS_CRITICAL?

> +
>         ret = clk_notifier_register(pwrcl_pmux.clkr.hw.clk, &pwrcl_pmux.nb);
>         if (ret)
>                 return ret;
> @@ -402,10 +417,48 @@ qcom_cpu_clk_msm8996_register_clks(struct device *dev, struct regmap *regmap)
>         return ret;
>  }
>  
> +#define CPU_AFINITY_MASK 0xFFF
> +#define PWRCL_CPU_REG_MASK 0x3
> +#define PERFCL_CPU_REG_MASK 0x103
> +
> +#define L2ACDCR_REG 0x580ULL
> +#define L2ACDTD_REG 0x581ULL
> +#define L2ACDDVMRC_REG 0x584ULL
> +#define L2ACDSSCR_REG 0x589ULL
> +
> +static DEFINE_SPINLOCK(acd_lock);
> +
> +static void qcom_cpu_clk_msm8996_acd_init(void __iomem *base)
> +{
> +       u64 hwid;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&acd_lock, flags);
> +
> +       hwid = read_cpuid_mpidr() & CPU_AFINITY_MASK;
> +
> +       kryo_l2_set_indirect_reg(L2ACDTD_REG, 0x00006A11);
> +       kryo_l2_set_indirect_reg(L2ACDDVMRC_REG, 0x000E0F0F);
> +       kryo_l2_set_indirect_reg(L2ACDSSCR_REG, 0x00000601);
> +
> +       if (PWRCL_CPU_REG_MASK == (hwid | PWRCL_CPU_REG_MASK)) {
> +               writel(0xF, base + PWRCL_REG_OFFSET + SSSCTL_OFFSET);
> +               wmb();
> +               kryo_l2_set_indirect_reg(L2ACDCR_REG, 0x002C5FFD);
> +       }
> +
> +       if (PERFCL_CPU_REG_MASK == (hwid | PERFCL_CPU_REG_MASK)) {
> +               kryo_l2_set_indirect_reg(L2ACDCR_REG, 0x002C5FFD);
> +               writel(0xF, base + PERFCL_REG_OFFSET + SSSCTL_OFFSET);
> +               wmb();

Please add comments to the barriers here so we know what they're doing.
I guess the first one is ordering writel with the indirect register
access, but the other one I don't know what it's doing.

> +       }
> +
> +       spin_unlock_irqrestore(&acd_lock, flags);
> +}
> +
>  static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
>  {
>         int ret;
> -       void __iomem *base;

Ok but still, why?

>         struct resource *res;
>         struct regmap *regmap;
>         struct clk_hw_onecell_data *data;
> @@ -429,6 +482,8 @@ static int qcom_cpu_clk_msm8996_driver_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>  
> +       qcom_cpu_clk_msm8996_acd_init(base);
> +
>         data->hws[0] = &pwrcl_pmux.clkr.hw;
>         data->hws[1] = &perfcl_pmux.clkr.hw;
>         data->num = 2;
> -- 
> 2.11.0
> 
