From: cwchoi00@gmail.com (Chanwoo Choi)
Date: Fri, 28 Nov 2014 00:44:07 +0900
Subject: [PATCH 11/19] clk: samsung: exynos5433: Add clocks for
 CMU_BUS{0|1|2} domains
In-Reply-To: <2150099.t3m9xROUE3@wuerfel>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <2120788.f3P3CC6nYQ@wuerfel>
 <CAGTfZH1DdBGYKXv6VgWYfqfcyWVMm8MLux1U7sn_rX5h3-TGNQ@mail.gmail.com>
 <2150099.t3m9xROUE3@wuerfel>
Message-ID: <CAGTfZH1C28s7trTh9+PhrnLnmJ9vpsKtAA61ASK-LA_1d_cihg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 28, 2014 at 12:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 28 November 2014 00:17:40 Chanwoo Choi wrote:
>>
>> But, "fixed-clock" pass all properties from dt file to
>> driver/clk/clk-fixed-rate.c.
>> and "fixed-clock" driver has not the data dependent on h/w. e.g.,
>> clock offset, parent clock.
>
> The parent clocks would obviously have to be provided in DT if you
> do this. I'm not sure what you mean with clock offsets. What would
> it take to describe that?
>
>> >> >
>> >> > > >     clock-controller at 113600000 {
>> >> > > >             reg = <0 0x113600000 0 0x1000>;
>> >> > > >             compatible = "samsung,exynos5433-cmu";
>> >> > > >             #clock-cells = <1>;
>> >> > > >     };
>> >> > > >
>> >> > > >     clock-controller at 114800000 {
>> >> > > >             reg = <0 0x114800000 0 0x1000>;
>> >> > > >             compatible = "samsung,exynos5433-cmu";
>> >> > > >             #clock-cells = <1>;
>> >> > > >     };
>> >> > > >
>> >> > > > The code will just map the local registers for each instance and then
>> >> > > > provide the clocks of the right instance when asked for it.
>> >> > >
>> >> > > Each clock domain has not the same mux/divider/clock. So, just one
>> >> > compatible
>> >> > > string could not support all of clock domains.
>> >> >
>> >> > What are the specific differences?
>> >>
>> >>
>> >>
>> >> > I'm not sure that difference among clock domains because I think it is
>> >> dependent on the opinion of architect of SoC.
>> >>
>> >> cmu_bus0/1/2 are much similar. Just cmu_bus2 has one more mux/gate clock
>> >> than cmu_bus0/1.
>> >
>> > Yes, that's what I mean. You can simply model that extra mux/gate
>> > in the driver, as long as nothing ever tries to access the clock.
>>
>> If only use one compatible to support CMU_BUSx domains,
>> I would implement it as following with Sylwester's guide.
>>
>> To Sylwester, Tomaz,
>> Are you agree following method to support CMU_BUSx domains
>> by using one compatible string?
>
>
>> +#define bus_clk_regs(num)                \
>> +static unsigned long bus##num_clk_regs[] __initdata = {    \
>> +    DIV_BUS,                    \
>> +    DIV_STAT_BUS,                    \
>> +    ENABLE_ACLK_BUS,                \
>> +    ENABLE_PCLK_BUS,                \
>> +    ENABLE_IP_BUS0,                    \
>> +    ENABLE_IP_BUS1,                    \
>> +};                            \
>
> I don't understand why you would need a macro here. Isn't this constant
> data that you can pass into multiple devices? The use of macros
> definitely makes it worse than the original patch.
>
>> +#define bus_div_clks(num)                        \
>> +static struct samsung_div_clock bus##num_div_clks[] __initdata = {    \
>> +    /* DIV_BUS */                            \
>> +    DIV(CLK_DIV_PCLK_BUS##num_133, "div_pclk_bus"#num"_133",    \
>> +            "aclk_bus"#num"_400", DIV_BUS##num, 0, 3),    \
>> +};                                    \
>
> To illustrate my point further: CLK_DIV_PCLK_BUS0/1/2 are all the
> same, and so are DIV_BUS0/1/2, so you should not need to duplicate
> the definitions at all but just call them 'CLK_DIV_PCLK_BUS'
> and 'DIV_BUS'.

CLK_DIV_PCLK_BUS0/1/2 is not all the same.
Each CLK_DIV_PCLK_BUS0/1/2 must need the unique clock number.
Because some device may need some clocks by using unique clock number.

>
> For the "aclk_bus"#num"_400" and "div_pclk_bus"#num"_133" strings,
> I don't know what they refer to. Are you sure they have to be unique?

Sure.
All clocks(mux/divider/gate) must need the unique clock number.

Best Regards,
Chanwoo Choi

>
>> +
>> +#define bus_clk_regs(0)
>> +#define bus_div_clks(0)
>> +#define bus_gate_clks(0)
>> +
>> +#define bus_clk_regs(1)
>> +#define bus_div_clks(1)
>> +#define bus_gate_clks(1)
>> +
>> +static void __init exynos5433_cmu_bus_init(struct device_node *np)
>> +{
>> +    void __iomem *reg_base_bus0, *reg_base_bus1;
>> +
>> +    reg_base_bus0 = of_iomap(np, 0);
>> +    reg_base_bus1 = of_iomap(np, 1);
>> +
>> +    bus0_ctx = samsung_clk_init(np, reg_base_bus0, BUS0_NR_CLKS);
>> +    bus1_ctx = samsung_clk_init(np, reg_base_bus0, BUS0_NR_CLKS);
>> +
>> +    samsung_clk_register_div(bus0_ctx, bus0_div_clks,
>> +                    ARRAY_SIZE(bus0_div_clks));
>> +    samsung_clk_register_gate(bus0_ctx, bus0_gate_clks,
>> +                    ARRAY_SIZE(bus0_gate_clks));
>> +    samsung_clk_register_div(bus1_ctx, bus1_div_clks,
>> +                    ARRAY_SIZE(bus1_div_clks));
>> +    samsung_clk_register_gate(bus1_ctx, bus1_gate_clks,
>> +                    ARRAY_SIZE(bus1_gate_clks));
>> +
>> +    samsung_clk_of_provider(np, bus0_ctx);
>> +    samsung_clk_of_provider(np, bus1_ctx);
>> +
>> +}
>> +CLK_OF_DECLARE(exynos5433_cmu_bus, "samsung,exynos5433-cmu-bus",
>> +        exynos5433_cmu_bus_init);
>
> This isn't helpful either: you really have two instances and should
> not merge them together into one device node. This should look like
>
> static void __init exynos5433_cmu_bus_init(struct device_node *np)
> {
>     void __iomem *reg_base_bus;
>
>     reg_base_bus = of_iomap(np, 0);
>
>     bus_ctx = samsung_clk_init(np, reg_base_bus, BUS_NR_CLKS);
>
>     samsung_clk_register_div(bus_ctx, bus_div_clks,
>                     ARRAY_SIZE(bus_div_clks));
>     samsung_clk_register_gate(bus_ctx, bus_gate_clks,
>                     ARRAY_SIZE(bus_gate_clks));
>
>     samsung_clk_of_provider(np, bus0_ctx);
> }
>
> and get called three times.
>
>         Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
