From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:33:26 +0200
Subject: [PATCH v2 36/38] ARM: orion5x: convert Maxtor Shared Storage
 II to the Device Tree
In-Reply-To: <1398202002-28530-37-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-37-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A506.6090905@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> This commit converts the Maxtor Shared Storage II Orion5x platform to
> the Device Tree. The only remaining things not converted are PCI and
> the special power off method.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Sylver Bruneau <sylver.bruneau@googlemail.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/Makefile                         |   1 +
>   .../boot/dts/orion5x-maxtor-shared-storage-2.dts   | 178 +++++++++++++
>   arch/arm/mach-orion5x/Kconfig                      |   5 +-
>   arch/arm/mach-orion5x/Makefile                     |   2 +-
>   arch/arm/mach-orion5x/board-dt.c                   |   3 +
>   arch/arm/mach-orion5x/board-mss2.c                 |  90 +++++++
>   arch/arm/mach-orion5x/common.h                     |   6 +
>   arch/arm/mach-orion5x/mss2-setup.c                 | 274 ---------------------
>   8 files changed, 282 insertions(+), 277 deletions(-)
>   create mode 100644 arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
>   create mode 100644 arch/arm/mach-orion5x/board-mss2.c
>   delete mode 100644 arch/arm/mach-orion5x/mss2-setup.c
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 59397c2..629eee2 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -291,6 +291,7 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>   	dra7-evm.dtb
>   dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-d2-network.dtb \
>   	orion5x-lacie-ethernet-disk-mini-v2.dtb \
> +	orion5x-maxtor-shared-storage-2.dtb \
>   	orion5x-rd88f5182-nas.dtb
>   dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
>   dtb-$(CONFIG_ARCH_QCOM) += qcom-msm8660-surf.dtb \
> diff --git a/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
> new file mode 100644
> index 0000000..ff34849
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-maxtor-shared-storage-2.dts
> @@ -0,0 +1,178 @@
> +/*
> + * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + * Copyright (C) Sylver Bruneau <sylver.bruneau@googlemail.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "orion5x-mv88f5182.dtsi"
> +
> +/ {
> +	model = "Maxtor Shared Storage II";
> +	compatible = "maxtor,shared-storage-2", "marvell,orion5x-88f5182", "marvell,orion5x";
> +
> +	memory {
> +		reg = <0x00000000 0x4000000>; /* 64 MB */
> +	};
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";
> +		linux,stdout-path = &uart0;
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
> +			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
> +			 <MBUS_ID(0x01, 0x0f) 0 0xff800000 0x40000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pmx_buttons>;
> +		pinctrl-names = "default";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		power {
> +			label = "Power";
> +			linux,code = <KEY_POWER>;
> +			gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		reset {
> +			label = "Reset";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&devbus_bootcs {
> +	status = "okay";
> +
> +	devbus,keep-config;
> +
> +	/*
> +	 * Currently the MTD code does not recognize the MX29LV400CBCT
> +	 * as a bottom-type device. This could cause risks of
> +	 * accidentally erasing critical flash sectors. We thus define
> +	 * a single, write-protected partition covering the whole
> +	 * flash.  TODO: once the flash part TOP/BOTTOM detection
> +	 * issue is sorted out in the MTD code, break this into at
> +	 * least three partitions: 'u-boot code', 'u-boot environment'
> +	 * and 'whatever is left'.
> +	 */
> +	flash at 0 {
> +		compatible = "cfi-flash";
> +		reg = <0 0x40000>;
> +		bank-width = <1>;
> +                #address-cells = <1>;
> +		#size-cells = <1>;
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	ethphy: ethernet-phy {
> +		reg = <8>;
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&eth {
> +	status = "okay";
> +
> +	ethernet-port at 0 {
> +		phy-handle = <&ethphy>;
> +	};
> +};
> +
> +&i2c {
> +	status = "okay";
> +	clock-frequency = <100000>;
> +	#address-cells = <1>;
> +
> +	rtc at 68 {
> +		compatible = "st,m41t81";
> +		reg = <0x68>;
> +		pinctrl-0 = <&pmx_rtc>;
> +		pinctrl-names = "default";
> +		interrupt-parent = <&gpio0>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +	};
> +};
> +
> +&pinctrl {
> +	pinctrl-0 = <&pmx_leds &pmx_misc>;
> +	pinctrl-names = "default";
> +
> +	pmx_buttons: pmx-buttons {
> +		marvell,pins = "mpp11", "mpp12";
> +		marvell,function = "gpio";
> +	};
> +
> +	/*
> +	 * MPP0: Power LED
> +	 * MPP1: Error LED
> +	 */
> +	pmx_leds: pmx-leds {
> +		marvell,pins = "mpp0", "mpp1";
> +		marvell,function = "gpio";
> +	};
> +
> +	/*
> +	 * MPP4: HDD ind. (Single/Dual)
> +	 * MPP5: HD0 5V control
> +	 * MPP6: HD0 12V control
> +	 * MPP7: HD1 5V control
> +	 * MPP8: HD1 12V control
> +	 */
> +	pmx_misc: pmx-misc {
> +		marvell,pins = "mpp4", "mpp5", "mpp6", "mpp7", "mpp8", "mpp10";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_rtc: pmx-rtc {
> +		marvell,pins = "mpp3";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_sata0_led_active: pmx-sata0-led-active {
> +		marvell,pins = "mpp14";
> +		marvell,function = "sata0";
> +	};
> +
> +	pmx_sata1_led_active: pmx-sata1-led-active {
> +		marvell,pins = "mpp15";
> +		marvell,function = "sata1";
> +	};
> +
> +	/*
> +	 * Non MPP GPIOs:
> +	 *  GPIO 22: USB port 1 fuse (0 = Fail, 1 = Ok)
> +	 *  GPIO 23: Blue front LED off
> +	 *  GPIO 24: Inhibit board power off (0 = Disabled, 1 = Enabled)
> +	 */
> +};
> +
> +&sata {
> +	pinctrl-0 = <&pmx_sata0_led_active
> +		     &pmx_sata1_led_active>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	nr-ports = <2>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index 3c4ad83..2412efb 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -129,8 +129,9 @@ config MACH_NET2BIG
>   	  Say 'Y' here if you want your kernel to support the
>   	  LaCie 2Big Network NAS.
>
> -config MACH_MSS2
> -	bool "Maxtor Shared Storage II"
> +config MACH_MSS2_DT
> +	bool "Maxtor Shared Storage II (Flattened Device Tree)"
> +	select ARCH_ORION5X_DT
>   	help
>   	  Say 'Y' here if you want your kernel to support the
>   	  Maxtor Shared Storage II platform.
> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
> index 787dcee..a40b5c9 100644
> --- a/arch/arm/mach-orion5x/Makefile
> +++ b/arch/arm/mach-orion5x/Makefile
> @@ -13,7 +13,6 @@ obj-$(CONFIG_MACH_WRT350N_V2)	+= wrt350n-v2-setup.o
>   obj-$(CONFIG_MACH_TS78XX)	+= ts78xx-setup.o
>   obj-$(CONFIG_MACH_MV2120)	+= mv2120-setup.o
>   obj-$(CONFIG_MACH_NET2BIG)	+= net2big-setup.o
> -obj-$(CONFIG_MACH_MSS2)		+= mss2-setup.o
>   obj-$(CONFIG_MACH_WNR854T)	+= wnr854t-setup.o
>   obj-$(CONFIG_MACH_RD88F5181L_GE)	+= rd88f5181l-ge-setup.o
>   obj-$(CONFIG_MACH_RD88F5181L_FXO)	+= rd88f5181l-fxo-setup.o
> @@ -22,4 +21,5 @@ obj-$(CONFIG_MACH_LINKSTATION_LSCHL)	+= ls-chl-setup.o
>
>   obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
>   obj-$(CONFIG_MACH_D2NET_DT)	+= board-d2net.o
> +obj-$(CONFIG_MACH_MSS2_DT)	+= board-mss2.o
>   obj-$(CONFIG_MACH_RD88F5182_DT)	+= board-rd88f5182.o
> diff --git a/arch/arm/mach-orion5x/board-dt.c b/arch/arm/mach-orion5x/board-dt.c
> index 78d2e52..35d418f 100644
> --- a/arch/arm/mach-orion5x/board-dt.c
> +++ b/arch/arm/mach-orion5x/board-dt.c
> @@ -61,6 +61,9 @@ static void __init orion5x_dt_init(void)
>   		cpu_idle_poll_ctrl(true);
>   	}
>
> +	if (of_machine_is_compatible("maxtor,shared-storage-2"))
> +		mss2_init();
> +
>   	of_platform_populate(NULL, of_default_bus_match_table,
>   			     orion5x_auxdata_lookup, NULL);
>   }
> diff --git a/arch/arm/mach-orion5x/board-mss2.c b/arch/arm/mach-orion5x/board-mss2.c
> new file mode 100644
> index 0000000..66f9c3b
> --- /dev/null
> +++ b/arch/arm/mach-orion5x/board-mss2.c
> @@ -0,0 +1,90 @@
> +/*
> + * Maxtor Shared Storage II Board Setup
> + *
> + * Maintainer: Sylver Bruneau <sylver.bruneau@googlemail.com>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * as published by the Free Software Foundation; either version
> + * 2 of the License, or (at your option) any later version.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/pci.h>
> +#include <mach/orion5x.h>
> +#include <mach/bridge-regs.h>
> +#include "common.h"
> +
> +/*****************************************************************************
> + * Maxtor Shared Storage II Info
> + ****************************************************************************/
> +
> +/****************************************************************************
> + * PCI setup
> + ****************************************************************************/
> +static int __init mss2_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> +{
> +	int irq;
> +
> +	/*
> +	 * Check for devices with hard-wired IRQs.
> +	 */
> +	irq = orion5x_pci_map_irq(dev, slot, pin);
> +	if (irq != -1)
> +		return irq;
> +
> +	return -1;
> +}
> +
> +static struct hw_pci mss2_pci __initdata = {
> +	.nr_controllers = 2,
> +	.setup		= orion5x_pci_sys_setup,
> +	.scan		= orion5x_pci_sys_scan_bus,
> +	.map_irq	= mss2_pci_map_irq,
> +};
> +
> +static int __init mss2_pci_init(void)
> +{
> +	if (machine_is_mss2())
> +		pci_common_init(&mss2_pci);
> +
> +	return 0;
> +}
> +subsys_initcall(mss2_pci_init);
> +
> +/*****************************************************************************
> + * MSS2 power off method
> + ****************************************************************************/
> +/*
> + * On the Maxtor Shared Storage II, the shutdown process is the following :
> + * - Userland modifies U-boot env to tell U-boot to go idle at next boot
> + * - The board reboots
> + * - U-boot starts and go into an idle mode until the user press "power"
> + */
> +static void mss2_power_off(void)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * Enable and issue soft reset
> +	 */
> +	reg = readl(RSTOUTn_MASK);
> +	reg |= 1 << 2;
> +	writel(reg, RSTOUTn_MASK);
> +
> +	reg = readl(CPU_SOFT_RESET);
> +	reg |= 1;
> +	writel(reg, CPU_SOFT_RESET);
> +}
> +
> +void __init mss2_init(void)
> +{
> +	/* register mss2 specific power-off method */
> +	pm_power_off = mss2_power_off;
> +}
> diff --git a/arch/arm/mach-orion5x/common.h b/arch/arm/mach-orion5x/common.h
> index 4470e31..26d6f34 100644
> --- a/arch/arm/mach-orion5x/common.h
> +++ b/arch/arm/mach-orion5x/common.h
> @@ -68,6 +68,12 @@ struct meminfo;
>   struct tag;
>   extern void __init tag_fixup_mem32(struct tag *, char **, struct meminfo *);
>
> +#ifdef CONFIG_MACH_MSS2_DT
> +extern void mss2_init(void);
> +#else
> +static inline void mss2_init(void) {}
> +#endif
> +
>   /*****************************************************************************
>    * Helpers to access Orion registers
>    ****************************************************************************/
> diff --git a/arch/arm/mach-orion5x/mss2-setup.c b/arch/arm/mach-orion5x/mss2-setup.c
> deleted file mode 100644
> index e105130..0000000
> --- a/arch/arm/mach-orion5x/mss2-setup.c
> +++ /dev/null
> @@ -1,274 +0,0 @@
> -/*
> - * Maxtor Shared Storage II Board Setup
> - *
> - * Maintainer: Sylver Bruneau <sylver.bruneau@googlemail.com>
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License
> - * as published by the Free Software Foundation; either version
> - * 2 of the License, or (at your option) any later version.
> - */
> -
> -#include <linux/kernel.h>
> -#include <linux/init.h>
> -#include <linux/platform_device.h>
> -#include <linux/pci.h>
> -#include <linux/irq.h>
> -#include <linux/mtd/physmap.h>
> -#include <linux/mv643xx_eth.h>
> -#include <linux/leds.h>
> -#include <linux/gpio_keys.h>
> -#include <linux/input.h>
> -#include <linux/i2c.h>
> -#include <linux/ata_platform.h>
> -#include <linux/gpio.h>
> -#include <asm/mach-types.h>
> -#include <asm/mach/arch.h>
> -#include <asm/mach/pci.h>
> -#include <mach/orion5x.h>
> -#include <mach/bridge-regs.h>
> -#include "common.h"
> -#include "mpp.h"
> -
> -#define MSS2_NOR_BOOT_BASE	0xff800000
> -#define MSS2_NOR_BOOT_SIZE	SZ_256K
> -
> -/*****************************************************************************
> - * Maxtor Shared Storage II Info
> - ****************************************************************************/
> -
> -/*
> - * Maxtor Shared Storage II hardware :
> - * - Marvell 88F5182-A2 C500
> - * - Marvell 88E1111 Gigabit Ethernet PHY
> - * - RTC M41T81 (@0x68) on I2C bus
> - * - 256KB NOR flash
> - * - 64MB of RAM
> - */
> -
> -/*****************************************************************************
> - * 256KB NOR Flash on BOOT Device
> - ****************************************************************************/
> -
> -static struct physmap_flash_data mss2_nor_flash_data = {
> -	.width		= 1,
> -};
> -
> -static struct resource mss2_nor_flash_resource = {
> -	.flags		= IORESOURCE_MEM,
> -	.start		= MSS2_NOR_BOOT_BASE,
> -	.end		= MSS2_NOR_BOOT_BASE + MSS2_NOR_BOOT_SIZE - 1,
> -};
> -
> -static struct platform_device mss2_nor_flash = {
> -	.name		= "physmap-flash",
> -	.id		= 0,
> -	.dev		= {
> -		.platform_data	= &mss2_nor_flash_data,
> -	},
> -	.resource	= &mss2_nor_flash_resource,
> -	.num_resources	= 1,
> -};
> -
> -/****************************************************************************
> - * PCI setup
> - ****************************************************************************/
> -static int __init mss2_pci_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
> -{
> -	int irq;
> -
> -	/*
> -	 * Check for devices with hard-wired IRQs.
> -	 */
> -	irq = orion5x_pci_map_irq(dev, slot, pin);
> -	if (irq != -1)
> -		return irq;
> -
> -	return -1;
> -}
> -
> -static struct hw_pci mss2_pci __initdata = {
> -	.nr_controllers = 2,
> -	.setup		= orion5x_pci_sys_setup,
> -	.scan		= orion5x_pci_sys_scan_bus,
> -	.map_irq	= mss2_pci_map_irq,
> -};
> -
> -static int __init mss2_pci_init(void)
> -{
> -	if (machine_is_mss2())
> -		pci_common_init(&mss2_pci);
> -
> -	return 0;
> -}
> -subsys_initcall(mss2_pci_init);
> -
> -
> -/*****************************************************************************
> - * Ethernet
> - ****************************************************************************/
> -
> -static struct mv643xx_eth_platform_data mss2_eth_data = {
> -	.phy_addr	= MV643XX_ETH_PHY_ADDR(8),
> -};
> -
> -/*****************************************************************************
> - * SATA
> - ****************************************************************************/
> -
> -static struct mv_sata_platform_data mss2_sata_data = {
> -	.n_ports	= 2,
> -};
> -
> -/*****************************************************************************
> - * GPIO buttons
> - ****************************************************************************/
> -
> -#define MSS2_GPIO_KEY_RESET	12
> -#define MSS2_GPIO_KEY_POWER	11
> -
> -static struct gpio_keys_button mss2_buttons[] = {
> -	{
> -		.code		= KEY_POWER,
> -		.gpio		= MSS2_GPIO_KEY_POWER,
> -		.desc		= "Power",
> -		.active_low	= 1,
> -	}, {
> -		.code		= KEY_RESTART,
> -		.gpio		= MSS2_GPIO_KEY_RESET,
> -		.desc		= "Reset",
> -		.active_low	= 1,
> -	},
> -};
> -
> -static struct gpio_keys_platform_data mss2_button_data = {
> -	.buttons	= mss2_buttons,
> -	.nbuttons	= ARRAY_SIZE(mss2_buttons),
> -};
> -
> -static struct platform_device mss2_button_device = {
> -	.name		= "gpio-keys",
> -	.id		= -1,
> -	.dev		= {
> -		.platform_data	= &mss2_button_data,
> -	},
> -};
> -
> -/*****************************************************************************
> - * RTC m41t81 on I2C bus
> - ****************************************************************************/
> -
> -#define MSS2_GPIO_RTC_IRQ	3
> -
> -static struct i2c_board_info __initdata mss2_i2c_rtc = {
> -	I2C_BOARD_INFO("m41t81", 0x68),
> -};
> -
> -/*****************************************************************************
> - * MSS2 power off method
> - ****************************************************************************/
> -/*
> - * On the Maxtor Shared Storage II, the shutdown process is the following :
> - * - Userland modifies U-boot env to tell U-boot to go idle at next boot
> - * - The board reboots
> - * - U-boot starts and go into an idle mode until the user press "power"
> - */
> -static void mss2_power_off(void)
> -{
> -	u32 reg;
> -
> -	/*
> -	 * Enable and issue soft reset
> -	 */
> -	reg = readl(RSTOUTn_MASK);
> -	reg |= 1 << 2;
> -	writel(reg, RSTOUTn_MASK);
> -
> -	reg = readl(CPU_SOFT_RESET);
> -	reg |= 1;
> -	writel(reg, CPU_SOFT_RESET);
> -}
> -
> -/****************************************************************************
> - * General Setup
> - ****************************************************************************/
> -static unsigned int mss2_mpp_modes[] __initdata = {
> -	MPP0_GPIO,		/* Power LED */
> -	MPP1_GPIO,		/* Error LED */
> -	MPP2_UNUSED,
> -	MPP3_GPIO,		/* RTC interrupt */
> -	MPP4_GPIO,		/* HDD ind. (Single/Dual)*/
> -	MPP5_GPIO,		/* HD0 5V control */
> -	MPP6_GPIO,		/* HD0 12V control */
> -	MPP7_GPIO,		/* HD1 5V control */
> -	MPP8_GPIO,		/* HD1 12V control */
> -	MPP9_UNUSED,
> -	MPP10_GPIO,		/* Fan control */
> -	MPP11_GPIO,		/* Power button */
> -	MPP12_GPIO,		/* Reset button */
> -	MPP13_UNUSED,
> -	MPP14_SATA_LED,		/* SATA 0 active */
> -	MPP15_SATA_LED,		/* SATA 1 active */
> -	MPP16_UNUSED,
> -	MPP17_UNUSED,
> -	MPP18_UNUSED,
> -	MPP19_UNUSED,
> -	0,
> -};
> -
> -static void __init mss2_init(void)
> -{
> -	/* Setup basic Orion functions. Need to be called early. */
> -	orion5x_init();
> -
> -	orion5x_mpp_conf(mss2_mpp_modes);
> -
> -	/*
> -	 * MPP[20] Unused
> -	 * MPP[21] PCI clock
> -	 * MPP[22] USB 0 over current
> -	 * MPP[23] USB 1 over current
> -	 */
> -
> -	/*
> -	 * Configure peripherals.
> -	 */
> -	orion5x_ehci0_init();
> -	orion5x_ehci1_init();
> -	orion5x_eth_init(&mss2_eth_data);
> -	orion5x_i2c_init();
> -	orion5x_sata_init(&mss2_sata_data);
> -	orion5x_uart0_init();
> -	orion5x_xor_init();
> -
> -	mvebu_mbus_add_window_by_id(ORION_MBUS_DEVBUS_BOOT_TARGET,
> -				    ORION_MBUS_DEVBUS_BOOT_ATTR,
> -				    MSS2_NOR_BOOT_BASE,
> -				    MSS2_NOR_BOOT_SIZE);
> -	platform_device_register(&mss2_nor_flash);
> -
> -	platform_device_register(&mss2_button_device);
> -
> -	if (gpio_request(MSS2_GPIO_RTC_IRQ, "rtc") == 0) {
> -		if (gpio_direction_input(MSS2_GPIO_RTC_IRQ) == 0)
> -			mss2_i2c_rtc.irq = gpio_to_irq(MSS2_GPIO_RTC_IRQ);
> -		else
> -			gpio_free(MSS2_GPIO_RTC_IRQ);
> -	}
> -	i2c_register_board_info(0, &mss2_i2c_rtc, 1);
> -
> -	/* register mss2 specific power-off method */
> -	pm_power_off = mss2_power_off;
> -}
> -
> -MACHINE_START(MSS2, "Maxtor Shared Storage II")
> -	/* Maintainer: Sylver Bruneau <sylver.bruneau@googlemail.com> */
> -	.atag_offset	= 0x100,
> -	.init_machine	= mss2_init,
> -	.map_io		= orion5x_map_io,
> -	.init_early	= orion5x_init_early,
> -	.init_irq	= orion5x_init_irq,
> -	.init_time	= orion5x_timer_init,
> -	.fixup		= tag_fixup_mem32,
> -	.restart	= orion5x_restart,
> -MACHINE_END
>
