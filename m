From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Mar 2018 16:58:14 +0800
Subject: [PATCH v5 2/3] USB3/DWC3: Add property "snps,
 incr-burst-type-adjustment" for INCR burst type
In-Reply-To: <20180306085911.5930-2-ran.wang_1@nxp.com>
References: <20180306085911.5930-1-ran.wang_1@nxp.com>
 <20180306085911.5930-2-ran.wang_1@nxp.com>
Message-ID: <20180308085813.GZ3217@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 06, 2018 at 04:59:10PM +0800, Ran Wang wrote:
> Property "snps,incr-burst-type-adjustment = <x>, <y>..." for USB3.0 DWC3.
> When only one value means INCRx mode with fix burst type.
> When more than one value, means undefined length burst mode, USB controller
> can use the length less than or equal to the largest enabled burst length.
> 
> While enabling undefined length INCR burst type and INCR16 burst type,
> get better write performance on NXP Layerscape platforms:
> around 3% improvement (from 364MB/s to 375MB/s).
> 
> Signed-off-by: Changming Huang <jerry.huang@nxp.com>
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
> Changes in v5:
>   - add support for ls1021a, ls1012a, ls1046a, ls1088a, ls1021a
>   - update ls208xa support according to code base change
> Changes in v4:
>   - change definition for this property.
> Changes in v3:
>   - add new property for INCR burst in usb node.
> 
>  Documentation/devicetree/bindings/usb/dwc3.txt |    6 ++++++

Please do not mix bindings doc with DTS change in one patch, and only
send DTS patch after bindings and driver changes are accepted.

Shawn

>  arch/arm/boot/dts/ls1021a.dtsi                 |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi |    1 +
>  arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi |    3 +++
>  arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi |    2 ++
>  arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi |    2 ++
>  7 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
> index 44e8bab..d1779b2 100644
> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
> @@ -59,6 +59,11 @@ Optional properties:
>  	fladj_30mhz_sdbnd signal is invalid or incorrect.
>  
>   - <DEPRECATED> tx-fifo-resize: determines if the FIFO *has* to be reallocated.
> + - snps,incr-burst-type-adjustment: Value for INCR burst type of GSBUSCFG0
> +	register, undefined length INCR burst type enable and INCRx type.
> +	When just one value, which means INCRX burst mode. When more than one
> +	value, which means undefined length INCR burst type enabled.
> +	The values can be 1, 4, 8, 16, 32, 64, 128 and 256.
>  
>   - in addition all properties from usb-xhci.txt from the current directory are
>     supported as well
> @@ -71,4 +76,5 @@ dwc3 at 4a030000 {
>  	reg = <0x4a030000 0xcfff>;
>  	interrupts = <0 92 4>
>  	usb-phy = <&usb2_phy>, <&usb3,phy>;
> +	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  };
> diff --git a/arch/arm/boot/dts/ls1021a.dtsi b/arch/arm/boot/dts/ls1021a.dtsi
> index c31dad9..b0c3f4f 100644
> --- a/arch/arm/boot/dts/ls1021a.dtsi
> +++ b/arch/arm/boot/dts/ls1021a.dtsi
> @@ -705,6 +705,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		pcie at 3400000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> index 82b272f..4275a8f 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> @@ -464,6 +464,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		sata: sata at 3200000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> index 380e7c7..0067567 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
> @@ -622,6 +622,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb1: usb3 at 3000000 {
> @@ -631,6 +632,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb2: usb3 at 3100000 {
> @@ -640,6 +642,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		sata: sata at 3200000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> index 06b5e12..2bf6756 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
> @@ -602,6 +602,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb1: usb at 3000000 {
> @@ -611,6 +612,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb2: usb at 3100000 {
> @@ -620,6 +622,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		sata: sata at 3200000 {
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> index 4fc150c..c2b5b45 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
> @@ -478,6 +478,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  			status = "disabled";
>  		};
>  
> @@ -488,6 +489,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  			status = "disabled";
>  		};
>  
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> index f3a40af..d5b25f2 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
> @@ -754,6 +754,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		usb1: usb3 at 3110000 {
> @@ -764,6 +765,7 @@
>  			dr_mode = "host";
>  			snps,quirk-frame-length-adjustment = <0x20>;
>  			snps,dis_rxdet_inp3_quirk;
> +			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
>  		};
>  
>  		ccn at 4000000 {
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
