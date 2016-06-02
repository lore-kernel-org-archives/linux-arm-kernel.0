From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 2 Jun 2016 15:14:24 -0700
Subject: [Patch v5 2/8] firmware: qcom: scm: Convert SCM to platform driver
In-Reply-To: <1463111221-6963-3-git-send-email-andy.gross@linaro.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-3-git-send-email-andy.gross@linaro.org>
Message-ID: <20160602221424.GM28218@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12, Andy Gross wrote:
> This patch converts the Qualcomm SCM firmware driver into a platform
> driver.

And introduces clk enable/disable + rate setting logic because
the firmware uses crypto clks during some scm calls.

> 
> +
> +static struct platform_driver qcom_scm_driver = {
> +	.driver = {
> +		.name	= "qcom_scm",
> +		.of_match_table = qcom_scm_dt_match,
> +	},
> +	.probe = qcom_scm_probe,
> +};
> +
> +static int __init qcom_scm_init(void)
> +{
> +	struct device_node *np, *parent;
> +	int ret;
> +
> +	np = of_find_matching_node_and_match(NULL, qcom_scm_dt_match, NULL);

Why can't we find a node called "firmware" in the root of the
tree? That would be clearer what's going on here, and avoid the
need to do the of_get_next_parent() dance, which just feels
awkward.

> +
> +	if (!np)
> +		return -ENODEV;
> +
> +	parent = of_get_next_parent(np);
> +	ret = of_platform_populate(parent, qcom_scm_dt_match, NULL, NULL);
> +
> +	of_node_put(parent);
> +
> +	if (ret)
> +		return ret;
> +
> +	return platform_driver_register(&qcom_scm_driver);
> +}

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
