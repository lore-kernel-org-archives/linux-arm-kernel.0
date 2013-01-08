From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 8 Jan 2013 09:57:29 +0000
Subject: [PATCH 02/11] ARM: nomadik: initial devicetree support
In-Reply-To: <1357599359-7385-1-git-send-email-linus.walleij@linaro.org>
References: <1357599359-7385-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20130108095729.GA2718@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have a couple of comments on the dts{,i} portion.

On Mon, Jan 07, 2013 at 10:55:59PM +0000, Linus Walleij wrote:
> Support basic device tree boot on the Nomadik. Implement the
> support in the cpu file with the intent of deleting the board
> files later. At this stage IRQ controllers, system timer,
> l2x0 cache, UARTs and thus console boot is fully functional.
> Patch out the code adding devices by initcalls for now so
> as not to disturb the boot.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/boot/dts/Makefile                 |  1 +
>  arch/arm/boot/dts/ste-nomadik-s8815.dts    | 18 ++++++
>  arch/arm/boot/dts/ste-nomadik-stn8815.dtsi | 77 +++++++++++++++++++++++++
>  arch/arm/mach-nomadik/board-nhk8815.c      |  4 ++
>  arch/arm/mach-nomadik/cpu-8815.c           | 90 ++++++++++++++++++++++++++++++
>  arch/arm/mach-nomadik/cpu-8815.h           |  1 +
>  arch/arm/mach-nomadik/i2c-8815nhk.c        |  5 ++
>  7 files changed, 196 insertions(+)
>  create mode 100644 arch/arm/boot/dts/ste-nomadik-s8815.dts
>  create mode 100644 arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index e44da40..7bc5ba73 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -100,6 +100,7 @@ dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>  	imx28-m28evk.dtb \
>  	imx28-sps1.dtb \
>  	imx28-tx28.dtb
> +dtb-$(CONFIG_ARCH_NOMADIK) += ste-nomadik-s8815.dtb
>  dtb-$(CONFIG_ARCH_OMAP2PLUS) += omap2420-h4.dtb \
>  	omap3-beagle.dtb \
>  	omap3-beagle-xm.dtb \
> diff --git a/arch/arm/boot/dts/ste-nomadik-s8815.dts b/arch/arm/boot/dts/ste-nomadik-s8815.dts
> new file mode 100644
> index 0000000..b698bc2
> --- /dev/null
> +++ b/arch/arm/boot/dts/ste-nomadik-s8815.dts
> @@ -0,0 +1,18 @@
> +/*
> + * Device Tree for the ST-Ericsson Nomadik S8815 board
> + * Produced by Calao Systems
> + */
> +
> +/dts-v1/;
> +/include/ "ste-nomadik-stn8815.dtsi"
> +
> +/ {
> +	model = "ST-Ericsson Nomadik S8815";
> +	compatible = "stericsson,nomadik";
> +	#address-cells = <1>;
> +	#size-cells = <1>;

Given there are addresses and sizes in the dtsi (but none in the dts), should
#address-cells and #size-cells not be in the dtsi?

> +
> +	chosen {
> +		bootargs = "root=/dev/ram0 console=ttyAMA1,115200n8 earlyprintk";
> +	};
> +};
> diff --git a/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
> new file mode 100644
> index 0000000..81284c5
> --- /dev/null
> +++ b/arch/arm/boot/dts/ste-nomadik-stn8815.dtsi
> @@ -0,0 +1,77 @@
> +/*
> + * Device Tree for the ST-Ericsson Nomadik 8815 STn8815 SoC
> + */
> +/include/ "skeleton.dtsi"
> +
> +/ {
> +	memory {
> +	       reg = <0x00000000 0x04000000>;
> +	       reg = <0x08000000 0x04000000>;

I believe that's not valid (duplicate property name).

Judging by other dts files under arch/arm/boot/dts, these should be two nodes,
with their unit addresses set (and possibly device_type, which I see is set for
some dts files, but not all).

> +	};
> +
> +	L2: l2-cache {
> +		compatible = "arm,l210-cache";
> +		reg = <0x10210000 0x1000>;
> +		interrupt-parent = <&vica>;
> +		interrupts = <30>;
> +		cache-unified;
> +		cache-level = <2>;
> +	};
> +
> +	mtu0 {
> +		/* Nomadik system timer */
> +		reg = <0x101e2000 0x1000>;
> +		interrupt-parent = <&vica>;
> +		interrupts = <4>;
> +	};
> +
> +	mtu1 {
> +		/* Secondary timer */
> +		reg = <0x101e3000 0x1000>;
> +		interrupt-parent = <&vica>;
> +		interrupts = <5>;
> +	};
> +
> +	amba {
> +		compatible = "arm,amba-bus";
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		vica: intc at 0x10140000 {
> +			compatible = "arm,versatile-vic";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			reg = <0x10140000 0x20>;
> +		};
> +
> +		vicb: intc at 0x10140020 {
> +			compatible = "arm,versatile-vic";
> +			interrupt-controller;
> +			#interrupt-cells = <1>;
> +			reg = <0x10140020 0x20>;
> +		};
> +
> +		uart0: uart at 101fd000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x101fd000 0x1000>;
> +			interrupt-parent = <&vica>;
> +			interrupts = <12>;
> +		};
> +
> +		uart1: uart at 101fb000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x101fb000 0x1000>;
> +			interrupt-parent = <&vica>;
> +			interrupts = <17>;
> +		};
> +
> +		uart2: uart at 101f2000 {
> +			compatible = "arm,pl011", "arm,primecell";
> +			reg = <0x101f2000 0x1000>;
> +			interrupt-parent = <&vica>;
> +			interrupts = <28>;
> +			status = "disabled";
> +		};
> +	};
> +};

Maybe I've misunderstood how this is laid out, but I can't see where we get a
cpus node from in the board's dts. Has this just been forgotten?

[...]

Thanks,
Mark.
