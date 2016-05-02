From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 3 May 2016 00:59:19 +0900
Subject: [PATCH v2] clk: uniphier: add clock drivers for UniPhier SoCs
In-Reply-To: <20160226000713.GO28849@codeaurora.org>
References: <1451298003-28841-1-git-send-email-yamada.masahiro@socionext.com>
 <20160226000713.GO28849@codeaurora.org>
Message-ID: <CAK7LNASQD4fpi=iDRbX96tSBvYjT_-N8EJnNk1VpuMxBTEnONg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

I am back after long silence.

2016-02-26 9:07 GMT+09:00 Stephen Boyd <sboyd@codeaurora.org>:
> On 12/28, Masahiro Yamada wrote:
>> This is the initial commit for the UniPhier clock drivers, including
>> support for PH1-sLD3, PH1-LD4, PH1-Pro4, PH1-sLD8, PH1-Pro5, and
>> ProXstream2/PH1-LD6b.
>>
>> To improve the code maintainability, the driver consists of common
>> functions (clk-uniphier-core.c) and clock data arrays needed to
>> support each SoC.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>
> Where's the DT binding? Also, can these clks be registered from a
> platform device driver instead of from
>>
>> diff --git a/drivers/clk/uniphier/Kconfig b/drivers/clk/uniphier/Kconfig
>> new file mode 100644
>> index 0000000..7606f27
>> --- /dev/null
>> +++ b/drivers/clk/uniphier/Kconfig
>> @@ -0,0 +1,35 @@
>> +menuconfig CLK_UNIPHIER
>> +     bool "Clock drivers for UniPhier SoCs"
>> +     depends on ARCH_UNIPHIER
>
> Can we have COMPILE_TEST here?

OK.
But if you recommend to drop "depends on ARCH_UNIPHIER",
COMPILE_TEST is not necessary.


>> +     depends on OF
>> +     default y
>
> And then default ARCH_UNIPHIER instead.



The problem is that CLK_UNIPHIER is not enabled along with
ARCH_UNIPHIER in "make menuconfig".

If we use "depends on ARCH_UNIPHIER"
and we enable ARCH_UNIPHIER from "make menuconfig",
CLK_UNIPHIER is automatically enabled as well.

Is the latter more like what we expect?




>> +endif
>> diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
>
> Maybe this patch can be split between core code and SoC specific
> data? That way we can focus on the core code without wading
> through all the random clk data arrays.

OK.  will do so.



>> +static void __init uniphier_clk_update_parent_name(struct device_node *np,
>> +                                                const char **parent_name)
>> +{
>> +     const char *new_name;
>> +     int index;
>> +
>> +     if (!parent_name || !*parent_name)
>> +             return;
>> +
>> +     if (strncmp(*parent_name, UNIPHIER_CLK_EXT, strlen(UNIPHIER_CLK_EXT)))
>> +             return;
>> +
>> +     index = of_property_match_string(np, "clock-names",
>> +                             *parent_name + strlen(UNIPHIER_CLK_EXT));
>
> If possible please don't use clock-names to set up clock
> hierarchy.

So, what shall I do instead?

I am not comfortable with hard-coding the parents' names
for clock-cascading.

Maybe, can we support clk registration
with clk_hw of parents, not names of parents?

For example, by adding  "struct clk_hw **parents"
to struct clk_init_data.



>> +int __init uniphier_clk_init(struct device_node *np,
>> +                          struct uniphier_clk_init_data *idata)
>> +{
>> +     struct clk_onecell_data *clk_data;
>> +     struct uniphier_clk_init_data *p;
>> +     void __iomem *regbase;
>> +     int max_index = 0;
>> +     int ret;
>> +
>> +     regbase = of_iomap(np, 0);
>
> If not a platform device, use of_io_request_and_map()?


I am planning to change all of them into platform drivers in the next version.



>> +#ifndef __CLK_UNIPHIER_H__
>> +#define __CLK_UNIPHIER_H__
>> +
>> +#include <linux/kernel.h>
>
> What's this include for?

Probably my mistake.  Will remove.


>> +
>> +#define UNIPHIER_CLK_EXT     "[EXT]"
>> +
>> +enum uniphier_clk_type {
>> +     UNIPHIER_CLK_TYPE_FIXED_FACTOR,
>> +     UNIPHIER_CLK_TYPE_FIXED_RATE,
>> +     UNIPHIER_CLK_TYPE_GATE,
>> +     UNIPHIER_CLK_TYPE_MUX,
>> +};
>> +
>> +struct uniphier_clk_fixed_factor_data {
>> +     const char *parent_name;
>> +     unsigned int mult;
>> +     unsigned int div;
>> +};
>> +
>> +struct uniphier_clk_fixed_rate_data {
>> +     unsigned long fixed_rate;
>> +};
>> +
>> +struct uniphier_clk_gate_data {
>> +     const char *parent_name;
>> +     unsigned int reg;
>> +     u8 bit_idx;
>> +};
>> +
>> +struct uniphier_clk_mux_data {
>> +     const char *parent_names[4];
>> +     u8 num_parents;
>> +     unsigned int reg;
>> +     u8 shift;
>> +};
>> +
>> +struct uniphier_clk_init_data {
>> +     const char *name;
>> +     enum uniphier_clk_type type;
>> +     int output_index;
>> +     union {
>> +             struct uniphier_clk_fixed_factor_data factor;
>> +             struct uniphier_clk_fixed_rate_data rate;
>> +             struct uniphier_clk_gate_data gate;
>> +             struct uniphier_clk_mux_data mux;
>> +     } data;
>> +     struct clk *clk;
>
> Probably need to forward declare this struct.


OK, thanks.

>> +};
>> +
>> +int uniphier_clk_init(struct device_node *np,
>
> Same for device_node.



-- 
Best Regards
Masahiro Yamada
