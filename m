From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 29 Mar 2013 11:31:32 -0400
Subject: [PATCH] ARM: kirkwood: DT board setup for CloudBox
In-Reply-To: <1364555206-5870-1-git-send-email-simon.guinot@sequanux.org>
References: <1364555206-5870-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20130329153132.GJ13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Neat! another new board!

On Fri, Mar 29, 2013 at 12:06:46PM +0100, Simon Guinot wrote:
> This patch adds DT board setup for the LaCie NAS CloudBox. The CloudBox
> is a low cost NAS based on the Network Space v2.
> 
> Chipset list:
> - CPU MARVELL 88F6702 1Ghz
> - SDRAM memory: 256MB DDR2-800 (2x128MB x8) 400Mhz
> - 1 Ethernet Gigabit port (PHY MARVELL 88E1318)
> - SPI flash, NOR 512KB
> - 1 push button
> - 2 LEDs (red and blue)
> 
> Note that there is no EEPROM and no USB ports embedded.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> ---
>  arch/arm/boot/dts/Makefile              |    3 +-
>  arch/arm/boot/dts/kirkwood-cloudbox.dts |   89 +++++++++++++++++++++++++++++++
>  arch/arm/configs/kirkwood_defconfig     |    1 +
>  arch/arm/mach-kirkwood/Kconfig          |    7 +++
>  arch/arm/mach-kirkwood/Makefile         |    1 +
>  arch/arm/mach-kirkwood/board-dt.c       |    4 +-
>  arch/arm/mach-kirkwood/board-ns2.c      |    3 +-
>  arch/arm/mach-kirkwood/common.h         |    6 +++
>  8 files changed, 111 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-cloudbox.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 9c62558..8b535ad 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -51,7 +51,8 @@ dtb-$(CONFIG_ARCH_HIGHBANK) += highbank.dtb \
>  dtb-$(CONFIG_ARCH_INTEGRATOR) += integratorap.dtb \
>  	integratorcp.dtb
>  dtb-$(CONFIG_ARCH_LPC32XX) += ea3250.dtb phy3250.dtb
> -dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
> +dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-cloudbox.dtb \
> +	kirkwood-dns320.dtb \
>  	kirkwood-dns325.dtb \
>  	kirkwood-dockstar.dtb \
>  	kirkwood-dreamplug.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-cloudbox.dts b/arch/arm/boot/dts/kirkwood-cloudbox.dts
> new file mode 100644
> index 0000000..93024b7
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-cloudbox.dts
> @@ -0,0 +1,89 @@
> +/dts-v1/;
> +
> +/include/ "kirkwood.dtsi"
> +/include/ "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "LaCie CloudBox";
> +	compatible = "lacie,cloudbox", "marvell,kirkwood-88f6702", "marvell,kirkwood";

Is there a more specific string we can add here?  eg
"lacie,cloudbox-MODEL", "lacie,cloudbox", ...

> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			pinctrl-0 = < &pmx_spi &pmx_twsi0 &pmx_uart0
> +					&pmx_cloudbox_sata0 >;
> +			pinctrl-names = "default";
> +
> +			pmx_cloudbox_sata0: pmx-cloudbox-sata0 {
> +				marvell,pins = "mpp15";
> +				marvell,function = "sata0";
> +			};
> +		};
> +
> +		serial at 12000 {
> +			clock-frequency = <166666667>;
> +			status = "okay";
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <1>;
> +		};
> +
> +		spi at 10600 {
> +			status = "okay";
> +
> +			flash at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "mx25l4005a";
> +				reg = <0>;
> +				spi-max-frequency = <20000000>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x80000>;
> +					label = "u-boot";
> +				};

Is there a u-boot environment block we should add here?  Would be nice
to be able to edit it from userspace.

> +			};
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		button at 1 {
> +			label = "Power push button";
> +			linux,code = <116>;
> +			gpios = <&gpio0 16 1>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +
> +		red-fail {
> +			label = "cloudbox:red:fail";
> +			gpios = <&gpio0 14 0>;
> +		};
> +		blue-sata {
> +			label = "cloudbox:blue:sata";
> +			gpios = <&gpio0 15 0>;
> +		};
> +	};
> +
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		gpios = <&gpio0 17 0>;
> +	};
> +};
> diff --git a/arch/arm/configs/kirkwood_defconfig b/arch/arm/configs/kirkwood_defconfig
> index 13482ea..94aff34 100644
> --- a/arch/arm/configs/kirkwood_defconfig
> +++ b/arch/arm/configs/kirkwood_defconfig
> @@ -35,6 +35,7 @@ CONFIG_MACH_NETSPACE_LITE_V2_DT=y
>  CONFIG_MACH_NETSPACE_MINI_V2_DT=y
>  CONFIG_MACH_OPENBLOCKS_A6_DT=y
>  CONFIG_MACH_TOPKICK_DT=y
> +CONFIG_MACH_CLOUDBOX_DT=y

