From: andy.yan@rock-chips.com (Andy Yan)
Date: Mon, 10 Oct 2016 19:25:52 +0800
Subject: [PATCH v1 1/2] ARM: dts: add rockchip PX3 Evaluation board
In-Reply-To: <738050204.FfkOZgkGGl@phil>
References: <1473529249-6151-1-git-send-email-andy.yan@rock-chips.com>
 <1473529440-6202-1-git-send-email-andy.yan@rock-chips.com>
 <64f4be31-1b19-60e3-da7c-f2fec186fab9@suse.de> <738050204.FfkOZgkGGl@phil>
Message-ID: <0a74b063-a94f-00d9-d1f7-a417c03c06a9@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko:


On 2016?10?10? 17:54, Heiko Stuebner wrote:
> Hi Andreas, Andy,
>
> Am Dienstag, 13. September 2016, 14:14:01 CEST schrieb Andreas F?rber:
>> Hi Andy,
>>
>> This patch didn't make it to linux-rockchip list somehow...
>> Not sure why I'm CC'ed, I don't have access to such a board to check, so
>> just a couple formal nitpicks:
>>
>> Am 10.09.2016 um 19:44 schrieb Andy Yan:
>>> PX3 EVB is designed by Rockchip for automotive field,
>>> which intergrated with CVBS(TP2825)/MIPI DSI/LVDS/HDMI
>> "integrated"
>> but the grammar is somewhat incorrect with "which" referring to field -
>> I assume you meant "with integrated CVBS..."?
>>
>>> video input/output interface, WIFI/BT/GPS(on a module
>> Also please always leave a space before an opening parenthesis in
>> English text. Similarly above, spaces around "/" would help recognize
>> that MIPI DSI belongs together rather than being two lists.
>>
>> If nothing else applies below then maybe Heiko can edit it for you?
> I've fixed the remarks in the commit description.
>
>
>>> named S500 which based on MT6620), Gsensor BMA250E and
>>> light&proximity sensor STK3410.
>>>
>>> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>>>
>>> ---
>>>
>>> Changes in v1:
>>> - board rename
>>> - add vendor prefix for i2c interfaced sensors
>>> - use stdout-path to set the default console
>>>
>>>   Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>>>   arch/arm/boot/dts/Makefile                         |   1 +
>>>   arch/arm/boot/dts/rk3188-px3-evb.dts               | 337
>>>   +++++++++++++++++++++ 3 files changed, 342 insertions(+)
>>>   create mode 100644 arch/arm/boot/dts/rk3188-px3-evb.dts
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt
>>> b/Documentation/devicetree/bindings/arm/rockchip.txt index
>>> 6668645..6da3881 100644
>>> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
>>> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
>>> @@ -21,6 +21,10 @@ Rockchip platforms device tree bindings
>>>
>>>       Required root node properties:
>>>         - compatible = "radxa,rock", "rockchip,rk3188";
>>>
>>> +- Rockchip PX3 Evaluation board:
>>> +    Required root node properties:
>>> +      - compatible = "rockchip,px3-evb", "rockchip,px3",
>>> "rockchip,rk3188";
>> How compatible is PX3 with RK3188? It is a separate SoC product:
>>
>> http://www.rock-chips.com/a/en/products/rkpower/2015/1125/730.html
>>
>> Wondering whether or not to drop the third compatible string.
> As discussed in IRC (and with arm-soc maintainers), I intend to keep the
> rk3188 part, as the chip really is just a (hardened?) variant of the consumer
> rk3188, but shares the same internals with the original.
>
>>> +
>>>
>>>   - Radxa Rock2 Square board:
>>>       Required root node properties:
>>>         - compatible = "radxa,rock2-square", "rockchip,rk3288";
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index faacd52..88d27a2 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -620,6 +620,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += \
>>>
>>>   	rk3066a-marsboard.dtb \
>>>   	rk3066a-rayeager.dtb \
>>>   	rk3188-radxarock.dtb \
>>>
>>> +	rk3188-px3-evb.dtb \
>> Affects file naming as well: px3-evb.dtb?
> see above
>
>>>   	rk3228-evb.dtb \
>>>   	rk3229-evb.dtb \
>>>   	rk3288-evb-act8846.dtb \
>>>
>>> diff --git a/arch/arm/boot/dts/rk3188-px3-evb.dts
>>> b/arch/arm/boot/dts/rk3188-px3-evb.dts new file mode 100644
>>> index 0000000..f6bc738
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/rk3188-px3-evb.dts
>>> @@ -0,0 +1,337 @@
>>> +/*
>>> + * Copyright (c) 2016 Andy Yan <andy.yan@rock-chips.com>
>>> + *
>>> + * This file is dual-licensed: you can use it either under the terms
>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>> + * licensing only applies to this file, and not this project as a
>>> + * whole.
>>> + *
>>> + *  a) This file is free software; you can redistribute it and/or
>>> + *     modify it under the terms of the GNU General Public License as
>>> + *     published by the Free Software Foundation; either version 2 of the
>>> + *     License, or (at your option) any later version.
>>> + *
>>> + *     This file is distributed in the hope that it will be useful,
>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + *     GNU General Public License for more details.
>>> + *
>>> + * Or, alternatively,
>>> + *
>>> + *  b) Permission is hereby granted, free of charge, to any person
>>> + *     obtaining a copy of this software and associated documentation
>>> + *     files (the "Software"), to deal in the Software without
>>> + *     restriction, including without limitation the rights to use,
>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>> + *     sell copies of the Software, and to permit persons to whom the
>>> + *     Software is furnished to do so, subject to the following
>>> + *     conditions:
>>> + *
>>> + *     The above copyright notice and this permission notice shall be
>>> + *     included in all copies or substantial portions of the Software.
>>> + *
>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>> + */
>>> +
>>> +/dts-v1/;
>>> +#include <dt-bindings/input/input.h>
>>> +#include "rk3188.dtsi"
>> I'm surprised there is no [rk3188-]px3.dtsi here! Surely some automotive
>> vendor may design their own board with it and should have at least the
>> two trailing compatible strings pre-set.
> see above. I don't think there is a need to pollute the directory with
> (nearly) empty dtsi files, especially as the compatible will get overwritten by
> a board compatible anyway.
>
>>> +
>>> +/ {
>>> +	model = "Rockchip PX3-EVB";
>>> +	compatible = "rockchip,px3-evb", "rockchip,px3", "rockchip,rk3188";
>>> +
>>> +	chosen {
>>> +		stdout-path = "serial2:115200n8";
>>> +	};
>>> +
>>> +	memory {
>>> +		device_type = "memory";
>>> +		reg = <0x60000000 0x80000000>;
>>> +	};
>>> +
>>> +	gpio-keys {
>>> +		compatible = "gpio-keys";
>>> +		autorepeat;
>>> +
>>> +		power {
>>> +			gpios = <&gpio0 4 GPIO_ACTIVE_LOW>;
>>> +			linux,code = <KEY_POWER>;
>>> +			label = "GPIO Key Power";
>>> +			linux,input-type = <1>;
>>> +			wakeup-source;
>>> +			debounce-interval = <100>;
>>> +		};
>>> +	};
>>> +
>>> +	vcc_sys: vsys-regulator {
>>> +		compatible = "regulator-fixed";
>>> +		regulator-name = "vsys";
>>> +		regulator-min-microvolt = <5000000>;
>>> +		regulator-max-microvolt = <5000000>;
>>> +		regulator-boot-on;
>>> +	};
>>> +};
>>> +
>>> +&cpu0 {
>>> +	cpu0-supply = <&vdd_cpu>;
>>> +};
>>> +
>>> +&i2c0 {
>>> +	status = "okay";
>>> +
>>> +	 /* Accelerometer */
>> Space after tab intentional?
>>
>>> +	bma250 at 18 {
>>> +		compatible = "bosch,bma250";
>>> +		reg = <0x18>;
>>> +		interrupt-parent = <&gpio0>;
>>> +		interrupts = <15 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>>> +
>>> +	stk3410 at 48 {
>>> +		compatible = "sensortek,STK3310";
>>> +		reg = <0x48>;
>>> +		interrupt-parent = <&gpio1>;
>>> +		interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
>>> +	};
>> Generally it is undesired to repeat the compatible name as node name -
>> did you compare other .dts files? (e.g., accelerometer at 18 would be
>> self-documenting) If this is a copy from an existing .dts then please
>> ignore this comment.
> due to the compatible ambiguity, I had dropped the stk3410 node anyway.
> I've also checked how the bma250 gets specified and there are both variants in
> use (accelerometer@ and bmc250@). So to set a good example for the future,
> I've changed the node name to accelerometer at 18 and dropped the now self
> explanatory comment obove it.
>
>
>>> +};
>>> +
>>> +&i2c1 {
>>> +	status = "okay";
>>> +	clock-frequency = <400000>;
>> Insert white line?
> done
>
>
> Heiko
>
>



  I have no problem with these above, Thanks for all you have done.
