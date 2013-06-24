From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 24 Jun 2013 12:12:41 +0800
Subject: [PATCH 1/2] ARM: dts: vf610-twr: Add SPI NOR support
In-Reply-To: <1371809432-29541-1-git-send-email-b41219@freescale.com>
References: <1371809432-29541-1-git-send-email-b41219@freescale.com>
Message-ID: <20130624041239.GB25856@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 06:10:32PM +0800, Xiaochun Li wrote:
> vf610-twr has a s25fl129p1 SPI NOR flash connected to QuadSpi0.
> 
> Add support for it.
> 
> Signed-off-by: Xiaochun Li <b41219@freescale.com>
> ---
>  arch/arm/boot/dts/vf610-twr.dts | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/vf610-twr.dts b/arch/arm/boot/dts/vf610-twr.dts
> index b3905f5..202cf1d 100644
> --- a/arch/arm/boot/dts/vf610-twr.dts
> +++ b/arch/arm/boot/dts/vf610-twr.dts
> @@ -55,3 +55,23 @@
>  	pinctrl-0 = <&pinctrl_uart1_1>;
>  	status = "okay";
>  };
> +
> +&qspi0 {
> +	fsl,spi-num-chipselects = <1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_qspi0_1>;
> +	status = "okay";
> +
> +	flash: s25fl129p1 at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "spansion,s25fl129p1";
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +
> +		partition at 0 {
> +			label = "s25fl129p1";
> +			reg = <0x0 0x1000000>;
> +		};

We should not enforce the partition layout in the device tree, because
that's not hardware specific configuration data but use case specific
one.  Not everyone running vf610-twr board with mainline device tree
wants that partition layout.  So let's remove it and leave it to boot
loader to fill in.

Shawn

> +	};
> +};
> -- 
> 1.8.0
> 
> 
