From: emilio@elopez.com.ar (=?UTF-8?B?RW1pbGlvIEzDs3Bleg==?=)
Date: Wed, 03 Apr 2013 22:19:22 -0300
Subject: [PATCH v2 1/7] clk: sunxi: Add support for AXI, AHB, APB0 and
 APB1 gates
In-Reply-To: <20130403214815.3383.60153@quantum>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-2-git-send-email-emilio@elopez.com.ar>
 <20130403214815.3383.60153@quantum>
Message-ID: <515CD51A.2070503@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

El 03/04/13 18:48, Mike Turquette escribi?:
> Quoting Emilio L?pez (2013-03-27 14:20:37)
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index d528a24..244de90 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> @@ -302,6 +302,82 @@ static void __init sunxi_divider_clk_setup(struct device_node *node,
>>  }
>>  
>>  
>> +
> 
> A lot of white space between these functions.

All of the function blocks are separated with three spaces on the file;
I thought it looked more readable that way, but I don't have any strong
opinion on separation. Is there any standard for this used on the kernel?

In any case, and to keep consistency, can we handle this on a follow-up
patch?

>> +/**
>> + * sunxi_gates_clk_setup() - Setup function for leaf gates on clocks
>> + */
>> +
>> +#define SUNXI_GATES_MAX_SIZE   64
>> +
>> +struct gates_data {
>> +       DECLARE_BITMAP(mask, SUNXI_GATES_MAX_SIZE);
>> +};
>> +
>> +static const __initconst struct gates_data axi_gates_data = {
>> +       .mask = {1},
>> +};
>> +
>> +static const __initconst struct gates_data ahb_gates_data = {
>> +       .mask = {0x7F77FFF, 0x14FB3F},
>> +};
>> +
>> +static const __initconst struct gates_data apb0_gates_data = {
>> +       .mask = {0x4EF},
>> +};
>> +
>> +static const __initconst struct gates_data apb1_gates_data = {
>> +       .mask = {0xFF00F7},
>> +};
>> +
>> +static void __init sunxi_gates_clk_setup(struct device_node *node,
>> +                                        struct gates_data *data)
>> +{
>> +       struct clk_onecell_data *clk_data;
>> +       const char *clk_parent;
>> +       const char *clk_name;
>> +       void *reg;
>> +       int qty;
>> +       int i = 0;
>> +       int j = 0;
>> +       int ignore;
>> +
>> +       reg = of_iomap(node, 0);
>> +
>> +       clk_parent = of_clk_get_parent_name(node, 0);
>> +
>> +       /* Worst-case size approximation and memory allocation */
>> +       qty = find_last_bit(data->mask, SUNXI_GATES_MAX_SIZE);
>> +       clk_data = kmalloc(sizeof(struct clk_onecell_data), GFP_KERNEL);
>> +       if (!clk_data)
>> +               return;
>> +       clk_data->clks = kzalloc((qty+1) * sizeof(struct clk *), GFP_KERNEL);
>> +       if (!clk_data->clks) {
>> +               kfree(clk_data);
>> +               return;
>> +       }
>> +
>> +       for_each_set_bit(i, data->mask, SUNXI_GATES_MAX_SIZE) {
>> +               of_property_read_string_index(node, "clock-output-names",
>> +                                             j, &clk_name);
>> +
>> +               /* No driver claims this clock, but it should remain gated */
> 
> Should the comment read, "ungated" instead of "gated"?

Indeed, good catch. Do you want me to resend the series, or can you
amend this when picking the patches?

>> +               ignore = !strcmp("ahb_sdram", clk_name) ? CLK_IGNORE_UNUSED : 0;
>> +
>> +               clk_data->clks[i] = clk_register_gate(NULL, clk_name,
>> +                                                     clk_parent, ignore,
>> +                                                     reg + 4 * (i/32), i % 32,
>> +                                                     0, &clk_lock);
>> +               WARN_ON(IS_ERR(clk_data->clks[i]));
>> +
>> +               j++;
>> +       }
>> +
>> +       /* Adjust to the real max */
>> +       clk_data->clk_num = i;
>> +
>> +       of_clk_add_provider(node, of_clk_src_onecell_get, clk_data);
>> +}
>> +
>>  /* Matches for of_clk_init */
>>  static const __initconst struct of_device_id clk_match[] = {
>>         {.compatible = "fixed-clock", .data = of_fixed_clk_setup,},
>> @@ -331,6 +407,15 @@ static const __initconst struct of_device_id clk_mux_match[] = {
>>         {}
>>  };
>>  
>> +/* Matches for gate clocks */
>> +static const __initconst struct of_device_id clk_gates_match[] = {
>> +       {.compatible = "allwinner,sun4i-axi-gates-clk", .data = &axi_gates_data,},
>> +       {.compatible = "allwinner,sun4i-ahb-gates-clk", .data = &ahb_gates_data,},
>> +       {.compatible = "allwinner,sun4i-apb0-gates-clk", .data = &apb0_gates_data,},
>> +       {.compatible = "allwinner,sun4i-apb1-gates-clk", .data = &apb1_gates_data,},
>> +       {}
>> +};
>> +
>>  static void __init of_sunxi_table_clock_setup(const struct of_device_id *clk_match,
>>                                               void *function)
>>  {
>> @@ -359,4 +444,7 @@ void __init sunxi_init_clocks(void)
>>  
>>         /* Register mux clocks */
>>         of_sunxi_table_clock_setup(clk_mux_match, sunxi_mux_clk_setup);
>> +
>> +       /* Register gate clocks */
>> +       of_sunxi_table_clock_setup(clk_gates_match, sunxi_gates_clk_setup);
> 
> I'm still a device tree noob, so this may be a dumb question.  Can the
> above be converted to of_clk_init?

As far as I know, you can't, because of_clk_init doesn't allow for
custom data to be passed to the functions. If we were to use of_clk_init
we would need one function per clock, and it would be mostly duplicated
code / wrappers. I've added Gregory on Cc, please correct me if this is
not the case.

Thanks for the review,

Emilio