Thanks for adding this.

>  CONFIG_MACH_TS219=y
>  CONFIG_MACH_TS41X=y
>  CONFIG_MACH_DOCKSTAR=y
> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
> index 7b6a64b..c6ffbce 100644
> --- a/arch/arm/mach-kirkwood/Kconfig
> +++ b/arch/arm/mach-kirkwood/Kconfig
> @@ -201,6 +201,13 @@ config MACH_TOPKICK_DT
>  	  Say 'Y' here if you want your kernel to support the
>  	  USI Topkick, using Flattened Device Tree
>  
> +config MACH_CLOUDBOX_DT
> +	bool "LaCie CloudBox NAS (Flattened Device Tree)"
> +	select ARCH_KIRKWOOD_DT
> +	help
> +	  Say 'Y' here if you want your kernel to support the LaCie
> +	  CloudBox NAS, using Flattened Device Tree.
> +

Could you please add this block alphabetically among the MACH_.*_DT
entries?  It reduces the number of merge conflicts for us.

>  config MACH_TS219
>  	bool "QNAP TS-110, TS-119, TS-119P+, TS-210, TS-219, TS-219P and TS-219P+ Turbo NAS"
>  	help
> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
> index 4cc4bee..c1b81d3 100644
> --- a/arch/arm/mach-kirkwood/Makefile
> +++ b/arch/arm/mach-kirkwood/Makefile
> @@ -40,3 +40,4 @@ obj-$(CONFIG_MACH_NETSPACE_MINI_V2_DT)	+= board-ns2.o
>  obj-$(CONFIG_MACH_NSA310_DT)		+= board-nsa310.o
>  obj-$(CONFIG_MACH_OPENBLOCKS_A6_DT)	+= board-openblocks_a6.o
>  obj-$(CONFIG_MACH_TOPKICK_DT)		+= board-usi_topkick.o
> +obj-$(CONFIG_MACH_CLOUDBOX_DT)		+= board-ns2.o
> diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
> index d367aa6..fdaac4e 100644
> --- a/arch/arm/mach-kirkwood/board-dt.c
> +++ b/arch/arm/mach-kirkwood/board-dt.c
> @@ -143,7 +143,8 @@ static void __init kirkwood_dt_init(void)
>  	    of_machine_is_compatible("lacie,netspace_v2") ||
>  	    of_machine_is_compatible("lacie,netspace_max_v2") ||
>  	    of_machine_is_compatible("lacie,netspace_lite_v2") ||
> -	    of_machine_is_compatible("lacie,netspace_mini_v2"))
> +	    of_machine_is_compatible("lacie,netspace_mini_v2") ||
> +	    of_machine_is_compatible("lacie,cloudbox"))

alphabetical here, too (I know, it's not perfect right now :) )

>  		ns2_init();
>  
>  	if (of_machine_is_compatible("mpl,cec4"))
> @@ -180,6 +181,7 @@ static const char * const kirkwood_dt_board_compat[] = {
>  	"plathome,openblocks-a6",
>  	"usi,topkick",
>  	"zyxel,nsa310",
> +	"lacie,cloudbox",

alpha...

thx,

Jason.

>  	NULL
>  };
>  
> diff --git a/arch/arm/mach-kirkwood/board-ns2.c b/arch/arm/mach-kirkwood/board-ns2.c
> index f2ea3b7..5be000d 100644
> --- a/arch/arm/mach-kirkwood/board-ns2.c
> +++ b/arch/arm/mach-kirkwood/board-ns2.c
> @@ -28,7 +28,8 @@ void __init ns2_init(void)
>  	 * Basic setup. Needs to be called early.
>  	 */
>  	if (of_machine_is_compatible("lacie,netspace_lite_v2") ||
> -	    of_machine_is_compatible("lacie,netspace_mini_v2"))
> +	    of_machine_is_compatible("lacie,netspace_mini_v2") ||
> +	    of_machine_is_compatible("lacie,cloudbox"))
>  		ns2_ge00_data.phy_addr = MV643XX_ETH_PHY_ADDR(0);
>  	kirkwood_ge00_init(&ns2_ge00_data);
>  }
> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
> index 5ed7056..2b6d16a 100644
> --- a/arch/arm/mach-kirkwood/common.h
> +++ b/arch/arm/mach-kirkwood/common.h
> @@ -147,6 +147,12 @@ void usi_topkick_init(void);
>  static inline void usi_topkick_init(void) {};
>  #endif
>  
> +#ifdef CONFIG_MACH_CLOUDBOX_DT
> +void cloudbox_init(void);
> +#else
> +static inline void cloudbox_init(void) {};
> +#endif
> +
>  /* early init functions not converted to fdt yet */
>  char *kirkwood_id(void);
>  void kirkwood_l2_init(void);
> -- 
> 1.7.10.4
> 
