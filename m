From: icenowy@aosc.io (icenowy at aosc.io)
Date: Tue, 15 Aug 2017 10:26:44 +0800
Subject: [linux-sunxi] Re: [PATCH v4 3/3] clk: sunxi-ng: support R40 SoC
In-Reply-To: <CAGb2v64Bc948fPLxW0o_Swt-zjgcZtz4voongpY8MJTwPpzDwg@mail.gmail.com>
References: <20170812124352.24148-1-icenowy@aosc.io>
 <20170812124352.24148-4-icenowy@aosc.io>
 <CAGb2v67cz9AeHghe6iB_AJc+2=0sYRHLdfHo+sTPYHhjJxydUQ@mail.gmail.com>
 <edaffbb2947c5d4707c880482d3c7f4c@aosc.io>
 <CAGb2v64Bc948fPLxW0o_Swt-zjgcZtz4voongpY8MJTwPpzDwg@mail.gmail.com>
Message-ID: <4a89582aef5e8414a31cb46416c556f1@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2017-08-15 10:16?Chen-Yu Tsai ???
> On Tue, Aug 15, 2017 at 12:53 AM,  <icenowy@aosc.io> wrote:
>> ? 2017-08-15 00:12?Chen-Yu Tsai ???
>>> 
>>> )On Sat, Aug 12, 2017 at 8:43 PM, Icenowy Zheng <icenowy@aosc.io> 
>>> wrote:
>>>> 
>>>> Allwinner R40 SoC have a clock controller module in the style of the
>>>> SoCs beyond sun6i, however, it's more rich and complex.
>>>> 
>>>> Add support for it.
>>>> 
>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>> ---
>>>> Changes in v4:
>>>> - Removed usb-ohci-12M mux clocks.
>>>> - Removed unused (and not in user manual) adda-4x clock.
>>>> - Implemented proper SATA PLL system.
>>>> - Renamed MP (Mixed Processor) clock names to drop the extra "DE_".
>>>> - Renamed TCONs' clock names to "tcon-lcdX" or "tcon-tvX".
>>>> - Added missing RST_DRAM.
>>>> - Several clock post/pre-dividers and constraints fixes.
>>>> Changes in v3:
>>>> - Rebased on current linux-next.
>>>> Changes in v2:
>>>> - Fixes according to the SoC's user manual.
>>>> 
>>>>  drivers/clk/sunxi-ng/Kconfig              |    5 +
>>>>  drivers/clk/sunxi-ng/Makefile             |    1 +
>>>>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c      | 1240
>>>> +++++++++++++++++++++++++++++
>>>>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h      |   69 ++
>>>>  include/dt-bindings/clock/sun8i-r40-ccu.h |  187 +++++
>>>>  include/dt-bindings/reset/sun8i-r40-ccu.h |  130 +++
>>>>  6 files changed, 1632 insertions(+)
>>>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>>>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.h
>>>>  create mode 100644 include/dt-bindings/clock/sun8i-r40-ccu.h
>>>>  create mode 100644 include/dt-bindings/reset/sun8i-r40-ccu.h
>>>> 
>>>> diff --git a/drivers/clk/sunxi-ng/Kconfig 
>>>> b/drivers/clk/sunxi-ng/Kconfig
>>>> index 7342928c35cd..7a360737fe3c 100644
>>>> --- a/drivers/clk/sunxi-ng/Kconfig
>>>> +++ b/drivers/clk/sunxi-ng/Kconfig
>>>> @@ -48,6 +48,11 @@ config SUN8I_V3S_CCU
>>>>  config SUN8I_DE2_CCU
>>>>         bool "Support for the Allwinner SoCs DE2 CCU"
>>>> 
>>>> +config SUN8I_R40_CCU
>>>> +       bool "Support for the Allwinner R40 CCU"
>>>> +       default MACH_SUN8I
>>>> +       depends on MACH_SUN8I || COMPILE_TEST
>>>> +
>>>>  config SUN9I_A80_CCU
>>>>         bool "Support for the Allwinner A80 CCU"
>>>>         default MACH_SUN9I
>>>> diff --git a/drivers/clk/sunxi-ng/Makefile
>>>> b/drivers/clk/sunxi-ng/Makefile
>>>> index 45a5910379a5..b1267fe68a8f 100644
>>>> --- a/drivers/clk/sunxi-ng/Makefile
>>>> +++ b/drivers/clk/sunxi-ng/Makefile
>>>> @@ -29,6 +29,7 @@ obj-$(CONFIG_SUN8I_H3_CCU)    += ccu-sun8i-h3.o
>>>>  obj-$(CONFIG_SUN8I_V3S_CCU)    += ccu-sun8i-v3s.o
>>>>  obj-$(CONFIG_SUN8I_DE2_CCU)    += ccu-sun8i-de2.o
>>>>  obj-$(CONFIG_SUN8I_R_CCU)      += ccu-sun8i-r.o
>>>> +obj-$(CONFIG_SUN8I_R40_CCU)    += ccu-sun8i-r40.o
>>>>  obj-$(CONFIG_SUN9I_A80_CCU)    += ccu-sun9i-a80.o
>>>>  obj-$(CONFIG_SUN9I_A80_CCU)    += ccu-sun9i-a80-de.o
>>>>  obj-$(CONFIG_SUN9I_A80_CCU)    += ccu-sun9i-a80-usb.o
>>>> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>>>> b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>>>> new file mode 100644
>>>> index 000000000000..9dc6ad419f9a
>>>> --- /dev/null
>>>> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>>> 
>>> 
>>> [...]
>>> 
>>>> +/*
>>>> + * The MIPI PLL has 2 modes: "MIPI" and "HDMI".
>>>> + *
>>>> + * The MIPI mode is a standard NKM-style clock. The HDMI mode is an
>>>> + * integer / fractional clock with switchable multipliers and 
>>>> dividers.
>>>> + * This is not supported here. We hardcode the PLL to MIPI mode.
>>>> + */
>>>> +#define SUN8I_R40_PLL_MIPI_REG 0x040
>>>> +
>>>> +static const char * const pll_mipi_parents[] = { "pll-video0" };
>>>> +static SUNXI_CCU_NKM_WITH_MUX_GATE_LOCK(pll_mipi_clk, "pll-mipi",
>>>> +                                       pll_mipi_parents, 0x040,
>>>> +                                       8, 4,   /* N */
>>>> +                                       4, 2,   /* K */
>>>> +                                       0, 4,   /* M */
>>>> +                                       21, 1,  /* mux */
>>>> +                                       BIT(31) | BIT(23) | BIT(22), 
>>>> /*
>>>> gate */
>>>> +                                       BIT(28),        /* lock */
>>>> +                                       CLK_SET_RATE_UNGATE);
>>> 
>>> 
>>> K has a minimum of 2 here.
>> 
>> 
>> I think it's not mentioned on the user manual...
>> 
>> It says "The range is from 1 to 4."
> 
> My R40 user manual v1.0 says otherwise. Page 85: PLL_FACTOR_K
> range is from 2 to 4.

