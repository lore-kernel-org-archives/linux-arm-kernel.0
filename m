From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 25 Apr 2016 18:29:35 -0700
Subject: [Patch v2 2/8] firmware: qcom: scm: Convert SCM to platform driver
In-Reply-To: <1461625725-32425-3-git-send-email-andy.gross@linaro.org>
References: <1461625725-32425-1-git-send-email-andy.gross@linaro.org>
 <1461625725-32425-3-git-send-email-andy.gross@linaro.org>
Message-ID: <20160426012935.GE29990@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/25, Andy Gross wrote:
> This patch converts the Qualcomm SCM firmware driver into a platform
> driver.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> ---
>  arch/arm64/Kconfig.platforms |   1 +
>  drivers/firmware/qcom_scm.c  | 163 ++++++++++++++++++++++++++++++++++++++++---
>  2 files changed, 155 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index efa77c1..6f0876f 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -76,6 +76,7 @@ config ARCH_MVEBU
>  config ARCH_QCOM
>  	bool "Qualcomm Platforms"
>  	select PINCTRL
> +	select QCOM_SCM

So far we've left this selection up to the consumer drivers of
the qcom_scm_*() APIs. Any reason why that's changing here? I
don't see mention in the commit text.

>  	help
>  	  This enables support for the ARMv8 based Qualcomm chipsets.
>  
> +
> +/**
> + * qcom_scm_is_available() - Checks if SCM is available
> + */
> +bool qcom_scm_is_available(void)
> +{
> +	return !!__scm;
> +}
> +EXPORT_SYMBOL(qcom_scm_is_available);

What's the planned user of this? If we need it can we bury it
inside the qcom_scm_*() functions?

> +
> +static int qcom_scm_probe(struct platform_device *pdev)
> +{
[...]
> +
> +	/* vote for max clk rate for highest performance */
> +	rate = clk_round_rate(scm->core_clk, INT_MAX);
> +	ret = clk_set_rate(scm->core_clk, rate);

You can just do clk_set_rate(scm->core_clk, INT_MAX) and it will
round internally for you and do the right thing. 

> +	if (ret)
> +		return ret;
> +
> +	__scm = scm;
> +	__scm->dev = &pdev->dev;
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id qcom_scm_dt_match[] = {
> +	{ .compatible = "qcom,scm-apq8064",},
> +	{ .compatible = "qcom,scm-apq8084",},
> +	{ .compatible = "qcom,scm-msm8916",},
> +	{ .compatible = "qcom,scm-msm8974",},
> +	{},

Nitpick: drop , here because it's always going to be the last
entry.

> +};
> +
> +MODULE_DEVICE_TABLE(of, qcom_scm_dt_match);
> +
> +static struct platform_driver qcom_scm_driver = {
> +	.driver = {
> +		.name	= "qcom_scm",
> +		.of_match_table = qcom_scm_dt_match,
> +	},
> +	.probe = qcom_scm_probe,
> +};
> +
> +builtin_platform_driver(qcom_scm_driver);
> +
> +static int __init qcom_scm_init(void)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_node_by_name(NULL, "firmware");
> +	if (!np)
> +		return -ENODEV;
> +
> +	return of_platform_populate(np, qcom_scm_dt_match, NULL, NULL);
> +

Weird newline and also we need an of_node_put() on the firmware
node at the end of this function.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
