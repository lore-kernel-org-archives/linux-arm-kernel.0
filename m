From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 20 May 2015 15:25:55 -0700
Subject: [PATCH v7 6/7] clk: hi6220: Clock driver support for Hisilicon
 hi6220 SoC
In-Reply-To: <1432117752-7074-2-git-send-email-bintian.wang@huawei.com>
References: <1432117752-7074-1-git-send-email-bintian.wang@huawei.com>
 <1432117752-7074-2-git-send-email-bintian.wang@huawei.com>
Message-ID: <555D09F3.7020506@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/20/15 03:29, Bintian Wang wrote:
> Add clock drivers for hi6220 SoC, this driver controls the SoC
> registers to supply different clocks to different IPs in the SoC.
>
> We add one divider clock for hi6220 because the divider in hi6220
> also has a mask bit but it doesnot obey the rule defined by flag
> "CLK_DIVIDER_HIWORD_MASK", we can not get index of the mask bit by
> left shift fixed bits (e.g. 16 bits), so we add this divider clock
> to handle it.
>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> Signed-off-by: Bintian Wang <bintian.wang@huawei.com>
> Acked-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> Reviewed-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Will Deacon <will.deacon@arm.com>
> Tested-by: Tyler Baker <tyler.baker@linaro.org>
> ---
>  drivers/clk/Kconfig                       |    2 +
>  drivers/clk/Makefile                      |    4 +-
>  drivers/clk/hisilicon/Kconfig             |    6 +
>  drivers/clk/hisilicon/Makefile            |    3 +-
>  drivers/clk/hisilicon/clk-hi6220.c        |  291 +++++++++++++++++++++++++++++
>  drivers/clk/hisilicon/clk.c               |   29 +++
>  drivers/clk/hisilicon/clk.h               |   17 ++
>  drivers/clk/hisilicon/clkdivider-hi6220.c |  156 ++++++++++++++++
>  include/dt-bindings/clock/hi6220-clock.h  |  173 +++++++++++++++++
>  9 files changed, 677 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/clk/hisilicon/Kconfig
>  create mode 100644 drivers/clk/hisilicon/clk-hi6220.c
>  create mode 100644 drivers/clk/hisilicon/clkdivider-hi6220.c
>  create mode 100644 include/dt-bindings/clock/hi6220-clock.h
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 9897f35..18bb930 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -150,6 +150,8 @@ config COMMON_CLK_CDCE706
>  	---help---
>  	  This driver supports TI CDCE706 programmable 3-PLL clock synthesizer.
>  
> +source "drivers/clk/hisilicon/Kconfig"
> +
>  source "drivers/clk/qcom/Kconfig"
>  

There's going to be a merge conflict here if this doesn't go through the
clk tree.

>
> +
> +static void __init hi6220_clk_sys_init(struct device_node *np)
> +{
> +	struct hisi_clock_data *clk_data;
> +
> +	clk_data = hisi_clk_init(np, HI6220_SYS_NR_CLKS);
> +	if (!clk_data)
> +		return;
> +
> +	hisi_clk_register_gate_sep(hi6220_separated_gate_clks_sys,
> +			ARRAY_SIZE(hi6220_separated_gate_clks_sys), clk_data);
> +
> +	hisi_clk_register_mux(hi6220_mux_clks_sys,
> +			ARRAY_SIZE(hi6220_mux_clks_sys), clk_data);
> +
> +	hi6220_clk_register_divider(hi6220_div_clks_sys,
> +			ARRAY_SIZE(hi6220_div_clks_sys), clk_data);
> +
> +	if (!clk_data_ao)
> +		return;
> +
> +	/* enable high speed clock on UART1 mux */
> +	clk_set_parent(clk_data->clk_data.clks[HI6220_UART1_SRC],
> +			clk_data_ao->clk_data.clks[HI6220_150M]);

Sorry I missed this one earlier. Can we do this clk_set_parent() through
assigned-parents instead? I expected an #include <linux/clk.h> for the
usage of clk_set_parent() here so I didn't look hard to see if consumer
APIs were being used.

Otherwise the patch looks fine.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