Sorry... I read wrong page.

> 
>> 
>>> 
>>>> +
>>>> +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_de_clk, "pll-de",
>>>> +                                       "osc24M", 0x0048,
>>>> +                                       8, 7,           /* N */
>>>> +                                       0, 4,           /* M */
>>>> +                                       BIT(24),        /* frac 
>>>> enable */
>>>> +                                       BIT(25),        /* frac 
>>>> select */
>>>> +                                       270000000,      /* frac rate 
>>>> 0 */
>>>> +                                       297000000,      /* frac rate 
>>>> 1 */
>>>> +                                       BIT(31),        /* gate */
>>>> +                                       BIT(28),        /* lock */
>>>> +                                       0);
>>> 
>>> 
>>> CLK_SET_RATE_UNGATE should be set for _all_ PLLs. The lock status bit
>>> depends on the PLL running, and we check the lock status whenever 
>>> set_rate
>>> is done.
>> 
>> 
>> Should we also do this on older SoCs?
>> 
>> I think at least on H3 I met PLL-DE waiting for lock failure.
> 
> We probably should. But let us focus on this driver for now.
> 
>> 
>>> 
>>>> +
>>>> +static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_ddr1_clk, "pll-ddr1",
>>>> +                                  "osc24M", 0x04c,
>>>> +                                  8, 7,        /* N */
>>>> +                                  0, 2,        /* M */
>>>> +                                  BIT(31),     /* gate */
>>>> +                                  BIT(28),     /* lock */
>>>> +                                  CLK_SET_RATE_UNGATE);
>>> 
>>> 
>>> Manual says 16 <= N <= 75.
>> 
>> 
>> Maybe we need to implement more things for this constraint?
>> 
>> But I think the frequency is not going to be changed when
>> running...
> 
> Either you implement it now, or leave a note saying it has
> said restrictions. I am in favor of implementing it now.
> That said, some other PLLs have restrictions on N*K. That
> we cannot implement at this time.

