From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 18 May 2017 11:32:26 +0200
Subject: [PATCH v2 1/2] clk: Hi3660: change to register crgctrl clock
 with CLK_OF_DECLARE_DRIVER
In-Reply-To: <1495072247-25217-2-git-send-email-leo.yan@linaro.org>
References: <1495072247-25217-1-git-send-email-leo.yan@linaro.org>
 <1495072247-25217-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20170518093226.GA2125@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 18, 2017 at 09:50:46AM +0800, Leo Yan wrote:
> The timer will register into system at very early phase at kernel boot;
> if timer needs to use clock, the clock should be get ready in function
> of_clk_init() so later the timer driver probe can retrieve clock
> successfully. This is finished in below flow on arm64:
> 
>   start_kernel()
>     `-> time_init()
>           `-> of_clk_init(NULL)    => register timer's clock
>           `-> clocksource_probe()  => register timer
> 
> On Hi3660 the sp804 timer uses clock "osc32k", this clock is registered
> as platform driver rather than CLK_OF_DECLARE_DRIVER method. As result,
> sp804 timer probe returns failure due if cannot bind clock properly.
> To fix the failure, this patch is to change crgctrl clock registration
> from platform driver to CLK_OF_DECLARE_DRIVER method so the clocks can
> be registered ahead with function of_clk_init() and then timer driver
> can use it.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  drivers/clk/hisilicon/clk-hi3660.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/hisilicon/clk-hi3660.c b/drivers/clk/hisilicon/clk-hi3660.c
> index fd5ce7f..4e5713b 100644
> --- a/drivers/clk/hisilicon/clk-hi3660.c
> +++ b/drivers/clk/hisilicon/clk-hi3660.c
> @@ -547,10 +547,10 @@ static void hi3660_clk_crgctrl_init(struct device_node *np)
>  				  ARRAY_SIZE(hi3660_crgctrl_divider_clks),
>  				  clk_data);
>  }
> +CLK_OF_DECLARE_DRIVER(hi3660_clk_crgctrl, "hisilicon,hi3660-crgctrl",
> +		      hi3660_clk_crgctrl_init);
>  
>  static const struct of_device_id hi3660_clk_match_table[] = {
> -	{ .compatible = "hisilicon,hi3660-crgctrl",
> -	  .data = hi3660_clk_crgctrl_init },
>  	{ .compatible = "hisilicon,hi3660-pctrl",
>  	  .data = hi3660_clk_pctrl_init },
>  	{ .compatible = "hisilicon,hi3660-pmuctrl",

Why not do the change for all the clocks and remove the
hi3660_clk_match_table[]? and all the related platform driver code?

That will be consistent with the other clk-hi* drivers.

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
