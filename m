From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Thu, 14 Mar 2013 01:20:33 +0300
Subject: [PATCH 1/7] ARM: shmobile: marzen: add USB phy support
In-Reply-To: <1352446306-19945-2-git-send-email-horms@verge.net.au>
References: <1352446306-19945-1-git-send-email-horms@verge.net.au>
 <1352446306-19945-2-git-send-email-horms@verge.net.au>
Message-ID: <5140FBB1.50401@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 11/09/2012 10:31 AM, Simon Horman wrote:

> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Signed-off-by: Simon Horman <horms@verge.net.au>
> ---
>   arch/arm/configs/marzen_defconfig     |    3 ++-
>   arch/arm/mach-shmobile/board-marzen.c |   21 +++++++++++++++++++++
>   2 files changed, 23 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
> index 69f7f46..74c7f0b 100644
> --- a/arch/arm/mach-shmobile/board-marzen.c
> +++ b/arch/arm/mach-shmobile/board-marzen.c
> @@ -144,11 +144,32 @@ static struct platform_device hspi_device = {
>   	.num_resources	= ARRAY_SIZE(hspi_resources),
>   };
>   
> +/* USB PHY */
> +static struct resource usb_phy_resources[] = {
> +	[0] = {
> +		.start		= 0xffe70000,

    Why not 0xffe70800? 0xffe70000 is where the EHCI registers start.
I don't see why they should be overlapped like this.

> +		.end		= 0xffe70900 - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start		= 0xfff70000,
> +		.end		= 0xfff70900 - 1,

    Hm, this PHY register range doesn't seem to be documented?

> +		.flags		= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device usb_phy_device = {
> +	.name		= "rcar_usb_phy",
> +	.resource	= usb_phy_resources,
> +	.num_resources	= ARRAY_SIZE(usb_phy_resources),
> +};
> +
>   static struct platform_device *marzen_devices[] __initdata = {
>   	&eth_device,
>   	&sdhi0_device,
>   	&thermal_device,
>   	&hspi_device,
> +	&usb_phy_device,
>   };
>   
>   static void __init marzen_init(void)

    Finally, the same question as for EHCI: why this ended up in the 
board file instead of setup-r8a7779.c?

WBR, Sergei
