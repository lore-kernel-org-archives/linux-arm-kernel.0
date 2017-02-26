From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 26 Feb 2017 02:50:35 +0100
Subject: [PATCH v2 2/2] arm64: dts: hisilicon: add dts files for
 hi3798cv200-poplar board
In-Reply-To: <1487752716-14824-3-git-send-email-xuejiancheng@hisilicon.com>
References: <1487752716-14824-1-git-send-email-xuejiancheng@hisilicon.com>
 <1487752716-14824-3-git-send-email-xuejiancheng@hisilicon.com>
Message-ID: <aa3f8ae7-d006-2eaf-222e-79ebc635e150@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.02.2017 um 09:38 schrieb Jiancheng Xue:
> Add basic dts files for hi3798cv200-poplar board. Poplar is the
> first development board compliant with the 96Boards Enterprise
> edition TV Platform specification. The board features the

"Enterprise Edition"

> Hi3798CV200 with an integrated quad-core 64-bit ARM Cortex A53
> processor and high performance Mali T720 GPU.
> 
> Signed-off-by: Jiancheng Xue <xuejiancheng@hisilicon.com>
> Reviewed-by: Alex Elder <elder@linaro.org>
> ---
> Changed Log:
> v2:
> - Fixed issues pointed by Rob Herring.
>   1. Moved the led node out of the soc node.
>   2. Restrained the ranges property of soc node smaller.
> - Refined the patch according to Andreas's suggestions.
> - Enabled gmac1 device node instead of gmac0.
> - Added a compatible string "syscon" for crg nodes.
> 
>  arch/arm64/boot/dts/hisilicon/Makefile             |   1 +
>  .../boot/dts/hisilicon/hi3798cv200-poplar.dts      | 171 +++++++++
>  arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi     | 415 +++++++++++++++++++++
>  3 files changed, 587 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
>  create mode 100644 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/Makefile b/arch/arm64/boot/dts/hisilicon/Makefile
> index c3a6c19..8960eca 100644
> --- a/arch/arm64/boot/dts/hisilicon/Makefile
> +++ b/arch/arm64/boot/dts/hisilicon/Makefile
> @@ -1,4 +1,5 @@
>  dtb-$(CONFIG_ARCH_HISI) += hi3660-hikey960.dtb
> +dtb-$(CONFIG_ARCH_HISI) += hi3798cv200-poplar.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hi6220-hikey.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hip05-d02.dtb
>  dtb-$(CONFIG_ARCH_HISI) += hip06-d03.dtb
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> new file mode 100644
> index 0000000..967853a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dts
> @@ -0,0 +1,171 @@
> +/*
> + * DTS File for HiSilicon Poplar Development Board
> + *
> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.

Rob has requested that new DT files use SPDX-License-Identifier, i.e.:

SPDX-License-Identifier: GPL-2.0+

although I believe dual-licensing is generally preferred for DT files:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +#include "hi3798cv200.dtsi"
> +
> +/ {
> +	model = "HiSilicon Poplar Development Board";
> +	compatible = "hisilicon,hi3798cv200-poplar", "hisilicon,hi3798cv200";
> +
> +	aliases {
> +		serial0 = &uart0;

No alias for uart2?

> +	};
> +
> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +	};
> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x0 0x0 0x0 0x80000000>;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		user-led0 {
> +			label = "USER-LED0";
> +			gpios = <&gpio6 3 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "heartbeat";
> +			default-state = "off";
> +		};
> +
> +		user-led1 {
> +			label = "USER-LED1";
> +			gpios = <&gpio5 1 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "mmc0";
> +			default-state = "off";
> +		};
> +
> +		user-led2 {
> +			label = "USER-LED2";
> +			gpios = <&gpio5 2 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "none";
> +			default-state = "off";
> +		};
> +
> +		user-led3 {
> +			label = "USER-LED3";
> +			gpios = <&gpio10 6 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "cpu0";
> +			default-state = "off";
> +		};
> +	};
> +};
> +
> +&uart0 {
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	status = "okay";
> +	label = "LS-UART0";
> +};
> +/* No optional LS-UART1 on Low Speed Expansion Connector. */
> +
> +&i2c0 {
> +	status = "okay";
> +	label = "LS-I2C0";
> +};
> +
> +&i2c2 {
> +	status = "okay";
> +	label = "LS-I2C1";
> +};
> +
> +&spi0 {
> +	status = "okay";
> +	label = "LS-SPI0";
> +};
> +
> +&gpio1 {
> +	status = "okay";
> +	gpio-line-names = "LS-GPIO-E",	"",
> +			  "",		"",
> +			  "",		"LS-GPIO-F",
> +			  "",		"LS-GPIO-J";
> +};
> +
> +&gpio2 {
> +	status = "okay";
> +	gpio-line-names = "LS-GPIO-H",	"LS-GPIO-I",
> +			  "LS-GPIO-L",	"LS-GPIO-G",
> +			  "LS-GPIO-K",	"",
> +			  "",		"";
> +};
> +
> +&gpio3 {
> +	status = "okay";
> +	gpio-line-names = "",		"",
> +			  "",		"",
> +			  "LS-GPIO-C",	"",
> +			  "",		"LS-GPIO-B";
> +};
> +
> +&gpio4 {
> +	status = "okay";
> +	gpio-line-names = "",		"",
> +			  "",		"",
> +			  "",		"LS-GPIO-D",
> +			  "",		"";
> +};
> +
> +&gpio5 {
> +	status = "okay";
> +	gpio-line-names = "",		"USER-LED-1",
> +			  "USER-LED-2",	"",
> +			  "",		"LS-GPIO-A",
> +			  "",		"";
> +};
> +
> +&gpio6 {
> +	status = "okay";
> +	gpio-line-names = "",		"",
> +			  "",		"USER-LED-0",
> +			  "",		"",
> +			  "",		"";
> +};
> +
> +&gpio10 {
> +	status = "okay";
> +	gpio-line-names = "",		"",
> +			  "",		"",
> +			  "",		"",
> +			  "USER-LED-3",	"";
> +};
> +
> +&gmac1 {
> +	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	phy-handle = <&eth_phy1>;
> +	phy-mode = "rgmii";
> +	hisilicon,phy-reset-delays-us = <10000 10000 30000>;
> +
> +	eth_phy1: phy at 3 {
> +		reg = <3>;
> +	};
> +};
> +
> +&ir {
> +	status = "okay";
> +};

The node sort order seems quite random; suggest alphabetically.

> diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> new file mode 100644
> index 0000000..3974dd4
> --- /dev/null
> +++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
> @@ -0,0 +1,415 @@
> +/*
> + * DTS File for HiSilicon Hi3798cv200 SoC.
> + *
> + * Copyright (c) 2016-2017 HiSilicon Technologies Co., Ltd.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>.

SPDX-License-Identifier

> + */
[snip]

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
