From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Tue, 25 Jun 2013 11:50:26 +0800
Subject: [PATCH v5 1/4] clk: hi3xxx: add clock support
In-Reply-To: <20130617215039.GM28497@quad.lixom.net>
References: <1371459376-25438-1-git-send-email-haojian.zhuang@linaro.org>
 <1371459376-25438-2-git-send-email-haojian.zhuang@linaro.org>
 <20130617215039.GM28497@quad.lixom.net>
Message-ID: <CAD6h2NSU684=suTphtXQEiMR5uRbQwc+Vzz_hGEq9BReCMqGCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 June 2013 05:50, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> A once over mostly on the readability and some of the bindings. I'm presuming
> that Mike Turquette will come in with a proper clock review, and probably merge
> this through his tree.
>
>
> -Olof
>
> On Mon, Jun 17, 2013 at 04:56:13PM +0800, Haojian Zhuang wrote:
>> Add clock support with device tree on Hisilicon SoC.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
>> Cc: Mike Turquette <mturquette@linaro.org>
>> ---
>>  .../devicetree/bindings/clock/hisilicon.txt        |  66 ++++
>>  drivers/clk/Makefile                               |   1 +
>>  drivers/clk/clk-hi3xxx.c                           | 414 +++++++++++++++++++++
>>  3 files changed, 481 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/clock/hisilicon.txt
>>  create mode 100644 drivers/clk/clk-hi3xxx.c
>>
>> diff --git a/Documentation/devicetree/bindings/clock/hisilicon.txt b/Documentation/devicetree/bindings/clock/hisilicon.txt
>> new file mode 100644
>> index 0000000..7f99805
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/hisilicon.txt
>> @@ -0,0 +1,66 @@
>> +Device Tree Clock bindings for arch-hi3xxx
>> +
>> +This binding uses the common clock binding[1].
>> +
>> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
>> +
>> +Required properties for mux clocks:
>> + - compatible : Shall be "hisilicon,hi3620-clk-mux".
>> + - clocks : shall be the input parent clock phandle for the clock. This should
>> +     be the reference clock.
>> + - clock-output-names : shall be reference name.
>> + - #clock-cells : from common clock binding; shall be set to 0.
>> + - hisilicon,clkmux-reg : array of mux register offset & mask bits
>> + - hisilicon,clkmux-table : array of mux select bits
>> +
>> +Required properties for Hi3620 gate clocks:
>> + - compatible : Shall be "hisilicon,hi3620-clk-gate".
>> + - clocks : shall be the input parent clock phandle for the clock. This should
>> +     be the reference clock.
>> + - clock-output-names : shall be reference name.
>> + - #clock-cells : from common clock binding; shall be set to 0.
>> + - hisilicon,hi3620-clkgate : array of enable register offset & enable bits
>> + - hisilicon,hi3620-clkreset : array of reset register offset & enable bits
>> +
>> +Required properties for clock divider:
>> + - compatible : Shall be "hisilicon,hi3620-clk-div".
>> + - clocks : shall be the input parent clock phandle for the clock. This should
>> +     be the reference clock.
>> + - clock-output-names : shall be reference name.
>> + - #clock-cells : from common clock binding; shall be set to 0.
>> + - #hisilicon,clkdiv-table-cells : the number of parameters after phandle in
>> +   hisilicon,clkdiv-table property.
>> + - hisilicon,clkdiv-table : list of value that are used to configure clock
>
> For a binding that is your own, you don't need to prefix the properties.
> Prefixes are mostly used when adding new vendor-specific attributes to a common
> binding.

