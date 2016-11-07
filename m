From: radoslaw.pietrzyk@gmail.com (=?UTF-8?Q?Rados=C5=82aw_Pietrzyk?=)
Date: Mon, 7 Nov 2016 15:57:05 +0100
Subject: [PATCH 1/6] clk: stm32f4: Add PLL_I2S & PLL_SAI for STM32F429/469
 boards
In-Reply-To: <1478523943-23142-2-git-send-email-gabriel.fernandez@st.com>
References: <1478523943-23142-1-git-send-email-gabriel.fernandez@st.com>
 <1478523943-23142-2-git-send-email-gabriel.fernandez@st.com>
Message-ID: <CAFvLkMQxvo=2Ak033n2XkPgdDfU5DLCMF7dj487QFB0e7WceCQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +static struct clk_hw *clk_register_pll_div(const char *name,
> +               const char *parent_name, unsigned long flags,
> +               void __iomem *reg, u8 shift, u8 width,
> +               u8 clk_divider_flags, const struct clk_div_table *table,
> +               struct clk_hw *pll_hw, spinlock_t *lock)
> +{
> +       struct stm32f4_pll_div *pll_div;
> +       struct clk_hw *hw;
> +       struct clk_init_data init;
> +       int ret;
> +
> +       /* allocate the divider */
> +       pll_div = kzalloc(sizeof(*pll_div), GFP_KERNEL);
> +       if (!pll_div)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = name;
> +       init.ops = &stm32f4_pll_div_ops;
> +       init.flags = flags;
Maybe it's worth to have CLK_SET_RATE_PARENT here and the VCO clock
should have CLK_SET_RATE_GATE flag and we can get rid of custom
divider ops.


> -static void stm32f4_rcc_register_pll(const char *hse_clk, const char *hsi_clk)
> +
> +static struct clk_hw *stm32f4_rcc_register_pll(const char *pllsrc,
> +               const struct stm32f4_pll_data *data,  spinlock_t *lock)
>  {
> -       unsigned long pllcfgr = readl(base + STM32F4_RCC_PLLCFGR);
> +       struct stm32f4_pll *pll;
> +       struct clk_init_data init = { NULL };
> +       void __iomem *reg;
> +       struct clk_hw *pll_hw;
> +       int ret;
> +
> +       pll = kzalloc(sizeof(*pll), GFP_KERNEL);
> +       if (!pll)
> +               return ERR_PTR(-ENOMEM);
> +
> +       init.name = data->vco_name;
> +       init.ops = &stm32f4_pll_gate_ops;
> +       init.flags = CLK_IGNORE_UNUSED;
CLK_SET_RATE_GATE here

Moreover why not having VCO as a composite clock from gate and mult ?

According to docs SAI VCO (don't know about I2S ) must be within
certain range so clk_set_rate_range should be somewhere.