I prefer to leave a note (also on PLL-DDR0).

> 
>> 
>>> 
>>> [...]
>>> 
>>>> +
>>>> +static struct clk_div_table ths_div_table[] = {
>>>> +       { .val = 0, .div = 1 },
>>>> +       { .val = 1, .div = 2 },
>>>> +       { .val = 2, .div = 4 },
>>>> +       { .val = 3, .div = 8 },
>>>> +};
>>>> +static const char * const ths_parents[] = { "osc24M" };
>>>> +static struct ccu_div ths_clk = {
>>>> +       .enable = BIT(31),
>>>> +       .div    = _SUNXI_CCU_DIV_TABLE(0, 2, ths_div_table),
>>> 
>>> 
>>> You could use _SUNXI_CCU_DIV_FLAGS(0, 2, CLK_DIVIDER_POWER_OF_TWO)
>>> instead of div_table.
>> 
>> 
>> Thanks.
>> 
>>> 
>>>> +       .mux    = _SUNXI_CCU_MUX(24, 2),
>>>> +       .common = {
>>>> +               .reg            = 0x074,
>>>> +               .hw.init        = CLK_HW_INIT_PARENTS("ths",
>>>> +                                                     ths_parents,
>>>> +                                                     &ccu_div_ops,
>>>> +                                                     0),
>>>> +       },
>>>> +};
>>> 
>>> 
>>> [...]
>>> 
>>>> +static const char * const keypad_parents[] = { "osc24M", "osc32k", 
>>>> };
>>> 
>>> 
>>> Nit: you can drop the extra comma.
>> 
>> 
>> Thanks.
>> 
>>> 
>>> [...]
>>> 
>>>> +static const char * const sata_parents[] = { "pll-sata-out", 
>>>> "sata-ext"
>>>> };
>>>> +static SUNXI_CCU_MUX_WITH_GATE(sata_clk, "sata", sata_parents,
>>>> +                              0x0c8, 24, 1, BIT(31),
>>>> CLK_SET_RATE_PARENT);
>>> 
>>> 
>>> You don't have CLK_SET_RATE_PARENT for the parent, which is also a
>>> mux+gate.
>>> I'm not sure what you are expecting to happen here.
>> 
>> 
>> Oh maybe I should add it there.
> 
> Adding it there may affect pll-periph0.

I should add it on pll-sata-out, but not on pll-periph0-sata.

pll-periph0-sata is a downstream clock of pll-periph0.

