From: t.figa@samsung.com (Tomasz Figa)
Date: Tue, 07 Jan 2014 15:10:04 +0100
Subject: [PATCH v7 3/3] mfd: max14577: Add device tree bindings document
In-Reply-To: <1386329534-14186-4-git-send-email-k.kozlowski@samsung.com>
References: <1386329534-14186-1-git-send-email-k.kozlowski@samsung.com>
 <1386329534-14186-4-git-send-email-k.kozlowski@samsung.com>
Message-ID: <2536498.L12VSLryvi@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Friday 06 of December 2013 12:32:14 Krzysztof Kozlowski wrote:
> Add document describing device tree bindings for MAX14577 MFD driver.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  Documentation/devicetree/bindings/mfd/max14577.txt |   65 ++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/max14577.txt
> 
> diff --git a/Documentation/devicetree/bindings/mfd/max14577.txt b/Documentation/devicetree/bindings/mfd/max14577.txt
> new file mode 100644
> index 000000000000..0b2449aaf8bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/max14577.txt
> @@ -0,0 +1,65 @@
> +Maxim MAX14577 Multi-Function Device
> +
> +MAX14577 is a Multi-Function Device with Micro-USB Interface Circuit, Li+
> +Battery Charger and SFOUT LDO output for powering USB devices. It is
> +interfaced to host controller using I2C.
> +
> +
> +Required properties:
> +- compatible : Must be "maxim,max14577".
> +- reg : I2C slave address for the max14577 chip.

If this chip has a predefined set of addresses it might be a good idea to
list them here.

> +- interrupts : IRQ line for the max14577 chip.
> +- interrupt-parent :  The parent interrupt controller.
> +
> +
> +Optional nodes:
> +- max14577-muic :
> +	Node used only by extcon consumers.

Do you need a dedicated node to do this? If you don't need any additional
data for MUIC cell, why couldn't the parent node be used to register the
extcon provider?

> +	Required properties:
> +		- compatible : "maxim,max14577-muic"
> +
> +- regulators :
> +	Required properties:
> +		- compatible : "maxim,max14577-regulator"
> +
> +	May contain a sub-node per regulator from the list below. Each

Is "May" the correct word? Wouldn't it be better to always have
configuration specified for all regulators of the cell?

> +	sub-node should contain the constraints and initialization information
> +	for that regulator. See regulator.txt for a description of standard
> +	properties for these sub-nodes.
> +
> +	List of valid regulator names: CHARGER, SAFEOUT.
> +
> +	The SAFEOUT is a fixed voltage regulator so there is no need to specify
> +	voltages for it.
> +
> +
> +Example:
> +
> +#include <dt-bindings/interrupt-controller/irq.h>
> +
> +max14577 at 25 {
> +	compatible = "maxim,max14577";
> +	reg = <0x25>;
> +	interrupt-parent = <&gpx1>;
> +	interrupts = <5 IRQ_TYPE_NONE>;
> +
> +	muic: max14577-muic {
> +		compatible = "maxim,max14577-muic";
> +	};
> +
> +	regulators {
> +		compatible = "maxim,max14577-regulator";
> +
> +		safeout_reg: regulator at 1 {
> +			regulator-compatible = "SAFEOUT";
> +			regulator-name = "SAFEOUT";
> +		};
> +		charger_reg: regulator at 0 {
> +			regulator-compatible = "CHARGER";
> +			regulator-name = "CHARGER";
> +			regulator-min-microamp = <90000>;
> +			regulator-max-microamp = <950000>;
> +			regulator-boot-on;
> +		};
> +	};
> +};
> 

Now this patch creates a question whether we should keep the existing
black-box MFD scheme, where the list of cells is determined by an array
hardcoded inside the driver or rather we should completely move to DT
based description where of_mfd_populate() could create all MFD cells
using description from DT.

Best regards,
Tomasz
