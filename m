From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Sat, 12 Dec 2015 10:34:01 +0800
Subject: [PATCH v1 7/8] ARM: dts: rockchip: add core rk3228 dtsi
In-Reply-To: <7783766.YsX4m8bWe1@diego>
References: <1449651853-1667-1-git-send-email-jeffy.chen@rock-chips.com>
 <24573164.okRNXjvZ1B@phil> <566A2CB7.4050801@rock-chips.com>
 <7783766.YsX4m8bWe1@diego>
Message-ID: <566B8799.2060704@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Heiko,

On 2015-12-11 18:12, Heiko St?bner wrote:
> Hi Jeffy,
>
> Am Freitag, 11. Dezember 2015, 09:53:59 schrieb Jeffy Chen:
>> On 2015-12-10 8:32, Heiko Stuebner wrote:
>>> Am Mittwoch, 9. Dezember 2015, 17:04:12 schrieb Jeffy Chen:
>>>> Initial release for rk3228 shared dtsi.
>>>>
>>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>>> ---
>>>>
>>>>    arch/arm/boot/dts/rk3228.dtsi | 478
>>>>    ++++++++++++++++++++++++++++++++++++++++++ 1 file changed, 478
>>>>    insertions(+)
>>>>    create mode 100644 arch/arm/boot/dts/rk3228.dtsi
>>>>
>>>> diff --git a/arch/arm/boot/dts/rk3228.dtsi
>>>> b/arch/arm/boot/dts/rk3228.dtsi
>>>> new file mode 100644
>>>> index 0000000..d6b3e40
>>>> --- /dev/null
>>>> +++ b/arch/arm/boot/dts/rk3228.dtsi
>>>> @@ -0,0 +1,478 @@
>>>> +/*
>>>> + * This file is dual-licensed: you can use it either under the terms
>>>> + * of the GPL or the X11 license, at your option. Note that this dual
>>>> + * licensing only applies to this file, and not this project as a
>>>> + * whole.
>>>> + *
>>>> + *  a) This file is free software; you can redistribute it and/or
>>>> + *     modify it under the terms of the GNU General Public License as
>>>> + *     published by the Free Software Foundation; either version 2 of
>>>> the
>>>> + *     License, or (at your option) any later version.
>>>> + *
>>>> + *     This file is distributed in the hope that it will be useful,
>>>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>>>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>>> + *     GNU General Public License for more details.
>>>> + *
>>>> + * Or, alternatively,
>>>> + *
>>>> + *  b) Permission is hereby granted, free of charge, to any person
>>>> + *     obtaining a copy of this software and associated documentation
>>>> + *     files (the "Software"), to deal in the Software without
>>>> + *     restriction, including without limitation the rights to use,
>>>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>>>> + *     sell copies of the Software, and to permit persons to whom the
>>>> + *     Software is furnished to do so, subject to the following
>>>> + *     conditions:
>>>> + *
>>>> + *     The above copyright notice and this permission notice shall be
>>>> + *     included in all copies or substantial portions of the Software.
>>>> + *
>>>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>>>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>>>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>>>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>>>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>>>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>>>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>>>> + *     OTHER DEALINGS IN THE SOFTWARE.
>>>> + */
>>>> +
>>>> +#include <dt-bindings/gpio/gpio.h>
>>>> +#include <dt-bindings/interrupt-controller/irq.h>
>>>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>>>> +#include <dt-bindings/pinctrl/rockchip.h>
>>>> +#include <dt-bindings/clock/rk3228-cru.h>
>>>> +#include "skeleton.dtsi"
>>>> +
>>>> +/ {
>>>> +	compatible = "rockchip,rk3228";
>>>> +
>>>> +	interrupt-parent = <&gic>;
>>>> +
>>>> +	aliases {
>>>> +		serial0 = &uart0;
>>>> +		serial1 = &uart1;
>>>> +		serial2 = &uart2;
>>>> +	};
>>>> +
>>>> +	memory {
>>>> +		device_type = "memory";
>>>> +		reg = <0x60000000 0x40000000>;
>>>> +	};
>>> The amount of memory is a property of the board
>> done.
>>
>>>> +
>>>> +	cpus {
>>>> +		#address-cells = <1>;
>>>> +		#size-cells = <0>;
>>> no enable-method?
>>>
>>> As the rk3228 also does not have a pmu, does the newly created
>>> "rockchip,rk3036-smp" work for you?
>> unlucky, that doesn't work...and our 3.10 kernel is using psci for
>> rk3228's smp ops, maybe i should check that too, but i know nothing
>> about psci for now :(
> Using PSCI on more rockchip socs will make the ARM people very happy ;-) .
>
> So definitly no argument from me against it. I guess you should only need the
> enable-method and psci node you should already have in your 3.10 dts, to
> actually enable it.
>
> cpu at xxx {
> 		enable-method = "psci";
> };
>
> psci {
> 	compatible = "arm,psci-0.2";
> 	...
> };
>
>
> But we can of course add that in a later patch as well.
>
>
> Heiko
>
yes, you're right~
after added psci node and enabled CONFIG_ARM_PSCI, it could bring up all 
cpus :

[    0.090371] CPU0: thread -1, cpu 0, socket 15, mpidr 80000f00
[    0.091018] Setting up static identity map for 0x60100000 - 0x60100058
[    0.095260] CPU1: thread -1, cpu 1, socket 15, mpidr 80000f01
[    0.096648] CPU2: thread -1, cpu 2, socket 15, mpidr 80000f02
[    0.098070] CPU3: thread -1, cpu 3, socket 15, mpidr 80000f03
[    0.098228] Brought up 4 CPUs
[    0.100145] SMP: Total of 4 processors activated (192.00 BogoMIPS).
[    0.100732] CPU: All CPU(s) started in SVC mode.

patch coming :)
