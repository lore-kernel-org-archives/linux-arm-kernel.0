From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 29 Oct 2013 16:08:29 +0200
Subject: [PATCH v3 06/10] spmi: document the PMIC arbiter SPMI bindings
In-Reply-To: <043d714725f8b6df1873047164d2d0e78778138b.1382985169.git.joshc@codeaurora.org>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <043d714725f8b6df1873047164d2d0e78778138b.1382985169.git.joshc@codeaurora.org>
Message-ID: <1383055709.2837.17.camel@iivanov-dev.int.mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Josh,

On Mon, 2013-10-28 at 13:12 -0500, Josh Cartwright wrote: 
> Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> ---
>  .../bindings/spmi/qcom,spmi-pmic-arb.txt           | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> 
> diff --git a/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> new file mode 100644
> index 0000000..68949aa
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spmi/qcom,spmi-pmic-arb.txt
> @@ -0,0 +1,42 @@
> +Qualcomm SPMI Controller (PMIC Arbiter)
> +
> +The SPMI PMIC Arbiter is found on the Snapdragon 800 Series.  It is an SPMI
> +controller with wrapping arbitration logic to allow for multiple on-chip
> +devices to control a single SPMI master.
> +
> +The PMIC Arbiter can also act as an interrupt controller, providing interrupts
> +to slave devices.
> +
> +See spmi.txt for the generic SPMI controller binding requirements for child
> +nodes.
> +
> +Required properties:
> +- compatible : should be "qcom,spmi-pmic-arb".
> +- reg-names  : should be "core", "intr", "cnfg"
> +- reg : offset and length of the PMIC Arbiter Core register map.
> +- reg : offset and length of the PMIC Arbiter Interrupt controller register map.
> +- reg : offset and length of the PMIC Arbiter Configuration register map.
> +- #address-cells : must be set to 1

This doesn't seem to follow generic set of bindings for the SPMI
controllers. #address-cells : must be set to 2.

Regards,
Ivan

> +- #size-cells : must be set to 0
> +- interrupt-controller : indicates the PMIC arbiter is an interrupt controller
> +- #interrupt-cells = <4>:  interrupts are specified as a 4-tuple:
> +    cell 1: slave ID for the requested interrupt (0-15)
> +    cell 2: peripheral ID for requested interrupt (0-255)
> +    cell 3: the requested peripheral interrupt (0-7)
> +    cell 4: interrupt flags indicating level-sense information, as defined in
> +            dt-bindings/interrupt-controller/irq.h
> +
> +Example:
> +
> +	qcom,spmi at fc4c0000 {
> +		compatible = "qcom,spmi-pmic-arb";
> +		reg-names = "core", "intr", "cnfg";
> +		reg = <0xfc4cf000 0x1000>,
> +		      <0Xfc4cb000 0x1000>,
> +		      <0Xfc4ca000 0x1000>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		interrupt-controller;
> +		#interrupt-cells = <4>;
> +	};
