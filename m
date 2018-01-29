From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 29 Jan 2018 09:48:57 +0800
Subject: [PATCH 1/1] dt-bindings: thermal: imx: update the binding to new
 method
In-Reply-To: <1516862269-25543-1-git-send-email-aisheng.dong@nxp.com>
References: <1516862269-25543-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20180129014855.GA12957@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 25, 2018 at 02:37:49PM +0800, Dong Aisheng wrote:
> Due to the old method has already been marked as deprecated in binding
> doc, so obviously it's better to update the example to new bindings
> as well.
> 
> Cc: Shawn Guo <shawn.guo@linaro.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>

Please use my kernel.org address for kernel patches.

Shawn

> Cc: Leonard Crestez <leonard.crestez@nxp.com>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  .../devicetree/bindings/thermal/imx-thermal.txt    | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/imx-thermal.txt b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> index 28be51a..379eb76 100644
> --- a/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/imx-thermal.txt
> @@ -22,7 +22,32 @@ Optional properties:
>  - clocks : thermal sensor's clock source.
>  
>  Example:
> +ocotp: ocotp at 21bc000 {
> +	#address-cells = <1>;
> +	#size-cells = <1>;
> +	compatible = "fsl,imx6sx-ocotp", "syscon";
> +	reg = <0x021bc000 0x4000>;
> +	clocks = <&clks IMX6SX_CLK_OCOTP>;
>  
> +	tempmon_calib: calib at 38 {
> +		reg = <0x38 4>;
> +	};
> +
> +	tempmon_temp_grade: temp-grade at 20 {
> +		reg = <0x20 4>;
> +	};
> +};
> +
> +tempmon: tempmon {
> +	compatible = "fsl,imx6sx-tempmon", "fsl,imx6q-tempmon";
> +	interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +	fsl,tempmon = <&anatop>;
> +	nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
> +	nvmem-cell-names = "calib", "temp_grade";
> +	clocks = <&clks IMX6SX_CLK_PLL3_USB_OTG>;
> +};
> +
> +Legacy method (Deprecated):
>  tempmon {
>  	compatible = "fsl,imx6q-tempmon";
>  	fsl,tempmon = <&anatop>;
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
