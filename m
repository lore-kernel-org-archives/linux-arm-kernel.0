From: balbi@ti.com (Felipe Balbi)
Date: Thu, 28 Aug 2014 14:16:25 -0500
Subject: [PATCH 3/5] phy: exynos5-usbdrd: Add facility for VBUS-BOOST-5V
 supply
In-Reply-To: <1409212920-28526-4-git-send-email-gautam.vivek@samsung.com>
References: <1409212920-28526-1-git-send-email-gautam.vivek@samsung.com>
 <1409212920-28526-4-git-send-email-gautam.vivek@samsung.com>
Message-ID: <20140828191625.GQ16689@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi,

On Thu, Aug 28, 2014 at 01:31:58PM +0530, Vivek Gautam wrote:
> @@ -457,11 +458,19 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
>  	clk_prepare_enable(phy_drd->ref_clk);
>  
>  	/* Enable VBUS supply */
> +	if (phy_drd->vbus_boost) {
> +		ret = regulator_enable(phy_drd->vbus_boost);
> +		if (ret) {
> +			dev_err(phy_drd->dev,
> +				"Failed to enable VBUS boost supply\n");
> +			goto fail_vbus;
> +		}
> +	}

really this is nitpicking, but can you add a blank line here just make
my inner child happy ? :-)

> @@ -470,6 +479,9 @@ static int exynos5_usbdrd_phy_power_on(struct phy *phy)
>  
>  	return 0;
>  
> +fail_vbus_boost:
> +	if (phy_drd->vbus_boost)
> +		regulator_disable(phy_drd->vbus_boost);

same here

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140828/065ab536/attachment.sig>
