From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 3 Jun 2016 17:03:43 -0700
Subject: [Patch v6 02/10] firmware: qcom: scm: Convert SCM to platform
 driver
In-Reply-To: <1464996330-16952-3-git-send-email-andy.gross@linaro.org>
References: <1464996330-16952-1-git-send-email-andy.gross@linaro.org>
 <1464996330-16952-3-git-send-email-andy.gross@linaro.org>
Message-ID: <20160604000343.GW28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/03, Andy Gross wrote:
> This patch converts the Qualcomm SCM firmware driver into a platform
> driver.  It also adds clock management for firmware calls which require
> clocks to be enabled during the duration of their execution.  Rate
> setting of the core clock is also in place for higher performance.
> 
> Signed-off-by: Andy Gross <andy.gross@linaro.org>
> Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

> +
> +static int __init qcom_scm_init(void)
> +{
> +	struct device_node *np, *fw_np;
> +	int ret;
> +
> +	fw_np = of_find_node_by_name(NULL, "firmware");
> +
> +	if (!fw_np)
> +		return -ENODEV;
> +
> +	np = of_find_matching_node(fw_np, qcom_scm_dt_match);
> +
> +	if (!np) {
> +		of_node_put(fw_np);
> +		return -ENODEV;
> +	}
> +
> +	of_node_put(np);
> +
> +	ret = of_platform_populate(fw_np, qcom_scm_dt_match, NULL, NULL);
> +
> +	of_node_put(fw_np);
> +
> +	if (ret)
> +		return ret;
> +
> +	return platform_driver_register(&qcom_scm_driver);
> +}

There are lots of newlines in this function, but that's a style nitpick.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
