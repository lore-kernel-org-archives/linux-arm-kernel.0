From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 17 Jul 2012 13:27:51 +0000
Subject: [PATCH 4/8] ARM: MCS814X: add DTS file for Tigal/Robotech RBT-832
In-Reply-To: <1342363754-30808-5-git-send-email-florian@openwrt.org>
References: <1342363754-30808-1-git-send-email-florian@openwrt.org>
 <1342363754-30808-5-git-send-email-florian@openwrt.org>
Message-ID: <201207171327.52118.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 15 July 2012, Florian Fainelli wrote:

> +	model = "Tigal RBT-832";
> +	compatible = "tigal,rbt-832", "moschip,mcs8140", "moschip,mcs814x";
> +
> +	chosen {
> +		bootargs = "mem=32M console=ttyS0,115200 earlyprintk";
> +	};

I think the mem=32M doesn't belong here, it's already specified in the memory
node.

> diff --git a/arch/arm/mach-mcs814x/Kconfig b/arch/arm/mach-mcs814x/Kconfig
> index c89422f..604537b 100644
> --- a/arch/arm/mach-mcs814x/Kconfig
> +++ b/arch/arm/mach-mcs814x/Kconfig
> @@ -6,6 +6,15 @@ config MCS8140
>  
>  menu "Moschip MCS8140 boards"
>  
> +config MACH_RBT_832
> +	bool "Tigal RBT-832"
> +	select MCS8140
> +	select NEW_LEDS
> +	select LEDS_CLASS
> +	select LEDS_GPIO
> +	help
> +	  Machine support for the Tigal RBT-832 board
> +
>  endmenu
>  
>  endif

I would prefer not to have any additional symbols selected by the board.
It's better to put those into the defconfig.

> @@ -27,6 +27,7 @@ static void __init mcs814x_dt_device_init(void)
>  }
>  
>  static const char *mcs8140_dt_board_compat[] __initdata = {
> +	"tigal,rbt-832",
>  	"moschip,mcs8140",
>  	NULL,	/* sentinel */
>  };

I'm not sure what the normal practice is these days regarding the 
board compatible table. I thought that we just put the soc name
in there for new platforms that are already DT-only. Your .dts
file contains both, so it works either way.

	Arnd
