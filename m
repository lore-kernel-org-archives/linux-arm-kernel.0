From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 19 Aug 2017 17:11:42 +0800
Subject: [linux-sunxi] Re: [PATCH v5] clk: sunxi-ng: support R40 SoC
In-Reply-To: <ba1af994f165b96c096ec03a72836739@aosc.io>
References: <20170815055529.4780-1-icenowy@aosc.io>
 <ba1af994f165b96c096ec03a72836739@aosc.io>
Message-ID: <CAGb2v645YO-t-5+k2yRsj4_wcJuURic-HY6oD0-mZzOh7--4Ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 4:52 PM,  <icenowy@aosc.io> wrote:
> ? 2017-08-15 13:55?Icenowy Zheng ???
>>
>> Allwinner R40 SoC have a clock controller module in the style of the
>> SoCs beyond sun6i, however, it's more rich and complex.
>>
>> Add support for it.
>>
>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>> ---
>> Changes in v5:
>> - Added TODO's for PLL constraints.
>> - Forced OHCI12M mux to 0.
>> - Changed "adda" clock to "codec" to be consistent with "bus-codec".
>> - Added several CLK_SET_RATE_{UNGATE,PARENT} flags.
>> - Added PLL_CPU gate notifier.
>> Changes in v4:
>> - Removed usb-ohci-12M mux clocks.
>> - Removed unused (and not in user manual) adda-4x clock.
>> - Implemented proper SATA PLL system.
>> - Renamed MP (Mixed Processor) clock names to drop the extra "DE_".
>> - Renamed TCONs' clock names to "tcon-lcdX" or "tcon-tvX".
>> - Added missing RST_DRAM.
>> - Several clock post/pre-dividers and constraints fixes.
>> Changes in v3:
>> - Rebased on current linux-next.
>> Changes in v2:
>> - Fixes according to the SoC's user manual.
>>
>>  drivers/clk/sunxi-ng/Kconfig              |    5 +
>>  drivers/clk/sunxi-ng/Makefile             |    1 +
>>  drivers/clk/sunxi-ng/ccu-sun8i-r40.c      | 1290
>> +++++++++++++++++++++++++++++
>>  drivers/clk/sunxi-ng/ccu-sun8i-r40.h      |   69 ++
>>  include/dt-bindings/clock/sun8i-r40-ccu.h |  187 +++++
>>  include/dt-bindings/reset/sun8i-r40-ccu.h |  130 +++
>>  6 files changed, 1682 insertions(+)
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.c
>>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-r40.h
>>  create mode 100644 include/dt-bindings/clock/sun8i-r40-ccu.h
>>  create mode 100644 include/dt-bindings/reset/sun8i-r40-ccu.h
>>
>> [...]
>>
>> +static void __init sun8i_r40_ccu_setup(struct device_node *node)
>> +{
>> +       void __iomem *reg;
>> +       u32 val;
>> +
>> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
>> +       if (IS_ERR(reg)) {
>> +               pr_err("%s: Could not map the clock registers\n",
>> +                      of_node_full_name(node));
>> +               return;
>> +       }
>> +
>> +       /* Force the PLL-Audio-1x divider to 4 */
>> +       val = readl(reg + SUN8I_R40_PLL_AUDIO_REG);
>> +       val &= ~GENMASK(19, 16);
>> +       writel(val | (3 << 16), reg + SUN8I_R40_PLL_AUDIO_REG);
>> +
>> +       /* Force PLL-MIPI to MIPI mode */
>> +       val = readl(reg + SUN8I_R40_PLL_MIPI_REG);
>> +       val &= ~BIT(16);
>> +       writel(val, reg + SUN8I_R40_PLL_MIPI_REG);
>> +
>> +       /* Force OHCI 12M parent to 0 */

Clarified the comment as

        Force OHCI 12M parent to 12M divided from 48M

>> +       val = readl(reg + SUN8I_R40_USB_CLK_REG);
>> +       val &= ~GENMASK(20, 6);
>
>
> Sorry but I think this line should be:
>
> val &= ~GENMASK(25, 20);
>
> I didn't understand GENMASK well...

Fixed and applied. Thanks!

ChenYu
