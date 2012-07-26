From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 26 Jul 2012 12:08:13 +0000
Subject: [PATCH 5/8 v2] ARM: EXYNOS5: Add PHY initialization code for usb
 2.0
In-Reply-To: <1342866729-30460-6-git-send-email-gautam.vivek@samsung.com>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
 <1342866729-30460-6-git-send-email-gautam.vivek@samsung.com>
Message-ID: <201207261208.13874.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 21 July 2012, Vivek Gautam wrote:
> This patch adds PHY setup functions usb 2.0 support on exynos5
> 
> Signed-off-by: Yulgon Kim <yulgon.kim@samsung.com>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                     |    1 +
>  arch/arm/mach-exynos/include/mach/regs-usb-phy.h |   86 ++++++++
>  arch/arm/mach-exynos/setup-usb-phy.c             |  232 +++++++++++++++++++++-
>  3 files changed, 311 insertions(+), 8 deletions(-)

This looks very much like a new device driver, not some code you can just stick
into platform code. We're trying hard to move driver code out of the platform
directories, so please don't add any new stuff for a driver and soc that doesn't
have to deal with legacy code.

>  
>  static int exynos4_usb_host_phy_is_on(void)
>  {
> -	return (readl(EXYNOS4_PHYPWR) & PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
> +	if (soc_is_exynos5250()) {
> +		return (readl(EXYNOS5_PHY_HOST_CTRL0) &
> +				HOST_CTRL0_PHYSWRSTALL) ? 0 : 1;
> +	} else {
> +		return (readl(EXYNOS4_PHYPWR) &
> +				PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
> +	}
> +}

Never hardcode register locations like this.
Also you clearly have two SoC that do different things here, so putting them
into the same function is a bit strange.

>  
>  static struct clk *exynos_usb_clock_enable(struct platform_device *pdev)
> @@ -31,7 +56,10 @@ static struct clk *exynos_usb_clock_enable(struct platform_device *pdev)
>  	struct clk *usb_clk = NULL;
>  	int err = 0;
>  
> -	usb_clk = clk_get(&pdev->dev, "otg");
> +	if (soc_is_exynos5250())
> +		usb_clk = clk_get(&pdev->dev, "usbhost");
> +	else
> +		usb_clk = clk_get(&pdev->dev, "otg");
>  	if (IS_ERR(usb_clk)) {
>  		dev_err(&pdev->dev, "Failed to get otg clock\n");
>  		return NULL;

Why do you have different names for the same clock on different SoCs?

If the clock has the same purpose, just give it the same name.

> @@ -50,7 +78,11 @@ static int exynos4210_usb_phy_clkset(struct platform_device *pdev)
>  	struct clk *xusbxti_clk;
>  	u32 phyclk = 0;
>  
> -	xusbxti_clk = clk_get(&pdev->dev, "xusbxti");
> +	if (soc_is_exynos5250())
> +		xusbxti_clk = clk_get(&pdev->dev, "ext_xtal");
> +	else
> +		xusbxti_clk = clk_get(&pdev->dev, "xusbxti");
> +
>  	if (xusbxti_clk && !IS_ERR(xusbxti_clk)) {
>  		if (soc_is_exynos4210()) {
>  			/* set clock frequency for PLL */

same here.

> @@ -218,8 +431,11 @@ int s5p_usb_phy_exit(struct platform_device *pdev, int type)
>  {
>  	if (type == S5P_USB_PHY_DEVICE)
>  		return exynos4210_usb_phy0_exit(pdev);
> -	else if (type == S5P_USB_PHY_HOST)
> -		return exynos4210_usb_phy1_exit(pdev);
> -
> +	else if (type == S5P_USB_PHY_HOST) {
> +		if (soc_is_exynos5250())
> +			return exynos5_usb_phy20_exit(pdev);
> +		else
> +			return exynos4210_usb_phy1_exit(pdev);
> +	}
>  	return -EINVAL;
>  }

You are doing completely different things here. None of these are actually
s5p, so better make these different functions for each soc.

If you have a driver that has some common code and some hardware specific
code, we generally structure the code so that the entry points are different
for the each kind of hardware and they call into common code from there.

This code is done in the opposite way and should be changed over time,
so please don't add to the mess.

	Arnd
