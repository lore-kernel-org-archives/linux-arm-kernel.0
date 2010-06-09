From: ryan@bluewatersys.com (Ryan Mallon)
Date: Thu, 10 Jun 2010 08:59:07 +1200
Subject: [PATCH v3] ep93xx: move physmap flash registration into core.c
In-Reply-To: <0D753D10438DA54287A00B02708426976370F421F7@AUSP01VMBX24.collaborationhost.net>
References: <AcrcNxXi/1OpCfUUTQ2+Xkz9P4CSMQ==>	<0D753D10438DA54287A00B0270842697636D62B066@AUSP01VMBX24.collaborationhost.net>	<t2h56d259a01004200333gfc5b6307vb34c20e60db28aa1@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636F3238EC@AUSP01VMBX24.collaborationhost.net>
	<0D753D10438DA54287A00B02708426976370F421F7@AUSP01VMBX24.collaborationhost.net>
Message-ID: <4C10009B.2010607@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

H Hartley Sweeten wrote:
> Create a core.c __init function to handle the physmap flash
> registration for all the ep93xx platforms.  Also, modify all
> the ep93xx platforms to use this new function.
> 
> This simplifies all the ep93xx platform init code and removes
> all the static variables that would exist in a unified kernel
> supporting multiple ep93xx platforms.

Looks fine. Not sure I understand the second part about the unified
kernel though. Can't we already build all ep93xx boards (at least those
at the same phys offset) into one kernel?

~Ryan

> Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
> Cc: Ryan Mallon <ryan@bluewatersys.com>
> Acked-by: Martin Guy <martinwguy@gmail.com>
> 
> ---
> 
> v3 - Rebased to 2.6.35-rc2
> 
>  arch/arm/mach-ep93xx/adssphere.c             |   24 +---------------
>  arch/arm/mach-ep93xx/core.c                  |   38 ++++++++++++++++++++++++++
>  arch/arm/mach-ep93xx/edb93xx.c               |   31 +-------------------
>  arch/arm/mach-ep93xx/gesbc9312.c             |   24 +---------------
>  arch/arm/mach-ep93xx/include/mach/platform.h |    3 ++
>  arch/arm/mach-ep93xx/micro9.c                |   37 ++++++-------------------
>  arch/arm/mach-ep93xx/simone.c                |   24 +---------------
>  arch/arm/mach-ep93xx/ts72xx.c                |   27 +++---------------
>  8 files changed, 59 insertions(+), 149 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/adssphere.c b/arch/arm/mach-ep93xx/adssphere.c
> index 3a1a855..f744f67 100644
> --- a/arch/arm/mach-ep93xx/adssphere.c
> +++ b/arch/arm/mach-ep93xx/adssphere.c
> @@ -13,7 +13,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/mtd/physmap.h>
>  
>  #include <mach/hardware.h>
>  
> @@ -21,26 +20,6 @@
>  #include <asm/mach/arch.h>
>  
>  
> -static struct physmap_flash_data adssphere_flash_data = {
> -	.width		= 4,
> -};
> -
> -static struct resource adssphere_flash_resource = {
> -	.start		= EP93XX_CS6_PHYS_BASE,
> -	.end		= EP93XX_CS6_PHYS_BASE + SZ_32M - 1,
> -	.flags		= IORESOURCE_MEM,
> -};
> -
> -static struct platform_device adssphere_flash = {
> -	.name		= "physmap-flash",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &adssphere_flash_data,
> -	},
> -	.num_resources	= 1,
> -	.resource	= &adssphere_flash_resource,
> -};
> -
>  static struct ep93xx_eth_data __initdata adssphere_eth_data = {
>  	.phy_id		= 1,
>  };
> @@ -48,8 +27,7 @@ static struct ep93xx_eth_data __initdata adssphere_eth_data = {
>  static void __init adssphere_init_machine(void)
>  {
>  	ep93xx_init_devices();
> -	platform_device_register(&adssphere_flash);
> -
> +	ep93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_32M);
>  	ep93xx_register_eth(&adssphere_eth_data, 1);
>  }
>  
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index 9092677..b87c85f 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -29,6 +29,7 @@
>  #include <linux/termios.h>
>  #include <linux/amba/bus.h>
>  #include <linux/amba/serial.h>
> +#include <linux/mtd/physmap.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-gpio.h>
>  #include <linux/spi/spi.h>
> @@ -348,6 +349,43 @@ static struct platform_device ep93xx_ohci_device = {
>  
>  
>  /*************************************************************************
> + * EP93xx physmap'ed flash
> + *************************************************************************/
> +static struct physmap_flash_data ep93xx_flash_data;
> +
> +static struct resource ep93xx_flash_resource = {
> +	.flags		= IORESOURCE_MEM,
> +};
> +
> +static struct platform_device ep93xx_flash = {
> +	.name		= "physmap-flash",
> +	.id		= 0,
> +	.dev		= {
> +		.platform_data	= &ep93xx_flash_data,
> +	},
> +	.num_resources	= 1,
> +	.resource	= &ep93xx_flash_resource,
> +};
> +
> +/**
> + * ep93xx_register_flash() - Register the external flash device.
> + * @width:	bank width in octets
> + * @start:	resource start address
> + * @size:	resource size
> + */
> +void __init ep93xx_register_flash(unsigned int width,
> +				  resource_size_t start, resource_size_t size)
> +{
> +	ep93xx_flash_data.width		= width;
> +
> +	ep93xx_flash_resource.start	= start;
> +	ep93xx_flash_resource.end	= start + size - 1;
> +
> +	platform_device_register(&ep93xx_flash);
> +}
> +
> +
> +/*************************************************************************
>   * EP93xx ethernet peripheral handling
>   *************************************************************************/
>  static struct ep93xx_eth_data ep93xx_eth_data;
> diff --git a/arch/arm/mach-ep93xx/edb93xx.c b/arch/arm/mach-ep93xx/edb93xx.c
> index 3884182..c2ce903 100644
> --- a/arch/arm/mach-ep93xx/edb93xx.c
> +++ b/arch/arm/mach-ep93xx/edb93xx.c
> @@ -27,7 +27,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/mtd/physmap.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-gpio.h>
> @@ -38,39 +37,13 @@
>  #include <asm/mach/arch.h>
>  
>  
> -static struct physmap_flash_data edb93xx_flash_data;
> -
> -static struct resource edb93xx_flash_resource = {
> -	.flags		= IORESOURCE_MEM,
> -};
> -
> -static struct platform_device edb93xx_flash = {
> -	.name		= "physmap-flash",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &edb93xx_flash_data,
> -	},
> -	.num_resources	= 1,
> -	.resource	= &edb93xx_flash_resource,
> -};
> -
> -static void __init __edb93xx_register_flash(unsigned int width,
> -			resource_size_t start, resource_size_t size)
> -{
> -	edb93xx_flash_data.width	= width;
> -	edb93xx_flash_resource.start	= start;
> -	edb93xx_flash_resource.end	= start + size - 1;
> -
> -	platform_device_register(&edb93xx_flash);
> -}
> -
>  static void __init edb93xx_register_flash(void)
>  {
>  	if (machine_is_edb9307() || machine_is_edb9312() ||
>  	    machine_is_edb9315()) {
> -		__edb93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_32M);
> +		ep93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_32M);
>  	} else {
> -		__edb93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
> +		ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
>  	}
>  }
>  
> diff --git a/arch/arm/mach-ep93xx/gesbc9312.c b/arch/arm/mach-ep93xx/gesbc9312.c
> index a809618..d97168c 100644
> --- a/arch/arm/mach-ep93xx/gesbc9312.c
> +++ b/arch/arm/mach-ep93xx/gesbc9312.c
> @@ -13,7 +13,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/mtd/physmap.h>
>  
>  #include <mach/hardware.h>
>  
> @@ -21,26 +20,6 @@
>  #include <asm/mach/arch.h>
>  
>  
> -static struct physmap_flash_data gesbc9312_flash_data = {
> -	.width		= 4,
> -};
> -
> -static struct resource gesbc9312_flash_resource = {
> -	.start		= EP93XX_CS6_PHYS_BASE,
> -	.end		= EP93XX_CS6_PHYS_BASE + SZ_8M - 1,
> -	.flags		= IORESOURCE_MEM,
> -};
> -
> -static struct platform_device gesbc9312_flash = {
> -	.name		= "physmap-flash",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &gesbc9312_flash_data,
> -	},
> -	.num_resources	= 1,
> -	.resource	= &gesbc9312_flash_resource,
> -};
> -
>  static struct ep93xx_eth_data __initdata gesbc9312_eth_data = {
>  	.phy_id		= 1,
>  };
> @@ -48,8 +27,7 @@ static struct ep93xx_eth_data __initdata gesbc9312_eth_data = {
>  static void __init gesbc9312_init_machine(void)
>  {
>  	ep93xx_init_devices();
> -	platform_device_register(&gesbc9312_flash);
> -
> +	ep93xx_register_flash(4, EP93XX_CS6_PHYS_BASE, SZ_8M);
>  	ep93xx_register_eth(&gesbc9312_eth_data, 0);
>  }
>  
> diff --git a/arch/arm/mach-ep93xx/include/mach/platform.h b/arch/arm/mach-ep93xx/include/mach/platform.h
> index 9a4413d..a6c0917 100644
> --- a/arch/arm/mach-ep93xx/include/mach/platform.h
> +++ b/arch/arm/mach-ep93xx/include/mach/platform.h
> @@ -43,6 +43,9 @@ static inline void ep93xx_devcfg_clear_bits(unsigned int bits)
>  
>  unsigned int ep93xx_chip_revision(void);
>  
> +void ep93xx_register_flash(unsigned int width,
> +			   resource_size_t start, resource_size_t size);
> +
>  void ep93xx_register_eth(struct ep93xx_eth_data *data, int copy_addr);
>  void ep93xx_register_i2c(struct i2c_gpio_platform_data *data,
>  			 struct i2c_board_info *devices, int num);
> diff --git a/arch/arm/mach-ep93xx/micro9.c b/arch/arm/mach-ep93xx/micro9.c
> index 1cc911b..2ba7763 100644
> --- a/arch/arm/mach-ep93xx/micro9.c
> +++ b/arch/arm/mach-ep93xx/micro9.c
> @@ -14,7 +14,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/mtd/physmap.h>
>  #include <linux/io.h>
>  
>  #include <mach/hardware.h>
> @@ -31,31 +30,6 @@
>   * Micro9-Lite uses a separate MTD map driver for flash support
>   * Micro9-Slim has up to 64MB of either 32-bit or 16-bit flash on CS1
>   *************************************************************************/
> -static struct physmap_flash_data micro9_flash_data;
> -
> -static struct resource micro9_flash_resource = {
> -	.start		= EP93XX_CS1_PHYS_BASE,
> -	.end		= EP93XX_CS1_PHYS_BASE + SZ_64M - 1,
> -	.flags		= IORESOURCE_MEM,
> -};
> -
> -static struct platform_device micro9_flash = {
> -	.name		= "physmap-flash",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &micro9_flash_data,
> -	},
> -	.num_resources	= 1,
> -	.resource	= &micro9_flash_resource,
> -};
> -
> -static void __init __micro9_register_flash(unsigned int width)
> -{
> -	micro9_flash_data.width = width;
> -
> -	platform_device_register(&micro9_flash);
> -}
> -
>  static unsigned int __init micro9_detect_bootwidth(void)
>  {
>  	u32 v;
> @@ -70,10 +44,17 @@ static unsigned int __init micro9_detect_bootwidth(void)
>  
>  static void __init micro9_register_flash(void)
>  {
> +	unsigned int width;
> +
>  	if (machine_is_micro9())
> -		__micro9_register_flash(4);
> +		width = 4;
>  	else if (machine_is_micro9m() || machine_is_micro9s())
> -		__micro9_register_flash(micro9_detect_bootwidth());
> +		width = micro9_detect_bootwidth();
> +	else
> +		width = 0;
> +
> +	if (width)
> +		ep93xx_register_flash(width, EP93XX_CS1_PHYS_BASE, SZ_64M);
>  }
>  
>  
> diff --git a/arch/arm/mach-ep93xx/simone.c b/arch/arm/mach-ep93xx/simone.c
> index 388aec9..5dded58 100644
> --- a/arch/arm/mach-ep93xx/simone.c
> +++ b/arch/arm/mach-ep93xx/simone.c
> @@ -18,7 +18,6 @@
>  #include <linux/kernel.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> -#include <linux/mtd/physmap.h>
>  #include <linux/gpio.h>
>  #include <linux/i2c.h>
>  #include <linux/i2c-gpio.h>
> @@ -29,26 +28,6 @@
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  
> -static struct physmap_flash_data simone_flash_data = {
> -	.width		= 2,
> -};
> -
> -static struct resource simone_flash_resource = {
> -	.start		= EP93XX_CS6_PHYS_BASE,
> -	.end		= EP93XX_CS6_PHYS_BASE + SZ_8M - 1,
> -	.flags		= IORESOURCE_MEM,
> -};
> -
> -static struct platform_device simone_flash = {
> -	.name		= "physmap-flash",
> -	.id		= 0,
> -	.num_resources	= 1,
> -	.resource	= &simone_flash_resource,
> -	.dev = {
> -		.platform_data	= &simone_flash_data,
> -	},
> -};
> -
>  static struct ep93xx_eth_data __initdata simone_eth_data = {
>  	.phy_id		= 1,
>  };
> @@ -77,8 +56,7 @@ static struct i2c_board_info __initdata simone_i2c_board_info[] = {
>  static void __init simone_init_machine(void)
>  {
>  	ep93xx_init_devices();
> -
> -	platform_device_register(&simone_flash);
> +	ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_8M);
>  	ep93xx_register_eth(&simone_eth_data, 1);
>  	ep93xx_register_fb(&simone_fb_info);
>  	ep93xx_register_i2c(&simone_i2c_gpio_data, simone_i2c_board_info,
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index ae7319e..93aeab8 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -17,7 +17,6 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/m48t86.h>
> -#include <linux/mtd/physmap.h>
>  #include <linux/mtd/nand.h>
>  #include <linux/mtd/partitions.h>
>  
> @@ -173,31 +172,13 @@ static struct platform_device ts72xx_nand_flash = {
>  };
>  
>  
> -/*************************************************************************
> - * NOR flash (TS-7200 only)
> - *************************************************************************/
> -static struct physmap_flash_data ts72xx_nor_data = {
> -	.width		= 2,
> -};
> -
> -static struct resource ts72xx_nor_resource = {
> -	.start		= EP93XX_CS6_PHYS_BASE,
> -	.end		= EP93XX_CS6_PHYS_BASE + SZ_16M - 1,
> -	.flags		= IORESOURCE_MEM,
> -};
> -
> -static struct platform_device ts72xx_nor_flash = {
> -	.name			= "physmap-flash",
> -	.id			= 0,
> -	.dev.platform_data	= &ts72xx_nor_data,
> -	.resource		= &ts72xx_nor_resource,
> -	.num_resources		= 1,
> -};
> -
>  static void __init ts72xx_register_flash(void)
>  {
> +	/*
> +	 * TS7200 has NOR flash all other TS72xx board have NAND flash.
> +	 */
>  	if (board_is_ts7200()) {
> -		platform_device_register(&ts72xx_nor_flash);
> +		ep93xx_register_flash(2, EP93XX_CS6_PHYS_BASE, SZ_16M);
>  	} else {
>  		resource_size_t start;
>  
> 
> 


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
