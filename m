From: jay.xu@rock-chips.com (Jianqun Xu)
Date: Thu, 18 Feb 2016 09:07:04 +0800
Subject: [PATCH 6/6] ARM64: dts: rockchip: add core dtsi file for rk3399
In-Reply-To: <20160217114645.GA32647@leverpostej>
References: <1455673992-16469-1-git-send-email-jay.xu@rock-chips.com>
 <1455674476-16655-1-git-send-email-jay.xu@rock-chips.com>
 <20160217114645.GA32647@leverpostej>
Message-ID: <56C51938.1060806@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark

? 17/02/2016 19:46, Mark Rutland ??:
> On Wed, Feb 17, 2016 at 10:01:16AM +0800, jianqun.xu wrote:
>> From: Xu Jianqun <jay.xu@rock-chips.com>
>>
>> Add dtsi file for Rockchip rk3399 SoCs, which includes some
>> general nodes such as cpu, pmu, cru, gic, amba and so on.
>>
>> Change-Id: Ie3b824e8ead967d4cb119d73222b7a198478c29c
>
> This is meaningless upstream. Please remove any "Change-Id" lines from
> upstream commit messages.
ok, next version will remove them. thanks

>
>> Signed-off-by: Xu Jianqun <jay.xu@rock-chips.com>
>> ---
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 989 +++++++++++++++++++++++++++++++
>>   1 file changed, 989 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> new file mode 100644
>> index 0000000..eb671f6
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -0,0 +1,989 @@
>> +/*
>> + * Copyright (c) 2016 Fuzhou Rockchip Electronics Co., Ltd
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +#include <dt-bindings/clock/rk3399-cru.h>
>> +#include <dt-bindings/gpio/gpio.h>
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +#include <dt-bindings/pinctrl/rockchip.h>
>> +
>> +/ {
>> +	compatible = "rockchip,rk3399";
>> +	interrupt-parent = <&gic>;
>> +	#address-cells = <2>;
>> +	#size-cells = <2>;
>> +
>> +	aliases {
>> +		serial0 = &uart0;
>> +		serial1 = &uart1;
>> +		serial2 = &uart2;
>> +		serial3 = &uart3;
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci";
>> +		method = "smc";
>> +	};
>
> That compatible string alone is insufficient, as it implies no
> particular function IDs. Hotplug and idle cannot possibly work.
>
> Have you tested this DT?
Yes, but only the simple system now, more function IDs will be added later.

>
> Which PSCI version have you implemented? Are you using a standard
> firmware (e.g. ARM Trusted Firmware), or some custom implementation?
>
>> +		cpu_l0: cpu at 0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a53", "arm,armv8";
>> +			reg = <0x0 0x0>;
>> +			cpu-idle-states = <&cpu_sleep>;
>> +			enable-method = "psci";
>> +		};
>
>> +		cpu_b0: cpu at 100 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a72", "arm,armv8";
>> +			reg = <0x0 0x100>;
>> +			cpu-idle-states = <&cpu_sleep>;
>> +			enable-method = "psci";
>> +		};
>> +
>
>> +	pmu {
>> +		compatible = "arm,armv8-pmuv3";
>> +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
>> +		interrupt-affinity = <&cpu_l0>, <&cpu_l1>, <&cpu_l2>,
>> +				     <&cpu_l3>, <&cpu_b0>, <&cpu_b1>;
>> +	};
>> +
>
> This isn't quite right. We should have separate nodes for the A72 and
> A53 PMUs.
>
> We can't describe that just yet due to needing cluster-local PPIs. I
> believe Will was looking into that.
>
> In the mean time, please drop the PMU node.

ok, next version will drop the pmu node first, someone will add them in 
another patch.

>
>> +	timer {
>> +		compatible = "arm,armv8-timer";
>> +		interrupts =
>> +			<GIC_PPI 13
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			<GIC_PPI 14
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			<GIC_PPI 11
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>,
>> +			<GIC_PPI 10
>> +			(GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
>> +		clock-frequency = <24000000>;
>> +	};
>
> Please fix your firmware to program CNTFRQ. Using clock-frequency is
> really not sufficient, and new platforms have no excuse for not having
> it programmed correctly.
ok, I will fix it. thanks

>
> Thanks,
> Mark.
>
>
>
