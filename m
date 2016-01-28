From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 15:42:56 +0800
Subject: [PATCH v2 1/5] ARM: dts: imx: Add basic dts support for imx6qp SOC
In-Reply-To: <1450159673-27314-2-git-send-email-b51503@freescale.com>
References: <1450159673-27314-1-git-send-email-b51503@freescale.com>
 <1450159673-27314-2-git-send-email-b51503@freescale.com>
Message-ID: <20160128074256.GL9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 02:07:49PM +0800, Bai Ping wrote:
> The i.MX6Quad Plus processor is an high performance SOC of i.MX6 family.
> It has enhanced graphics performance and increased overall memory bandwidth
> compared to i.MX6Q. Most of the design are same as i.MX6Quad/Dual, so code
> for i.MX6Quad can be resued by this chip. The revision number is identied as
> i.MX6Q Rev2.0, but actually it is a new chip, as we did many change to the
> overall architecture.
> 
> This patch adds basic dtsi file support for the new i.MX6Quad Plus processor.
> 
> Signed-off-by: Bai Ping <b51503@freescale.com>
> ---
>  arch/arm/boot/dts/imx6q.dtsi              |   2 +-
>  arch/arm/boot/dts/imx6qp.dtsi             | 157 ++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/imx6qdl-clock.h |  16 ++-
>  3 files changed, 173 insertions(+), 2 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6qp.dtsi
> 
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index a266a56..e26d0fd 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -22,7 +22,7 @@
>  		#address-cells = <1>;
>  		#size-cells = <0>;
>  
> -		cpu at 0 {
> +		cpu0: cpu at 0 {
>  			compatible = "arm,cortex-a9";
>  			device_type = "cpu";
>  			reg = <0>;
> diff --git a/arch/arm/boot/dts/imx6qp.dtsi b/arch/arm/boot/dts/imx6qp.dtsi
> new file mode 100644
> index 0000000..e43751f
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qp.dtsi
> @@ -0,0 +1,157 @@
> +/*
> + * Copyright 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

For new dts files, we suggest to use GPL/X11 dual license to consider
non-Linux users.  You can grep "dual-licensed" in arch/arm/boot/dts to
find a plenty of examples.

> + *
> + */
> +

Do you not need to include "imx6qdl.dtsi" here?

> +/ {
> +	aliases {
> +		pre0 = &pre1;
> +		pre1 = &pre2;
> +		pre2 = &pre3;
> +		pre3 = &pre4;
> +		prg0 = &prg1;
> +		prg1 = &prg2;
> +	};
> +
> +	soc {
> +		ocram_2: sram at 00940000 {

The label can just be ocram2.

> +			compatible = "mmio-sram";
> +			reg = <0x00940000 0x20000>;
> +			clocks = <&clks IMX6QDL_CLK_OCRAM>;
> +		};
> +
> +		ocram_3: sram at 00960000 {

ocram3

> +			compatible = "mmio-sram";
> +			reg = <0x00960000 0x20000>;
> +			clocks = <&clks IMX6QDL_CLK_OCRAM>;
> +		};
> +
> +		pcie: pcie at 0x01000000 {
> +			compatible = "fsl,imx6qp-pcie", "snps,dw-pcie";
> +			reg = <0x01ffc000 0x4000>, <0x01f00000 0x80000>;
> +			reg-names = "dbi", "config";
> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +			device_type = "pci";
> +			ranges = <0x81000000 0 0          0x01f80000 0 0x00010000 /* downstream I/O */
> +				  0x82000000 0 0x01000000 0x01000000 0 0x00f00000>; /* non-prefetchable memory */
> +			num-lanes = <1>;
> +			interrupts = <0 120 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "msi";
> +			#interrupt-cells = <1>;
> +			interrupt-map-mask = <0 0 0 0x7>;
> +			interrupt-map = <0 0 0 1 &intc 0 123 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 2 &intc 0 122 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 3 &intc 0 121 IRQ_TYPE_LEVEL_HIGH>,
> +					<0 0 0 4 &intc 0 120 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6QDL_CLK_PCIE_REF_125M>,
> +				 <&clks IMX6QDL_CLK_SATA_REF_100M>,
> +				 <&clks IMX6QDL_CLK_LVDS1_GATE>, <&clks IMX6QDL_CLK_PCIE_AXI>;
> +			clock-names = "pcie_phy", "ref_100m", "pcie_bus", "pcie";
> +			status = "disabled";
> +		};
> +
> +		aips-bus at 02100000 { /* AIPS2 */
> +			pre1: pre at 021c8000 {
> +				compatible = "fsl,imx6q-pre";

Is there already a device tree binding and driver for this block in
upstream kernel?  I do not accepted any unestablished device.

> +				reg = <0x021c8000 0x1000>;
> +				clocks = <&clks IMX6QDL_CLK_PRE0>;
> +				interrupts = <0 90 IRQ_TYPE_EDGE_RISING>;
> +				ocram = <&ocram_2>;
> +				status = "disabled";
> +			};
> +
> +			pre2: pre at 021c9000 {
> +				compatible = "fsl,imx6q-pre";
> +				reg = <0x021c9000 0x1000>;
> +				clocks = <&clks IMX6QDL_CLK_PRE1>;
> +				interrupts = <0 97 IRQ_TYPE_EDGE_RISING>;
> +				ocram = <&ocram_2>;
> +				status = "disabled";
> +			};
> +
> +			pre3: pre at 021ca000 {
> +				compatible = "fsl,imx6q-pre";
> +				reg = <0x021ca000 0x1000>;
> +				clocks = <&clks IMX6QDL_CLK_PRE2>;
> +				interrupts = <0 98 IRQ_TYPE_EDGE_RISING>;
> +				ocram = <&ocram_3>;
> +				status = "disabled";
> +			};
> +
> +			pre4: pre at 021cb000 {
> +				compatible = "fsl,imx6q-pre";
> +				reg = <0x021cb000 0x1000>;
> +				clocks = <&clks IMX6QDL_CLK_PRE3>;
> +				interrupts = <0 99 IRQ_TYPE_EDGE_RISING>;
> +				ocram = <&ocram_3>;
> +				status = "disabled";
> +			};
> +
> +			prg1: prg at 021cc000 {
> +				compatible = "fsl,imx6q-prg";

Ditto

> +				reg = <0x021cc000 0x1000>;
> +				clocks = <&clks IMX6QDL_CLK_PRG0_AXI>,
> +					 <&clks IMX6QDL_CLK_PRG0_APB>;
> +				clock-names = "axi", "apb";
> +				gpr = <&gpr>;
> +				status = "disabled";
> +			};
> +
> +			prg2: prg at 021cd000 {
> +				compatible = "fsl,imx6q-prg";
> +				reg = <0x021cd000 0x1000>;
> +				clocks = <&clks IMX6QDL_CLK_PRG1_AXI>,
> +					 <&clks IMX6QDL_CLK_PRG1_APB>;
> +				clock-names = "axi", "apb";
> +				gpr = <&gpr>;
> +				status = "disabled";
> +			};
> +		};
> +
> +		ipu1: ipu at 02400000 {
> +			compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
> +			clocks = <&clks IMX6QDL_CLK_IPU1>,
> +				 <&clks IMX6QDL_CLK_IPU1_DI0>, <&clks IMX6QDL_CLK_IPU1_DI1>,
> +				 <&clks IMX6QDL_CLK_IPU1_DI0_SEL>, <&clks IMX6QDL_CLK_IPU1_DI1_SEL>,
> +				 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>,
> +				 <&clks IMX6QDL_CLK_PRG0_APB>;
> +			clock-names = "bus",
> +				      "di0", "di1",
> +				      "di0_sel", "di1_sel",
> +				      "ldb_di0", "ldb_di1", "prg";
> +		};
> +
> +		ipu2: ipu at 02800000 {
> +			compatible = "fsl,imx6qp-ipu", "fsl,imx6q-ipu";
> +			clocks = <&clks IMX6QDL_CLK_IPU2>,
> +				 <&clks IMX6QDL_CLK_IPU2_DI0>, <&clks IMX6QDL_CLK_IPU2_DI1>,
> +				 <&clks IMX6QDL_CLK_IPU2_DI0_SEL>, <&clks IMX6QDL_CLK_IPU2_DI1_SEL>,
> +				 <&clks IMX6QDL_CLK_LDB_DI0_PODF>, <&clks IMX6QDL_CLK_LDB_DI1_PODF>,
> +				 <&clks IMX6QDL_CLK_PRG1_APB>;
> +			clock-names = "bus",
> +				      "di0", "di1",
> +				      "di0_sel", "di1_sel",
> +				      "ldb_di0", "ldb_di1", "prg";
> +		};
> +
> +		sata: sata at 02200000 {
> +			compatible = "fsl,imx6qp-ahci";
> +			reg = <0x02200000 0x4000>;
> +			interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6QDL_CLK_SATA>,
> +				 <&clks IMX6QDL_CLK_SATA_REF_100M>,
> +				 <&clks IMX6QDL_CLK_AHB>;
> +			clock-names = "sata", "sata_ref", "ahb";
> +			status = "disabled";
> +		};
> +	};
> +};
> +
> +&ldb {
> +	compatible = "fsl,imx6qp-ldb", "fsl,imx6q-ldb", "fsl,imx53-ldb";
> +};
> diff --git a/include/dt-bindings/clock/imx6qdl-clock.h b/include/dt-bindings/clock/imx6qdl-clock.h
> index 77985cc..2905033 100644
> --- a/include/dt-bindings/clock/imx6qdl-clock.h
> +++ b/include/dt-bindings/clock/imx6qdl-clock.h

This file should be updated in the patch that updates clock driver.
Only after these new clocks get supported by clock driver, you can use
them in device tree.

Shawn

> @@ -255,6 +255,20 @@
>  #define IMX6QDL_CLK_CAAM_ACLK			242
>  #define IMX6QDL_CLK_CAAM_IPG			243
>  #define IMX6QDL_CLK_SPDIF_GCLK			244
> -#define IMX6QDL_CLK_END				245
> +#define IMX6QDL_CLK_UART_SEL			245
> +#define IMX6QDL_CLK_IPG_PER_SEL			246
> +#define IMX6QDL_CLK_ECSPI_SEL			247
> +#define IMX6QDL_CLK_CAN_SEL			248
> +#define IMX6QDL_CLK_MMDC_CH1_AXI_CG		249
> +#define IMX6QDL_CLK_PRE0			250
> +#define IMX6QDL_CLK_PRE1			251
> +#define IMX6QDL_CLK_PRE2			252
> +#define IMX6QDL_CLK_PRE3			253
> +#define IMX6QDL_CLK_PRG0_AXI			254
> +#define IMX6QDL_CLK_PRG1_AXI			255
> +#define IMX6QDL_CLK_PRG0_APB			256
> +#define IMX6QDL_CLK_PRG1_APB			257
> +#define IMX6QDL_CLK_PRE_AXI			258
> +#define IMX6QDL_CLK_END				259
>  
>  #endif /* __DT_BINDINGS_CLOCK_IMX6QDL_H */
> -- 
> 1.9.1
> 
> 
