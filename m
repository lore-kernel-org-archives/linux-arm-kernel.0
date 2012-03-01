From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 1 Mar 2012 11:17:45 +0000
Subject: [PATCH v5 2/2] Regulator: Add Anatop regulator driver
In-Reply-To: <1330593052-15184-2-git-send-email-paul.liu@linaro.org>
References: <1328734286-30091-1-git-send-email-paul.liu@linaro.org>
 <1330593052-15184-1-git-send-email-paul.liu@linaro.org>
 <1330593052-15184-2-git-send-email-paul.liu@linaro.org>
Message-ID: <20120301111744.GC3124@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 01, 2012 at 05:10:52PM +0800, Ying-Chun Liu (PaulLiu) wrote:

> +	if (IS_ERR(rdev)) {
> +		dev_err(&pdev->dev, "failed to register %s\n",
> +			rdesc->name);
> +		kfree(rdesc->name);
> +		return PTR_ERR(rdev);
> +	}
> +
> +	return 0;
> +}
> +
> +int anatop_regulator_remove(struct platform_device *pdev)
> +{
> +	struct regulator_dev *rdev = platform_get_drvdata(pdev);
> +	regulator_unregister(rdev);
> +	return 0;

Looks mostly good but this leaks rdesc->name which was allocated with
kstrdup() in the probe() function.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120301/dbd214a6/attachment.sig>
