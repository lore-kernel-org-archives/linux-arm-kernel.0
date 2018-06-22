From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 22 Jun 2018 09:41:02 +0200
Subject: [PATCH 2/7] ARM: dts: s5pv210: Add initial DTS for Samsung Aries
 based phones.
In-Reply-To: <1529608199-5583-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
References: <1529608199-5583-1-git-send-email-pawel.mikolaj.chmiel@gmail.com>
 <1529608199-5583-3-git-send-email-pawel.mikolaj.chmiel@gmail.com>
Message-ID: <CAJKOXPf9BVXP19Yt36uEKz=bzMh3cDd6_wdyxoRRX3itk9kuhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 June 2018 at 21:09, Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com> wrote:
> This DTS file have initial support Samsung Aries based phones.
> Initial version have support for:
> - sdcard
> - internal memory (present only on non 4g variant)
> - max8998 pmic and rtc
> - max17040 fuel gauge
> - gpio keys
> - fimd (no panel driver yet)
> - usb (peripherial mode)
> - wifi
>
> Signed-off-by: Pawe? Chmiel <pawel.mikolaj.chmiel@gmail.com>

Hi Pawel,

Nice job in mainlining!

Below you'll find some comments for improvement.

> ---
>  arch/arm/boot/dts/s5pv210-aries.dtsi | 397 +++++++++++++++++++++++++++++++++++
>  1 file changed, 397 insertions(+)
>  create mode 100644 arch/arm/boot/dts/s5pv210-aries.dtsi
>
> diff --git a/arch/arm/boot/dts/s5pv210-aries.dtsi b/arch/arm/boot/dts/s5pv210-aries.dtsi
> new file mode 100644
> index 000000000000..6e8ac3615765
> --- /dev/null
> +++ b/arch/arm/boot/dts/s5pv210-aries.dtsi
> @@ -0,0 +1,397 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Samsung's S5PV210 based Galaxy Aries board device tree source
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/gpio/gpio.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/input/input.h>

Is the input header used here?

> +#include <dt-bindings/interrupt-controller/irq.h>

Duplicated inclusion.

