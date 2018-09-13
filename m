From: yao.yuan@linaro.org (Yao Yuan)
Date: Thu, 13 Sep 2018 14:06:11 +0800
Subject: [PATCH] ARM: dts: aspeed: Add HXT StarDragon 4800 REP2 BMC
In-Reply-To: <CACPK8Xc6g9R9SyaJT3XzgKrxzZiV0ccTwAddf5Ot2tzQ0bmeag@mail.gmail.com>
References: <1536805516-21484-1-git-send-email-yao.yuan@linaro.org>
 <CACPK8Xc6g9R9SyaJT3XzgKrxzZiV0ccTwAddf5Ot2tzQ0bmeag@mail.gmail.com>
Message-ID: <CA+eB3Aw_K-zSf16eOvf7FDnhppPpJH5FLrmOOiJY+_GDE99ctA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2018 at 11:01, Joel Stanley <joel@jms.id.au> wrote:
> On Thu, 13 Sep 2018 at 11:55, Yuan Yao <yao.yuan@linaro.org> wrote:
>>
>> The HXT StarDragon 4800 REP2 (Reference Evaluation Platform) is
>> an aarch64 ARMv8 server platform with an ast2520 BMC.
>>
>> Signed-off-by: Yuan Yao <yao.yuan@linaro.org>
>
> Looks good. I will apply it to the Aspeed tree in a few days, after
> giving others a chance to review.
>
> Out of interest, are you planning on running OpenBMC on this platform?

Hi Joel,

Thanks for your work.

Yes, I will running OpenBMC on this platform.
And In fact, the OpenBMC basic startup is already running on REP2.
I'm also trying to push the OpenBMC patch for this platform.


