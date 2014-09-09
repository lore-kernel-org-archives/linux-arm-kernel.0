From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Sep 2014 18:59:40 +0100
Subject: [PATCH RFC 1/3] DT: add binding for MXS regulator
In-Reply-To: <1410089869-6611-2-git-send-email-info@lategoodbye.de>
References: <1410089869-6611-1-git-send-email-info@lategoodbye.de>
 <1410089869-6611-2-git-send-email-info@lategoodbye.de>
Message-ID: <20140909175940.GF3896@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Sep 07, 2014 at 12:37:47PM +0100, Stefan Wahren wrote:
> This patch adds the Device tree bindings for the Freescale MXS on-chip
> regulators.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> ---
>  .../bindings/regulator/mxs-regulator.txt           | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/mxs-regulator.txt
> 
> diff --git a/Documentation/devicetree/bindings/regulator/mxs-regulator.txt b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
> new file mode 100644
> index 0000000..c3226cc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/mxs-regulator.txt
> @@ -0,0 +1,38 @@
> +MXS regulators
> +
> +Required node properties:
> +- compatible: Should be "fsl,<soc>-power", where soc is "imx23" or "imx28"
> +- reg: Offset and length of the register set for the device

We require #address-cells and #size-cells if the child nodes have reg
entries.

> +
> +Required regulator properties:
> +- compatible: Must be "fsl,mxs-regulator"
> +- reg: Offset of the register set for the regulator

Is this the offset or the absolute physical address?

The example seems to be absolute.

> +- mxs-max-reg-val: Maximum value of this register

What does this even mean? What's the format?

Is this not implied by standard properties like regulator-max-microvolt?

> +Optional regulator properties:
> +- mxs-default-microvolt: initial voltage of the regulator

Why is this necessary?

Mark.

> +
> +Any regulator property defined as part of the core regulator
> +binding, defined in regulator.txt, can also be used.
> +
> +Example:
> +
> +	power: power at 80044000 {
> +		compatible = "fsl,imx28-power";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		reg = <0x80044000 0x2000>;
> +
> +		reg_vddio: regulator-vddio at 80044060 {
> +			reg = <0x80044060>;
> +			compatible = "fsl,mxs-regulator";
> +			regulator-name = "vddio";
> +			regulator-min-microvolt = <2800000>;
> +			regulator-max-microvolt = <3600000>;
> +			regulator-microvolt-offset = <80000>;
> +			regulator-always-on;
> +			mxs-max-reg-val = <0x10>;
> +			mxs-default-microvolt = <3300000>;
> +		};
> +	};
> +
> -- 
> 1.8.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
