From: linux.amoon@gmail.com (Anand Moon)
Date: Wed, 22 Jul 2015 17:09:20 +0530
Subject: [PATCH] clk: s2mps11: Use kcalloc instead of kzalloc for array
 allocation
In-Reply-To: <1437557693-29433-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <1437557693-29433-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <CANAwSgSEUaSd9xM4deOO_=MabdknKCT148nXud7rWabzaXD9Bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vaibhav,

On 22 July 2015 at 15:04, Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
> This patch cleans up the driver for,
>
>   - Use devm_kcalloc varient instead of devm_kzalloc for array
>     allocation.
>   - clk_prepare/unprepare, remove "ret" variable as it is not required
>   - use __exit for cleanup function
>
> As I am referring this driver as a reference for my 88pm800 clk driver,
> applying same changes here as well.
>
> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> ---
> Since I do not have platform to test, it would be helpful if someone
> tests it for me.
> I have build tested it.
>
>  drivers/clk/clk-s2mps11.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
> index 9b13a30..e17c66a 100644
> --- a/drivers/clk/clk-s2mps11.c
> +++ b/drivers/clk/clk-s2mps11.c
> @@ -58,21 +58,17 @@ static struct s2mps11_clk *to_s2mps11_clk(struct clk_hw *hw)
>  static int s2mps11_clk_prepare(struct clk_hw *hw)
>  {
>         struct s2mps11_clk *s2mps11 = to_s2mps11_clk(hw);
> -       int ret;
>
> -       ret = regmap_update_bits(s2mps11->iodev->regmap_pmic,
> +       return regmap_update_bits(s2mps11->iodev->regmap_pmic,
>                                  s2mps11->reg,
>                                  s2mps11->mask, s2mps11->mask);
> -
> -       return ret;
>  }
>
>  static void s2mps11_clk_unprepare(struct clk_hw *hw)
>  {
>         struct s2mps11_clk *s2mps11 = to_s2mps11_clk(hw);
> -       int ret;
>
> -       ret = regmap_update_bits(s2mps11->iodev->regmap_pmic, s2mps11->reg,
> +       regmap_update_bits(s2mps11->iodev->regmap_pmic, s2mps11->reg,
>                            s2mps11->mask, ~s2mps11->mask);
>  }
>
> @@ -186,15 +182,15 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
>         struct clk_init_data *clks_init;
>         int i, ret = 0;
>
> -       s2mps11_clks = devm_kzalloc(&pdev->dev, sizeof(*s2mps11_clk) *
> -                                       S2MPS11_CLKS_NUM, GFP_KERNEL);
> +       s2mps11_clks = devm_kcalloc(&pdev->dev, S2MPS11_CLKS_NUM,
> +                               sizeof(*s2mps11_clk), GFP_KERNEL);
>         if (!s2mps11_clks)
>                 return -ENOMEM;
>
>         s2mps11_clk = s2mps11_clks;
>
> -       clk_table = devm_kzalloc(&pdev->dev, sizeof(struct clk *) *
> -                                S2MPS11_CLKS_NUM, GFP_KERNEL);
> +       clk_table = devm_kcalloc(&pdev->dev, S2MPS11_CLKS_NUM,
> +                               sizeof(struct clk *), GFP_KERNEL);
>         if (!clk_table)
>                 return -ENOMEM;
>
> @@ -322,7 +318,7 @@ static int __init s2mps11_clk_init(void)
>  }
>  subsys_initcall(s2mps11_clk_init);
>
> -static void __init s2mps11_clk_cleanup(void)
> +static void __exit s2mps11_clk_cleanup(void)
>  {
>         platform_driver_unregister(&s2mps11_clk_driver);
>  }
> --
> 1.9.1
>

Tested on Odroid-XU3 board.

Tested-by: Anand Moon <linux.amoon@gmail.com>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
