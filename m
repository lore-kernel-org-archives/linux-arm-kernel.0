From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Thu, 26 Jul 2018 22:25:55 +0530
Subject: [PATCH] clk: actions: Add custom delay option to Actions Semi
 OWL pll clock driver
In-Reply-To: <CADHB5bAztBFgWe-1v5vFfsxJgW1S3OOpV1Jkjrgk2h+pJBFw9w@mail.gmail.com>
References: <CADHB5bAztBFgWe-1v5vFfsxJgW1S3OOpV1Jkjrgk2h+pJBFw9w@mail.gmail.com>
Message-ID: <20180726165555.GB5220@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Edgar,

On Tue, Jul 17, 2018 at 02:02:00PM -0300, Edgar Bernardi Righi wrote:
> This patch adds custom delay support to Actions Semi OWL pll clock driver.
> It is required for future Actions Semi Owl series S500 SoC clock support
> 
> Currently, the driver waits a fixed amount of time defined by the
> macro PLL_STABILITY_WAIT_US.
> The default delay (50us) is not enough for Actions Semi Owl S500 SoC.
> It needs up to 150us.
> A new field called "delay" was added to "struct owl_pll_hw". The rest
> of the code was updated accordingly.
> Old macros "OWL_PLL_HW", "OWL_PLL" and "OWL_PLL_NO_PARENT" were kept
> (same usage), but updated to set "delay" value to
> PLL_STABILITY_WAIT_US (50us).
> New macros "OWL_PLL_HW_DELAY", "OWL_PLL_DELAY" and
> "OWL_PLL_NO_PARENT_DELAY" were created with an extra argument to set a
> custom "delay".
> This does not break S700 and S900 code and was tested on S500 based
> Lemaker Guitar Board.
> 
> Signed-off-by: Edgar Bernardi Righi <edgar.righi@lsitec.org.br>
> 
> diff -uprN -X vanilla/Documentation/dontdiff
> vanilla/drivers/clk/actions/owl-pll.c
> linux/drivers/clk/actions/owl-pll.c
> --- vanilla/drivers/clk/actions/owl-pll.c    2018-07-17 13:07:16.667704000 -0300
> +++ linux/drivers/clk/actions/owl-pll.c    2018-07-17 13:42:07.396785603 -0300
> @@ -179,7 +179,7 @@ static int owl_pll_set_rate(struct clk_h
> 
>      regmap_write(common->regmap, pll_hw->reg, reg);
> 
> -    udelay(PLL_STABILITY_WAIT_US);
> +    udelay(pll_hw->delay);
> 
>      return 0;
>  }
> diff -uprN -X vanilla/Documentation/dontdiff
> vanilla/drivers/clk/actions/owl-pll.h
> linux/drivers/clk/actions/owl-pll.h
> --- vanilla/drivers/clk/actions/owl-pll.h    2018-07-17 13:07:16.667704000 -0300
> +++ linux/drivers/clk/actions/owl-pll.h    2018-07-17 13:42:11.116765089 -0300
> @@ -27,6 +27,7 @@ struct owl_pll_hw {
>      u8            width;
>      u8            min_mul;
>      u8            max_mul;
> +    u32            delay;
>      const struct clk_pll_table *table;
>  };
> 
> @@ -35,6 +36,51 @@ struct owl_pll {
>      struct owl_clk_common    common;
>  };
> 
> +#define PLL_STABILITY_WAIT_US    (50)
> +

You don't need this here. Please see below.

> +#define OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,            \
> +           _width, _min_mul, _max_mul, _table, _delay)            \
> +    {                                \
> +        .reg        = _reg,                    \
> +        .bfreq        = _bfreq,                \
> +        .bit_idx    = _bit_idx,                \
> +        .shift        = _shift,                \
> +        .width        = _width,                \
> +        .min_mul    = _min_mul,                \
> +        .max_mul    = _max_mul,                \
> +        .table        = _table,                \
> +        .delay        = _delay,                \
> +    }
> +
> +#define OWL_PLL_DELAY(_struct, _name, _parent, _reg, _bfreq, _bit_idx,    \
> +        _shift, _width, _min_mul, _max_mul, _table, _flags, _delay)    \
> +    struct owl_pll _struct = {                    \
> +        .pll_hw    = OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,    \
> +                     _width, _min_mul,            \
> +                     _max_mul, _table, _delay),            \
> +        .common = {                        \
> +            .regmap = NULL,                    \
> +            .hw.init = CLK_HW_INIT(_name,            \
> +                           _parent,            \
> +                           &owl_pll_ops,        \
> +                           _flags),            \
> +        },                            \
> +    }
> +
> +#define OWL_PLL_NO_PARENT_DELAY(_struct, _name, _reg, _bfreq, _bit_idx,    \
> +        _shift, _width, _min_mul, _max_mul, _table, _flags, _delay)    \
> +    struct owl_pll _struct = {                    \
> +        .pll_hw    = OWL_PLL_HW_DELAY(_reg, _bfreq, _bit_idx, _shift,    \
> +                     _width, _min_mul,            \
> +                     _max_mul, _table, _delay),            \
> +        .common = {                        \
> +            .regmap = NULL,                    \
> +            .hw.init = CLK_HW_INIT_NO_PARENT(_name,        \
> +                           &owl_pll_ops,        \
> +                           _flags),            \
> +        },                            \
> +    }
> +

No need to have DELAY and non DELAY defines. You can just add delay
as a parameter to the OWL_PLL_NO_PARENT and OWL_PLL defines for the
whole Owl family. Then use the corresponding delays in board specific
owl-sx00.c file.

>  #define OWL_PLL_HW(_reg, _bfreq, _bit_idx, _shift,            \
>             _width, _min_mul, _max_mul, _table)            \
>      {                                \
> @@ -46,6 +92,7 @@ struct owl_pll {
>          .min_mul    = _min_mul,                \
>          .max_mul    = _max_mul,                \
>          .table        = _table,                \
> +        .delay        = PLL_STABILITY_WAIT_US,\

As said above, delay should come from board specific file. No need to
worry about touching the S900/S700 part. As long as your change not breaking
the functionality, it is fine.

Thanks,
Mani

>      }
> 
>  #define OWL_PLL(_struct, _name, _parent, _reg, _bfreq, _bit_idx,    \
> @@ -78,7 +125,6 @@ struct owl_pll {
>      }
> 
>  #define mul_mask(m)        ((1 << ((m)->width)) - 1)
> -#define PLL_STABILITY_WAIT_US    (50)
> 
>  static inline struct owl_pll *hw_to_owl_pll(const struct clk_hw *hw)
>  {
