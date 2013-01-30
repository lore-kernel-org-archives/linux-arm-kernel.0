From: florian@openwrt.org (Florian Fainelli)
Date: Wed, 30 Jan 2013 18:28:35 +0100
Subject: [PATCH] arm: mvebu: support for the new Armada XP evaluation
 board(DB-MV784MP-GP)
In-Reply-To: <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
References: <1359566774-27669-1-git-send-email-gregory.clement@free-electrons.com>
 <1359566774-27669-2-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <51095843.30107@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Gregory,

On 01/30/2013 06:26 PM, Gregory CLEMENT wrote:
> This is the new Armada XP evaluation board from Marvell. It comes with
> a RS232 port over USB, a SATA link, an internal SSD, 4 Ethernet
> Gigabit links.
>
> Support for USB (Host and device), SDIO, PCIe will be added as drivers
> when they become available for Armada XP in mainline.
>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>   arch/arm/boot/dts/Makefile         |    1 +
>   arch/arm/boot/dts/armada-xp-gp.dts |   94 ++++++++++++++++++++++++++++++++++++
>   2 files changed, 95 insertions(+)
>   create mode 100644 arch/arm/boot/dts/armada-xp-gp.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 5ebb44f..51aab4b 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -78,6 +78,7 @@ dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>   dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>   	armada-370-mirabox.dtb \
>   	armada-xp-db.dtb \
> +	armada-xp-gp.dtb \
>   	armada-xp-openblocks-ax3-4.dtb
>   dtb-$(CONFIG_ARCH_MXC) += imx51-babbage.dtb \
>   	imx53-ard.dtb \
> diff --git a/arch/arm/boot/dts/armada-xp-gp.dts b/arch/arm/boot/dts/armada-xp-gp.dts
> new file mode 100644
> index 0000000..85ba642
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-gp.dts
> @@ -0,0 +1,94 @@
> +/*
> + * Device Tree file for Marvell Armada XP evaluation board
> + * (RD-MV784MP-GP)

Marvell refers to this as a Reference Design (which it is because it is 
boxed).

> + *
> + * Copyright (C) 2013 Marvell
> + *
> + * Lior Amsalem <alior@marvell.com>
> + * Gregory CLEMENT <gregory.clement@free-electrons.com>
> + * Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +/dts-v1/;
> +/include/ "armada-xp-mv78460.dtsi"
> +
> +/ {
> +	model = "Marvell Armada XP Evaluation Board: RD-MV784MP-GP";

Ditto, should be "Marvell Armada XP Reference Design Board".
> +	compatible = "marvell,axp-db", "marvell,armadaxp-mv78460", "marvell,armadaxp", "marvell,armada-370-xp";
> +
> +	chosen {
> +		bootargs = "console=ttyS0,115200 earlyprintk";
> +	};
> +
> +	memory {
> +		device_type = "memory";
> +		reg = <0x00000000 0xC0000000>; /* 3 GB */
> +	};
> +
> +	soc {
> +		serial at d0012000 {
> +			clock-frequency = <250000000>;
> +			status = "okay";
> +		};
> +		serial at d0012100 {
> +			clock-frequency = <250000000>;
> +			status = "okay";
> +		};
> +		serial at d0012200 {
> +			clock-frequency = <250000000>;
> +			status = "okay";
> +		};
> +		serial at d0012300 {
> +			clock-frequency = <250000000>;
> +			status = "okay";
> +		};
> +
> +		sata at d00a0000 {
> +			nr-ports = <2>;
> +			status = "okay";
> +		};
> +
> +		mdio {
> +			phy0: ethernet-phy at 0 {
> +				reg = <16>;
> +			};
> +
> +			phy1: ethernet-phy at 1 {
> +				reg = <17>;
> +			};
> +
> +			phy2: ethernet-phy at 2 {
> +				reg = <18>;
> +			};
> +
> +			phy3: ethernet-phy at 3 {
> +				reg = <19>;
> +			};
> +		};

It seemed to me like the PHY addresses were 0 to 3, but I will test that 
within the next few minutes.
--
Florian