> 
>>> 
>>>> +
>>>> +static SUNXI_CCU_GATE(usb_phy0_clk,    "usb-phy0",     "osc24M",
>>>> +                     0x0cc, BIT(8), 0);
>>>> +static SUNXI_CCU_GATE(usb_phy1_clk,    "usb-phy1",     "osc24M",
>>>> +                     0x0cc, BIT(9), 0);
>>>> +static SUNXI_CCU_GATE(usb_phy2_clk,    "usb-phy2",     "osc24M",
>>>> +                     0x0cc, BIT(10), 0);
>>>> +static SUNXI_CCU_GATE(usb_ohci0_clk,   "usb-ohci0",    "osc12M",
>>>> +                     0x0cc, BIT(16), 0);
>>>> +static SUNXI_CCU_GATE(usb_ohci1_clk,   "usb-ohci1",    "osc12M",
>>>> +                     0x0cc, BIT(17), 0);
>>>> +static SUNXI_CCU_GATE(usb_ohci2_clk,   "usb-ohci2",    "osc12M",
>>>> +                     0x0cc, BIT(18), 0);
>>> 
>>> 
>>> Maybe you should force the OHCI muxes to 0?
>> 
>> 
>> This seems to be not done in A64 driver.
>> 
>> P.S. I changed this block to make it similar to the A64 driver.
> 
> Then you should at least leave a note saying this is unimplemented
> and we are depending on the hardware default.

Let me force it ;-)

> 
>> 
>>> 
>>> [...]
>>> 
>>>> +static const char * const tcon_parents[] = { "pll-video0", 
>>>> "pll-video1",
>>>> +                                            "pll-video0-2x",
>>>> "pll-video1-2x",
>>>> +                                            "pll-mipi" };
>>>> +static SUNXI_CCU_MUX_WITH_GATE(tcon_lcd0_clk, "tcon-lcd0", 
>>>> tcon_parents,
>>>> +                              0x110, 24, 3, BIT(31),
>>>> CLK_SET_RATE_PARENT);
>>>> +static SUNXI_CCU_MUX_WITH_GATE(tcon_lcd1_clk, "tcon-lcd1", 
>>>> tcon_parents,
>>>> +                              0x114, 24, 3, BIT(31),
>>>> CLK_SET_RATE_PARENT);
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(tcon_tv0_clk, "tcon-tv0", 
>>>> tcon_parents,
>>>> +                                0x118, 0, 4, 24, 3, BIT(31), 0);
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(tcon_tv1_clk, "tcon-tv1", 
>>>> tcon_parents,
>>>> +                                0x11c, 0, 4, 24, 3, BIT(31), 0);
>>> 
>>> 
>>> You will likely need CLK_SET_RATE_PARENT for tcon-tv* as well.
>> 
>> 
>> According to the experience on H3, the TCONs may be more complex.
>> 
>> Leave 0 here until we have either HDMI driver or TVE driver.
> 
> OK.
> 
>> 
>>> 
>>> [...]
>>> 
>>>> +static const char * const csi_mclk_parents[] = { "osc24M", 
>>>> "pll-video",
>>> 
>>> 
>>> pll-video1?
>> 
>> 
>> oh yes, thanks.
>> 
>>> 
>>>> +                                                "pll-periph1" };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(csi1_mclk_clk, "csi1-mclk",
>>>> csi_mclk_parents,
>>>> +                                0x130, 0, 5, 8, 3, BIT(15), 0);
>>>> +
>>>> +static const char * const csi_sclk_parents[] = { "pll-periph0",
>>>> "pll-periph1" };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(csi_sclk_clk, "csi-sclk",
>>>> csi_sclk_parents,
>>>> +                                0x134, 16, 4, 24, 3, BIT(31), 0);
>>>> +
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(csi0_mclk_clk, "csi0-mclk",
>>>> csi_mclk_parents,
>>>> +                                0x134, 0, 5, 8, 3, BIT(15), 0);
>>> 
>>> 
>>> [...]
>>> 
>>>> +
>>>> +static SUNXI_CCU_M_WITH_GATE(ve_clk, "ve", "pll-ve",
>>>> +                            0x13c, 16, 3, BIT(31), 0);
>>> 
>>> 
>>> CLK_SET_RATE_PARENT?
>> 
>> 
>> Seems ok.
>> 
>>> 
>>>> +
>>>> +static SUNXI_CCU_GATE(adda_clk,                "adda",
>>>> "pll-audio",
>>>> +                     0x140, BIT(31), CLK_SET_RATE_PARENT);
>>> 
>>> 
>>> You call the bus clock "bus-codec", but here you call it "adda". Pick 
>>> one
>>> and
>>> be consistent.
>> 
>> 
>> Use codec?
> 
> Cool.
> 
>> 
>>> 
>>> [...]
>>> 
>>>> +static const char * const hdmi_parents[] = { "pll-video0", 
>>>> "pll-video1"
>>>> };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
>>>> +                                0x150, 0, 4, 24, 2, BIT(31), 0);
>>> 
>>> 
>>> CLK_SET_RATE_PARENT?
>> 
>> 
>> Wait for HDMI driver.
> 
> OK.
> 
>> 
>>> 
>>> 
>>> [...]
>>> 
>>>> +static const char * const mbus_parents[] = { "osc24M", 
>>>> "pll-periph0-2x",
>>>> +                                            "pll-ddr0" };
>>>> +static SUNXI_CCU_MP_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents, 
>>>> 0x15c,
>>>> +                                 0, 4,         /* M */
>>>> +                                 16, 2,        /* P */
>>>> +                                 24, 2,        /* mux */
>>>> +                                 BIT(31),      /* gate */
>>>> +                                 CLK_IS_CRITICAL);
>>> 
>>> 
>>> The documentation for this one is fuzzy. It mentions the N (or P) 
>>> factor,
>>> but does not include it in the formula. Can you double check it 
>>> against
>>> the BSP and add a comment about it?
>> 
>> 
>> ```
>> SUNXI_CLK_PERIPH(mbus, MBUS_CFG, 24, 2, MBUS_CFG, 0, 4, 16, 2, 0, 
>> MBUS_CFG,
>>                         MBUS_RST, 0, 0, 31, 31, 0, 0, &clk_lock, NULL, 
>> 0);
>> ```
>> I think the BSP driver used both factors, however, the driver may be 
>> also
>> not accurate as I think maybe mbus is not going to be changed even in 
>> BSP
>> kernel.
> 
> OK. Please add a comment saying that the doc is fuzzy and you're 
> following
> the BSP on this one.

