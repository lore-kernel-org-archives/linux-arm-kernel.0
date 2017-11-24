From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri, 24 Nov 2017 21:57:37 +0100 (CET)
Subject: [PATCH] ARM: dts: add minimal device tree for compute model 3
In-Reply-To: <20171124121813.11318-1-kernel@martin.sperl.org>
References: <20171124121813.11318-1-kernel@martin.sperl.org>
Message-ID: <787908872.337073.1511557057220@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Martin,

thanks for working on this.

> kernel at martin.sperl.org hat am 24. November 2017 um 13:18 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add a minimal working device tree for the compute model 3
> for both arm and arm64.

i think it's worth to provide more context:

The Raspberry Compute Module 3 is a SoM which contains a BCM2837 processor, 1 GB RAM and a 4 GB eMMC. There is also a carrier board which is called Compute Module IO Board V3.

Datasheet:
https://www.raspberrypi.org/documentation/hardware/computemodule/RPI-CM-DATASHEET-V1_0.pdf

> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  arch/arm/boot/dts/Makefile                       |  1 +
>  arch/arm/boot/dts/bcm2837-rpi-cm3.dts            | 38 ++++++++++++++++++++++++
>  arch/arm64/boot/dts/broadcom/Makefile            |  1 +
>  arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3.dts |  2 ++
>  4 files changed, 42 insertions(+)
>  create mode 100644 arch/arm/boot/dts/bcm2837-rpi-cm3.dts
>  create mode 100644 arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index eff87a344566..b24a682c450d 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -75,6 +75,7 @@ dtb-$(CONFIG_ARCH_BCM2835) += \
>  	bcm2835-rpi-a-plus.dtb \
>  	bcm2836-rpi-2-b.dtb \
>  	bcm2837-rpi-3-b.dtb \
> +	bcm2837-rpi-cm3.dtb \

Since we need always 2 boards (SoM + carrier), i like to see two separate DT files. A DTSI file for the SoM (describe RAM, eMMC) and a DTS file for the carrier board (please look at arm/boot/dts/imx6ul-tx6ul.dtsi and arm/boot/dts/imx6ul-tx6ul-mainboard.dts as an example).

Suggested include hierarchy:

  bcm2837.dtsi
    bcm2837-rpi-cm3.dtsi
      bcm2837-rpi-cm3-io3.dts

>  	bcm2835-rpi-zero.dtb \
>  	bcm2835-rpi-zero-w.dtb
>  dtb-$(CONFIG_ARCH_BCM_5301X) += \
> diff --git a/arch/arm/boot/dts/bcm2837-rpi-cm3.dts b/arch/arm/boot/dts/bcm2837-rpi-cm3.dts
> new file mode 100644
> index 000000000000..f387bd8bd707
> --- /dev/null
> +++ b/arch/arm/boot/dts/bcm2837-rpi-cm3.dts
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/dts-v1/;
> +#include "bcm2837.dtsi"
> +#include "bcm2835-rpi.dtsi"
> +#include "bcm283x-rpi-usb-host.dtsi"
> +
> +/ {
> +	compatible = "raspberrypi,3-compute-model", "brcm,bcm2837";

s/compute-model/compute-module/

> +	model = "Raspberry Pi Compute Module 3";

Raspberry Pi Compute Module 3 on a IO board V3

> +
> +	memory {
> +		reg = <0 0x40000000>;
> +	};
> +
> +	leds {
> +		act {
> +			gpios = <&gpio 47 0>;

Please use GPIO_ACTIVE_HIGH here

> +		};
> +	};
> +};
> +
> +&hdmi {
> +	hpd-gpios = <&gpio 46 GPIO_ACTIVE_LOW>;
> +};
> +
> +&uart0 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&uart0_gpio14>;
> +	status = "okay";
> +};
> +
> +/* SDHOST is used to drive the SD card */

Since this is an eMMC please drop this misleading comment.

> +&sdhost {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhost_gpio48>;
> +	status = "okay";
> +	bus-width = <4>;

non-removable;

> +};
> diff --git a/arch/arm64/boot/dts/broadcom/Makefile b/arch/arm64/boot/dts/broadcom/Makefile
> index 3df2db7f8878..aecf58f503ae 100644
> --- a/arch/arm64/boot/dts/broadcom/Makefile
> +++ b/arch/arm64/boot/dts/broadcom/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0
>  dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-3-b.dtb
> +dtb-$(CONFIG_ARCH_BCM2835) += bcm2837-rpi-cm3.dtb
>  
>  dts-dirs	+= northstar2
>  dts-dirs	+= stingray
> diff --git a/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3.dts b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3.dts
> new file mode 100644
> index 000000000000..a1bba71462ed
> --- /dev/null
> +++ b/arch/arm64/boot/dts/broadcom/bcm2837-rpi-cm3.dts
> @@ -0,0 +1,2 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include "arm/bcm2837-rpi-cm3.dts"
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
