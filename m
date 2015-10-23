From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 23 Oct 2015 09:58:57 -0700
Subject: [PATCH v2] EDAC: Add ARM64 EDAC
In-Reply-To: <1445460097-10260-1-git-send-email-brijeshkumar.singh@amd.com>
References: <1445460097-10260-1-git-send-email-brijeshkumar.singh@amd.com>
Message-ID: <20151023165857.GD19782@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drive by nitpicks

On 10/21, Brijesh Singh wrote:
> diff --git a/drivers/edac/cortex_arm64_edac.c b/drivers/edac/cortex_arm64_edac.c
> new file mode 100644
> index 0000000..c37bb94
> --- /dev/null
> +++ b/drivers/edac/cortex_arm64_edac.c
> +
> +#define L1_CACHE		     0
> +#define L2_CACHE		     1
> +
> +int poll_msec = 100;

static?

> +
> +struct cortex_arm64_edac {
> +	struct edac_device_ctl_info *edac_ctl;
> +};
[..]
> +
> +static int cortex_arm64_edac_probe(struct platform_device *pdev)
> +{
> +	int rc;
> +	struct cortex_arm64_edac *drv;
> +	struct device *dev = &pdev->dev;
> +
> +	drv = devm_kzalloc(dev, sizeof(*drv), GFP_KERNEL);
> +	if (!drv)
> +		return -ENOMEM;
> +
> +	drv->edac_ctl = edac_device_alloc_ctl_info(0, "cpu",
> +						   num_possible_cpus(), "L", 2,
> +						   1, NULL, 0,
> +						   edac_device_alloc_index());
> +	if (IS_ERR(drv->edac_ctl))
> +		return -ENOMEM;
> +
> +	drv->edac_ctl->poll_msec = poll_msec;
> +	drv->edac_ctl->edac_check = arm64_monitor_cache_errors;
> +	drv->edac_ctl->dev = dev;
> +	drv->edac_ctl->mod_name = dev_name(dev);
> +	drv->edac_ctl->dev_name = dev_name(dev);
> +	drv->edac_ctl->ctl_name = "cpu_err";
> +	drv->edac_ctl->panic_on_ue = 1;
> +	platform_set_drvdata(pdev, drv);
> +
> +	rc = edac_device_add_device(drv->edac_ctl);
> +	if (rc)
> +		goto edac_alloc_failed;
> +
> +	return 0;
> +
> +edac_alloc_failed:
> +	edac_device_free_ctl_info(drv->edac_ctl);
> +	return rc;

Simplify to:

	rc = edac_device_add_device(...
	if (rc)
		edac_device_free_ctl_info(..

	return rc;

> +}
> +
> +
> +static const struct of_device_id cortex_arm64_edac_of_match[] = {
> +	{ .compatible = "arm,armv8-edac" },
> +	{},

Dropping the comma here is good style because it forces us to add
a comma if we were to add an element after the sentinel,
hopefully causing us to question why we're doing that in the
first place.

> +};
> +MODULE_DEVICE_TABLE(of, cortex_arm64_edac_of_match);
> +
> +static struct platform_driver cortex_arm64_edac_driver = {
> +	.probe = cortex_arm64_edac_probe,
> +	.remove = cortex_arm64_edac_remove,
> +	.driver = {
> +		.name = "arm64-edac",
> +		.owner = THIS_MODULE,

platform_driver_register() sets this so we can drop this
assignment here.

> +		.of_match_table = cortex_arm64_edac_of_match,
> +	},
> +};
> +
> +static int __init cortex_arm64_edac_init(void)
> +{
> +	int rc;
> +
> +	/* Only POLL mode is supported so far */
> +	edac_op_state = EDAC_OPSTATE_POLL;
> +
> +	rc = platform_driver_register(&cortex_arm64_edac_driver);
> +	if (rc) {
> +		edac_printk(KERN_ERR, EDAC_MOD_STR, "failed to register\n");
> +		return rc;
> +	}
> +
> +	return 0;

This could be simplified to

	rc = ...
	if (rc)
		edac_printk(...

	return rc;

Or even just 'return platform_driver_register()' and not care
about printing a message in that case because the end-user can't
do anything with the message anyway.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
