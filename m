From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 08 Sep 2016 14:41:35 +0200
Subject: [PATCH 6/8 v2] arm: orion5x: Add DT-based support for Netgear
 WNR854T
In-Reply-To: <1473109646-23366-1-git-send-email-jm@lentin.co.uk> (Jamie
 Lentin's message of "Mon, 5 Sep 2016 22:07:26 +0100")
References: <1472203264-21089-7-git-send-email-jm@lentin.co.uk>
 <1473109646-23366-1-git-send-email-jm@lentin.co.uk>
Message-ID: <87d1kebm2o.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jamie,
 
 On lun., sept. 05 2016, Jamie Lentin <jm@lentin.co.uk> wrote:

> This is a router based on the mv88f5181 chipset.
>
> http://www.netgear.com/support/product/WNR854T.aspx
> http://wiki.openwrt.org/toh/netgear/wnr854t
>
> Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
> ---
> This removes the contentious vendor partitioning scheme and goes back
> to the original partitioning scheme used in non-DT ports to this board.
> Using the same partitioning scheme should mean less surprises for
> someone trying to upgrade their router.
>
> The non-DT PCI setup is still here, as there are other orion5x DT boards
> doing very similar things, and can all be converted at the same time.

I only noticed today your v2. I expected a full series actually.  I am
now taking care of it. I mainly have to rename most of the commit titles
as they do not really match the subsystem where they will be applied.

I will apply all of them on the mvebu branches to avoid to more
dependency issue. However, we are very close to the end of the merge
window for arm-soc. I will do my best, but the merge of the series could
be delayed to 4.10.

Thanks,

Gregory


>
> The patchset in it's entirety is available at
> https://github.com/lentinj/linux wnr854t-support-v2
>
> Cheers,
> ---
>  .../bindings/arm/marvell/marvell,orion5x.txt       |   1 +
>  arch/arm/boot/dts/Makefile                         |   1 +
>  arch/arm/boot/dts/orion5x-netgear-wnr854t.dts      | 197 +++++++++++++++++++++
>  arch/arm/mach-orion5x/Kconfig                      |   6 +
>  arch/arm/mach-orion5x/Makefile                     |   1 +
>  arch/arm/mach-orion5x/board-wnr854t.c              |  78 ++++++++
>  6 files changed, 284 insertions(+)
>  create mode 100644 arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
>  create mode 100644 arch/arm/mach-orion5x/board-wnr854t.c
>
> diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
> index ff3c120..748a8f2 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/marvell,orion5x.txt
> @@ -22,3 +22,4 @@ board. Currently known boards are:
>  "lacie,d2-network"
>  "marvell,rd-88f5182-nas"
>  "maxtor,shared-storage-2"
> +"netgear,wnr854t"
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index faacd52..4588b3c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -584,6 +584,7 @@ dtb-$(CONFIG_ARCH_ORION5X) += \
>  	orion5x-linkstation-lswtgl.dtb \
>  	orion5x-lswsgl.dtb \
>  	orion5x-maxtor-shared-storage-2.dtb \
> +	orion5x-netgear-wnr854t.dtb \
>  	orion5x-rd88f5182-nas.dtb
>  dtb-$(CONFIG_ARCH_PRIMA2) += \
>  	prima2-evb.dtb
> diff --git a/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
> new file mode 100644
> index 0000000..cce5091
> --- /dev/null
> +++ b/arch/arm/boot/dts/orion5x-netgear-wnr854t.dts
> @@ -0,0 +1,197 @@
> +/*
> + * Copyright (C) 2016 Jamie Lentin <jm@lentin.co.uk>
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
> +#include "orion5x-mv88f5181.dtsi"
> +
> +/ {
> +	model = "Netgear WNR854-t";
> +	compatible = "netgear,wnr854t", "marvell,orion5x-88f5181",
> +		     "marvell,orion5x";
> +
> +	memory {
> +		reg = <0x00000000 0x2000000>; /* 32 MB */
> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000>,
> +			 <MBUS_ID(0x09, 0x00) 0 0xf2200000 0x800>,
> +			 <MBUS_ID(0x01, 0x0f) 0 0xf4000000 0x800000>;
> +	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pmx_reset_button>;
> +		pinctrl-names = "default";
> +
> +		reset {
> +			label = "Reset Button";
> +			linux,code = <KEY_RESTART>;
> +			gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +
> +	gpio-leds {
> +		compatible = "gpio-leds";
> +		pinctrl-0 = <&pmx_power_led &pmx_power_led_blink &pmx_wan_led>;
> +		pinctrl-names = "default";
> +
> +		led at 0 {
> +			label = "wnr854t:green:power";
> +			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led at 1 {
> +			label = "wnr854t:blink:power";
> +			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
> +		};
> +
> +		led at 2 {
> +			label = "wnr854t:green:wan";
> +			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
> +		};
> +	};
> +};
> +
> +&devbus_bootcs {
> +	status = "okay";
> +
> +	devbus,keep-config;
> +
> +	flash at 0 {
> +		compatible = "cfi-flash";
> +		reg = <0 0x800000>;
> +		bank-width = <2>;
> +
> +		partitions {
> +			compatible = "fixed-partitions";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			partition at 0 {
> +				label = "kernel";
> +				reg = <0x0 0x100000>;
> +			};
> +
> +			partition at 100000 {
> +				label = "rootfs";
> +				reg = <0x100000 0x660000>;
> +			};
> +
> +			partition at 760000 {
> +				label = "uboot_env";
> +				reg = <0x760000 0x20000>;
> +			};
> +
> +			partition at 780000 {
> +				label = "uboot";
> +				reg = <0x780000 0x80000>;
> +				read-only;
> +			};
> +		};
> +	};
> +};
> +
> +&mdio {
> +	status = "okay";
> +
> +	switch: switch at 0 {
> +		compatible = "marvell,mv88e6085";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0>;
> +		dsa,member = <0 0>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				label = "lan3";
> +			};
> +
> +			port at 1 {
> +				reg = <1>;
> +				label = "lan4";
> +			};
> +
> +			port at 2 {
> +				reg = <2>;
> +				label = "wan";
> +			};
> +
> +			port at 3 {
> +				reg = <3>;
> +				label = "cpu";
> +			};
> +
> +			port at 5 {
> +				reg = <5>;
> +				label = "lan1";
> +			};
> +
> +			port at 7 {
> +				reg = <7>;
> +				label = "lan2";
> +			};
> +		};
> +	};
> +};
> +
> +&eth {
> +	status = "okay";
> +
> +	ethernet-port at 0 {
> +		/* Hardwired to DSA switch */
> +		speed = <1000>;
> +		duplex = <1>;
> +	};
> +};
> +
> +&pinctrl {
> +	pinctrl-0 = <&pmx_pci_gpios>;
> +	pinctrl-names = "default";
> +
> +	pmx_power_led: pmx-power-led {
> +		marvell,pins = "mpp0";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_reset_button: pmx-reset-button {
> +		marvell,pins = "mpp1";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_power_led_blink: pmx-power-led-blink {
> +		marvell,pins = "mpp2";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_wan_led: pmx-wan-led {
> +		marvell,pins = "mpp3";
> +		marvell,function = "gpio";
> +	};
> +
> +	pmx_pci_gpios: pmx-pci-gpios {
> +		marvell,pins = "mpp4";
> +		marvell,function = "gpio";
> +	};
> +};
> +
> +&uart0 {
> +	/* Pin 1: Tx, Pin 7: Rx, Pin 8: Gnd */
> +	status = "okay";
> +};
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index 89bb0fc..9acb37b 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -151,6 +151,12 @@ config MACH_MSS2_DT
>  	  Say 'Y' here if you want your kernel to support the
>  	  Maxtor Shared Storage II platform.
>  
> +config MACH_WNR854T_DT
> +	bool "Netgear WNR854T (Flattened Device Tree)"
> +	help
> +	  Say 'Y' here if you want your kernel to support the
> +	  Netgear WNR854T platform.
> +
>  config MACH_WNR854T
>  	bool "Netgear WNR854T"
>  	help
> diff --git a/arch/arm/mach-orion5x/Makefile b/arch/arm/mach-orion5x/Makefile
> index 4b2502b..9dff2d3 100644
> --- a/arch/arm/mach-orion5x/Makefile
> +++ b/arch/arm/mach-orion5x/Makefile
> @@ -24,3 +24,4 @@ obj-$(CONFIG_ARCH_ORION5X_DT)		+= board-dt.o
>  obj-$(CONFIG_MACH_D2NET_DT)	+= board-d2net.o
>  obj-$(CONFIG_MACH_MSS2_DT)	+= board-mss2.o
>  obj-$(CONFIG_MACH_RD88F5182_DT)	+= board-rd88f5182.o
> +obj-$(CONFIG_MACH_WNR854T_DT)	+= board-wnr854t.o
> diff --git a/arch/arm/mach-orion5x/board-wnr854t.c b/arch/arm/mach-orion5x/board-wnr854t.c
> new file mode 100644
> index 0000000..c506e33
> --- /dev/null
> +++ b/arch/arm/mach-orion5x/board-wnr854t.c
> @@ -0,0 +1,78 @@
> +/*
> + * Netgear WNR854T PCI setup
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +#include <linux/gpio.h>
> +#include <linux/platform_device.h>
> +#include <linux/pci.h>
> +#include <asm/mach/pci.h>
> +#include "common.h"
> +#include "orion5x.h"
> +
> +#define WNR854T_PCI_SLOT0_OFFS	7
> +#define WNR854T_PCI_SLOT0_IRQ_PIN	4
> +
> +static void __init wnr854t_pci_preinit(void)
> +{
> +	int pin;
> +
> +	/*
> +	 * Configure PCI GPIO IRQ pins
> +	 */
> +	pin = WNR854T_PCI_SLOT0_IRQ_PIN;
> +	if (gpio_request(pin, "PCI Int") == 0) {
> +		if (gpio_direction_input(pin) == 0) {
> +			irq_set_irq_type(gpio_to_irq(pin), IRQ_TYPE_LEVEL_LOW);
> +		} else {
> +			pr_err("wnr854t_pci_preinit failed to set_irq_type pin %d\n",
> +				pin);
> +			gpio_free(pin);
> +		}
> +	} else {
> +		pr_err("wnr854t_pci_preinit failed to request gpio %d\n", pin);
> +	}
> +}
> +
> +static int __init wnr854t_pci_map_irq(const struct pci_dev *dev, u8 slot,
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
> +	switch (slot - WNR854T_PCI_SLOT0_OFFS) {
> +	case 0:
> +		return gpio_to_irq(WNR854T_PCI_SLOT0_IRQ_PIN);
> +	default:
> +		return -1;
> +	}
> +}
> +
> +static struct hw_pci wnr854t_pci __initdata = {
> +	.nr_controllers	= 2,
> +	.preinit	= wnr854t_pci_preinit,
> +	.setup		= orion5x_pci_sys_setup,
> +	.scan		= orion5x_pci_sys_scan_bus,
> +	.map_irq	= wnr854t_pci_map_irq,
> +};
> +
> +static int __init wnr854t_pci_init(void)
> +{
> +	if (of_machine_is_compatible("netgear,wnr854t"))
> +		pci_common_init(&wnr854t_pci);
> +
> +	return 0;
> +}
> +/* NB: Use late_initcall so we can gpio_request() without being deferred */
> +late_initcall(wnr854t_pci_init);
> -- 
> 2.8.1
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
