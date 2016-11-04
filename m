From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 04 Nov 2016 13:44:10 +0100
Subject: [PATCH] convert orion5x ls-chl to device tree
In-Reply-To: <14522899-679b-2f8b-73ca-493788299790@gmail.com> (Ash Hughes's
 message of "Tue, 25 Oct 2016 00:04:49 +0100")
References: <14522899-679b-2f8b-73ca-493788299790@gmail.com>
Message-ID: <87zilfmn39.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ash,
 
 On mar., oct. 25 2016, Ash Hughes <sehguh.hsa@gmail.com> wrote:

> Hi all,
>
> This patch converts my orion5x ls-chl Linkstation device to device
> tree.

I was about to apply your patch but it does not apply on mvebu/dt or
even on v4.9-rc1.

Could you rebase it?

Thanks,

Gregory

>
> Signed-off-by: Ashley Hughes <ashley.hughes@blueyonder.co.uk>
> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/orion5x-lschl.dts  | 171 ++++++++++++++++++
>  arch/arm/mach-orion5x/Kconfig        |   4 +-
>  arch/arm/mach-orion5x/Makefile       |   1 -
>  arch/arm/mach-orion5x/ls-chl-setup.c | 331 -----------------------------------
>  5 files changed, 174 insertions(+), 334 deletions(-)
>  create mode 100644 arch/arm/boot/dts/orion5x-lschl.dts
>  delete mode 100644 arch/arm/mach-orion5x/ls-chl-setup.c
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index befcd26..4853049 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -597,6 +597,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>      orion5x-lacie-ethernet-disk-mini-v2.dtb \
>      orion5x-linkstation-lsgl.dtb \
>      orion5x-linkstation-lswtgl.dtb \
> +    orion5x-lschl.dtb \
>      orion5x-lswsgl.dtb \
>      orion5x-maxtor-shared-storage-2.dtb \
>      orion5x-netgear-wnr854t.dtb \
> diff --git a/arch/arm/boot/dts/orion5x-lschl.dts b/arch/arm/boot/dts/orion5x-lschl.dts
> new file mode 100644
> index 0000000..9474092
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-lschl.dts
> @@ -0,0 +1,171 @@
> +/*
> + * Device Tree file for Buffalo Linkstation LS-CHLv3
> + *
> + * Copyright (C) 2016 Ash Hughes <ashley.hughes@blueyonder.co.uk>
> + * Copyright (C) 2015, 2016
> + * Roger Shimizu <rogershimizu@gmail.com>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED , WITHOUT WARRANTY OF ANY KIND
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */
> +
> +/dts-v1/;
> +
> +#include "orion5x-linkstation.dtsi"
> +#include "mvebu-linkstation-gpio-simple.dtsi"
> +#include "mvebu-linkstation-fan.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +    model = "Buffalo Linkstation Live v3 (LS-CHL)";
> +    compatible = "buffalo,lschl", "marvell,orion5x-88f5182", "marvell,orion5x";
> +
> +    memory { /* 128 MB */
> +        device_type = "memory";
> +        reg = <0x00000000 0x8000000>;
> +    };
> +
> +    gpio_keys {
> +        func {
> +            label = "Function Button";
> +            linux,code = <KEY_OPTION>;
> +            gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
> +        };
> +
> +        power-on-switch {
> +            gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
> +        };
> +
> +        power-auto-switch {
> +            gpios = <&gpio0 10 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +
> +    gpio_leds {
> +        pinctrl-0 = <&pmx_led_power &pmx_led_alarm &pmx_led_info &pmx_led_func>;
> +        blue-power-led {
> +            gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
> +        };
> +
> +        red-alarm-led {
> +            gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
> +        };
> +
> +        amber-info-led {
> +            gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +        };
> +
> +        func {
> +            label = "lschl:func:blue:top";
> +            gpios = <&gpio0 17 GPIO_ACTIVE_LOW>;
> +        };
> +    };
> +
> +    gpio_fan {
> +        gpios = <&gpio0 14 GPIO_ACTIVE_LOW
> +             &gpio0 16 GPIO_ACTIVE_LOW>;
> +
> +        alarm-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
> +    };
> +};
> +
> +&pinctrl {
> +    pmx_led_power: pmx-leds {
> +        marvell,pins = "mpp0";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_power_hdd: pmx-power-hdd {
> +        marvell,pins = "mpp1";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_led_alarm: pmx-leds {
> +        marvell,pins = "mpp2";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_led_info: pmx-leds {
> +        marvell,pins = "mpp3";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_fan_lock: pmx-fan-lock {
> +        marvell,pins = "mpp6";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_power_switch: pmx-power-switch {
> +        marvell,pins = "mpp8", "mpp10", "mpp15";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_power_usb: pmx-power-usb {
> +        marvell,pins = "mpp9";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_fan_high: pmx-fan-high {
> +        marvell,pins = "mpp14";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_fan_low: pmx-fan-low {
> +        marvell,pins = "mpp16";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_led_func: pmx-leds {
> +        marvell,pins = "mpp17";
> +        marvell,function = "gpio";
> +    };
> +
> +    pmx_sw_init: pmx-sw-init {
> +        marvell,pins = "mpp7";
> +        marvell,function = "gpio";
> +    };
> +};
> +
> +&hdd_power {
> +    gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&usb_power {
> +    gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
> +};
> +
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index 89bb0fc..793efa9 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -85,8 +85,8 @@ config MACH_LINKSTATION_PRO
>        v2 devices are supported.
>  
>  config MACH_LINKSTATION_LSCHL
> -    bool "Buffalo Linkstation Live v3 (LS-CHL)"
> -    select I2C_BOARDINFO if I2C
> +    bool "Buffalo Linkstation Live v3 (LS-CHL) (Flattened Device Tree)"
> +    select ARCH_ORION5X_DT
>      help
>        Say 'Y' here if you want your kernel to support the
>        Buffalo Linkstation Live v3 (LS-CHL) platform.
> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
> index 4b2502b..ae91872 100644
> --- a/arch/arm/mach-orion5x/Makefile
> +++ b/arch/arm/mach-orion5x/Makefile
> @@ -18,7 +18,6 @@ obj-$(CONFIG_MACH_WNR854T)    += wnr854t-setup.o
>  obj-$(CONFIG_MACH_RD88F5181L_GE)    += rd88f5181l-ge-setup.o
>  obj-$(CONFIG_MACH_RD88F5181L_FXO)    += rd88f5181l-fxo-setup.o
>  obj-$(CONFIG_MACH_RD88F6183AP_GE)    += rd88f6183ap-ge-setup.o
> -obj-$(CONFIG_MACH_LINKSTATION_LSCHL)    += ls-chl-setup.o
>  
>  obj-$(CONFIG_ARCH_ORION5X_DT)        += board-dt.o
>  obj-$(CONFIG_MACH_D2NET_DT)    += board-d2net.o
> diff --git a/arch/arm/mach-orion5x/ls-chl-setup.c b/arch/arm/mach-orion5x/ls-chl-setup.c
> deleted file mode 100644
> index dfdaa8a..0000000
> --- a/arch/arm/mach-orion5x/ls-chl-setup.c
> +++ /dev/null
> @@ -1,331 +0,0 @@
> -/*
> - * arch/arm/mach-orion5x/ls-chl-setup.c
> - *
> - * Maintainer: Ash Hughes <ashley.hughes@blueyonder.co.uk>
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/leds.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/gpio-fan.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/ata_platform.h>
> -#include <linux/gpio.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include "common.h"
> -#include "mpp.h"
> -#include "orion5x.h"
> -
> -/*****************************************************************************
> - * Linkstation LS-CHL Info
> - ****************************************************************************/
> -
> -/*
> - * 256K NOR flash Device bus boot chip select
> - */
> -
> -#define LSCHL_NOR_BOOT_BASE    0xf4000000
> -#define LSCHL_NOR_BOOT_SIZE    SZ_256K
> -
> -/*****************************************************************************
> - * 256KB NOR Flash on BOOT Device
> - ****************************************************************************/
> -
> -static struct physmap_flash_data lschl_nor_flash_data = {
> -    .width = 1,
> -};
> -
> -static struct resource lschl_nor_flash_resource = {
> -    .flags    = IORESOURCE_MEM,
> -    .start    = LSCHL_NOR_BOOT_BASE,
> -    .end    = LSCHL_NOR_BOOT_BASE + LSCHL_NOR_BOOT_SIZE - 1,
> -};
> -
> -static struct platform_device lschl_nor_flash = {
> -    .name = "physmap-flash",
> -    .id = 0,
> -    .dev = {
> -        .platform_data    = &lschl_nor_flash_data,
> -    },
> -    .num_resources = 1,
> -    .resource = &lschl_nor_flash_resource,
> -};
> -
> -/*****************************************************************************
> - * Ethernet
> - ****************************************************************************/
> -
> -static struct mv643xx_eth_platform_data lschl_eth_data = {
> -    .phy_addr = MV643XX_ETH_PHY_ADDR(8),
> -};
> -
> -/*****************************************************************************
> - * RTC 5C372a on I2C bus
> - ****************************************************************************/
> -
> -static struct i2c_board_info __initdata lschl_i2c_rtc = {
> -    I2C_BOARD_INFO("rs5c372a", 0x32),
> -};
> -
> -/*****************************************************************************
> - * LEDs attached to GPIO
> - ****************************************************************************/
> -
> -#define LSCHL_GPIO_LED_ALARM    2
> -#define LSCHL_GPIO_LED_INFO    3
> -#define LSCHL_GPIO_LED_FUNC    17
> -#define LSCHL_GPIO_LED_PWR    0
> -
> -static struct gpio_led lschl_led_pins[] = {
> -    {
> -        .name = "alarm:red",
> -        .gpio = LSCHL_GPIO_LED_ALARM,
> -        .active_low = 1,
> -    }, {
> -        .name = "info:amber",
> -        .gpio = LSCHL_GPIO_LED_INFO,
> -        .active_low = 1,
> -    }, {
> -        .name = "func:blue:top",
> -        .gpio = LSCHL_GPIO_LED_FUNC,
> -        .active_low = 1,
> -    }, {
> -        .name = "power:blue:bottom",
> -        .gpio = LSCHL_GPIO_LED_PWR,
> -    },
> -};
> -
> -static struct gpio_led_platform_data lschl_led_data = {
> -    .leds = lschl_led_pins,
> -    .num_leds = ARRAY_SIZE(lschl_led_pins),
> -};
> -
> -static struct platform_device lschl_leds = {
> -    .name = "leds-gpio",
> -    .id = -1,
> -    .dev = {
> -        .platform_data = &lschl_led_data,
> -    },
> -};
> -
> -/*****************************************************************************
> - * SATA
> - ****************************************************************************/
> -static struct mv_sata_platform_data lschl_sata_data = {
> -    .n_ports = 2,
> -};
> -
> -/*****************************************************************************
> - * LS-CHL specific power off method: reboot
> - ****************************************************************************/
> -/*
> - * On the LS-CHL, the shutdown process is following:
> - * - Userland monitors key events until the power switch goes to off position
> - * - The board reboots
> - * - U-boot starts and goes into an idle mode waiting for the user
> - *   to move the switch to ON position
> - *
> - */
> -
> -static void lschl_power_off(void)
> -{
> -    orion5x_restart(REBOOT_HARD, NULL);
> -}
> -
> -/*****************************************************************************
> - * General Setup
> - ****************************************************************************/
> -#define LSCHL_GPIO_USB_POWER    9
> -#define LSCHL_GPIO_AUTO_POWER    17
> -#define LSCHL_GPIO_POWER    18
> -
> -/****************************************************************************
> - * GPIO Attached Keys
> - ****************************************************************************/
> -#define LSCHL_GPIO_KEY_FUNC        15
> -#define LSCHL_GPIO_KEY_POWER        8
> -#define LSCHL_GPIO_KEY_AUTOPOWER    10
> -#define LSCHL_SW_POWER        0x00
> -#define LSCHL_SW_AUTOPOWER    0x01
> -#define LSCHL_SW_FUNC        0x02
> -
> -static struct gpio_keys_button lschl_buttons[] = {
> -    {
> -        .type = EV_SW,
> -        .code = LSCHL_SW_POWER,
> -        .gpio = LSCHL_GPIO_KEY_POWER,
> -        .desc = "Power-on Switch",
> -        .active_low = 1,
> -    }, {
> -        .type = EV_SW,
> -        .code = LSCHL_SW_AUTOPOWER,
> -        .gpio = LSCHL_GPIO_KEY_AUTOPOWER,
> -        .desc = "Power-auto Switch",
> -        .active_low = 1,
> -    }, {
> -        .type = EV_SW,
> -        .code = LSCHL_SW_FUNC,
> -        .gpio = LSCHL_GPIO_KEY_FUNC,
> -        .desc = "Function Switch",
> -        .active_low = 1,
> -    },
> -};
> -
> -static struct gpio_keys_platform_data lschl_button_data = {
> -    .buttons = lschl_buttons,
> -    .nbuttons = ARRAY_SIZE(lschl_buttons),
> -};
> -
> -static struct platform_device lschl_button_device = {
> -    .name = "gpio-keys",
> -    .id = -1,
> -    .num_resources = 0,
> -    .dev = {
> -        .platform_data = &lschl_button_data,
> -    },
> -};
> -
> -#define LSCHL_GPIO_HDD_POWER    1
> -
> -/****************************************************************************
> - * GPIO Fan
> - ****************************************************************************/
> -
> -#define LSCHL_GPIO_FAN_LOW    16
> -#define LSCHL_GPIO_FAN_HIGH    14
> -#define LSCHL_GPIO_FAN_LOCK    6
> -
> -static struct gpio_fan_alarm lschl_alarm = {
> -    .gpio = LSCHL_GPIO_FAN_LOCK,
> -};
> -
> -static struct gpio_fan_speed lschl_speeds[] = {
> -    {
> -        .rpm = 0,
> -        .ctrl_val = 3,
> -    }, {
> -        .rpm = 1500,
> -        .ctrl_val = 2,
> -    }, {
> -        .rpm = 3250,
> -        .ctrl_val = 1,
> -    }, {
> -        .rpm = 5000,
> -        .ctrl_val = 0,
> -    },
> -};
> -
> -static int lschl_gpio_list[] = {
> -    LSCHL_GPIO_FAN_HIGH, LSCHL_GPIO_FAN_LOW,
> -};
> -
> -static struct gpio_fan_platform_data lschl_fan_data = {
> -    .num_ctrl = ARRAY_SIZE(lschl_gpio_list),
> -    .ctrl = lschl_gpio_list,
> -    .alarm = &lschl_alarm,
> -    .num_speed = ARRAY_SIZE(lschl_speeds),
> -    .speed = lschl_speeds,
> -};
> -
> -static struct platform_device lschl_fan_device = {
> -    .name = "gpio-fan",
> -    .id = -1,
> -    .num_resources = 0,
> -    .dev = {
> -        .platform_data = &lschl_fan_data,
> -    },
> -};
> -
> -/****************************************************************************
> - * GPIO Data
> - ****************************************************************************/
> -
> -static unsigned int lschl_mpp_modes[] __initdata = {
> -    MPP0_GPIO, /* LED POWER */
> -    MPP1_GPIO, /* HDD POWER */
> -    MPP2_GPIO, /* LED ALARM */
> -    MPP3_GPIO, /* LED INFO */
> -    MPP4_UNUSED,
> -    MPP5_UNUSED,
> -    MPP6_GPIO, /* FAN LOCK */
> -    MPP7_GPIO, /* SW INIT */
> -    MPP8_GPIO, /* SW POWER */
> -    MPP9_GPIO, /* USB POWER */
> -    MPP10_GPIO, /* SW AUTO POWER */
> -    MPP11_UNUSED,
> -    MPP12_UNUSED,
> -    MPP13_UNUSED,
> -    MPP14_GPIO, /* FAN HIGH */
> -    MPP15_GPIO, /* SW FUNC */
> -    MPP16_GPIO, /* FAN LOW */
> -    MPP17_GPIO, /* LED FUNC */
> -    MPP18_UNUSED,
> -    MPP19_UNUSED,
> -    0,
> -};
> -
> -static void __init lschl_init(void)
> -{
> -    /*
> -     * Setup basic Orion functions. Needs to be called early.
> -     */
> -    orion5x_init();
> -
> -    orion5x_mpp_conf(lschl_mpp_modes);
> -
> -    /*
> -     * Configure peripherals.
> -     */
> -    orion5x_ehci0_init();
> -    orion5x_ehci1_init();
> -    orion5x_eth_init(&lschl_eth_data);
> -    orion5x_i2c_init();
> -    orion5x_sata_init(&lschl_sata_data);
> -    orion5x_uart0_init();
> -    orion5x_xor_init();
> -
> -    mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -                    ORION_MBUS_DEVBUS_BOOT_ATTR,
> -                    LSCHL_NOR_BOOT_BASE,
> -                    LSCHL_NOR_BOOT_SIZE);
> -    platform_device_register(&lschl_nor_flash);
> -
> -    platform_device_register(&lschl_leds);
> -
> -    platform_device_register(&lschl_button_device);
> -
> -    platform_device_register(&lschl_fan_device);
> -
> -    i2c_register_board_info(0, &lschl_i2c_rtc, 1);
> -
> -    /* usb power on */
> -    gpio_set_value(LSCHL_GPIO_USB_POWER, 1);
> -
> -    /* register power-off method */
> -    pm_power_off = lschl_power_off;
> -
> -    pr_info("%s: finished\n", __func__);
> -}
> -
> -MACHINE_START(LINKSTATION_LSCHL, "Buffalo Linkstation LiveV3 (LS-CHL)")
> -    /* Maintainer: Ash Hughes <ashley.hughes@blueyonder.co.uk> */
> -    .atag_offset    = 0x100,
> -    .nr_irqs    = ORION5X_NR_IRQS,
> -    .init_machine    = lschl_init,
> -    .map_io        = orion5x_map_io,
> -    .init_early    = orion5x_init_early,
> -    .init_irq    = orion5x_init_irq,
> -    .init_time    = orion5x_timer_init,
> -    .fixup        = tag_fixup_mem32,
> -    .restart    = orion5x_restart,
> -MACHINE_END
> -- 2.7.4
>
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
