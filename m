From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 23 Apr 2014 13:30:45 +0200
Subject: [PATCH v2 34/38] ARM: orion5x: convert RD-88F5182 to Device Tree
In-Reply-To: <1398202002-28530-35-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1398202002-28530-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1398202002-28530-35-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5357A465.7090600@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 11:26 PM, Thomas Petazzoni wrote:
> This commit converts the RD-88F5182 platform to the Device Tree. All
> devices except the PCI are converted to the Device Tree.
>
> It is worth noting that:
>
>   * The PCI description for the DT case is kept in board-rd88f5182.c.
>
>   * The existing non-DT support in rd88f5182-setup.c is kept as is, in
>     order to allow testing of a given platform in both DT and non-DT
>     cases. It will ultimately be removed, once we no longer care about
>     non-DT support for Orion5x.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Ronen Shitrit <rshitrit@marvell.com>

Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

> ---
>   arch/arm/boot/dts/Makefile                  |   3 +-
>   arch/arm/boot/dts/orion5x-rd88f5182-nas.dts | 177 ++++++++++++++++++++++++++++
>   arch/arm/mach-orion5x/Kconfig               |   8 ++
>   arch/arm/mach-orion5x/Makefile              |   1 +
>   arch/arm/mach-orion5x/board-rd88f5182.c     | 116 ++++++++++++++++++
>   5 files changed, 304 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
>   create mode 100644 arch/arm/mach-orion5x/board-rd88f5182.c
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 35c146f..f7943a8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -289,7 +289,8 @@ dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>   	am43x-epos-evm.dtb \
>   	am437x-gp-evm.dtb \
>   	dra7-evm.dtb
> -dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb
> +dtb-$(CONFIG_ARCH_ORION5X) += orion5x-lacie-ethernet-disk-mini-v2.dtb \
> +	orion5x-rd88f5182-nas.dtb
>   dtb-$(CONFIG_ARCH_PRIMA2) += prima2-evb.dtb
>   dtb-$(CONFIG_ARCH_QCOM) += qcom-msm8660-surf.dtb \
>   	qcom-msm8960-cdp.dtb \
> diff --git a/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
> new file mode 100644
> index 0000000..6fb0525
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-rd88f5182-nas.dts
> @@ -0,0 +1,177 @@
> +/*
> + * Copyright (C) 2014 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "orion5x-mv88f5182.dtsi"
> +
> +/ {
> +	model = "Marvell Reference Design 88F5182 NAS";
> +	compatible = "marvell,rd-88f5182-nas", "marvell,orion5x-88f5182", "marvell,orion5x";
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
> +		         <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
> +			 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x80000>,
> +			 <MBUS_ID(0x01, 0x1d) 0 0xfc000000 0x1000000>;
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_debug_led>;
> +		pinctrl-names = "default";
> +
> +		led at 0 {
> +			label = "rd88f5182:cpu";
> +			linux,default-trigger = "heartbeat";
> +			gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
> +		};
> +	};
> +};
> +
> +&devbus_bootcs {
> +	status = "okay";
> +
> +	/* Read parameters */
> +	devbus,bus-width    = <8>;
> +	devbus,turn-off-ps  = <90000>;
> +	devbus,badr-skew-ps = <0>;
> +	devbus,acc-first-ps = <186000>;
> +	devbus,acc-next-ps  = <186000>;
> +
> +	/* Write parameters */
> +	devbus,wr-high-ps  = <90000>;
> +	devbus,wr-low-ps   = <90000>;
> +	devbus,ale-wr-ps   = <90000>;
> +
> +	flash at 0 {
> +		compatible = "cfi-flash";
> +		reg = <0 0x80000>;
> +		bank-width = <1>;
> +	};
> +};
> +
> +&devbus_cs1 {
> +	status = "okay";
> +
> +	/* Read parameters */
> +	devbus,bus-width    = <8>;
> +	devbus,turn-off-ps  = <90000>;
> +	devbus,badr-skew-ps = <0>;
> +	devbus,acc-first-ps = <186000>;
> +	devbus,acc-next-ps  = <186000>;
> +
> +	/* Write parameters */
> +	devbus,wr-high-ps  = <90000>;
> +	devbus,wr-low-ps   = <90000>;
> +	devbus,ale-wr-ps   = <90000>;
> +
> +	flash at 0 {
> +		compatible = "cfi-flash";
> +		reg = <0 0x1000000>;
> +		bank-width = <1>;
> +	};
> +};
> +
> +&ehci0 {
> +	status = "okay";
> +};
> +
> +&ehci1 {
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
> +		pinctrl-0 = <&pmx_rtc>;
> +		pinctrl-names = "default";
> +		compatible = "dallas,ds1338";
> +		reg = <0x68>;
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
> +&pinctrl {
> +	pinctrl-0 = <&pmx_reset_switch &pmx_misc_gpios
> +		&pmx_pci_gpios>;
> +	pinctrl-names = "default";
> +
> +	/*
> +	 * MPP[20] PCI Clock to MV88F5182
> +	 * MPP[21] PCI Clock to mini PCI CON11
> +	 * MPP[22] USB 0 over current indication
> +	 * MPP[23] USB 1 over current indication
> +	 * MPP[24] USB 1 over current enable
> +	 * MPP[25] USB 0 over current enable
> +	 */
> +
> +	pmx_debug_led: pmx-debug_led {
> +		marvell,pins = "mpp0";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_reset_switch: pmx-reset-switch {
> +		marvell,pins = "mpp1";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_rtc: pmx-rtc {
> +		marvell,pins = "mpp3";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_misc_gpios: pmx-misc-gpios {
> +		marvell,pins = "mpp4", "mpp5";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_pci_gpios: pmx-pci-gpios {
> +		marvell,pins = "mpp6", "mpp7";
> +		marvell,function = "gpio";
> +	};
> +};
> +
> +&sata {
> +	pinctrl-0 = <&pmx_sata0 &pmx_sata1>;
> +	pinctrl-names = "default";
> +	status = "okay";
> +	nr-ports = <2>;
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index 928f4cb..11b0c7e 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -28,6 +28,14 @@ config MACH_RD88F5182
>   	  Say 'Y' here if you want your kernel to support the
>   	  Marvell Orion-NAS (88F5182) RD2
>
> +config MACH_RD88F5182_DT
> +	bool "Marvell Orion-NAS Reference Design (Flattened Device Tree)"
> +	select ARCH_ORION5X_DT
> +	select I2C_BOARDINFO
> +	help
> +	  Say 'Y' here if you want your kernel to support the Marvell
> +	  Orion-NAS (88F5182) RD2, Flattened Device Tree.
> +
>   config MACH_KUROBOX_PRO
>   	bool "KuroBox Pro"
>   	select I2C_BOARDINFO
> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
> index e8fdbdd..f405894 100644
> --- a/arch/arm/mach-orion5x/Makefile
> +++ b/arch/arm/mach-orion5x/Makefile
> @@ -23,3 +23,4 @@ obj-$(CONFIG_MACH_RD88F6183AP_GE)	+= rd88f6183ap-ge-setup.o
>   obj-$(CONFIG_MACH_LINKSTATION_LSCHL)	+= ls-chl-setup.o
>
>   obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
> +obj-$(CONFIG_MACH_RD88F5182_DT)	+= board-rd88f5182.o
> diff --git a/arch/arm/mach-orion5x/board-rd88f5182.c b/arch/arm/mach-orion5x/board-rd88f5182.c
> new file mode 100644
> index 0000000..270824b
> --- /dev/null
> +++ b/arch/arm/mach-orion5x/board-rd88f5182.c
> @@ -0,0 +1,116 @@
> +/*
> + * arch/arm/mach-orion5x/rd88f5182-setup.c
> + *
> + * Marvell Orion-NAS Reference Design Setup
> + *
> + * Maintainer: Ronen Shitrit <rshitrit@marvell.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/gpio.h>
> +#include <linux/kernel.h>
> +#include <linux/init.h>
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <asm/mach-types.h>
> +#include <asm/mach/arch.h>
> +#include <asm/mach/pci.h>
> +#include <mach/orion5x.h>
> +#include "common.h"
> +
> +/*****************************************************************************
> + * RD-88F5182 Info
> + ****************************************************************************/
> +
> +/*
> + * PCI
> + */
> +
> +#define RD88F5182_PCI_SLOT0_OFFS	7
> +#define RD88F5182_PCI_SLOT0_IRQ_A_PIN	7
> +#define RD88F5182_PCI_SLOT0_IRQ_B_PIN	6
> +
> +/*****************************************************************************
> + * PCI
> + ****************************************************************************/
> +
> +static void __init rd88f5182_pci_preinit(void)
> +{
> +	int pin;
> +
> +	/*
> +	 * Configure PCI GPIO IRQ pins
> +	 */
> +	pin = RD88F5182_PCI_SLOT0_IRQ_A_PIN;
> +	if (gpio_request(pin, "PCI IntA") == 0) {
> +		if (gpio_direction_input(pin) == 0) {
> +			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
> +		} else {
> +			printk(KERN_ERR "rd88f5182_pci_preinit failed to "
> +					"set_irq_type pin %d\n", pin);
> +			gpio_free(pin);
> +		}
> +	} else {
> +		printk(KERN_ERR "rd88f5182_pci_preinit failed to request gpio %d\n", pin);
> +	}
> +
> +	pin = RD88F5182_PCI_SLOT0_IRQ_B_PIN;
> +	if (gpio_request(pin, "PCI IntB") == 0) {
> +		if (gpio_direction_input(pin) == 0) {
> +			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
> +		} else {
> +			printk(KERN_ERR "rd88f5182_pci_preinit failed to "
> +					"set_irq_type pin %d\n", pin);
> +			gpio_free(pin);
> +		}
> +	} else {
> +		printk(KERN_ERR "rd88f5182_pci_preinit failed to gpio_request %d\n", pin);
> +	}
> +}
> +
> +static int __init rd88f5182_pci_map_irq(const struct pci_dev *dev, u8 slot,
> +	u8 pin)
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
> +	/*
> +	 * PCI IRQs are connected via GPIOs
> +	 */
> +	switch (slot - RD88F5182_PCI_SLOT0_OFFS) {
> +	case 0:
> +		if (pin == 1)
> +			return gpio_to_irq(RD88F5182_PCI_SLOT0_IRQ_A_PIN);
> +		else
> +			return gpio_to_irq(RD88F5182_PCI_SLOT0_IRQ_B_PIN);
> +	default:
> +		return -1;
> +	}
> +}
> +
> +static struct hw_pci rd88f5182_pci __initdata = {
> +	.nr_controllers	= 2,
> +	.preinit	= rd88f5182_pci_preinit,
> +	.setup		= orion5x_pci_sys_setup,
> +	.scan		= orion5x_pci_sys_scan_bus,
> +	.map_irq	= rd88f5182_pci_map_irq,
> +};
> +
> +static int __init rd88f5182_pci_init(void)
> +{
> +	if (of_machine_is_compatible("marvell,rd-88f5182-nas"))
> +		pci_common_init(&rd88f5182_pci);
> +
> +	return 0;
> +}
> +
> +subsys_initcall(rd88f5182_pci_init);
>
