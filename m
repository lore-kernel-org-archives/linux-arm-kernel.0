From: miquel.raynal@free-electrons.com (Miquel RAYNAL)
Date: Wed, 2 Aug 2017 19:16:08 +0200
Subject: [PATCH] ARM64: dts: marvell: armada-37xx: Enable uSD on
 ESPRESSObin
In-Reply-To: <1500594636-19911-1-git-send-email-mw@semihalf.com>
References: <1500594636-19911-1-git-send-email-mw@semihalf.com>
Message-ID: <20170802191608.58aa312e@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, 21 Jul 2017 01:50:36 +0200
Marcin Wojtas <mw@semihalf.com> wrote:

> The ESPRESSObin board exposes one of the SDHCI interfaces
> via J1 uSD slot. This patch enables it.
> 
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Signed-off-by: Zbigniew Bodek <zbodek@gmail.com>

Tested-by: Miquel Raynal <miquel.raynal@free-electrons.com>

> ---
>  .../boot/dts/marvell/armada-3720-espressobin.dts   | 26
> ++++++++++++++++++++++ 1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts
> b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts index
> b1af3f98..6d0caf1 100644 ---
> a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts +++
> b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dts @@ -45,6
> +45,7 @@ 
>  /dts-v1/;
>  
> +#include <dt-bindings/gpio/gpio.h>
>  #include "armada-372x.dtsi"
>  
>  / {
> @@ -59,6 +60,20 @@
>  		device_type = "memory";
>  		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
>  	};
> +
> +	vcc_sd_reg1: regulator {
> +		compatible = "regulator-gpio";
> +		regulator-name = "vcc_sd1";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-boot-on;
> +
> +		gpios = <&gpionb 4 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0>;
> +		states = <1800000 0x1
> +			  3300000 0x0>;
> +		enable-active-high;
> +	};
>  };
>  
>  /* J9 */
> @@ -71,6 +86,17 @@
>  	status = "okay";
>  };
>  
> +/* J1 */
> +&sdhci1 {
> +	wp-inverted;
> +	bus-width = <4>;
> +	cd-gpios = <&gpionb 3 GPIO_ACTIVE_LOW>;
> +	no-1-8-v;
> +	marvell,pad-type = "sd";
> +	vqmmc-supply = <&vcc_sd_reg1>;
> +	status = "okay";
> +};
> +
>  /* Exported on the micro USB connector J5 through an FTDI */
>  &uart0 {
>  	status = "okay";



-- 
Miquel Raynal, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