OK.

> 
>> 
>>> 
>>>> +
>>>> +static const char * const dsi_dphy_parents[] = { "pll-video0",
>>>> "pll-video1",
>>>> +                                                "pll-periph0" };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(dsi_dphy_clk, "dsi-dphy",
>>>> dsi_dphy_parents,
>>>> +                                0x168, 0, 4, 8, 2, BIT(15), 0);
>>> 
>>> 
>>> Note: we might need CLK_SET_RATE_PARENT later on, but we will need to 
>>> find
>>> a way to keep pll-periph* fixed.
>>> 
>>>> +
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(tve0_clk, "tve0", tcon_parents,
>>>> +                                0x180, 0, 4, 24, 3, BIT(31), 0);
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(tve1_clk, "tve1", tcon_parents,
>>>> +                                0x184, 0, 4, 24, 3, BIT(31), 0);
>>> 
>>> 
>>> CLK_SET_RATE_PARENT?
>> 
>> 
>> Wait for the real driver -- it may be more complex.
> 
> OK.
> 
>> 
>>> 
>>>> +
>>>> +static const char * const tvd_parents[] = { "pll-video0", 
>>>> "pll-video1",
>>>> +                                           "pll-video0-2x",
>>>> "pll-video1-2x" };
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(tvd0_clk, "tvd0", tvd_parents,
>>>> +                                0x188, 0, 4, 24, 3, BIT(31), 0);
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(tvd1_clk, "tvd1", tvd_parents,
>>>> +                                0x18c, 0, 4, 24, 3, BIT(31), 0);
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(tvd2_clk, "tvd2", tvd_parents,
>>>> +                                0x190, 0, 4, 24, 3, BIT(31), 0);
>>>> +static SUNXI_CCU_M_WITH_MUX_GATE(tvd3_clk, "tvd3", tvd_parents,
>>>> +                                0x194, 0, 4, 24, 3, BIT(31), 0);
>>> 
>>> 
>>> CLK_SET_RATE_PARENT?
>> 
>> 
>> Not sure at all, maybe they should be changed when really doing TVD
>> driver.
> 
> OK.
> 
>> 
>>> 
>>> [...]
>>> 
>>> You are missing the SYS_32k mux at register 0x310. According to
>>> the diagrams, this is the actual clock that supplies the LOSC
>>> parent of various muxes in the CCU. It itself is a mux between
>>> an internal 2M RC oscillator, and LOSC from the RTC module.
>>> 
>>>> +
>>>> +static struct ccu_reset_map sun8i_r40_ccu_resets[] = {
>>> 
>>> 
>>> [...]
>>> 
>>>> +       [RST_BUS_HDMI_SLOW]     =  { 0x2c4, BIT(10) },
>>>> +       [RST_BUS_HDMI]          =  { 0x2c4, BIT(11) },
>>> 
>>> 
>>> Manual says bit 10 is HDMI0, bit 11 is HDMI1. Looking at the clocks,
>>> bit 10 would be RST_BUS_HDMI, while bit 11 would be 
>>> RST_BUS_HDMI_SLOW.
>> 
>> 
>> Let me just call them 0 and 1 in next version.
> 
> OK.
> 
>> 
>> 
>>> 
>>> [...]
>>> 
>>>> +
>>>> +static const struct sunxi_ccu_desc sun8i_r40_ccu_desc = {
>>>> +       .ccu_clks       = sun8i_r40_ccu_clks,
>>>> +       .num_ccu_clks   = ARRAY_SIZE(sun8i_r40_ccu_clks),
>>>> +
>>>> +       .hw_clks        = &sun8i_r40_hw_clks,
>>>> +
>>>> +       .resets         = sun8i_r40_ccu_resets,
>>>> +       .num_resets     = ARRAY_SIZE(sun8i_r40_ccu_resets),
>>>> +};
>>>> +
>>>> +static struct ccu_mux_nb sun8i_r40_cpu_nb = {
>>>> +       .common         = &cpu_clk.common,
>>>> +       .cm             = &cpu_clk.mux,
>>>> +       .delay_us       = 1, /* > 8 clock cycles at 24 MHz */
>>>> +       .bypass_index   = 1, /* index of 24 MHz oscillator */
>>>> +};
>>>> +
>>>> +static void __init sun8i_r40_ccu_setup(struct device_node *node)
>>>> +{
>>>> +       void __iomem *reg;
>>>> +       u32 val;
>>>> +
>>>> +       reg = of_io_request_and_map(node, 0, 
>>>> of_node_full_name(node));
>>>> +       if (IS_ERR(reg)) {
>>>> +               pr_err("%s: Could not map the clock registers\n",
>>>> +                      of_node_full_name(node));
>>>> +               return;
>>>> +       }
>>>> +
>>>> +       /* Force the PLL-Audio-1x divider to 4 */
>>>> +       val = readl(reg + SUN8I_R40_PLL_AUDIO_REG);
>>>> +       val &= ~GENMASK(19, 16);
>>>> +       writel(val | (3 << 16), reg + SUN8I_R40_PLL_AUDIO_REG);
>>> 
>>> 
>>> You should also force pll-mipi to mipi mode. And the OHCI muxes.
>>> 
>>>> +
>>>> +       sunxi_ccu_probe(node, reg, &sun8i_r40_ccu_desc);
>>>> +
>>>> +       ccu_mux_notifier_register(pll_cpu_clk.common.hw.clk,
>>>> +                                 &sun8i_r40_cpu_nb);
>>> 
>>> 
>>> Do you also need the gate-then-ungate notifier?
>> 
>> 
>> Still unknown...
> 
> OK.

Maybe I should do some experiments, and if possible, add DVFS even
in the start?

We have proper driver for AXP221s ;-)

> 
> Thanks
> ChenYu
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
