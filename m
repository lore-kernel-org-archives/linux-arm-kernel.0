From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Feb 2018 16:17:23 +0800
Subject: [PATCH v2] arm64: dts: ls1088a: Add qspi device node for
 ls1088a-rdb
In-Reply-To: <1517334262-17969-1-git-send-email-yogeshnarayan.gaur@nxp.com>
References: <1517334262-17969-1-git-send-email-yogeshnarayan.gaur@nxp.com>
Message-ID: <20180205081722.GS31354@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 11:14:22PM +0530, Yogesh Gaur wrote:
> Add nodes and properties for QSPI controller.
> Add support for spansion flash, s25fs512s, as slave device for
> QSPI controller.
> 
> Added entry of "fsl,ls1088a-qspi" in fsl-quadspi.txt binding file.
> 
> Signed-off-by: Suresh Gupta <suresh.gupta@nxp.com>
> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> ---
> Depends on
>  https://patchwork.ozlabs.org/project/linux-mtd/list/?series=26084

Send me dts patch only after driver and bindings doc get merged.

> 
> Changes for v2:
> - Move property spi-rx-bus-width and spi-tx-bus-width from controller
>   to connected slave device node.
> 
>  .../devicetree/bindings/mtd/fsl-quadspi.txt        |  1 +

The bindings doc shouldn't be part of dts patch.

Shawn

>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts  | 23 ++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi     | 12 +++++++++++
>  3 files changed, 36 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> index 811da0e..956c23c 100644
> --- a/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> +++ b/Documentation/devicetree/bindings/mtd/fsl-quadspi.txt
> @@ -7,6 +7,7 @@ Required properties:
>  		 or
>  		 "fsl,ls2080a-qspi" followed by "fsl,ls1021a-qspi",
>  		 "fsl,ls1043a-qspi" followed by "fsl,ls1021a-qspi"
> +		 "fsl,ls2080a-qspi" followed by "fsl,ls1088a-qspi",
>    - reg : the first contains the register location and length,
>            the second contains the memory mapping address and length
>    - reg-names: Should contain the reg names "QuadSPI" and "QuadSPI-memory"
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index 0f6fcda..8afe536 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -94,6 +94,29 @@
>  	};
>  };
>  
> +&qspi {
> +	status = "okay";
> +	fsl,qspi-has-second-chip;
> +	qflash0: s25fs512s at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <20000000>;
> +		reg = <0>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +	};
> +
> +	qflash1: s25fs512s at 1 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		spi-max-frequency = <20000000>;
> +		reg = <1>;
> +		spi-rx-bus-width = <4>;
> +		spi-tx-bus-width = <4>;
> +	};
> +
> +};
> +
>  &ifc {
>  	ranges = <0 0 0x5 0x30000000 0x00010000
>  		  2 0 0x5 0x20000000 0x00010000>;
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index bd80e9a..b45a522 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -394,6 +394,18 @@
>  			status = "disabled";
>  		};
>  
> +		qspi: quadspi at 20c0000 {
> +			compatible = "fsl,ls2080a-qspi", "fsl,ls1088a-qspi";
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0 0x20c0000 0x0 0x10000>,
> +				<0x0 0x20000000 0x0 0x10000000>;
> +			reg-names = "QuadSPI", "QuadSPI-memory";
> +			interrupts = <0 25 0x4>; /* Level high type */
> +			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> +			clock-names = "qspi_en", "qspi";
> +		};
> +
>  		sata: sata at 3200000 {
>  			compatible = "fsl,ls1088a-ahci";
>  			reg = <0x0 0x3200000 0x0 0x10000>,
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
