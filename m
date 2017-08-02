From: net147@gmail.com (Jonathan Liu)
Date: Wed, 2 Aug 2017 17:05:04 +1000
Subject: [PATCH v6 2/6] clk: sunxi-ng: Add sun4i/sun7i CCU driver
In-Reply-To: <f03e50040dc2d3dc3edd6be071510feeb953161d.1500043741.git-series.plaes@plaes.org>
References: <cover.ba2aaaa405a7ec685034e34926b8855fd6c9ab86.1500043741.git-series.plaes@plaes.org>
 <f03e50040dc2d3dc3edd6be071510feeb953161d.1500043741.git-series.plaes@plaes.org>
Message-ID: <CANwerB2En3q6XkUDwMo1CpCraCzpNi42WQYuAFb3yACT2j1FYw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Priit,

On 15 July 2017 at 00:49, Priit Laes <plaes@plaes.org> wrote:
> Introduce a clock controller driver for sun4i A10 and sun7i A20
> series SoCs.
>
> Signed-off-by: Priit Laes <plaes@plaes.org>
> ---
>  drivers/clk/sunxi-ng/Kconfig              |   13 +-
>  drivers/clk/sunxi-ng/Makefile             |    1 +-
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.c      | 1454 ++++++++++++++++++++++-
>  drivers/clk/sunxi-ng/ccu-sun4i-a10.h      |   61 +-
>  include/dt-bindings/clock/sun4i-a10-ccu.h |  200 +++-
>  include/dt-bindings/clock/sun7i-a20-ccu.h |   53 +-
>  include/dt-bindings/reset/sun4i-a10-ccu.h |   69 +-
>  7 files changed, 1851 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun4i-a10.h
>  create mode 100644 include/dt-bindings/clock/sun4i-a10-ccu.h
>  create mode 100644 include/dt-bindings/clock/sun7i-a20-ccu.h
>  create mode 100644 include/dt-bindings/reset/sun4i-a10-ccu.h

<snip>

> diff --git a/drivers/clk/sunxi-ng/ccu-sun4i-a10.c b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c
> new file mode 100644
> index 0000000..09e97d7
> --- /dev/null
> +++ b/drivers/clk/sunxi-ng/ccu-sun4i-a10.c

<snip>

> +static void __init sun4i_ccu_init(struct device_node *node,
> +                                 const struct sunxi_ccu_desc *desc)
> +{
> +       void __iomem *reg;
> +       u32 val;
> +
> +       reg = of_io_request_and_map(node, 0, of_node_full_name(node));
> +       if (IS_ERR(reg)) {
> +               pr_err("%s: Could not map the clock registers\n",
> +                      of_node_full_name(node));
> +               return;
> +       }
> +
> +       /* Force the PLL-Audio-1x divider to 4 */
> +       val = readl(reg + SUN4I_PLL_AUDIO_REG);

> +       val &= ~GENMASK(19, 16);
> +       writel(val | (3 << 16), reg + SUN4I_PLL_AUDIO_REG);

This doesn't work for me on A20 (440 Hz tone outputs@880 Hz tone)
and I need to use the following instead:
       val &= ~GENMASK(29, 26);
       writel(val | (4 << 26), reg + SUN4I_PLL_AUDIO_REG);

Toggling bits 16-19 doesn't seem to have any effect on the audio for me.

Thanks.

Regards,
Jonathan
