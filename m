From: djkurtz@chromium.org (Daniel Kurtz)
Date: Sat, 11 Jul 2015 00:03:10 +0800
Subject: [PATCH 0/2] Add clk_null to be the dummy root of MT8173 clocks
In-Reply-To: <1436519763-3195-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1436519763-3195-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <CAGS+omDu7F8EaqRgFLQC79zzn5Pwt2-zzB_wKa-kK_grsxs1eg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 5:16 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> This patchset is based on 4.2-rc1 and adds a dummy clock "clk_null"
> to be the root clock of clocks whose parents are not contained in
> CCF clock tree.
>
> In previous patch [1], it seems not suitable to declare clk_null in
> device tree because it's not a clock comes form outside of SoC. So we
> move clk_null into clock driver.

NAK.  I still do not see why we need to introduce clk_null.  Just
model the real clock tree.

Every clock listed with "clk_null" as its parent actually has a real
parent clock.
As mentioned elsewhere, it is not enough to just enable/disable a clock gate.
Clock enables/disables propagate up to parent clocks, and ensure that
parents themselves are enabled when any child is enabled, and disabled
when all of its children are disabled.
So, we must properly configure each clock's parent to ensure that its
parent will be enabled when needed, and that it can be disabled to
save power when no longer required.

Creating a bogus clk_null breaks the clock tree model, potentially
causing real issues when enabling/disabling clocks.

Please ask your hardware team to specify the real parent clock for
each of the clocks below so we can model the clock tree accurately.

In addition, these four need not be defined at all.  We can just use
their parent clocks directly.
As Sascha eloquently put it: "There's no need to model pieces of wire in CCF."

FACTOR(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk_null", 1, 1),
FACTOR(CLK_TOP_DPI, "dpi_ck", "clk_null", 1, 1),
FACTOR(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk_null", 1, 1),
FACTOR(CLK_TOP_HDMITX_DIG_CTS, "hdmitx_dig_cts", "clk_null", 1, 1),


For these "clk_null as parent" gate clocks, please specify their real
parent clock:

GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "clk_null", 15),
GATE_MM1(CLK_MM_DSI0_DIGITAL, "mm_dsi0_digital", "clk_null", 5),
GATE_MM1(CLK_MM_DSI1_DIGITAL, "mm_dsi1_digital", "clk_null", 7),
GATE_MM1(CLK_MM_DPI1_PIXEL, "mm_dpi1_pixel", "clk_null", 10),
GATE_MM1(CLK_MM_LVDS_PIXEL, "mm_lvds_pixel", "clk_null", 16),
GATE_MM1(CLK_MM_LVDS_CTS, "mm_lvds_cts", "clk_null", 17),

Thanks,
-Dan

> [1] https://lkml.org/lkml/2015/6/18/24
>
> James Liao (2):
>   clk: mediatek: Add root clocks support for Mediatek SoC.
>   clk: mediatek: Add clk_null to be the dummy root clock for MT8173
>
>  drivers/clk/mediatek/clk-mt8173.c      |  5 +++++
>  drivers/clk/mediatek/clk-mtk.c         | 23 +++++++++++++++++++++++
>  drivers/clk/mediatek/clk-mtk.h         | 17 ++++++++++++++++-
>  include/dt-bindings/clock/mt8173-clk.h |  1 +
>  4 files changed, 45 insertions(+), 1 deletion(-)
>
> --
> 1.8.1.1.dirty
