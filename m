From: marex@denx.de (Marek Vasut)
Date: Sun, 08 May 2016 22:23:39 +0200
Subject: [PATCH 3/4] ARM: mxs: dts: Add Creative X-Fi3 support
In-Reply-To: <977436072.210446.e7eef450-2262-47df-8e8e-6a44da10083c.open-xchange@email.1und1.de>
References: <1462479971-7891-1-git-send-email-marex@denx.de>
 <1462479971-7891-3-git-send-email-marex@denx.de>
 <977436072.210446.e7eef450-2262-47df-8e8e-6a44da10083c.open-xchange@email.1und1.de>
Message-ID: <572FA04B.1020005@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/06/2016 09:40 AM, Stefan Wahren wrote:
> Hi Marek,

Hi!

> sorry for the reply format.

replying from a phone ? :)

>> Marek Vasut <marex@denx.de> hat am 5. Mai 2016 um 22:26 geschrieben:
>>
>> Add support for this small MP3 player based on STMP3780 (rev.4).
>> Currently supported is both external microSD and internal SD-NAND
>> bridge, PWM and USB gadget.
>>
>> Signed-off-by: Marek Vasut <marex@denx.de>
>> Cc: Fabio Estevam <fabio.estevam@nxp.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> ---
>>  arch/arm/boot/dts/Makefile | 1 +
>>  arch/arm/boot/dts/imx23-xfi3.dts | 190
>> +++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 191 insertions(+)
>>  create mode 100644 arch/arm/boot/dts/imx23-xfi3.dts
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index 8f9f1c2..7a79d37 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -417,6 +417,7 @@ dtb-$(CONFIG_ARCH_MXS) += \
>>  imx23-evk.dtb \
>>  imx23-olinuxino.dtb \
>>  imx23-stmp378x_devb.dtb \
>> + imx23-xfi3.dtb \
>>  imx28-apf28.dtb \
>>  imx28-apf28dev.dtb \
>>  imx28-apx4devkit.dtb \
>> diff --git a/arch/arm/boot/dts/imx23-xfi3.dts
>> b/arch/arm/boot/dts/imx23-xfi3.dts
>> new file mode 100644
>> index 0000000..d7e7cf5
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/imx23-xfi3.dts
>> @@ -0,0 +1,190 @@
>> +/*
>> + * Copyright (C) 2013-2016 Marek Vasut <marex@denx.de>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + * a) This file is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License as
>> + * published by the Free Software Foundation; either version 2 of
>> + * the License, or (at your option) any later version.
>> + *
>> + * This file is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public
>> + * License along with this file; if not, write to the Free
>> + * Software Foundation, Inc., 51 Franklin St, Fifth Floor, Boston,
>> + * MA 02110-1301 USA
> 
> AFAIK this address shouldn't be included.

Hmmm, some boards do include it. I'll remove it from this submission and
also for the xfi.

Shall I send patch(es) removing the address from the other boards too ?

>> + *
>> + * Or, alternatively,
>> + *
>> + * b) Permission is hereby granted, free of charge, to any person
>> + * obtaining a copy of this software and associated documentation
>> + * files (the "Software"), to deal in the Software without
>> + * restriction, including without limitation the rights to use,
>> + * copy, modify, merge, publish, distribute, sublicense, and/or
>> + * sell copies of the Software, and to permit persons to whom the
>> + * Software is furnished to do so, subject to the following
>> + * conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be
>> + * included in all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + * OTHER DEALINGS IN THE SOFTWARE.
>> + *
>> + */
>> +
>> +/dts-v1/;
>> +#include "imx23.dtsi"
>> +
>> +/ {
>> + model = "Creative ZEN X-Fi3";
>> + compatible = "creative,x-fi3", "fsl,imx23";
> 
> Is there a pending patch to add "creative" to the vendor-prefixes.txt?

There isn't. I'll send one.

>> +
>> + memory {
>> + reg = ;
>> + };
>> +
>> + apb at 80000000 {
>> + apbh at 80000000 {
>> + ssp0: ssp at 80010000 {
>> + compatible = "fsl,imx23-mmc";
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&mmc0_4bit_pins_a &mmc0_pins_fixup>;
>> + bus-width = ;
>> + vmmc-supply = <&reg_vddio_sd0>;
>> + cd-inverted;
>> + status = "okay";
>> + };
>> +
>> + ssp1: ssp at 80034000 {
>> + compatible = "fsl,imx23-mmc";
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&mmc1_4bit_pins_a>;
>> + bus-width = ;
>> + non-removable;
>> + status = "okay";
>> + };
>> +
>> + pinctrl at 80018000 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&hog_pins_a>;
>> +
>> + hog_pins_a: hog at 0 {
>> + reg = ;
>> + fsl,pinmux-ids = <
>> + MX23_PAD_GPMI_D07__GPIO_0_7
>> + >;
>> + fsl,drive-strength = ;
>> + fsl,voltage = ;
>> + fsl,pull-up = ;
>> + };
>> +
>> + key_pins_a: keys at 0 {
>> + reg = ;
>> + fsl,pinmux-ids = <
>> + MX23_PAD_ROTARYA__GPIO_2_7
>> + MX23_PAD_ROTARYB__GPIO_2_8
>> + >;
>> + fsl,drive-strength = ;
>> + fsl,voltage = ;
>> + fsl,pull-up = ;
>> + };
>> + };
>> + };
>> +
>> + apbx at 80040000 {
>> + i2c: i2c at 80058000 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&i2c_pins_a>;
>> + status = "okay";
>> + };
>> +
>> + pwm: pwm at 80064000 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&pwm2_pins_a>;
>> + status = "okay";
>> + };
>> +
>> + duart: serial at 80070000 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&duart_pins_a>;
>> + status = "okay";
>> + };
>> +
>> + auart1: serial at 8006e000 {
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&auart1_2pins_a>;
>> + status = "okay";
>> + };
>> +
>> + usbphy0: usbphy at 8007c000 {
>> + status = "okay";
>> + };
>> +
>> + lradc at 80050000 {
>> + status = "okay";
>> + };
>> + };
>> + };
>> +
>> + ahb at 80080000 {
>> + usb0: usb at 80080000 {
>> + dr_mode = "peripheral";
>> + status = "okay";
>> + };
>> + };
>> +
>> + regulators {
>> + compatible = "simple-bus";
>> +
>> + reg_vddio_sd0: vddio-sd0 {
>> + compatible = "regulator-fixed";
>> + regulator-name = "vddio-sd0";
>> + regulator-min-microvolt = ;
>> + regulator-max-microvolt = ;
>> + gpio = <&gpio0 7 0>;
>> + };
>> + };
>> +
>> + backlight {
>> + compatible = "pwm-backlight";
>> + pwms = <&pwm 2 5000000>;
>> + brightness-levels = ;
>> + default-brightness-level = ;
>> + };
>> +
>> + gpio_keys {
>> + compatible = "gpio-keys";
>> + pinctrl-names = "default";
>> + pinctrl-0 = <&key_pins_a>;
>> + #address-cells = ;
>> + #size-cells = ;
>> +
>> + button at 0 {
>> + label = "volume-down";
>> + linux,code = ;
>> + gpios = <&gpio2 7 0>;
>> + debounce-interval = ;
>> + };
> 
> I think this would introduce new dtc warnings.
> 
> Please look at
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/commit/?id=f2953a461042721e9a2aca58d2b1cfc67c70d371

Ha, fixed, thanks.

>> +
>> + button at 1 {
>> + label = "volume-up";
>> + linux,code = ;
>> + gpios = <&gpio2 8 0>;
>> + debounce-interval = ;
>> + };
>> + };
>> +};
>> -- 
>> 2.7.0
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


-- 
Best regards,
Marek Vasut