> +#include "s5pv210.dtsi"
> +
> +/ {
> +       compatible = "samsung,aries", "samsung,s5pv210";
> +
> +       aliases {
> +               i2c6 = &i2c_pmic;
> +               i2c9 = &i2c_fuel;
> +       };
> +
> +       memory at 30000000 {
> +               device_type = "memory";
> +               reg = <0x30000000 0x05000000
> +                       0x40000000 0x10000000
> +                       0x50000000 0x08000000>;
> +       };
> +
> +       wifi_pwrseq: wifi-pwrseq {
> +               compatible = "mmc-pwrseq-simple";
> +               reset-gpios = <&gpg1 2 GPIO_ACTIVE_LOW>;
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&wlan_gpio_rst>;
> +               post-power-on-delay-ms = <500>;
> +               power-off-delay-us = <500>;
> +       };
> +
> +       i2c_pmic: i2c-pmic {

s/i2c-pmic/ to /i2c-gpio-0/
to reflect generic class of this node. Change only the node name. The
label can stay as is.

> +               compatible = "i2c-gpio";
> +               sda-gpios = <&gpj4 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +               scl-gpios = <&gpj4 3 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

Spaces around pipe |.

> +               i2c-gpio,delay-us = <2>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               pmic at 66 {
> +                       compatible = "maxim,max8998";
> +                       reg = <0x66>;
> +                       interrupt-parent = <&gph0>;
> +                       interrupts = <7 0>;

If you really wanted 0 then IRQ_TYPE_NONE... but this should be a
proper interrupt type.

> +
> +                       max8998,pmic-buck1-default-dvs-idx = <1>;
> +                       max8998,pmic-buck1-dvs-gpios = <&gph0 3 GPIO_ACTIVE_HIGH>,
> +                                                       <&gph0 4 GPIO_ACTIVE_HIGH>;
> +                       max8998,pmic-buck1-dvs-voltage = <1275000>, <1200000>,
> +                                                       <1050000>, <950000>;
> +
> +                       max8998,pmic-buck2-default-dvs-idx = <0>;
> +                       max8998,pmic-buck2-dvs-gpio = <&gph0 5 GPIO_ACTIVE_HIGH>;
> +                       max8998,pmic-buck2-dvs-voltage = <1100000>, <1000000>;
> +
> +                       regulators {
> +                               ldo2_reg: LDO2 {
> +                                       regulator-name = "VALIVE_1.2V";
> +                                       regulator-min-microvolt = <1200000>;
> +                                       regulator-max-microvolt = <1200000>;
> +                                       regulator-always-on;
> +
> +                                       regulator-state-mem {
> +                                               regulator-on-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo3_reg: LDO3 {
> +                                       regulator-name = "VUSB_1.1V";
> +                                       regulator-min-microvolt = <1100000>;
> +                                       regulator-max-microvolt = <1100000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo4_reg: LDO4 {
> +                                       regulator-name = "VADC_3.3V";
> +                                       regulator-min-microvolt = <3300000>;
> +                                       regulator-max-microvolt = <3300000>;
> +                                       regulator-always-on;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo5_reg: LDO5 {
> +                                       regulator-name = "VTF_2.8V";
> +                                       regulator-min-microvolt = <2800000>;
> +                                       regulator-max-microvolt = <2800000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };

LDO6?

All regulators should be defined in general. Most of the drivers would
anyway register all of them and use driver-specific defaults for the
ones which are missing in DT. I see that max8998 behaves differently
and silently ignores missing regulators leaving them at bootloader
settings. That's also not good because their initial settings might
not be correct for current load and kernel cannot turn them off if
needed. Also we want in general to have full description of HW in DT.

The same applies to LDO10, clocks and ESAFEOUT2 later.


> +
> +                               ldo7_reg: LDO7 {
> +                                       regulator-name = "VLCD_1.8V";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       /* Till we get panel driver */
> +                                       regulator-always-on;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo8_reg: LDO8 {
> +                                       regulator-name = "VUSB_3.3V";
> +                                       regulator-min-microvolt = <3300000>;
> +                                       regulator-max-microvolt = <3300000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo9_reg: LDO9 {
> +                                       regulator-name = "VCC_2.8V_PDA";
> +                                       regulator-min-microvolt = <2800000>;
> +                                       regulator-max-microvolt = <2800000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               ldo11_reg: LDO11 {
> +                                       regulator-name = "CAM_AF_3.0V";
> +                                       regulator-min-microvolt = <3000000>;
> +                                       regulator-max-microvolt = <3000000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo12_reg: LDO12 {
> +                                       regulator-name = "CAM_SENSOR_CORE_1.2V";
> +                                       regulator-min-microvolt = <1200000>;
> +                                       regulator-max-microvolt = <1200000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo13_reg: LDO13 {
> +                                       regulator-name = "VGA_VDDIO_2.8V";
> +                                       regulator-min-microvolt = <2800000>;
> +                                       regulator-max-microvolt = <2800000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo14_reg: LDO14 {
> +                                       regulator-name = "VGA_DVDD_1.8V";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo15_reg: LDO15 {
> +                                       regulator-name = "CAM_ISP_HOST_2.8V";
> +                                       regulator-min-microvolt = <2800000>;
> +                                       regulator-max-microvolt = <2800000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo16_reg: LDO16 {
> +                                       regulator-name = "VGA_AVDD_2.8V";
> +                                       regulator-min-microvolt = <2800000>;
> +                                       regulator-max-microvolt = <2800000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               ldo17_reg: LDO17 {
> +                                       regulator-name = "VCC_3.0V_LCD";
> +                                       regulator-min-microvolt = <3000000>;
> +                                       regulator-max-microvolt = <3000000>;
> +                                       /* Till we get panel driver */
> +                                       regulator-always-on;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               buck1_reg: BUCK1 {
> +                                       regulator-name = "vddarm";
> +                                       regulator-min-microvolt = <750000>;
> +                                       regulator-max-microvolt = <1500000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                               regulator-suspend-microvolt = <1250000>;
> +                                       };
> +                               };
> +
> +                               buck2_reg: BUCK2 {
> +                                       regulator-name = "vddint";
> +                                       regulator-min-microvolt = <750000>;
> +                                       regulator-max-microvolt = <1500000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                               regulator-suspend-microvolt = <1100000>;
> +                                       };
> +                               };
> +
> +                               buck3_reg: BUCK3 {
> +                                       regulator-name = "VCC_1.8V";
> +                                       regulator-min-microvolt = <1800000>;
> +                                       regulator-max-microvolt = <1800000>;
> +                                       regulator-always-on;
> +                               };
> +
> +                               buck4_reg: BUCK4 {
> +                                       regulator-name = "CAM_ISP_CORE_1.2V";
> +                                       regulator-min-microvolt = <1200000>;
> +                                       regulator-max-microvolt = <1200000>;
> +
> +                                       regulator-state-mem {
> +                                               regulator-off-in-suspend;
> +                                       };
> +                               };
> +
> +                               safe1_sreg: ESAFEOUT1 {
> +                                       regulator-name = "SAFEOUT1";
> +                               };
> +                       };
> +               };
> +       };
> +
> +       i2c_fuel: i2c-fuel {

s/i2c-fuel/ to /i2c-gpio-1/


> +               compatible = "i2c-gpio";
> +               sda-gpios = <&mp05 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
> +               scl-gpios = <&mp05 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;

Spaces around | please.

> +               i2c-gpio,delay-us = <2>;
> +               #address-cells = <1>;
> +               #size-cells = <0>;
> +
> +               fuel at 36 {

Name: fuelgauge

> +                       compatible = "maxim,max17040";
> +                       interrupt-parent = <&vic0>;
> +                       interrupts = <7>;
> +                       reg = <0x36>;
> +               };
> +       };
> +};
> +
> +&xusbxti {
> +       clock-frequency = <24000000>;
> +};
> +
> +&pinctrl0 {

Please order all labels alphabetically. It reduces conflicts later
with multiple changes.

> +       wlan_bt_en: wlan-bt-en {
> +               samsung,pins = "gpb-5";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +               samsung,pin-val = <1>;
> +       };
> +
> +       wlan_gpio_rst: wlan-gpio-rst {
> +               samsung,pins = "gpg1-2";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +       };
> +
> +       wifi_host_wake: wifi-host-wake {
> +               samsung,pins = "gph2-4";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +       };
> +
> +       tf_detect: tf-detect {
> +               samsung,pins = "gph3-4";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_INPUT>;
> +               samsung,pin-pud = <S3C64XX_PIN_PULL_DOWN>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +       };
> +
> +       wifi_wake: wifi-wake {
> +               samsung,pins = "gph3-5";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +       };
> +
> +       massmemory_en: massmemory-en {
> +               samsung,pins = "gpj2-7";
> +               samsung,pin-function = <EXYNOS_PIN_FUNC_OUTPUT>;
> +               samsung,pin-pud = <S3C64XX_PIN_PULL_NONE>;
> +               samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
> +       };
> +};
> +
> +&uart0 {
> +       status = "okay";
> +};
> +
> +&uart1 {
> +       status = "okay";
> +};
> +
> +&uart2 {
> +       status = "okay";
> +};
> +
> +&sdhci1 {
> +       #address-cells = <1>;
> +       #size-cells = <0>;
> +
> +       bus-width = <4>;
> +       max-frequency = <38400000>;
> +       pinctrl-0 = <&sd1_clk &sd1_cmd &sd1_bus4 &wifi_wake &wifi_host_wake &wlan_bt_en>;
> +       pinctrl-names = "default";
> +       cap-sd-highspeed;
> +       cap-mmc-highspeed;
> +
> +       mmc-pwrseq = <&wifi_pwrseq>;
> +       non-removable;
> +       status = "okay";
> +
> +       brcmf: bcrmf at 1 {

Name of node should describe generic class of the device so maybe
"wlan" or "wlanbt"? Label is okay.

Best regards,
Krzysztof
