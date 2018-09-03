From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 3 Sep 2018 11:01:12 +0800
Subject: [PATCH 5/7] arm64: dts: lx2160a: add fspi node property
In-Reply-To: <1535711404-29528-6-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1535711404-29528-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <1535711404-29528-6-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20180903030110.GI3850@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 31, 2018 at 04:00:02PM +0530, Yogesh Gaur wrote:
> Add fspi node property for LX2160A SoC for FlexSPI driver.
> Property added for the FlexSPI controller and for the connected
> slave device for the LX2160ARDB target.
> This is having two SPI-NOR flash device, mt35xu512aba, connected
> at CS0 and CS1.
> 
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 21 +++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    | 12 ++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 70fad20..3646315 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -32,6 +32,27 @@
>  	status = "okay";
>  };
>  
> +&fspi {
> +	status = "okay";

Have a newline between property and child node.

> +	flash0: mt35xu512aba at 0 {

Generic name for node, and specific name for label.

> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "m25p80";

Please take a look at bindings doc jedec,spi-nor.txt on how compatible
should be written.

> +		m25p,fast-read;
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +	};
> +
> +	flash1: mt35xu512aba at 1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "m25p80";
> +		m25p,fast-read;
> +		spi-max-frequency = <20000000>;
> +		reg = <1>;
> +	};
> +};
> +
>  &i2c0 {
>  	status = "okay";
>  	pca9547 at 77 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index e35e494..031eb26 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -568,5 +568,17 @@
>  			timeout-sec = <30>;
>  		};
>  
> +		fspi: flexspi at 20c0000 {
> +			status = "disabled";

We conventionally put 'status' line at the end of property list.

Shawn

> +			compatible = "nxp,lx2160a-fspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x20c0000 0x0 0x10000>,
> +				<0x0 0x20000000 0x0 0x10000000>;
> +			reg-names = "fspi_base", "fspi_mmap";
> +			interrupts = <0 25 0x4>; /* Level high type */
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "fspi_en", "fspi";
> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