OK.
>
>> +   divider. They're value of phandle, index & divider value.
>> + - hisilicon,clkdiv : array of divider register offset & mask bits.
>> +
>> +Required properties for gate clocks:
>> + - compatible : Shall be "hisilicon,clk-gate".
>> + - clocks : shall be the input parent clock phandle for the clock. This should
>> +     be the reference clock.
>> + - clock-output-names : shall be reference name.
>> + - #clock-cells : from common clock binding; shall be set to 0.
>> + - hisilicon,clkgate-inverted : bool value. True means that set-to-disable.
>> +
>> +For example:
>> +     timclk1: clkgate at 38 {
>> +             compatible = "hisilicon,clk-gate";
>> +             #clock-cells = <0>;
>> +             clocks = <&refclk_timer1>;
>> +             clock-output-names = "timclk1";
>> +             hisilicon,clkgate-inverted;
>> +             hisilicon,clkgate = <0 18>;
>> +     };
>> +
>> +     dtable: clkdiv at 0 {
>> +             #hisilicon,clkdiv-table-cells = <2>;
>> +     };
>> +
>> +     div_cfgaxi: clkdiv at 2 {
>> +             compatible = "hisilicon,hi3620-clk-div";
>> +             #clock-cells = <0>;
>> +             clocks = <&div_shareaxi>;
>> +             clock-output-names = "cfgAXI_div";
>> +             hisilicon,clkdiv-table = <&dtable 0x01 2>;
>> +             hisilicon,clkdiv = <0x100 0x60>;
>> +     };
>> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
>> index 137d3e7..522e8d1 100644
>> --- a/drivers/clk/Makefile
>> +++ b/drivers/clk/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_COMMON_CLK)    += clk-composite.o
>>  # SoCs specific
>>  obj-$(CONFIG_ARCH_BCM2835)   += clk-bcm2835.o
>>  obj-$(CONFIG_ARCH_NOMADIK)   += clk-nomadik.o
>> +obj-$(CONFIG_ARCH_HI3xxx)    += clk-hi3xxx.o
>>  obj-$(CONFIG_ARCH_HIGHBANK)  += clk-highbank.o
>>  obj-$(CONFIG_ARCH_MXS)               += mxs/
>>  obj-$(CONFIG_ARCH_SOCFPGA)   += socfpga/
>> diff --git a/drivers/clk/clk-hi3xxx.c b/drivers/clk/clk-hi3xxx.c
>> new file mode 100644
>> index 0000000..14c2f80
>> --- /dev/null
>> +++ b/drivers/clk/clk-hi3xxx.c
>> @@ -0,0 +1,414 @@
>> +/*
>> + * Hisilicon clock driver
>> + *
>> + * Copyright (c) 2012-2013 Hisilicon Limited.
>> + * Copyright (c) 2012-2013 Linaro Limited.
>> + *
>> + * Author: Haojian Zhuang <haojian.zhuang@linaro.org>
>> + *      Xin Li <li.xin@linaro.org>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License along
>> + * with this program; if not, write to the Free Software Foundation, Inc.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + *
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/clk-private.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/clk.h>
>> +
>> +#define HI3620_DISABLE_OFF           0x4
>> +#define HI3620_STATUS_OFF            0x8
>> +
>> +enum {
>> +     HI3620_SCTRL,
>> +     HI3XXX_MAX,
>> +};
>> +
>> +struct hi3620_periclk {
>> +     struct clk_hw   hw;
>> +     void __iomem    *enable;        /* enable register */
>> +     void __iomem    *reset;         /* reset register */
>> +     u32             ebits;          /* bits in enable/disable register */
>> +     u32             rbits;          /* bits in reset/unreset register */
>> +     spinlock_t      *lock;
>> +};
>> +
>> +struct hs_clk {
>> +     void __iomem    *pmctrl;
>> +     void __iomem    *sctrl;
>> +     spinlock_t      lock;
>> +};
>> +
>> +static void __iomem *hi3xxx_clk_base[HI3XXX_MAX];
>
> This is a 1-entry array of pointers. What do you expect it to grow with in the
> future? It's easier not adding extra complexity with the initial code; it will
> just add more review comments to get stuck on. Such as the one below:
>
Clock registers exists in some components, such as System Controller,
graphics frame Controller, and so on. It means that I'll append new clock
nodes in this array in the future, such as EDC (graphic frame Controller).

Since the framebuffer driver isn't fully ready, I don't want to add these clocks
in this driver at this time.

>> +static DEFINE_SPINLOCK(hi3xxx_clk_lock);
>> +
>> +static const struct of_device_id hi3xxx_of_match[] = {
>> +     { .compatible = "hisilicon,sctrl", .data = (void *)HI3620_SCTRL, },
>> +};
>
> You need a terminating entry here. Also, what is this property and how it is
> used? It's not included in the bindings above.

Yes, it'll be appended in the future.
>
>> +
>> +static void __iomem __init *hi3xxx_init_clocks(struct device_node *np)
>> +{
>> +     struct device_node *parent;
>> +     const struct of_device_id *match;
>> +     void __iomem *ret = NULL;
>> +     int i;
>> +
>> +     parent = of_get_parent(np);
>> +     if (!parent)
>> +             goto out;
>> +     match = of_match_node(hi3xxx_of_match, parent);
>> +     if (!match)
>> +             goto out;
>
> Please explain for someone reading this code why you're going up one level and
> looking for the "hisilicon,sctrl" device here, and why that's needed.
>

Since those clock registers exist in some components, it needs to map those
register mapping. When it's mapped, the base of io mapping could be saved
in the hi3xxx_clk_base[] array.

If it's already mapped, we only need to access the saved address.

> Also, you should probably print some sort of error/warning here when the lookup
> fails.
>

OK. I'll append the warning/error information.

>> +
>> +     i = (unsigned int)match->data;
>> +     switch (i) {
>> +     case HI3620_SCTRL:
>> +             if (!hi3xxx_clk_base[i]) {
>> +                     ret = of_iomap(parent, 0);
>> +                     WARN_ON(!ret);
>> +                     hi3xxx_clk_base[i] = ret;
>> +             } else {
>> +                     ret = hi3xxx_clk_base[i];
>> +             }
>
> This is unnecessarily complicated. You can do:
>
>                 if (hi3xxx_clk_base[i])
>                         return hi3xxx_clk_base[i]
>                 ret = of_iomap()
>                 ...
>
OK

>> +             break;
>> +     default:
>> +             goto out;
>> +     }
>> +out:
>> +     return ret;
>> +}
>
>
>
> -Olof
