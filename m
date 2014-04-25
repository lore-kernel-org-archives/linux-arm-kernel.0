From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 25 Apr 2014 10:41:50 -0400 (EDT)
Subject: [PATCH v8 2/2] usb: ehci-exynos: Change to use phy provided by
 the generic phy framework
In-Reply-To: <1398424873-20257-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <Pine.LNX.4.44L0.1404251039210.1140-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 25 Apr 2014, Vivek Gautam wrote:

> From: Kamil Debski <k.debski@samsung.com>
> 
> Add the phy provider, supplied by new Exynos-usb2phy using
> Generic phy framework.
> Keeping the support for older USB phy intact right now, in order
> to prevent any functionality break in absence of relevant
> device tree side change for ehci-exynos.
> Once we move to new phy in the device nodes for ehci, we can
> remove the support for older phys.
> 
> Signed-off-by: Kamil Debski <k.debski@samsung.com>
> [gautam.vivek at samsung.com: Addressed review comments from mailing list]
> [gautam.vivek at samsung.com: Kept the code for old usb-phy, and just
> added support for new exynos5-usb2phy in generic phy framework]
> [gautam.vivek at samsung.com: Edited the commit message]
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>

> +static int exynos_ehci_phyg_off(struct phy *phy[])
> +{
> +	int i;
> +	int ret = 0;
> +
> +	for (i = 0; ret == 0 && i < PHY_NUMBER; i++)
> +		if (phy[i])
> +			ret = phy_power_off(phy[i]);
> +
> +	return ret;
> +}

Same comment as in the OHCI driver about ret.

> @@ -175,6 +269,7 @@ skip_phy:
>  fail_add_hcd:
>  	if (exynos_ehci->phy)
>  		usb_phy_shutdown(exynos_ehci->phy);
> +	exynos_ehci_phyg_off(exynos_ehci->phy_g);
>  fail_io:
>  	clk_disable_unprepare(exynos_ehci->clk);
>  fail_clk:
> @@ -195,6 +290,8 @@ static int exynos_ehci_remove(struct platform_device *pdev)
>  	if (exynos_ehci->phy)
>  		usb_phy_shutdown(exynos_ehci->phy);
>  
> +	exynos_ehci_phyg_off(exynos_ehci->phy_g);
> +

In both these places, you need to test exynos_ehci->phyg before calling 
exynos_ehci_phyg_off().

Maybe it would help to add exynos_ehci_phy_enable/disable routines, 
like in the OHCI driver.

Alan Stern
