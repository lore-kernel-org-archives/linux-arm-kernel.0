From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 20 Dec 2014 20:43:27 +0800
Subject: [PATCH v2 01/11] clk: sunxi: Add mod0 and mmc module clock
 support for A80
In-Reply-To: <20141219180235.GO4820@lukather>
References: <1418886058-8145-1-git-send-email-wens@csie.org>
 <1418886058-8145-2-git-send-email-wens@csie.org>
 <20141219180235.GO4820@lukather>
Message-ID: <CAGb2v66iEhdCxuLPRPLxJENUtB04GtbHDHu+7tuBHFqNL2foeA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Dec 20, 2014 at 2:02 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> Hi Chen-Yu,
>
> On Thu, Dec 18, 2014 at 03:00:48PM +0800, Chen-Yu Tsai wrote:
>> The module 0 style clocks, or storage module clocks as named in the
>> official SDK, are almost the same as the module 0 clocks on earlier
>> Allwinner SoCs. The only difference is wider mux register bits.
>>
>> As with earlier Allwinner SoCs, mmc module clocks are a special case
>> of mod0 clocks, with phase controls for 2 child clocks, output and
>> sample.
>>
>> This patch adds support for both.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  Documentation/devicetree/bindings/clock/sunxi.txt |  7 +-
>>  drivers/clk/sunxi/clk-mod0.c                      | 99 +++++++++++++++++++++++
>>  2 files changed, 104 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
>> index 8c60433..b660bdb 100644
>> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
>> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
>> @@ -56,7 +56,9 @@ Required properties:
>>       "allwinner,sun8i-a23-apb2-gates-clk" - for the APB2 gates on A23
>>       "allwinner,sun5i-a13-mbus-clk" - for the MBUS clock on A13
>>       "allwinner,sun4i-a10-mmc-clk" - for the MMC clock
>> +     "allwinner,sun9i-a80-mmc-clk" - for mmc module clocks on A80
>>       "allwinner,sun4i-a10-mod0-clk" - for the module 0 family of clocks
>> +     "allwinner,sun9i-a80-mod0-clk" - for module 0 (storage) clocks on A80
>>       "allwinner,sun8i-a23-mbus-clk" - for the MBUS clock on A23
>>       "allwinner,sun7i-a20-out-clk" - for the external output clocks
>>       "allwinner,sun7i-a20-gmac-clk" - for the GMAC clock module on A20/A31
>> @@ -72,7 +74,8 @@ Required properties for all clocks:
>>  - #clock-cells : from common clock binding; shall be set to 0 except for
>>       the following compatibles where it shall be set to 1:
>>       "allwinner,*-gates-clk", "allwinner,sun4i-pll5-clk",
>> -     "allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk"
>> +     "allwinner,sun4i-pll6-clk", "allwinner,sun6i-a31-pll6-clk",
>> +     "allwinner,*-usb-clk", "allwinner,*-mmc-clk"
>>  - clock-output-names : shall be the corresponding names of the outputs.
>>       If the clock module only has one output, the name shall be the
>>       module name.
>> @@ -94,7 +97,7 @@ For "allwinner,sun6i-a31-pll6-clk", there are 2 outputs. The first output
>>  is the normal PLL6 output, or "pll6". The second output is rate doubled
>>  PLL6, or "pll6x2".
>>
>> -The "allwinner,sun4i-a10-mmc-clk" has three different outputs: the
>> +The "allwinner,*-mmc-clk" clocks have three different outputs: the
>>  main clock, with the ID 0, and the output and sample clocks, with the
>>  IDs 1 and 2, respectively.
>>
>> diff --git a/drivers/clk/sunxi/clk-mod0.c b/drivers/clk/sunxi/clk-mod0.c
>> index 4ac52c7..ef36e89 100644
>> --- a/drivers/clk/sunxi/clk-mod0.c
>> +++ b/drivers/clk/sunxi/clk-mod0.c
>> @@ -93,6 +93,30 @@ static void __init sun4i_a10_mod0_setup(struct device_node *node)
>>  }
>>  CLK_OF_DECLARE(sun4i_a10_mod0, "allwinner,sun4i-a10-mod0-clk", sun4i_a10_mod0_setup);
>>
>> +static const struct factors_data sun9i_a80_mod0_data __initconst = {
>> +     .enable = 31,
>> +     .mux = 24,
>> +     .muxmask = BIT(3) | BIT(2) | BIT(1) | BIT(0),
>> +     .table = &sun4i_a10_mod0_config,
>> +     .getter = sun4i_a10_get_mod0_factors,
>> +};
>> +
>> +static void __init sun9i_a80_mod0_setup(struct device_node *node)
>> +{
>> +     void __iomem *reg;
>> +
>> +     reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>> +     if (!reg) {
>> +             pr_err("Could not get registers for mod0-clk: %s\n",
>> +                    node->name);
>> +             return;
>> +     }
>> +
>> +     sunxi_factors_register(node, &sun9i_a80_mod0_data,
>> +                            &sun4i_a10_mod0_lock, reg);
>> +}
>> +CLK_OF_DECLARE(sun9i_a80_mod0, "allwinner,sun9i-a80-mod0-clk", sun9i_a80_mod0_setup);
>> +
>>  static DEFINE_SPINLOCK(sun5i_a13_mbus_lock);
>>
>>  static void __init sun5i_a13_mbus_setup(struct device_node *node)
>> @@ -309,3 +333,78 @@ err_free_data:
>>       kfree(clk_data);
>>  }
>>  CLK_OF_DECLARE(sun4i_a10_mmc, "allwinner,sun4i-a10-mmc-clk", sun4i_a10_mmc_setup);
>> +
>> +static DEFINE_SPINLOCK(sun9i_a80_mmc_lock);
>> +
>> +static void __init sun9i_a80_mmc_setup(struct device_node *node)
>> +{
>> +     struct clk_onecell_data *clk_data;
>> +     const char *parent;
>> +     void __iomem *reg;
>> +     int i;
>> +
>> +     reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>> +     if (IS_ERR(reg)) {
>> +             pr_err("Couldn't map the %s clock registers\n", node->name);
>> +             return;
>> +     }
>> +
>> +     clk_data = kmalloc(sizeof(*clk_data), GFP_KERNEL);
>> +     if (!clk_data)
>> +             return;
>> +
>> +     clk_data->clks = kcalloc(3, sizeof(*clk_data->clks), GFP_KERNEL);
>> +     if (!clk_data->clks)
>> +             goto err_free_data;
>> +
>> +     clk_data->clk_num = 3;
>> +     clk_data->clks[0] = sunxi_factors_register(node,
>> +                                                &sun9i_a80_mod0_data,
>> +                                                &sun9i_a80_mmc_lock, reg);
>> +     if (!clk_data->clks[0])
>> +             goto err_free_clks;
>> +
>> +     parent = __clk_get_name(clk_data->clks[0]);
>> +
>> +     for (i = 1; i < 3; i++) {
>> +             struct clk_init_data init = {
>> +                     .num_parents    = 1,
>> +                     .parent_names   = &parent,
>> +                     .ops            = &mmc_clk_ops,
>> +             };
>> +             struct mmc_phase *phase;
>> +
>> +             phase = kmalloc(sizeof(*phase), GFP_KERNEL);
>> +             if (!phase)
>> +                     continue;
>> +
>> +             phase->hw.init = &init;
>> +             phase->reg = reg;
>> +             phase->lock = &sun9i_a80_mmc_lock;
>> +
>> +             if (i == 1)
>> +                     phase->offset = 8;
>> +             else
>> +                     phase->offset = 20;
>> +
>> +             if (of_property_read_string_index(node, "clock-output-names",
>> +                                               i, &init.name))
>> +                     init.name = node->name;
>> +
>> +             clk_data->clks[i] = clk_register(NULL, &phase->hw);
>> +             if (IS_ERR(clk_data->clks[i])) {
>> +                     kfree(phase);
>> +                     continue;
>> +             }
>> +     }
>> +
>> +     of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>> +
>> +     return;
>> +
>> +err_free_clks:
>> +     kfree(clk_data->clks);
>> +err_free_data:
>> +     kfree(clk_data);
>> +}
>> +CLK_OF_DECLARE(sun9i_a80_mmc, "allwinner,sun9i-a80-mmc-clk", sun9i_a80_mmc_setup);
>
> That looks a lot like the A10 MMC clock. What's changing? only the
> data to feed to the factors setup code?

That's correct. Only the mux width in the data fed to the setup code
and the lock differ.

The hardware can work with the a10 mod0 code, but it won't recover from
cases where someone writes to the upper bits of the mux, since it doesn't
know about them.

ChenYu
