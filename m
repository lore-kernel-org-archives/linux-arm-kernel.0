From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 26 Jul 2017 10:24:16 +0800
Subject: [PATCH] usb: dts: fix the issue that usb is not detected on
 ls1088ardb
In-Reply-To: <1500518306-9879-1-git-send-email-yinbo.zhu@nxp.com>
References: <1500518306-9879-1-git-send-email-yinbo.zhu@nxp.com>
Message-ID: <20170726022414.GH29754@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 10:38:26AM +0800, yinbo.zhu at nxp.com wrote:
> From: "yinbo.zhu" <yinbo.zhu@nxp.com>
> 
> Signed-off-by: yinbo.zhu <yinbo.zhu@nxp.com>

The subject should be prefixed like 'arm64: dts: ls1088a: ...'.  And
the current subject is confusing.  You are adding USB support rather
than fixing something.

Also empty commit log is not really good.

> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts |  8 ++++++++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 18 ++++++++++++++++++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> index e9276a5..d5c3d96 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
> @@ -149,6 +149,14 @@
>  	status = "okay";
>  };
>  
> +&usb0 {
> +	status = "okay";
> +};
> +
> +&usb1 {
> +	status = "okay";
> +};
> +
>  &emdio1 {
>  	/* Freescale F104 PHY1 */
>  	mdio1_phy1: emdio1_phy at 1 {

What tree is your patch generated against?  I do not see this 'emdio1'
device in my tree.

Remember to sort the node alphabetically in label name when adding new
labelled nodes.

> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 3a3be87..65b3059 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -566,6 +566,24 @@
>  			fsl,qspi-has-second-chip;
>  		};
>  
> +		usb0: usb3 at 3100000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0x3100000 0x0 0x10000>;
> +			interrupts = <0 80 0x4>; /* Level high type */

Use IRQ_TYPE_LEVEL_HIGH, so that you can save the comment here.

> +			dr_mode = "host";
> +			configure-gfladj;

What is this property?

Shawn

> +			snps,dis_rxdet_inp3_quirk;
> +		};
> +
> +		usb1: usb3 at 3110000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0x3110000 0x0 0x10000>;
> +			interrupts = <0 81 0x4>; /* Level high type */
> +			dr_mode = "host";
> +			configure-gfladj;
> +			snps,dis_rxdet_inp3_quirk;
> +		};
> +
>  		pcie at 3400000 {
>  			compatible = "fsl,ls2088a-pcie", "fsl,ls1088a-pcie",
>  				     "snps,dw-pcie";
> -- 
> 2.1.0.27.g96db324
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
