From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 23 Nov 2012 21:39:42 -0500
Subject: [PATCH 3/4] ARM: Dove: Convert to DT GPIO and pinctrl
In-Reply-To: <1353317996-20841-4-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1353317996-20841-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1353317996-20841-4-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20121124023942.GO15800@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2012 at 10:39:55AM +0100, Sebastian Hesselbarth wrote:
> Following the ongoing conversion of Orion SoCs to DT, make use of
> gpio and pinctrl drivers through DT. The main dtsi for Dove is prepared
> to allow board specific descriptors to make use of pinctrl muxing.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> ---
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Cc: Axel Lin <axel.lin@ingics.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/Kconfig            |    2 ++
>  arch/arm/boot/dts/dove.dtsi |   20 +++++++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index d5a28da..bb9a85d 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -539,6 +539,8 @@ config ARCH_DOVE
>  	select CPU_V7
>  	select GENERIC_CLOCKEVENTS
>  	select MIGHT_HAVE_PCI
> +	select PINCTRL
> +	select PINCTRL_DOVE
>  	select PLAT_ORION_LEGACY
>  	select USB_ARCH_HAS_EHCI
>  	help
> diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
> index 8c8ab62..c457480 100644
> --- a/arch/arm/boot/dts/dove.dtsi
> +++ b/arch/arm/boot/dts/dove.dtsi
> @@ -4,6 +4,12 @@
>  	compatible = "marvell,dove";
>  	model = "Marvell Armada 88AP510 SoC";
>  
> +	aliases {
> +		gpio0 = &gpio0;
> +		gpio1 = &gpio1;
> +		gpio2 = &gpio2;
> +	};
> +
>  	soc at f1000000 {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -85,7 +91,8 @@
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			reg = <0xd0400 0x20>;
> -			ngpio = <32>;
> +			ngpios = <32>;
> +			interrupt-controller;
>  			interrupts = <12>, <13>, <14>, <60>;
>  		};
>  
> @@ -94,7 +101,8 @@
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			reg = <0xd0420 0x20>;
> -			ngpio = <32>;
> +			ngpios = <32>;
> +			interrupt-controller;
>  			interrupts = <61>;
>  		};
>  
> @@ -103,7 +111,13 @@
>  			#gpio-cells = <2>;
>  			gpio-controller;
>  			reg = <0xe8400 0x0c>;
> -			ngpio = <8>;
> +			ngpios = <8>;
> +		};
> +
> +		pinctrl: pinctrl at d0200 {
> +			compatible = "marvell,dove-pinctrl";
> +			reg = <0xd0200 0x10>;
> +			clocks = <&gate_clk 22>;

The above line broke the dtbs build target for dove_defconfig.  I have
removed it.  Please let me know if that is not the correct answer.  This
was the only occurence of 'clk' in arch/arm/boot/dts/dove* .

thx,

Jason.

>  		};
>  
>  		spi0: spi at 10600 {
> -- 
> 1.7.10.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
