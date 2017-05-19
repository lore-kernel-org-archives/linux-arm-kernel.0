From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 May 2017 18:51:37 -0700
Subject: [PATCH v2 1/2] clk: Hi3660: change to register crgctrl clock
 with CLK_OF_DECLARE_DRIVER
In-Reply-To: <1495072247-25217-2-git-send-email-leo.yan@linaro.org>
References: <1495072247-25217-1-git-send-email-leo.yan@linaro.org>
 <1495072247-25217-2-git-send-email-leo.yan@linaro.org>
Message-ID: <20170519015137.GE20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/18, Leo Yan wrote:
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

I'm slightly confused. CLK_OF_DECLARE_DRIVER is for when a
platform driver _and_ CLK_OF_DELARE need to "probe" the same
device node. But in this patch, the compatible string is being
deleted from the driver's match table. Also, are all the
registered in hi3660_clk_crgctrl_init() actually needed for the
timer? If only a subset, then I would expect to split the code
and have the CLK_OF_DECLARE_DRIVER() path register just the clks
that matter for the timer, and then leave the rest of the clks to
be registered by the probe of the platform driver.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
