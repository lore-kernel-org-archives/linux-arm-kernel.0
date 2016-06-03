From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 2 Jun 2016 22:45:35 -0500
Subject: [Patch v5 2/8] firmware: qcom: scm: Convert SCM to platform driver
In-Reply-To: <20160602221424.GM28218@codeaurora.org>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-3-git-send-email-andy.gross@linaro.org>
 <20160602221424.GM28218@codeaurora.org>
Message-ID: <20160603034535.GA13357@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 02, 2016 at 03:14:24PM -0700, Stephen Boyd wrote:
> On 05/12, Andy Gross wrote:
> > This patch converts the Qualcomm SCM firmware driver into a platform
> > driver.
> 
> And introduces clk enable/disable + rate setting logic because
> the firmware uses crypto clks during some scm calls.

I'll make the commit message more descriptive of the change.

> > 
> > +
> > +static struct platform_driver qcom_scm_driver = {
> > +	.driver = {
> > +		.name	= "qcom_scm",
> > +		.of_match_table = qcom_scm_dt_match,
> > +	},
> > +	.probe = qcom_scm_probe,
> > +};
> > +
> > +static int __init qcom_scm_init(void)
> > +{
> > +	struct device_node *np, *parent;
> > +	int ret;
> > +
> > +	np = of_find_matching_node_and_match(NULL, qcom_scm_dt_match, NULL);
> 
> Why can't we find a node called "firmware" in the root of the
> tree? That would be clearer what's going on here, and avoid the
> need to do the of_get_next_parent() dance, which just feels
> awkward.

Well I had reworked it previously to avoid calling of_platform_populate on
anyone with a firmware node.  I guess what I can do is find the firmware node
and then only populate if I get a match starting from the firmware node itself.
That satisfies both comments.

> > +
> > +	if (!np)
> > +		return -ENODEV;
> > +
> > +	parent = of_get_next_parent(np);
> > +	ret = of_platform_populate(parent, qcom_scm_dt_match, NULL, NULL);
> > +
> > +	of_node_put(parent);
> > +
> > +	if (ret)
> > +		return ret;
> > +
> > +	return platform_driver_register(&qcom_scm_driver);
> > +}
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> a Linux Foundation Collaborative Project
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
