From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 19 Jan 2015 18:02:51 +0800
Subject: [linux-sunxi] Re: [PATCH v8 1/6] mfd: AXP20x: Add bindings
 documentation
In-Reply-To: <20150119093718.GH21886@x1>
References: <1419303194-3075-1-git-send-email-wens@csie.org>
 <1419303194-3075-2-git-send-email-wens@csie.org> <20150119093718.GH21886@x1>
Message-ID: <CAGb2v64=j8FXQmkz3UGEwac8ZkiX2qO7Cs3rTV3jbA6Y3Gt_jQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 19, 2015 at 5:37 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Tue, 23 Dec 2014, Chen-Yu Tsai wrote:
>
>> From: Carlo Caione <carlo@caione.org>
>>
>> Bindings documentation for the AXP20x driver. In this file also
>> sub-nodes are documented.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> [wens at csie.org: clarify interrupt source for the axp PMIC]
>> [wens at csie.org: explain dcdc-workmode in detail and trim lines to 80 chars]
>> [wens at csie.org: make regulator supplies optional if using unregulated input]
>> [wens at csie.org: use cubieboard2 regulator nodes as example]
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/axp20x.txt | 97 ++++++++++++++++++++++++
>>  1 file changed, 97 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/axp20x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
>> new file mode 100644
>> index 000000000000..b775d8ccbc7c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
>> @@ -0,0 +1,97 @@
>> +AXP202/AXP209 device tree bindings
>> +
>> +The axp20x family current members :
>> +axp202 (X-Powers)
>> +axp209 (X-Powers)
>> +
>> +Required properties:
>> +- compatible: "x-powers,axp202" or "x-powers,axp209"
>> +- reg: The I2C slave address for the AXP chip
>> +- interrupt-parent: The parent interrupt controller
>> +- interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
>> +- interrupt-controller: axp20x has its own internal IRQs
>> +- #interrupt-cells: Should be set to 1
>> +- regulators: A node that houses a sub-node for each regulator. The regulators
>> +           are bound using their name as listed here: dcdc2, dcdc3, ldo1,
>> +           ldo2, ldo3, ldo4, ldo5.  The bindings details of individual
>> +           regulator device can be found in:
>> +           Documentation/devicetree/bindings/regulator/regulator.txt with
>> +           the exception of x-powers,dcdc-freq. Regulators not used should
>> +           still be listed for completeness and that the regulator subsystem
>> +           properly registers them.
>> +
>> +- x-powers,dcdc-freq: defines the work frequency of DC-DC in KHz
>> +                   (range: 750-1875). Default: 1.5MHz
>
> I'm not keen on defining new properties when existing properties would
> suffice.  How about using clock-frequency here instead?  Also it's not
> common to issue this stuff using metric prefixes (KHz, MHz, etc).
> Please use HZ.

I was a bit worried about conflicts later on with things like ADC
sampling rates. But I guess that would be in a separate sub-node.
So yeah, using clock-frequencies should work out. Same for the
prefix. I'll add a patch to fix axp209.dtsi that was merged.

>> +Optional properties:
>> +- regulator supplies - may be omitted if inputs are unregulated, such as using
>> +                    the IPSOUT output from the PMIC
>> +  - acin-supply: The input supply for LDO1
>> +  - vin2-supply: The input supply for DCDC2
>> +  - vin3-supply: The input supply for DCDC3
>> +  - ldo24in-supply: The input supply for LDO2, LDO4
>> +  - ldo3in-supply: The input supply for LDO3
>> +  - ldo5in-supply: The input supply for LDO5
>> +
>> +Optional properties for DCDC regulators:
>> +- x-powers,dcdc-workmode: 1 for PWM mode, 0 for AUTO (PWM/PFM) mode
>
> If there only two options, please use bool.
>
> 'x-powers,dcdc-workmode-pwm' and default to auto if it's not present.

OK. Adding another regulator patch for this.

>> +                       Default: AUTO mode
>> +                       The DCDC regulators work in a mixed PWM/PFM mode,
>> +                       using PFM under light loads and switching to PWM
>> +                       for heavier loads. Forcing PWM mode trades efficiency
>> +                       under light loads for lower output noise. This
>> +                       probably makes sense for HiFi audio related
>> +                       applications that aren't battery constrained.
>> +
>> +Example:
>> +
>> +axp209: pmic at 34 {
>> +     compatible = "x-powers,axp209";
>> +     reg = <0x34>;
>> +     interrupt-parent = <&nmi_intc>;
>> +     interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +     interrupt-controller;
>> +     #interrupt-cells = <1>;
>> +
>> +     regulators {
>> +             x-powers,dcdc-freq = <1500>;
>> +
>> +             vdd_cpu: dcdc2 {
>> +                     regulator-always-on;
>> +                     regulator-min-microvolt = <1000000>;
>> +                     regulator-max-microvolt = <1450000>;
>> +                     regulator-name = "vdd-cpu";
>> +             };
>> +
>> +             vdd_int_dll: dcdc3 {
>> +                     regulator-always-on;
>> +                     regulator-min-microvolt = <1000000>;
>> +                     regulator-max-microvolt = <1400000>;
>> +                     regulator-name = "vdd-int-dll";
>> +             };
>> +
>> +             vdd_rtc: ldo1 {
>> +                     regulator-always-on;
>> +                     regulator-min-microvolt = <1200000>;
>> +                     regulator-max-microvolt = <1400000>;
>> +                     regulator-name = "vdd-rtc";
>> +             };
>> +
>> +             avcc: ldo2 {
>> +                     regulator-always-on;
>> +                     regulator-min-microvolt = <2700000>;
>> +                     regulator-max-microvolt = <3300000>;
>> +                     regulator-name = "avcc";
>> +             };
>> +
>> +             ldo3 {
>> +                     /* unused */
>> +             };
>
> Does this need to be in the example?

This follows the bit in the bindings saying that _all_ regulators
should be listed, even unused ones, so the regulator subsystem
can do cleanup.

>> +             csi1_io_2v8: ldo4 {
>> +                     /* output on extension headers */
>> +                     regulator-name = "csi1-io-2v8";
>> +             };
>> +     };

ldo5 is missing here.

>> +};
>> +

Thanks for the review.

Regards,
ChenYu
