From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Thu, 28 Jun 2018 09:48:48 +0200
Subject: [PATCH v2 02/10] ARM: dts: s5pv210: Add initial DTS for Samsung
 Aries based phones
In-Reply-To: <CAJKOXPdxdwmCcXNnYNCc81hZVi=YUs_+CNKev_gPZbXoMPPepg@mail.gmail.com>
References: <1530119544-30023-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1530119544-30023-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <CAJKOXPdxdwmCcXNnYNCc81hZVi=YUs_+CNKev_gPZbXoMPPepg@mail.gmail.com>
Message-ID: <CAJKOXPf5MMAwEEt8xZ2mcTUCmrZiOTgGOJuuo5yHmh8UWE6ULA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 June 2018 at 09:41, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On 27 June 2018 at 19:12, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
>> This DTS file have initial support Samsung Aries based phones.
>> Initial version have support for:
>> - sdcard
>> - internal memory (present only on non 4g variant)
>> - max8998 pmic and rtc
>> - max17040 fuel gauge
>> - gpio keys
>> - fimd (no panel driver yet)
>> - usb (peripherial mode)
>> - wifi
>>
>> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>
>> ---
>>
>> Changes from v1:
>>   - Removed duplicated and unneeded headers
>>   - Corrected node names
>>   - Added missing spaces
>>   - Removed unneeded pinctrl and sorted entries
>>   - Set correct interrupt type for max8998 pmic
>>   - Add missing regulators
>> ---
>> ---
>>  arch/arm/boot/dts/s5pv210-aries.dtsi | 423 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 423 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
>>
>> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> new file mode 100644
>> index 000000000000..61b6cf76265f
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
>> @@ -0,0 +1,423 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Samsung's S5PV210 based Galaxy Aries board device tree source
>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include "s5pv210.dtsi"
>> +
>> +/ {
>> +       compatible = "samsung,aries", "samsung,s5pv210";
>> +
>> +       aliases {
>> +               i2c6 = &i2c_pmic;
>> +               i2c9 = &i2c_fuel;
>> +       };
>> +
>> +       memory at 30000000 {
>> +               device_type = "memory";
>> +               reg = <0x30000000 0x05000000
>> +                       0x40000000 0x10000000
>> +                       0x50000000 0x08000000>;
>> +       };
>> +
>> +       wifi_pwrseq: wifi-pwrseq {
>> +               compatible = "mmc-pwrseq-simple";
>> +               reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
>> +               pinctrl-names = "default";
>> +               pinctrl-0 = <&wlan_gpio_rst>;
>> +               post-power-on-delay-ms = <500>;
>> +               power-off-delay-us = <500>;
>> +       };
>> +
>> +       i2c_pmic: i2c-gpio-0 {
>> +               compatible = "i2c-gpio";
>> +               sda-gpios = <&gpj4 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +               scl-gpios = <&gpj4 3 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +               i2c-gpio,delay-us = <2>;
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               pmic at 66 {
>> +                       compatible = "maxim,max8998";
>> +                       reg = <0x66>;
>> +                       interrupt-parent = <&gph0>;
>> +                       interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>> +
>> +                       max8998,pmic-buck1-default-dvs-idx = <1>;
>> +                       max8998,pmic-buck1-dvs-gpios = <&gph0 3 GPIO_ACTIVE_HIGH>,
>> +                                                       <&gph0 4 GPIO_ACTIVE_HIGH>;
>> +                       max8998,pmic-buck1-dvs-voltage = <1275000>, <1200000>,
>> +                                                       <1050000>, <950000>;
>> +
>> +                       max8998,pmic-buck2-default-dvs-idx = <0>;
>> +                       max8998,pmic-buck2-dvs-gpio = <&gph0 5 GPIO_ACTIVE_HIGH>;
>> +                       max8998,pmic-buck2-dvs-voltage = <1100000>, <1000000>;
>> +
>> +                       regulators {
>> +                               ldo2_reg: LDO2 {
>> +                                       regulator-name = "VALIVE_1.2V";
>> +                                       regulator-min-microvolt = <1200000>;
>> +                                       regulator-max-microvolt = <1200000>;
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-on-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo3_reg: LDO3 {
>> +                                       regulator-name = "VUSB_1.1V";
>> +                                       regulator-min-microvolt = <1100000>;
>> +                                       regulator-max-microvolt = <1100000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo4_reg: LDO4 {
>> +                                       regulator-name = "VADC_3.3V";
>> +                                       regulator-min-microvolt = <3300000>;
>> +                                       regulator-max-microvolt = <3300000>;
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo5_reg: LDO5 {
>> +                                       regulator-name = "VTF_2.8V";
>> +                                       regulator-min-microvolt = <2800000>;
>> +                                       regulator-max-microvolt = <2800000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo6_reg: LDO6 {
>> +                                       regulator-name = "LDO6";
>> +                                       regulator-min-microvolt = <1600000>;
>> +                                       regulator-max-microvolt = <3600000>;
>> +                               };
>> +
>> +                               ldo7_reg: LDO7 {
>> +                                       regulator-name = "VLCD_1.8V";
>> +                                       regulator-min-microvolt = <1800000>;
>> +                                       regulator-max-microvolt = <1800000>;
>> +                                       /* Till we get panel driver */
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo8_reg: LDO8 {
>> +                                       regulator-name = "VUSB_3.3V";
>> +                                       regulator-min-microvolt = <3300000>;
>> +                                       regulator-max-microvolt = <3300000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo9_reg: LDO9 {
>> +                                       regulator-name = "VCC_2.8V_PDA";
>> +                                       regulator-min-microvolt = <2800000>;
>> +                                       regulator-max-microvolt = <2800000>;
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               ldo10_reg: LDO10 {
>> +                                       regulator-name = "VPLL_1.2V";
>> +                                       regulator-min-microvolt = <1200000>;
>> +                                       regulator-max-microvolt = <1200000>;
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-on-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo11_reg: LDO11 {
>> +                                       regulator-name = "CAM_AF_3.0V";
>> +                                       regulator-min-microvolt = <3000000>;
>> +                                       regulator-max-microvolt = <3000000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo12_reg: LDO12 {
>> +                                       regulator-name = "CAM_SENSOR_CORE_1.2V";
>> +                                       regulator-min-microvolt = <1200000>;
>> +                                       regulator-max-microvolt = <1200000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo13_reg: LDO13 {
>> +                                       regulator-name = "VGA_VDDIO_2.8V";
>> +                                       regulator-min-microvolt = <2800000>;
>> +                                       regulator-max-microvolt = <2800000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo14_reg: LDO14 {
>> +                                       regulator-name = "VGA_DVDD_1.8V";
>> +                                       regulator-min-microvolt = <1800000>;
>> +                                       regulator-max-microvolt = <1800000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo15_reg: LDO15 {
>> +                                       regulator-name = "CAM_ISP_HOST_2.8V";
>> +                                       regulator-min-microvolt = <2800000>;
>> +                                       regulator-max-microvolt = <2800000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo16_reg: LDO16 {
>> +                                       regulator-name = "VGA_AVDD_2.8V";
>> +                                       regulator-min-microvolt = <2800000>;
>> +                                       regulator-max-microvolt = <2800000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ldo17_reg: LDO17 {
>> +                                       regulator-name = "VCC_3.0V_LCD";
>> +                                       regulator-min-microvolt = <3000000>;
>> +                                       regulator-max-microvolt = <3000000>;
>> +                                       /* Till we get panel driver */
>> +                                       regulator-always-on;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               buck1_reg: BUCK1 {
>> +                                       regulator-name = "vddarm";
>> +                                       regulator-min-microvolt = <750000>;
>> +                                       regulator-max-microvolt = <1500000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                               regulator-suspend-microvolt = <1250000>;
>> +                                       };
>> +                               };
>> +
>> +                               buck2_reg: BUCK2 {
>> +                                       regulator-name = "vddint";
>> +                                       regulator-min-microvolt = <750000>;
>> +                                       regulator-max-microvolt = <1500000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                               regulator-suspend-microvolt = <1100000>;
>> +                                       };
>> +                               };
>> +
>> +                               buck3_reg: BUCK3 {
>> +                                       regulator-name = "VCC_1.8V";
>> +                                       regulator-min-microvolt = <1800000>;
>> +                                       regulator-max-microvolt = <1800000>;
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               buck4_reg: BUCK4 {
>> +                                       regulator-name = "CAM_ISP_CORE_1.2V";
>> +                                       regulator-min-microvolt = <1200000>;
>> +                                       regulator-max-microvolt = <1200000>;
>> +
>> +                                       regulator-state-mem {
>> +                                               regulator-off-in-suspend;
>> +                                       };
>> +                               };
>> +
>> +                               ap32khz_reg: EN32KHz-AP {
>> +                                       regulator-name = "32KHz AP";
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               cp32khz_reg: EN32KHz-CP {
>> +                                       regulator-name = "32KHz CP";
>> +                               };
>> +
>> +                               vichg_reg: ENVICHG {
>> +                                       regulator-name = "VICHG";
>> +                                       regulator-always-on;
>> +                               };
>> +
>> +                               safe1_sreg: ESAFEOUT1 {
>> +                                       regulator-name = "SAFEOUT1";
>> +                               };
>> +
>> +                               safe2_sreg: ESAFEOUT2 {
>> +                                       regulator-name = "SAFEOUT2";
>> +                               };
>> +                       };
>> +               };
>> +       };
>> +
>> +       i2c_fuel: i2c-gpio-1 {
>> +               compatible = "i2c-gpio";
>> +               sda-gpios = <&mp05 1 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +               scl-gpios = <&mp05 0 (GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN)>;
>> +               i2c-gpio,delay-us = <2>;
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               fuelgauge at 36 {
>> +                       compatible = "maxim,max17040";
>> +                       interrupt-parent = <&vic0>;
>> +                       interrupts = <7>;
>> +                       reg = <0x36>;
>> +               };
>> +       };
>> +};
>> +
>> +&xusbxti {
>> +       clock-frequency = <24000000>;
>> +};
>> +
>> +&pinctrl0 {
>
> Thanks for changes. You missed one part - ordering the labels here
> alphabetically, so:
>
> &fimd {}
> &hsotg {}
> ...
> &xusbxti {}

Ah, now I see that you changed the order of nodes inside pinctrl. No
need. These were good - ordered by pin names (so gpb, gpg, gph, gpj).
I was referring only to the top-level overrides by label. The point is
when people add new overrides, they tend to add them to the end... and
this brings conflicts with multiple edits at the same time. When node
overrides are ordered and new entries are being added, the chance of
conflicts is reduced.

BR,
Krzysztof
