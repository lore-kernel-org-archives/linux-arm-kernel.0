From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 10 May 2017 09:20:58 +0800
Subject: [PATCH][v2] arm64: Add flash node for ls1088a qds and rdb
In-Reply-To: <1493962448-10888-1-git-send-email-prabhakar.kushwaha@nxp.com>
References: <1493962448-10888-1-git-send-email-prabhakar.kushwaha@nxp.com>
Message-ID: <20170510012057.GB5833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 05, 2017 at 11:04:08AM +0530, Prabhakar Kushwaha wrote:
> LS1088AQDS consist of NOR, NAND and FPGA connected over IFC
> LS1088ARDB consist of NAND and FPGA connected over IFC.
> 
> So add flash information in ifc node of device tree.
> 
> Signed-off-by: Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>
> ---
> changes for v2: Incorporated Shawn's comments
> 
> 
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts | 25 +++++++++++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 17 +++++++++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    |  4 ----
>  3 files changed, 42 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
> index 8c3cae5..f536ca9 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
> @@ -110,6 +110,31 @@
>  	};
>  };
>  
> +&ifc {
> +	status = "okay";
> +
> +	ranges = <0 0 0x5 0x80000000 0x08000000
> +		  2 0 0x5 0x30000000 0x00010000
> +		  3 0 0x5 0x20000000 0x00010000>;

We usually have 'status' be the last one in property list, and also
newline in the middle of property list is generally unneeded.

	ranges = <0 0 0x5 0x80000000 0x08000000
		  2 0 0x5 0x30000000 0x00010000
		  3 0 0x5 0x20000000 0x00010000>;
	status = "okay";

> +
> +	nor at 0,0 {
> +		compatible = "cfi-flash";
> +		reg = <0x0 0x0 0x8000000>;
> +		bank-width = <2>;
> +		device-width = <1>;
> +	};
> +
> +	nand at 2,0 {
> +		compatible = "fsl,ifc-nand";
> +		reg = <0x2 0x0 0x10000>;
> +	};
> +
> +	fpga: board-control at 3,0 {
> +		compatible = "fsl,ls1088aqds-fpga", "fsl,fpga-qixis";
> +		reg = <0x3 0x0 0x0000100>;
> +	};
> +};
> +
>  &duart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index 8a04fbb..3f79610 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -94,6 +94,23 @@
>  	};
>  };
>  
> +&ifc {
> +	status = "okay";
> +
> +	ranges = <0 0 0x5 0x30000000 0x00010000
> +		  2 0 0x5 0x20000000 0x00010000>;

Ditto

> +
> +	nand at 0,0 {
> +		compatible = "fsl,ifc-nand";
> +		reg = <0x0 0x0 0x10000>;
> +	};
> +
> +	fpga: board-control at 2,0 {
> +		compatible = "fsl,ls1088ardb-fpga", "fsl,fpga-qixis";
> +		reg = <0x2 0x0 0x0000100>;
> +	};
> +};
> +
>  &duart0 {
>  	status = "okay";
>  };
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 2946fd7..9f6bcb4 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -217,10 +217,6 @@
>  			#address-cells = <2>;
>  			#size-cells = <1>;
>  
> -			ranges = <0 0 0x5 0x80000000 0x08000000
> -				  2 0 0x5 0x30000000 0x00010000
> -				  3 0 0x5 0x20000000 0x00010000>;
> -			status = "disabled";

The 'status' line should be kept.

Shawn

>  		};
>  
>  		i2c0: i2c at 2000000 {
> -- 
> 2.7.4
> 
> 
