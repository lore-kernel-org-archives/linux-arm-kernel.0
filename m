From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 6 Mar 2014 14:14:29 +0100
Subject: [PATCH] ARM: mvebu: add Device Tree for the Armada 385 RD board
In-Reply-To: <1394107868-26094-1-git-send-email-gregory.clement@free-electrons.com>
References: <1394107868-26094-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140306131429.GJ4780@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 01:11:08PM +0100, Gregory CLEMENT wrote:
> The Armada 385 RD board is the reference design board from Marvell
> for the Armada 385 SoC. This commit adds a Device Tree description for
> this board, which enables the following features:
> 
>  * Network interfaces
>  * I2C bus
>  * Serial port
>  * SPI bus, with a SPI flash
>  * PCIe interface
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi,
> 
> I have received this board only recently, so that why its device tree
> comes only now. This patch should not cause any trouble to other part
> of the kernel, so that's why I think it is reasonable to have it in
> 3.15.
> 
> Thanks,
> 
> Gregory
> 
> 
>  arch/arm/boot/dts/Makefile          |   3 +-
>  arch/arm/boot/dts/armada-385-rd.dts | 104 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 106 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/armada-385-rd.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index f7d678808122..9155cf48e1b1 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -153,7 +153,8 @@ dtb-$(CONFIG_MACH_ARMADA_370) += \
>  dtb-$(CONFIG_MACH_ARMADA_375) += \
>  	armada-375-db.dtb
>  dtb-$(CONFIG_MACH_ARMADA_38X) += \
> -	armada-385-db.dtb
> +	armada-385-db.dtb \
> +	armada-385-rd.dtb
>  dtb-$(CONFIG_MACH_ARMADA_XP) += \
>  	armada-xp-axpwifiap.dtb \
>  	armada-xp-db.dtb \
> diff --git a/arch/arm/boot/dts/armada-385-rd.dts b/arch/arm/boot/dts/armada-385-rd.dts
> new file mode 100644
> index 000000000000..951bd91059e1
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-385-rd.dts
> @@ -0,0 +1,104 @@
> +/*
> + * Device Tree file for Marvell Armada 385 Reference Design board
> + * (RD-88F6820-AP)
> + *
> + *  Copyright (C) 2014 Marvell
> + *
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +#include "armada-385.dtsi"
> +
> +/ {
> +	model = "Marvell Armada 385 Reference Design";
> +	compatible = "marvell,a385-rd", "marvell,armada385", "marvell,armada38x";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0x10000000>; /* 256 MB */
> +	};
> +
> +	soc {
> +		ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000
> +			  MBUS_ID(0x01, 0x1d) 0 0xfff00000 0x100000>;
> +
> +		internal-regs {
> +			spi at 10600 {
> +				status = "okay";
> +
> +				spi-flash at 0 {
> +					#address-cells = <1>;
> +					#size-cells = <1>;
> +					compatible = "m25p128";

Hi Gregory

I guess checkpatch.pl is probably complaining about missing vendor
prefix?

> +					reg = <0>; /* Chip select 0 */
> +					spi-max-frequency = <108000000>;
> +				};
> +			};
> +
> +			i2c at 11000 {
> +				status = "okay";
> +				clock-frequency = <100000>;
> +			};
> +
> +			serial at 12000 {
> +				clock-frequency = <200000000>;
> +				status = "okay";
> +			};
> +
> +
> +			/*
> +			 * The Ethernet nodes are not ordered by
> +			 * address on purpose. Indeed the first
> +			 * Ethernet port of the board (Giga0) is
> +			 * located at 0x70000 whereas the the second
> +			 * Ethernet(Giga 1) port is located at
> +			 * 0x30000.
> +			 */
> +
> +			ethernet at 70000 {
> +				status = "okay";
> +				phy = <&phy0>;
> +				phy-mode = "rgmii";
> +			};
> +
> +			ethernet at 30000 {
> +				status = "okay";
> +				phy = <&phy1>;
> +				phy-mode = "rgmii";
> +			};
> +

I think you can use aliases to get the order correct, independent of
how you list them in DT. That should be a lot safer than assuming
things are instantiated from top to bottom.

       Andrew
