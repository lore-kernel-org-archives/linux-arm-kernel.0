From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Wed, 14 Mar 2018 14:23:26 +0800
Subject: [PATCH 8/8] ARM: dts: berlin2cd: add Valve Steam Link board
In-Reply-To: <20180311160008.22928-9-amonakov@ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
 <20180311160008.22928-9-amonakov@ispras.ru>
Message-ID: <20180314142326.572642c3@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, 11 Mar 2018 19:00:08 +0300 Alexander Monakov wrote:

> Valve Steam Link is a consumer device built around the Marvell BG2CD SoC.
> This board file enables the UART, USB and Ethernet interfaces as well as
> internal I2C and SDIO, and adds SoC voltage regulator and board-specific
> GPIO restart method info.
> 
> Cc: Sam Lantinga <saml@valvesoftware.com>
> Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
> ---
> At this point, major missing user-facing features are audio/video and
> power management (cpufreq, cpuidle, and/or suspend).
> 
> It's easy to wire up the Vivante 3D graphics core, but without scanout
> it's not useful.
> 
> For avoidance of doubt, I am not affiliated with Valve.
> 
>  arch/arm/boot/dts/Makefile                      |  1 +
>  arch/arm/boot/dts/berlin2cd-valve-steamlink.dts | 80 +++++++++++++++++++++++++
>  2 files changed, 81 insertions(+)
>  create mode 100644 arch/arm/boot/dts/berlin2cd-valve-steamlink.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index d0381e9caf21..e52fa7168dd8 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -140,6 +140,7 @@ dtb-$(CONFIG_ARCH_BCM_NSP) += \
>  dtb-$(CONFIG_ARCH_BERLIN) += \
>  	berlin2-sony-nsz-gs7.dtb \
>  	berlin2cd-google-chromecast.dtb \
> +	berlin2cd-valve-steamlink.dtb \
>  	berlin2q-marvell-dmp.dtb
>  dtb-$(CONFIG_ARCH_BRCMSTB) += \
>  	bcm7445-bcm97445svmb.dtb
> diff --git a/arch/arm/boot/dts/berlin2cd-valve-steamlink.dts b/arch/arm/boot/dts/berlin2cd-valve-steamlink.dts
> new file mode 100644
> index 000000000000..3161ada6eb34
> --- /dev/null
> +++ b/arch/arm/boot/dts/berlin2cd-valve-steamlink.dts
> @@ -0,0 +1,80 @@
> +/*
> + * Copyright 2018 Alexander Monakov <amonakov@gmail.com>
> + *
> + * SPDX-License-Identifier: (GPL-2.0 OR MIT)

Mind to license it under GPL2 or X11?

Other source usually tag as:
// SPDX-License-Identifier: (GPL-2.0 OR X11)

And the tag is put into the first line, could we keep the style?

> + */
> +/dts-v1/;
> +
> +#include "berlin2cd.dtsi"
> +#include <dt-bindings/gpio/gpio.h>
> +
> +/ {
> +	model = "Valve Steam Link";
> +	compatible = "valve,steamlink", "marvell,berlin2cd", "marvell,berlin";
> +
> +	memory at 0 {
> +		device_type = "memory";
> +		reg = <0x00000000 0x20000000>; /* 512 MB */
> +	};
> +
> +	gpio-restart {
> +		compatible = "gpio-restart";
> +		gpios = <&porta 6 GPIO_ACTIVE_HIGH>;
> +		active-delay = <100>;
> +		inactive-delay = <10>;
> +		wait-delay = <100>;
> +		priority = <200>;
> +	};
> +};
> +
> +&cpu {
> +	cpu-supply = <&vcpu>;
> +	operating-points = <
> +		/* kHz    uV */
> +		1000000 1325000
> +	>;
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +
> +	/* There are two regulators on the board. One is accessible via I2C,
> +	 * with buck1 providing SoC power (set up by bootloader to 1.325V or
> +	 * less depending on leakage value in OTP), and buck2 likely used for
> +	 * DRAM (providing 1.35V). The other regulator on the opposite side
> +	 * of the board is probably supplying SDIO and NAND fixed voltages. */
> +	regulator at 19 {
> +		compatible = "marvell,88pg868";
> +		reg = <0x19>;
> +
> +		vcpu: buck1 {
> +			regulator-boot-on;
> +			regulator-always-on;
> +			regulator-min-microvolt = <1000000>;
> +			regulator-max-microvolt = <1325000>;
> +		};
> +	};
> +};
> +
> +/* Fixed interface to on-board Marvell 8897 Wi-Fi/Bluetooth/NFC chip. */
> +&sdhci0 {
> +	keep-power-in-suspend;
> +	non-removable;
> +	status = "okay";
> +};
> +
> +&uart0 {
> +	/* RX/TX are routed to TP50/TP51 on the board. */
> +	status = "okay";
> +};
> +
> +/* The SoC is connected to on-board USB hub that in turn has one downstream
> + * port wired to the on-board Steam Controller wireless receiver chip. */
> +&usb_phy1 { status = "okay"; };
> +
> +&usb1 {
> +	dr_mode = "host";
> +	status = "okay";
> +};
> +
> +&eth1 { status = "okay"; };
