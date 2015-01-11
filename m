From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 11 Jan 2015 10:02:45 +0800
Subject: [PATCH v8 1/6] mfd: AXP20x: Add bindings documentation
In-Reply-To: <1419303194-3075-2-git-send-email-wens@csie.org>
References: <1419303194-3075-1-git-send-email-wens@csie.org>
 <1419303194-3075-2-git-send-email-wens@csie.org>
Message-ID: <CAGb2v65nTA1WCY0gR7-WPV13+od-kJo2cLdD0BS8pq762qEbDw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 23, 2014 at 10:53 AM, Chen-Yu Tsai <wens@csie.org> wrote:
> From: Carlo Caione <carlo@caione.org>
>
> Bindings documentation for the AXP20x driver. In this file also
> sub-nodes are documented.
>
> Signed-off-by: Carlo Caione <carlo@caione.org>
> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> [wens at csie.org: clarify interrupt source for the axp PMIC]
> [wens at csie.org: explain dcdc-workmode in detail and trim lines to 80 chars]
> [wens at csie.org: make regulator supplies optional if using unregulated input]
> [wens at csie.org: use cubieboard2 regulator nodes as example]
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/mfd/axp20x.txt | 97 ++++++++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>
> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
> new file mode 100644
> index 000000000000..b775d8ccbc7c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
> @@ -0,0 +1,97 @@
> +AXP202/AXP209 device tree bindings
> +
> +The axp20x family current members :
> +axp202 (X-Powers)
> +axp209 (X-Powers)
> +
> +Required properties:
> +- compatible: "x-powers,axp202" or "x-powers,axp209"
> +- reg: The I2C slave address for the AXP chip
> +- interrupt-parent: The parent interrupt controller
> +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
> +- interrupt-controller: axp20x has its own internal IRQs
> +- #interrupt-cells: Should be set to 1
> +- regulators: A node that houses a sub-node for each regulator. The regulators
> +             are bound using their name as listed here: dcdc2, dcdc3, ldo1,
> +             ldo2, ldo3, ldo4, ldo5.  The bindings details of individual
> +             regulator device can be found in:
> +             Documentation/devicetree/bindings/regulator/regulator.txt with
> +             the exception of x-powers,dcdc-freq. Regulators not used should
> +             still be listed for completeness and that the regulator subsystem
> +             properly registers them.
> +
> +- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
> +                     (range: 750-1875). Default: 1.5MHz
> +
> +Optional properties:
> +- regulator supplies - may be omitted if inputs are unregulated, such as using
> +                      the IPSOUT output from the PMIC
> +  - acin-supply: The input supply for LDO1
> +  - vin2-supply: The input supply for DCDC2
> +  - vin3-supply: The input supply for DCDC3
> +  - ldo24in-supply: The input supply for LDO2, LDO4
> +  - ldo3in-supply: The input supply for LDO3
> +  - ldo5in-supply: The input supply for LDO5
> +
> +Optional properties for DCDC regulators:
> +- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO (PWM/PFM) mode
> +                         Default: AUTO mode
> +                         The DCDC regulators work in a mixed PWM/PFM mode,
> +                         using PFM under light loads and switching to PWM
> +                         for heavier loads. Forcing PWM mode trades efficiency
> +                         under light loads for lower output noise. This
> +                         probably makes sense for HiFi audio related
> +                         applications that aren't battery constrained.

Hi Mark,

You raised some questions during v7 about the regulator bits, specifically
about the "x-powers,dcdc-workmode" property. I've expanded the regulator
parts of the DT bindings doc.

Is the current version clear enough for you? I'd like to get this merged.


Thank You
ChenYu

> +
> +Example:
> +
> +axp209: pmic at 34 {
> +       compatible = "x-powers,axp209";
> +       reg = <0x34>;
> +       interrupt-parent = <&nmi_intc>;
> +       interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
> +       interrupt-controller;
> +       #interrupt-cells = <1>;
> +
> +       regulators {
> +               x-powers,dcdc-freq = <1500>;
> +
> +               vdd_cpu: dcdc2 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1450000>;
> +                       regulator-name = "vdd-cpu";
> +               };
> +
> +               vdd_int_dll: dcdc3 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <1000000>;
> +                       regulator-max-microvolt = <1400000>;
> +                       regulator-name = "vdd-int-dll";
> +               };
> +
> +               vdd_rtc: ldo1 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <1200000>;
> +                       regulator-max-microvolt = <1400000>;
> +                       regulator-name = "vdd-rtc";
> +               };
> +
> +               avcc: ldo2 {
> +                       regulator-always-on;
> +                       regulator-min-microvolt = <2700000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-name = "avcc";
> +               };
> +
> +               ldo3 {
> +                       /* unused */
> +               };
> +
> +               csi1_io_2v8: ldo4 {
> +                       /* output on extension headers */
> +                       regulator-name = "csi1-io-2v8";
> +               };
> +       };
> +};
> +
> --
> 2.1.4
>
