From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 26 Jan 2017 19:12:44 +0800
Subject: [linux-sunxi] Re: [PATCH 06/11] clk: sunxi-ng: Add A80 USB CCU
In-Reply-To: <20170126101405.npxzp2bmto5oeyex@lukather>
References: <20170124023230.3990-1-wens@csie.org>
 <20170124023230.3990-7-wens@csie.org>
 <20170126101405.npxzp2bmto5oeyex@lukather>
Message-ID: <CAGb2v66R+NtOQ_J-kQeawppvPUUxBd1n0BXD7p8H5JA6pwYDJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 6:14 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi,
>
> On Tue, Jan 24, 2017 at 10:32:25AM +0800, Chen-Yu Tsai wrote:
>> Add support for the USB clock controls found on the A80.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  .../devicetree/bindings/clock/sun9i-usb.txt        |  24 ++++
>>  drivers/clk/sunxi-ng/Makefile                      |   1 +
>>  drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c           | 144 +++++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h           |  25 ++++
>>  include/dt-bindings/clock/sun9i-a80-usb.h          |  59 +++++++++
>>  include/dt-bindings/reset/sun9i-a80-usb.h          |  56 ++++++++
>>  6 files changed, 309 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/sun9i-usb.txt
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.h
>>  create mode 100644 include/dt-bindings/clock/sun9i-a80-usb.h
>>  create mode 100644 include/dt-bindings/reset/sun9i-a80-usb.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sun9i-usb.txt b/Documentation/devicetree/bindings/clock/sun9i-usb.txt
>> new file mode 100644
>> index 000000000000..c2d38626eaaa
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/sun9i-usb.txt
>> @@ -0,0 +1,24 @@
>> +Allwinner A80 USB Clock Control Binding
>> +------------------------------------
>> +
>> +Required properties :
>> +- compatible: must contain one of the following compatibles:
>> +             - "allwinner,sun9i-a80-usb-clocks"
>> +
>> +- reg: Must contain the registers base address and length
>> +- clocks: phandle to the clocks feeding the USB subsystem. Two are needed:
>> +  - "bus": the bus clock for the whole USB subsystem
>> +  - "hosc": the high frequency oscillator (usually at 24MHz)
>> +- clock-names: Must contain the clock names described just above
>> +- #clock-cells : must contain 1
>> +- #reset-cells : must contain 1
>> +
>> +Example:
>> +usb_clocks: clock at 00a08000 {
>> +     compatible = "allwinner,sun9i-a80-usb-clks";
>> +     reg = <0x00a08000 0x8>;
>> +     clocks = <&ccu CLK_BUS_USB>, <&osc24M>;
>> +     clock-names = "bus", "hosc";
>> +     #clock-cells = <1>;
>> +     #reset-cells = <1>;
>> +};
>> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
>> index 126bb7c1c3f7..8f37ef7fb67d 100644
>> --- a/drivers/clk/sunxi-ng/Makefile
>> +++ b/drivers/clk/sunxi-ng/Makefile
>> @@ -26,3 +26,4 @@ obj-$(CONFIG_SUN8I_A33_CCU) += ccu-sun8i-a33.o
>>  obj-$(CONFIG_SUN8I_H3_CCU)   += ccu-sun8i-h3.o
>>  obj-$(CONFIG_SUN8I_V3S_CCU)  += ccu-sun8i-v3s.o
>>  obj-$(CONFIG_SUN9I_A80_CCU)  += ccu-sun9i-a80.o
>> +obj-$(CONFIG_SUN9I_A80_CCU)  += ccu-sun9i-a80-usb.o
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
>> new file mode 100644
>> index 000000000000..1d76f24f7df3
>> --- /dev/null
>> +++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80-usb.c
>> @@ -0,0 +1,144 @@
>> +/*
>> + * Copyright (c) 2016 Chen-Yu Tsai. All rights reserved.
>> + *
>> + * This software is licensed under the terms of the GNU General Public
>> + * License version 2, as published by the Free Software Foundation, and
>> + * may be copied, distributed, and modified under those terms.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/of_address.h>
>> +#include <linux/platform_device.h>
>> +
>> +#include "ccu_common.h"
>> +#include "ccu_gate.h"
>> +#include "ccu_reset.h"
>> +
>> +#include "ccu-sun9i-a80-usb.h"
>> +
>> +static SUNXI_CCU_GATE(bus_hci0_clk, "bus-hci0", "bus-usb", 0x0, BIT(1), 0);
>> +static SUNXI_CCU_GATE(usb_ohci0_clk, "usb-ohci0", "osc24M", 0x0, BIT(2), 0);
>> +static SUNXI_CCU_GATE(bus_hci1_clk, "bus-hci1", "bus-usb", 0x0, BIT(3), 0);
>> +static SUNXI_CCU_GATE(bus_hci2_clk, "bus-hci2", "bus-usb", 0x0, BIT(5), 0);
>> +static SUNXI_CCU_GATE(usb_ohci2_clk, "usb-ohci2", "osc24M", 0x0, BIT(6), 0);
>
> In the current !sunxi-ng driver, there's a clock at offset 4, did you
> forget it?

It supposedly is for ohci1, but since the second USB host is HSIC
only, and Allwinner does not even list ohci1 in its documents, it
probably isn't there. IIRC the gate itself can be toggled. But
there probably isn't anything connected. The old driver having
a gate for it would be my mistake.

ChenYu
