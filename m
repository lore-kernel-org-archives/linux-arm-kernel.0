From: balbi@ti.com (Felipe Balbi)
Date: Thu, 26 Dec 2013 10:25:20 -0600
Subject: [PATCH v8 11/12] usb: phy-mxs: Add system suspend/resume API
In-Reply-To: <1387857536-4996-12-git-send-email-peter.chen@freescale.com>
References: <1387857536-4996-1-git-send-email-peter.chen@freescale.com>
 <1387857536-4996-12-git-send-email-peter.chen@freescale.com>
Message-ID: <20131226162520.GC3937@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 24, 2013 at 11:58:55AM +0800, Peter Chen wrote:
> @@ -398,6 +433,29 @@ static int mxs_phy_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static int mxs_phy_system_suspend(struct device *dev)
> +{
> +	struct mxs_phy *mxs_phy = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		mxs_phy_enable_ldo_in_suspend(mxs_phy, true);
> +
> +	return 0;
> +}
> +
> +static int mxs_phy_system_resume(struct device *dev)
> +{
> +	struct mxs_phy *mxs_phy = dev_get_drvdata(dev);
> +
> +	if (device_may_wakeup(dev))
> +		mxs_phy_enable_ldo_in_suspend(mxs_phy, false);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(mxs_phy_pm, mxs_phy_system_suspend,
> +		mxs_phy_system_resume);

this will give "Defined but not used" warnings when !PM_SLEEP.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131226/be7bcff9/attachment.sig>
