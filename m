From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 7 Mar 2014 19:13:00 +0100
Subject: [PATCH 2/7] mfd: AXP20x: Add bindings documentation
In-Reply-To: <1393692352-10839-3-git-send-email-carlo@caione.org>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-3-git-send-email-carlo@caione.org>
Message-ID: <20140307181300.GZ607@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 01, 2014 at 05:45:47PM +0100, Carlo Caione wrote:
> Bindings documentation for the AXP20x driver. In this file also two
> sub-nodes (PEK and regulators) are documented.
> 
> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 93 ++++++++++++++++++++++++
>  1 file changed, 93 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> new file mode 100644
> index 0000000..ae3e3c4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -0,0 +1,93 @@
> +* axp20x device tree bindings
> +
> +The axp20x family current members :-
> +axp202 (X-Powers)
> +axp209 (X-Powers)
> +
> +Required properties:
> +- compatible 			: Should be "x-powers,axp202" or "x-powers,axp209"
> +- interrupt-controller 		: axp20x has its own internal IRQs
> +- #interrupt-cells 		: Should be set to 1
> +- interrupt-parent 		: The parent interrupt controller
> +- interrupts 			: Interrupt specifiers for interrupt sources
> +- reg 				: The I2C slave address for the AXP chip
> +- axp,system-power-controller	: Telling whether or not this pmic is
> +				  controlling the system power
> +
> +Sub-nodes:
> +* regulators : Contain the regulator nodes. The regulators are bound using
> +	       their name as listed here: dcdc2, dcdc3, ldo1, ldo2, ldo3,
> +	       ldo4, ldo5.
> +	       The bindings details of individual regulator device can be found in:
> +	       Documentation/devicetree/bindings/regulator/regulator.txt with the
> +	       exception of:
> +
> +	- dcdc-freq		: defines the work frequency of DC-DC in KHz
> +				  (range: 750-1875)
> +	- dcdc-workmode		: 1 for PWM mode, 0 for AUTO mode

You don't seem to always set this. You should mention that it is
optional, and which default value it has.

> +
> +* axp20x-pek : Power Enable Key
> +	- compatible		: should be "x-powers,axp20x-pek"

Why is this needed for?

Plus, please don't use any generic, or pattern matching compatibles,
but rather precise ones, so that if it is needed, we can add any quirk
we want.


> +Example:
> +
> +axp: axp20x at 34 {
> +	reg = <0x34>;
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 8>;
> +
> +	axp,system-power-controller;
> +
> +	compatible = "x-powers,axp209";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	axp20x-pek {
> +		compatible = "x-powers,axp20x-pek";
> +	};
> +
> +	regulators {
> +		dcdc-freq = "8";
> +
> +		axp_dcdc2: dcdc2 {
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <2275000>;
> +			dcdc-workmode = <0>;
> +			regulator-always-on;
> +		};
> +
> +		axp_dcdc3: dcdc3 {
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <3500000>;
> +			dcdc-workmode = <0>;
> +			regulator-always-on;
> +		};
> +
> +		axp_ldo1: ldo1 {
> +			regulator-min-microvolt = <1300000>;
> +			regulator-max-microvolt = <1300000>;
> +		};
> +
> +		axp_ldo2: ldo2 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +
> +		axp_ldo3: ldo3 {
> +			regulator-min-microvolt = <700000>;
> +			regulator-max-microvolt = <3500000>;
> +		};
> +
> +		axp_ldo4: ldo4 {
> +			regulator-min-microvolt = <1250000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +
> +		axp_ldo5: ldo5 {
> +			regulator-min-microvolt = <1800000>;
> +			regulator-max-microvolt = <3300000>;
> +		};
> +	};
> +};
> +
> -- 
> 1.8.3.2
> 

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140307/52e645ac/attachment-0001.sig>
