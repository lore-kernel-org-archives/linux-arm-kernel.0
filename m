From: LW@KARO-electronics.de (=?iso-8859-15?Q?Lothar_Wa=DFmann?=)
Date: Wed, 17 Mar 2010 08:52:56 +0100
Subject: [PATCH] ep93xx/core.c: remove redundant static variable
In-Reply-To: <0D753D10438DA54287A00B0270842697636858C6FE@AUSP01VMBX24.collaborationhost.net>
References: <0D753D10438DA54287A00B02708426976368534061@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B0270842697636858C6FE@AUSP01VMBX24.collaborationhost.net>
Message-ID: <19360.35416.358644.406403@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> Use the pointer to the passed board support data directly instead of 
> copying it to local static variables.
> 
> This updates the ethernet, i2c, and framebuffer devices.
> 
> While here, also document the functions used to register the devices.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> V2: spotted a couple others in addition to the ethernet device.
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 90fb591..5f5bc6d 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -330,8 +330,10 @@ static struct platform_device ep93xx_ohci_device = {
>  	.resource	= ep93xx_ohci_resources,
>  };
>  
> -static struct ep93xx_eth_data ep93xx_eth_data;
>  
> +/*************************************************************************
> + * EP93xx ethernet peripheral handling
> + *************************************************************************/
>  static struct resource ep93xx_eth_resource[] = {
>  	{
>  		.start	= EP93XX_ETHERNET_PHYS_BASE,
> @@ -347,19 +349,22 @@ static struct resource ep93xx_eth_resource[] = {
>  static struct platform_device ep93xx_eth_device = {
>  	.name		= "ep93xx-eth",
>  	.id		= -1,
> -	.dev		= {
> -		.platform_data	= &ep93xx_eth_data,
> -	},
>  	.num_resources	= ARRAY_SIZE(ep93xx_eth_resource),
>  	.resource	= ep93xx_eth_resource,
>  };
>  
> +/**
> + * ep93xx_register_eth - Register the built-in ethernet platform device.
> + * @data:	platform specific ethernet configuration
> + * @copy_addr:	flag indicating that the MAC address should be copied
> + *		from the IndAd registers (as programmed by the bootloader)
> + */
>  void __init ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr)
>  {
>  	if (copy_addr)
>  		memcpy_fromio(data->dev_addr, EP93XX_ETHERNET_BASE + 0x50, 6);
>  
> -	ep93xx_eth_data = *data;
> +	ep93xx_eth_device.dev.platform_data = data;
>  	platform_device_register(&ep93xx_eth_device);
>  }
>
I don't think this is a good idea.
In a multi platform kernel each platform that could potentially
register the device needs to have the platform_data lying around in
memory even if it's never used.

In the old way the platforms could have the platform_data that is
passed to the ep93xx_register_eth() function marked as __initdata and
only one copy that is actually used would be kept.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
