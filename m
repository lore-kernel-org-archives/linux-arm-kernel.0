From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 23 Feb 2014 12:30:14 -0500
Subject: [PATCH 3/4] ARM: mvebu: Add HP T5325 thin client
In-Reply-To: <1393175982-18516-4-git-send-email-andrew@lunn.ch>
References: <1393175982-18516-1-git-send-email-andrew@lunn.ch>
 <1393175982-18516-4-git-send-email-andrew@lunn.ch>
Message-ID: <20140223173014.GP7862@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 23, 2014 at 06:19:41PM +0100, Andrew Lunn wrote:
> Convert the kirkwood t5325-setup.c to mostly device tree for
> mach-mvebu. Part of the audio setup needs to remain in C for the
> moment until suitable bindings are designed and implemented. So add
> board code, triggered by the compatibility string.
> 
> The first version of the dts file was created by Thomas Petazzoni.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/kirkwood-t5325.dts | 209 +++++++++++++++++++++++++++++++++++

Please split this in two.  dts|mach-mvebu

thx,

Jason.

>  arch/arm/mach-mvebu/Kconfig          |   7 ++
>  arch/arm/mach-mvebu/Makefile         |   1 +
>  arch/arm/mach-mvebu/board-t5325.c    |  41 +++++++
>  arch/arm/mach-mvebu/board.h          |  22 ++++
>  arch/arm/mach-mvebu/kirkwood.c       |  11 +-
>  7 files changed, 291 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/kirkwood-t5325.dts
>  create mode 100644 arch/arm/mach-mvebu/board-t5325.c
>  create mode 100644 arch/arm/mach-mvebu/board.h
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 436cc381db4a..20c152faa800 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -132,6 +132,7 @@ kirkwood := \
>  	kirkwood-rs411.dtb \
>  	kirkwood-sheevaplug.dtb \
>  	kirkwood-sheevaplug-esata.dtb \
> +	kirkwood-t5325.dtb \
>  	kirkwood-topkick.dtb \
>  	kirkwood-ts219-6281.dtb \
>  	kirkwood-ts219-6282.dtb \
> diff --git a/arch/arm/boot/dts/kirkwood-t5325.dts b/arch/arm/boot/dts/kirkwood-t5325.dts
> new file mode 100644
> index 000000000000..07b0146f31da
> --- /dev/null
> +++ b/arch/arm/boot/dts/kirkwood-t5325.dts
> @@ -0,0 +1,209 @@
> +/*
> + * Device Tree file for HP t5325 Thin Client"
> + *
> + * Copyright (C) 2014
> + *
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> +*/
> +
> +/dts-v1/;
> +
> +#include "kirkwood.dtsi"
> +#include "kirkwood-6281.dtsi"
> +
> +/ {
> +	model = "HP t5325 Thin Client";
> +	compatible = "hp,t5325", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>;
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8";
> +	};
> +
> +	mbus {
> +		pcie-controller {
> +			status = "okay";
> +
> +			pcie at 1,0 {
> +				status = "okay";
> +			};
> +		};
> +	};
> +
> +	ocp at f1000000 {
> +		pinctrl: pinctrl at 10000 {
> +			pinctrl-0 = <&pmx_i2s &pmx_sysrst>;
> +			pinctrl-names = "default";
> +
> +			pmx_button_power: pmx-button_power {
> +				marvell,pins = "mpp45";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_power_off: pmx-power-off {
> +				marvell,pins = "mpp48";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_led: pmx-led {
> +				marvell,pins = "mpp21";
> +				marvell,function = "gpio";
> +			};
> +
> +			pmx_usb_sata_power_enable: pmx-usb-sata-power-enable {
> +				marvell,pins = "mpp44";
> +				marvell,function = "gpio";
> +			};
> +
> +			/*
> +                         * Redefined from kirkwood-6281.dtsi, because
> +			 * we don't use SPI CS on MPP0, but on MPP7.
> +			 */
> +			pmx_spi: pmx-spi {
> +				marvell,pins = "mpp1", "mpp2", "mpp3", "mpp7";
> +				marvell,function = "spi";
> +			};
> +
> +			pmx_sysrst: pmx-sysrst {
> +				marvell,pins = "mpp6";
> +				marvell,function = "sysrst";
> +			};
> +
> +			pmx_i2s: pmx-i2s {
> +				marvell,pins = "mpp39", "mpp40", "mpp41", "mpp42",
> +					       "mpp43";
> +				marvell,function = "audio";
> +			};
> +		};
> +
> +		spi at 10600 {
> +			pinctrl-0 = <&pmx_spi>;
> +			pinctrl-names = "default";
> +			status = "okay";
> +
> +			flash at 0 {
> +				#address-cells = <1>;
> +				#size-cells = <1>;
> +				compatible = "st,m25p80";
> +				spi-max-frequency = <86000000>;
> +				reg = <0>;
> +				mode = <0>;
> +
> +				partition at 0 {
> +					reg = <0x0 0x80000>;
> +					label = "u-boot";
> +				};
> +
> +				partition at 1 {
> +					reg = <0x80000 0x40000>;
> +					label = "SSD firmware";
> +				};
> +
> +				partition at 2 {
> +					reg = <0xc0000 0x10000>;
> +					label = "u-boot env";
> +				};
> +
> +				partition at 3 {
> +					reg = <0xd0000 0x10000>;
> +					label = "permanent u-boot env";
> +				};
> +
> +				partition at 4 {
> +					reg = <0xd0000 0x10000>;
> +					label = "permanent u-boot env";
> +				};
> +			};
> +		};
> +
> +		i2c at 11000 {
> +			status = "okay";
> +
> +			alc5621: alc5621 at 1a {
> +				compatible = "realtek,alc5621";
> +				reg = <0x1a>;
> +			};
> +		};
> +
> +		serial at 12000 {
> +			status = "okay";
> +		};
> +
> +		sata at 80000 {
> +			status = "okay";
> +			nr-ports = <2>;
> +		};
> +
> +		audio: audio-controller at a0000 {
> +			status = "okay";
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_usb_sata_power_enable>;
> +		pinctrl-names = "default";
> +
> +		usb_power: regulator at 1 {
> +			compatible = "regulator-fixed";
> +			reg = <1>;
> +			regulator-name = "USB-SATA Power";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			enable-active-high;
> +			regulator-always-on;
> +			regulator-boot-on;
> +			gpio = <&gpio1 12 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		pinctrl-0 = <&pmx_button_power>;
> +		pinctrl-names = "default";
> +
> +		button at 1 {
> +			label = "Power Button";
> +			linux,code = < KEY_POWER >;
> +			gpios = <&gpio1 13 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +
> +	gpio_poweroff {
> +		compatible = "gpio-poweroff";
> +		pinctrl-0 = <&pmx_power_off>;
> +		pinctrl-names = "default";
> +		gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy0: ethernet-phy {
> +		device_type = "ethernet-phy";
> +                reg = <8>;
> +	};
> +};
> +
> +&eth0 {
> +	status = "okay";
> +	ethernet0-port at 0 {
> +		phy-handle = <&ethphy0>;
> +	};
> +};
> +
> diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
> index 529f9164a8ca..f6e928c97a01 100644
> --- a/arch/arm/mach-mvebu/Kconfig
> +++ b/arch/arm/mach-mvebu/Kconfig
> @@ -92,6 +92,13 @@ config MACH_KIRKWOOD
>  	  Say 'Y' here if you want your kernel to support boards based
>  	  on the Marvell Kirkwood device tree.
>  
> +config MACH_T5325
> +	bool "HP T5325 thin client"
> +	depends on MACH_KIRKWOOD
> +	help
> +	 Say 'Y' here if you want your kernel to support the
> +	 HP T5325 Thin client
> +
>  endmenu
>  
>  endif
> diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
> index d7672f1c8a6a..bbeb41ee3e75 100644
> --- a/arch/arm/mach-mvebu/Makefile
> +++ b/arch/arm/mach-mvebu/Makefile
> @@ -9,3 +9,4 @@ obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
>  obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
>  obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
>  obj-$(CONFIG_MACH_KIRKWOOD)	 += kirkwood.o kirkwood-pm.o
> +obj-$(CONFIG_MACH_T5325)	 += board-t5325.o
> diff --git a/arch/arm/mach-mvebu/board-t5325.c b/arch/arm/mach-mvebu/board-t5325.c
> new file mode 100644
> index 000000000000..65ace6db9f28
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/board-t5325.c
> @@ -0,0 +1,41 @@
> +/*
> + * HP T5325 Board Setup
> + *
> + * Copyright (C) 2014
> + *
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <sound/alc5623.h>
> +#include "board.h"
> +
> +static struct platform_device hp_t5325_audio_device = {
> +	.name		= "t5325-audio",
> +	.id		= -1,
> +};
> +
> +static struct alc5623_platform_data alc5621_data = {
> +	.add_ctrl = 0x3700,
> +	.jack_det_ctrl = 0x4810,
> +};
> +
> +static struct i2c_board_info i2c_board_info[] __initdata = {
> +	{
> +		I2C_BOARD_INFO("alc5621", 0x1a),
> +		.platform_data = &alc5621_data,
> +	},
> +};
> +
> +void __init t5325_init(void)
> +{
> +	i2c_register_board_info(0, i2c_board_info, ARRAY_SIZE(i2c_board_info));
> +	platform_device_register(&hp_t5325_audio_device);
> +}
> diff --git a/arch/arm/mach-mvebu/board.h b/arch/arm/mach-mvebu/board.h
> new file mode 100644
> index 000000000000..de7f0a191394
> --- /dev/null
> +++ b/arch/arm/mach-mvebu/board.h
> @@ -0,0 +1,22 @@
> +/*
> + * Board functions for Marvell System On Chip
> + *
> + * Copyright (C) 2014
> + *
> + * Andrew Lunn <andrew@lunn.ch>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#ifndef __ARCH_MVEBU_BOARD_H
> +#define __ARCH_MVEBU_BOARD_H
> +
> +#ifdef CONFIG_MACH_T5325
> +void t5325_init(void);
> +#else
> +static inline void t5325_init(void) {};
> +#endif
> +
> +#endif
> diff --git a/arch/arm/mach-mvebu/kirkwood.c b/arch/arm/mach-mvebu/kirkwood.c
> index 8a38b10532e5..120207fc36f1 100644
> --- a/arch/arm/mach-mvebu/kirkwood.c
> +++ b/arch/arm/mach-mvebu/kirkwood.c
> @@ -25,6 +25,7 @@
>  #include "kirkwood.h"
>  #include "kirkwood-pm.h"
>  #include "common.h"
> +#include "board.h"
>  
>  static struct resource kirkwood_cpufreq_resources[] = {
>  	[0] = {
> @@ -158,6 +159,11 @@ void kirkwood_disable_mbus_error_propagation(void)
>  	writel(readl(cpu_config) & ~CPU_CONFIG_ERROR_PROP, cpu_config);
>  }
>  
> +static struct of_dev_auxdata auxdata[] __initdata = {
> +	OF_DEV_AUXDATA("marvell,kirkwood-audio", 0xf10a0000,
> +		       "mvebu-audio", NULL),
> +	{ /* sentinel */ }
> +};
>  
>  static void __init kirkwood_dt_init(void)
>  {
> @@ -174,7 +180,10 @@ static void __init kirkwood_dt_init(void)
>  	kirkwood_pm_init();
>  	kirkwood_dt_eth_fixup();
>  
> -	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
> +	if (of_machine_is_compatible("hp,t5325"))
> +		t5325_init();
> +
> +	of_platform_populate(NULL, of_default_bus_match_table, auxdata, NULL);
>  }
>  
>  static const char * const kirkwood_dt_board_compat[] = {
> -- 
> 1.8.5.3
> 