> Cheers,
>
> Joel
>
>> ---
>>  .../devicetree/bindings/vendor-prefixes.txt        |   1 +
>>  arch/arm/boot/dts/Makefile                         |   1 +
>>  .../dts/aspeed-bmc-arm-stardragon4800-rep2.dts     | 207 +++++++++++++++++++++
>>  3 files changed, 209 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> index 2c3fc51..c65c0c1 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
>> @@ -165,6 +165,7 @@ honeywell   Honeywell
>>  hp     Hewlett Packard
>>  holtek Holtek Semiconductor, Inc.
>>  hwacom HwaCom Systems Inc.
>> +hxt            Huaxintong Semiconductor Technology Co., Ltd.
>>  i2se   I2SE GmbH
>>  ibm    International Business Machines (IBM)
>>  idt    Integrated Device Technologies, Inc.
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b5bd3de..a1b8816 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -1199,6 +1199,7 @@ dtb-$(CONFIG_ARCH_ZX) += zx296702-ad1.dtb
>>  dtb-$(CONFIG_ARCH_ASPEED) += \
>>         aspeed-ast2500-evb.dtb \
>>         aspeed-bmc-arm-centriq2400-rep.dtb \
>> +       aspeed-bmc-arm-stardragon4800-rep2.dtb \
>>         aspeed-bmc-intel-s2600wf.dtb \
>>         aspeed-bmc-opp-lanyang.dtb \
>>         aspeed-bmc-opp-palmetto.dtb \
>> diff --git a/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
>> new file mode 100644
>> index 0000000..83335c0
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/aspeed-bmc-arm-stardragon4800-rep2.dts
>> @@ -0,0 +1,207 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/dts-v1/;
>> +
>> +#include "aspeed-g5.dtsi"
>> +#include <dt-bindings/gpio/aspeed-gpio.h>
>> +
>> +/ {
>> +       model = "HXT StarDragon 4800 REP2 AST2520";
>> +       compatible = "hxt,stardragon4800-rep2-bmc", "aspeed,ast2500";
>> +
>> +       chosen {
>> +               stdout-path = &uart5;
>> +               bootargs = "console=ttyS4,115200 earlyprintk";
>> +       };
>> +
>> +       memory {
>> +               reg = <0x80000000 0x40000000>;
>> +       };
>> +
>> +       iio-hwmon {
>> +               compatible = "iio-hwmon";
>> +               io-channels = <&adc 0>, <&adc 1>, <&adc 2>, <&adc 3>,
>> +                                               <&adc 4>, <&adc 5>, <&adc 6>, <&adc 8>;
>> +       };
>> +
>> +       iio-hwmon-battery {
>> +               compatible = "iio-hwmon";
>> +               io-channels = <&adc 7>;
>> +       };
>> +
>> +       leds {
>> +               compatible = "gpio-leds";
>> +
>> +               system_fault1 {
>> +                       label = "System_fault1";
>> +                       gpios = <&gpio ASPEED_GPIO(I, 3) GPIO_ACTIVE_LOW>;
>> +               };
>> +
>> +               system_fault2 {
>> +                       label = "System_fault2";
>> +                       gpios = <&gpio ASPEED_GPIO(I, 2) GPIO_ACTIVE_LOW>;
>> +               };
>> +       };
>> +};
>> +
>> +&fmc {
>> +       status = "okay";
>> +       flash at 0 {
>> +               status = "okay";
>> +               m25p,fast-read;
>> +               label = "bmc";
>> +#include "openbmc-flash-layout.dtsi"
>> +       };
>> +};
>> +
>> +&spi1 {
>> +       status = "okay";
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_spi1_default>;
>> +       flash at 0 {
>> +               status = "okay";
>> +       };
>> +};
>> +
>> +&spi2 {
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_spi2ck_default
>> +                       &pinctrl_spi2miso_default
>> +                       &pinctrl_spi2mosi_default
>> +                       &pinctrl_spi2cs0_default>;
>> +};
>> +
>> +&uart3 {
>> +       status = "okay";
>> +
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_txd3_default &pinctrl_rxd3_default>;
>> +       current-speed = <115200>;
>> +};
>> +
>> +&uart5 {
>> +       status = "okay";
>> +};
>> +
>> +&mac0 {
>> +       status = "okay";
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_rgmii1_default &pinctrl_mdio1_default>;
>> +};
>> +
>> +&mac1 {
>> +       status = "okay";
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_rmii2_default>;
>> +       use-ncsi;
>> +};
>> +
>> +&i2c0 {
>> +       status = "okay";
>> +};
>> +
>> +&i2c1 {
>> +       status = "okay";
>> +
>> +       tmp421 at 1e {
>> +               compatible = "ti,tmp421";
>> +               reg = <0x1e>;
>> +       };
>> +       tmp421 at 2a {
>> +               compatible = "ti,tmp421";
>> +               reg = <0x2a>;
>> +       };
>> +       tmp421 at 1c {
>> +               compatible = "ti,tmp421";
>> +               reg = <0x1c>;
>> +       };
>> +};
>> +
>> +&i2c2 {
>> +       status = "okay";
>> +};
>> +
>> +&i2c3 {
>> +       status = "okay";
>> +};
>> +
>> +&i2c4 {
>> +       status = "okay";
>> +};
>> +
>> +&i2c5 {
>> +       status = "okay";
>> +};
>> +
>> +&i2c6 {
>> +       status = "okay";
>> +
>> +       tmp421 at 1f {
>> +               compatible = "ti,tmp421";
>> +               reg = <0x1f>;
>> +       };
>> +       nvt210 at 4c {
>> +               compatible = "nvt210";
>> +               reg = <0x4c>;
>> +       };
>> +       eeprom at 50 {
>> +               compatible = "atmel,24c128";
>> +               reg = <0x50>;
>> +               pagesize = <128>;
>> +       };
>> +};
>> +
>> +&i2c7 {
>> +       status = "okay";
>> +};
>> +
>> +&i2c8 {
>> +       status = "okay";
>> +
>> +       pca9641 at 70 {
>> +               compatible = "nxp,pca9641";
>> +               reg = <0x70>;
>> +               i2c-arb {
>> +                       #address-cells = <1>;
>> +                       #size-cells = <0>;
>> +                       eeprom at 50 {
>> +                               compatible = "atmel,24c02";
>> +                               reg = <0x50>;
>> +                       };
>> +                       dps650ab at 58 {
>> +                               compatible = "dps650ab";
>> +                               reg = <0x58>;
>> +                       };
>> +               };
>> +       };
>> +};
>> +
>> +&i2c9 {
>> +       status = "okay";
>> +};
>> +
>> +&vuart {
>> +       status = "okay";
>> +};
>> +
>> +&gfx {
>> +       status = "okay";
>> +};
>> +
>> +&pinctrl {
>> +       aspeed,external-nodes = <&gfx &lhc>;
>> +};
>> +
>> +&gpio {
>> +       pin_gpio_c7 {
>> +               gpio-hog;
>> +               gpios = <ASPEED_GPIO(C, 7) GPIO_ACTIVE_HIGH>;
>> +               output-low;
>> +               line-name = "BIOS_SPI_MUX_S";
>> +       };
>> +       pin_gpio_d1 {
>> +               gpio-hog;
>> +               gpios = <ASPEED_GPIO(D, 1) GPIO_ACTIVE_HIGH>;
>> +               output-high;
>> +               line-name = "PHY2_RESET_N";
>> +       };
>> +};
>> --
>> 1.8.3.1
>>
