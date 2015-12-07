From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Dec 2015 12:18:43 +0000
Subject: [PATCH 12/12] ARM: dts: imx6: add Vivante GPU nodes
In-Reply-To: <1449237604-19064-13-git-send-email-l.stach@pengutronix.de>
References: <1449237604-19064-1-git-send-email-l.stach@pengutronix.de>
 <1449237604-19064-13-git-send-email-l.stach@pengutronix.de>
Message-ID: <20151207121843.GO8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 04, 2015 at 03:00:04PM +0100, Lucas Stach wrote:
> This adds the device nodes for 2D, 3D and VG GPU cores.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>

This should have been copied to the arm-soc people, as we'll need their
acks to keep this part of the series, or it needs to be split from this
series and merged independently.  Also adding lakml.

It'd also be good to add two Dove patches to the set.

> ---
>  arch/arm/boot/dts/imx6dl.dtsi  |  5 +++++
>  arch/arm/boot/dts/imx6q.dtsi   | 15 +++++++++++++++
>  arch/arm/boot/dts/imx6qdl.dtsi | 22 ++++++++++++++++++++++
>  3 files changed, 42 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
> index 4b0ec0703825..51c517a5cafd 100644
> --- a/arch/arm/boot/dts/imx6dl.dtsi
> +++ b/arch/arm/boot/dts/imx6dl.dtsi
> @@ -104,6 +104,11 @@
>  		compatible = "fsl,imx-display-subsystem";
>  		ports = <&ipu1_di0>, <&ipu1_di1>;
>  	};
> +
> +	gpu-subsystem {
> +		compatible = "fsl,imx-gpu-subsystem";
> +		cores = <&gpu_2d>, <&gpu_3d>;
> +	};
>  };
>  
>  &gpt {
> diff --git a/arch/arm/boot/dts/imx6q.dtsi b/arch/arm/boot/dts/imx6q.dtsi
> index 399103b8e2c9..77d618b2870c 100644
> --- a/arch/arm/boot/dts/imx6q.dtsi
> +++ b/arch/arm/boot/dts/imx6q.dtsi
> @@ -153,6 +153,16 @@
>  			status = "disabled";
>  		};
>  
> +		gpu_vg: gpu at 02204000 {
> +			compatible = "vivante,gc";
> +			reg = <0x02204000 0x4000>;
> +			interrupts = <0 11 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6QDL_CLK_OPENVG_AXI>,
> +				 <&clks IMX6QDL_CLK_GPU2D_CORE>;
> +			clock-names = "bus", "core";
> +			power-domains = <&gpc 1>;
> +		};
> +
>  		ipu2: ipu at 02800000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> @@ -225,6 +235,11 @@
>  		compatible = "fsl,imx-display-subsystem";
>  		ports = <&ipu1_di0>, <&ipu1_di1>, <&ipu2_di0>, <&ipu2_di1>;
>  	};
> +
> +	gpu-subsystem {
> +		compatible = "fsl,imx-gpu-subsystem";
> +		cores = <&gpu_2d>, <&gpu_3d>, <&gpu_vg>;
> +	};
>  };
>  
>  &hdmi {
> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
> index 2b6cc8bf3c5c..018975b867e1 100644
> --- a/arch/arm/boot/dts/imx6qdl.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
> @@ -119,6 +119,28 @@
>  			status = "disabled";
>  		};
>  
> +
> +		gpu_2d: gpu at 00134000 {
> +			compatible = "vivante,gc";
> +			reg = <0x00134000 0x4000>;
> +			interrupts = <0 10 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6QDL_CLK_GPU2D_AXI>,
> +				 <&clks IMX6QDL_CLK_GPU2D_CORE>;
> +			clock-names = "bus", "core";
> +			power-domains = <&gpc 1>;
> +		};
> +
> +		gpu_3d: gpu at 00130000 {
> +			compatible = "vivante,gc";
> +			reg = <0x00130000 0x4000>;
> +			interrupts = <0 9 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks IMX6QDL_CLK_GPU3D_AXI>,
> +				 <&clks IMX6QDL_CLK_GPU3D_CORE>,
> +				 <&clks IMX6QDL_CLK_GPU3D_SHADER>;
> +			clock-names = "bus", "core", "shader";
> +			power-domains = <&gpc 1>;
> +		};
> +
>  		hdmi: hdmi at 0120000 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -- 
> 2.6.2
> 

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
