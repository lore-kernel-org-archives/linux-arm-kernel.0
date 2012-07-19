From: jangra.pankaj9@gmail.com (Pankaj Jangra)
Date: Thu, 19 Jul 2012 09:53:45 +0530
Subject: [PATCH 1/8] EXYNOS4: USB: Generalising setup-usb-phy driver for
 exynos
In-Reply-To: <1342619128-25013-2-git-send-email-gautam.vivek@samsung.com>
References: <1342619128-25013-1-git-send-email-gautam.vivek@samsung.com>
 <1342619128-25013-2-git-send-email-gautam.vivek@samsung.com>
Message-ID: <CADTbHxqFR2etsoqAQDU8UafpPwKFMsCRT1Vkrg8un52PYXnRbw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jul 18, 2012 at 7:15 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> This patch updates the setup-usb-phy in order to accomodate
> exynos5 support later.
>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
>
> diff --git a/arch/arm/mach-exynos/setup-usb-phy.c b/arch/arm/mach-exynos/setup-usb-phy.c
> index b81cc56..bfc1367 100644
> --- a/arch/arm/mach-exynos/setup-usb-phy.c
> +++ b/arch/arm/mach-exynos/setup-usb-phy.c
> @@ -26,10 +26,31 @@ static int exynos4_usb_host_phy_is_on(void)
>         return (readl(EXYNOS4_PHYPWR) & PHY1_STD_ANALOG_POWERDOWN) ? 0 : 1;
>  }
>
> -static void exynos4210_usb_phy_clkset(struct platform_device *pdev)
> +struct clk *exynos_usb_clock_enable(struct platform_device *pdev)

You might want to make it static struct clk * ?

> +{
> +       struct clk *usb_clk = NULL;
> +       int err = 0;
> +
> +       if (!usb_clk) {

What is the purpose of this condition check? usb_clk will always be
NULL here, right?

> +               usb_clk = clk_get(&pdev->dev, "otg");
> +               if (IS_ERR(usb_clk)) {
> +                       dev_err(&pdev->dev, "Failed to get otg clock\n");
> +                       return NULL;
> +               }

Regards,
Pankaj Jangra
