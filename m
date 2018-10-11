From: leoyang.li@nxp.com (Leo Li)
Date: Thu, 11 Oct 2018 17:25:39 +0000
Subject: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
In-Reply-To: <20181011063522.7767-1-yinbo.zhu@nxp.com>
References: <20181011063522.7767-1-yinbo.zhu@nxp.com>
Message-ID: <AMSPR04MB503AE4F55B3FAE7E77842218FE10@AMSPR04MB503.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Yinbo Zhu <yinbo.zhu@nxp.com>
> Sent: Thursday, October 11, 2018 1:35 AM
> To: Yinbo Zhu <yinbo.zhu@nxp.com>; Y.b. Lu <yangbo.lu@nxp.com>; linux-
> mmc at vger.kernel.org; Adrian Hunter <adrian.hunter@intel.com>;
> ulf.hansson at linaro.org; Leo Li <leoyang.li@nxp.com>
> Cc: Xiaobo Xie <xiaobo.xie@nxp.com>; devicetree at vger.kernel.org; linux-
> arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org
> Subject: [PATCH v2] arm64: dts: lx2160a: enable eSDHC controller
> 
> There are two eSDHC controllers in lx2160a. This patch is to enable eSDHC for
> RDB and QDS board.
> 
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v2:
> 		squash all lx2160a esdhc dts patch into the original patch

Hi Yinbo,

What I meant is that the eSDHC nodes should be squashed into the patches adding these device tree.  I don't see a good reason that SDHC nodes should be a separate patch for now, especially when the original patch is still being reviewed and could be changing.
https://lore.kernel.org/patchwork/patch/995433/
https://lore.kernel.org/patchwork/patch/995434/

Regards,
Leo
> 
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |    8 ++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts |   15 ++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi    |   25
> +++++++++++++++++++++
>  3 files changed, 48 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> index bc30173..b58b96c 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
> @@ -294,6 +294,14 @@
>  	status = "okay";
>  };
> 
> +&esdhc0 {
> +	status = "okay";
> +};
> +
> +&esdhc1 {
> +	status = "okay";
> +};
> +
>  &dspi0 {
>  	dflash0: n25q128a {
>  		#address-cells = <1>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> index 53b0e80..cbe8919 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> @@ -170,6 +170,21 @@
>  	status = "okay";
>  };
> 
> +&esdhc0 {
> +	sd-uhs-sdr104;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr25;
> +	sd-uhs-sdr12;
> +	status = "okay";
> +};
> +
> +&esdhc1 {
> +	mmc-hs200-1_8v;
> +	mmc-hs400-1_8v;
> +	bus-width = <8>;
> +	status = "okay";
> +};
> +
>  &fspi {
>  	status = "okay";
>  	nxp,fspi-has-second-chip;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> index fa4a1f8..174544a 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> @@ -356,6 +356,31 @@
>  			little-endian;
>  		};
> 
> +		esdhc0: esdhc at 2140000 {
> +			compatible = "fsl,esdhc";
> +			reg = <0x0 0x2140000 0x0 0x10000>;
> +			interrupts = <0 28 0x4>; /* Level high type */
> +			clocks = <&clockgen 4 1>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			little-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
> +		esdhc1: esdhc at 2150000 {
> +			compatible = "fsl,esdhc";
> +			reg = <0x0 0x2150000 0x0 0x10000>;
> +			interrupts = <0 63 0x4>; /* Level high type */
> +			clocks = <&clockgen 4 1>;
> +			voltage-ranges = <1800 1800 3300 3300>;
> +			sdhci,auto-cmd12;
> +			broken-cd;
> +			little-endian;
> +			bus-width = <4>;
> +			status = "disabled";
> +		};
> +
>  		gpio0: gpio at 2300000 {
>  			compatible = "fsl,ls2080a-gpio", "fsl,qoriq-gpio";
>  			reg = <0x0 0x2300000 0x0 0x10000>;
> --
> 1.7.1
