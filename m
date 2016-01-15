From: broonie@kernel.org (Mark Brown)
Date: Fri, 15 Jan 2016 17:57:57 +0000
Subject: [PATCH 1/2] regulator: act8945a: add regulator driver for ACT8945A
In-Reply-To: <1452218938-10621-2-git-send-email-wenyou.yang@atmel.com>
References: <1452218938-10621-1-git-send-email-wenyou.yang@atmel.com>
 <1452218938-10621-2-git-send-email-wenyou.yang@atmel.com>
Message-ID: <20160115175757.GA6588@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 10:08:57AM +0800, Wenyou Yang wrote:

> +	np = of_get_child_by_name(pdev->dev.of_node, "regulators");
> +	if (!np) {
> +		dev_err(&pdev->dev, "regulator node not found\n");
> +		return -EINVAL;
> +	}
> +
> +	matches = act8945a_matches;
> +	num_matches = ARRAY_SIZE(act8945a_matches);
> +
> +	ret = of_regulator_match(&pdev->dev, np, matches, num_matches);

Don't open code this, use the core regulators_node and of_match
implementation instead.

> +		dev_info(act8945a_dev->dev, "%s regulator registered\n",
> +			desc->name);

This is just noise, please remove it - let the core handle notifying
users.

> +static int __init act8945a_pmic_init(void)
> +{
> +	return platform_driver_register(&act8945a_pmic_driver);
> +}
> +subsys_initcall(act8945a_pmic_init);

Please use module_platform_driver() unless there is a strong reason to
do otherwise.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160115/9b93e624/attachment.sig>
