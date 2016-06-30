From: f.fainelli@gmail.com (Florian Fainelli)
Date: Thu, 30 Jun 2016 16:26:00 -0700
Subject: [PATCH 5/7] net: ethernet: bgmac: Add platform device support
In-Reply-To: <1467327554-22074-6-git-send-email-jon.mason@broadcom.com>
References: <1467327554-22074-1-git-send-email-jon.mason@broadcom.com>
 <1467327554-22074-6-git-send-email-jon.mason@broadcom.com>
Message-ID: <5775AA88.60800@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]

+
> +	return 0;
> +
> +err2:
> +	devm_iounmap(&pdev->dev, bgmac->plat.idm_base);
> +err1:
> +	devm_iounmap(&pdev->dev, bgmac->plat.base);
> +err:
> +	devm_kfree(&pdev->dev, bgmac);


This is not needed actually, now that you use the device managed helper
functions.

> +
> +	return rc;
> +}
> +
> +static int bgmac_remove(struct platform_device *pdev)
> +{
> +	struct bgmac *bgmac = platform_get_drvdata(pdev);
> +
> +	bgmac_enet_remove(bgmac);
> +	devm_iounmap(&pdev->dev, bgmac->plat.idm_base);
> +	devm_iounmap(&pdev->dev, bgmac->plat.base);
> +	devm_kfree(&pdev->dev, bgmac);

Same here.
-- 
Florian
