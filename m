From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 14 Mar 2013 00:45:03 +0300
Subject: [PATCH 2/7] ARM: shmobile: marzen: add USB EHCI driver support
In-Reply-To: <1352446306-19945-3-git-send-email-horms@verge.net.au>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-3-git-send-email-horms@verge.net.au>
Message-ID: <5140F35F.3090702@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/09/2012 10:31 AM, Simon Horman wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> This patch supports CN21/CN22 USB 2.0 (port 0/1/2),
> and enable USB momery on defconfig

    Sorry for late comment but I'm studying this code just now (in order 
to add R-Car M1A USB support).

> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>   arch/arm/configs/marzen_defconfig     |    6 ++
>   arch/arm/mach-shmobile/Kconfig        |    1 +
>   arch/arm/mach-shmobile/board-marzen.c |  108 ++++++++++++++++++++++++++++++++-
>   3 files changed, 114 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index 74c7f0b..707b3bd 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -34,6 +34,9 @@
[...]
> @@ -172,6 +175,101 @@ static struct platform_device *marzen_devices[] __initdata = {
>   	&usb_phy_device,
>   };
>   
> +/* USB */
> +static struct usb_phy *phy;
> +static int usb_power_on(struct platform_device *pdev)
> +{
> +	if (!phy)
> +		return -EIO;
> +
> +	pm_runtime_enable(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +
> +	usb_phy_init(phy);
> +
> +	return 0;
> +}
> +
> +static void usb_power_off(struct platform_device *pdev)
> +{
> +	if (!phy)
> +		return;
> +
> +	usb_phy_shutdown(phy);
> +
> +	pm_runtime_put_sync(&pdev->dev);
> +	pm_runtime_disable(&pdev->dev);
> +}
> +
> +static struct usb_ehci_pdata ehcix_pdata = {
> +	.power_on	= usb_power_on,
> +	.power_off	= usb_power_off,
> +	.power_suspend	= usb_power_off,
> +};
> +
> +static struct resource ehci0_resources[] = {
> +	[0] = {
> +		.start	= 0xffe70000,
> +		.end	= 0xffe70400 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= gic_spi(44),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device ehci0_device = {
> +	.name	= "ehci-platform",
> +	.id	= 0,
> +	.dev	= {
> +		.dma_mask		= &ehci0_device.dev.coherent_dma_mask,
> +		.coherent_dma_mask	= 0xffffffff,
> +		.platform_data		= &ehcix_pdata,
> +	},
> +	.num_resources	= ARRAY_SIZE(ehci0_resources),
> +	.resource	= ehci0_resources,
> +};
> +
> +static struct resource ehci1_resources[] = {
> +	[0] = {
> +		.start	= 0xfff70000,
> +		.end	= 0xfff70400 - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= gic_spi(45),
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device ehci1_device = {
> +	.name	= "ehci-platform",
> +	.id	= 1,
> +	.dev	= {
> +		.dma_mask		= &ehci1_device.dev.coherent_dma_mask,
> +		.coherent_dma_mask	= 0xffffffff,
> +		.platform_data		= &ehcix_pdata,
> +	},
> +	.num_resources	= ARRAY_SIZE(ehci1_resources),
> +	.resource	= ehci1_resources,
> +};
> +
> +static struct platform_device *marzen_late_devices[] __initdata = {
> +	&ehci0_device,
> +	&ehci1_device,
> +};
> +
> +void __init marzen_init_late(void)
> +{
> +	/* get usb phy */
> +	phy = usb_get_phy(USB_PHY_TYPE_USB2);
> +
> +	shmobile_init_late();
> +	platform_add_devices(marzen_late_devices,
> +			     ARRAY_SIZE(marzen_late_devices));
> +}
> +
>

    Morimoto-san, I don't understand why this SoC specific platform device
ended up in the board file? Could you explain your reasons please?
    I think this is generally a bad practice as this approach scales badly.

WVR, Sergei
