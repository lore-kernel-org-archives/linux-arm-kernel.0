From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 17 Apr 2014 11:33:06 +0800
Subject: [PATCH 3/4] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
In-Reply-To: <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <20140417113306.545ca4a7@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Antoine,

On Wed, 16 Apr 2014 05:40:10 -0700
Antoine T?nart <antoine.tenart@free-electrons.com> wrote:

> Add the SDHCI nodes for the Marvell Berlin BG2Q, using the berlin-sdhci
> driver.
> 
> Signed-off-by: Antoine T?nart <antoine.tenart@free-electrons.com>
> ---
>  arch/arm/boot/dts/berlin2q.dtsi | 40
> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 40 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi
> b/arch/arm/boot/dts/berlin2q.dtsi index 5925e6a16749..8f897d461460 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -67,6 +67,14 @@
>  		clock-div = <3>;
>  	};
>  
> +	sdio1clk: sdio1clk {
> +		compatible = "fixed-factor-clock";
> +		#clock-cells = <0>;
> +		clocks = <&syspll>;
> +		clock-mult = <1>;
> +		clock-div = <4>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <1>;
> @@ -75,6 +83,38 @@
>  		ranges = <0 0xf7000000 0x1000000>;
>  		interrupt-parent = <&gic>;
>  
> +		sdhci0: sdhci at ab0000 {
> +			compatible = "marvell,berlin2q-sdhci";
> +			reg = <0xab0000 0x200>;
> +			clocks = <&sdio1clk>;
> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> +			keep-power-in-suspend;
> +			enable-sdio-wakeup;
> +			broken-cd;
> +			status = "disabled";
> +		};
> +
> +		sdhci1: sdhci at ab0800 {
> +			compatible = "marvell,berlin2q-sdhci";
> +			reg = <0xab0800 0x200>;
> +			clocks = <&sdio1clk>;
> +			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> +			keep-power-in-suspend;
> +			enable-sdio-wakeup;
> +			status = "disabled";
> +		};
> +
> +		sdhci2: sdhci at ab1000 {
> +			compatible = "marvell,berlin2q-sdhci";
> +			reg = <0xab1000 0x200>;
> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&sdio1clk>;
> +			keep-power-in-suspend;
> +			enable-sdio-wakeup;
> +			broken-cd;
> +			status = "disabled";
> +		};

could we put sdhci at ab1000 at the first of sdhci lists? For two reasons:

1. sdhci at ab0000 and sdhci at ab0800 is called as sdhci1 and sdhci2 in mrvl
internal discussion, so this would make the name consistent when we
upgrade linux kernel to one mainline version.

2. sdhci at ab1000 is always used for emmc. if sdhci at ab0800 is put at the
head of sdhci at ab1000, and there's one sdcard in it, mmcblock0 would be
the sdcard rather than emmc.

I dunno whether there's elegant solutions for these two issues. alias? Could
anyone kindly help?

Thanks in advance,
Jisheng
