From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 18 Mar 2014 09:45:05 +0100
Subject: [PATCH v2 2/8] mfd: AXP20x: Add bindings documentation
In-Reply-To: <1394898225-28452-3-git-send-email-carlo@caione.org>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-3-git-send-email-carlo@caione.org>
Message-ID: <20140318084505.GT27873@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 15, 2014 at 04:43:39PM +0100, Carlo Caione wrote:
> Bindings documentation for the AXP20x driver. In this file also two
> sub-nodes (PEK and regulators) are documented.

PEK doesn't look to be documented, either in this patch, or any other.

> Signed-off-by: Carlo Caione <carlo@caione.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt   | 83 ++++++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +

I don't really know what the DT maintainers are expecting here, but I
would have done two patches.

>  2 files changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> new file mode 100644
> index 0000000..982aefe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -0,0 +1,83 @@
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
> +				  (range: 750-1875). Default: 1.5MHz
> +	- dcdc-workmode		: Optional. 1 for PWM mode, 0 for AUTO mode
> +				  Default: AUTO mode

Those two are x-powers specific, or would it make sense to have them
in other drivers too?

If the former, please add the x-powers prefix.

> +
> +Example:
> +
> +axp: axp20x at 34 {
> +	reg = <0x34>;
> +	interrupt-parent = <&nmi_intc>;
> +	interrupts = <0 8>;
> +
> +	compatible = "x-powers,axp209";
> +	interrupt-controller;
> +	#interrupt-cells = <1>;
> +
> +	regulators {

Do we really need that subnode ? it looks useless, and we already know
that we are defining regulators here.

> +		dcdc-freq = "1500";

That frequency is defined at the same level than the dcdc-workmode
property, yet they both seem to be placed at different levels.

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

It looks like those are at their default values?

Thanks!
Maxime

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140318/8f9575d9/attachment.sig>
