From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 6 Feb 2015 11:30:33 +0100
Subject: [PATCH v4 0/7] clk: Add common clock support for Mediatek MT8135
 and MT8173.
In-Reply-To: <CABuKBeJSH3WzG3QC=9OoPzXE6fd9W2U67V4c19NzWcPxWR7VDg@mail.gmail.com>
References: <1422594798-13375-1-git-send-email-henryc.chen@mediatek.com>
 <CABuKBeJSH3WzG3QC=9OoPzXE6fd9W2U67V4c19NzWcPxWR7VDg@mail.gmail.com>
Message-ID: <20150206103033.GS18908@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 05, 2015 at 06:24:54PM +0100, Matthias Brugger wrote:
> Hi Henry,
> 
> 2015-01-30 6:13 GMT+01:00 Henry Chen <henryc.chen@mediatek.com>:
> > This patchset contains the initial common clock support for Mediatek SoCs.
> > Mediatek SoC's clock architecture comprises of various PLLs, dividers, muxes and clock gates.
> >
> > This patchset also contains a basic clock support for Mediatek MT8135 and MT8173.
> >
> > This driver is based on 3.19-rc1 + MT8135 and MT8173 basic support.
> >
> > Changes in v2:
> > - Re-ordered patchset. Fold include/dt-bindings and DT document in 1st patch.
> >
> > Changes in v3:
> > - Rebase to 3.19-rc1.
> > - Refine code. Remove unneed functions, debug logs and comments, and fine tune error logs.
> >
> > Changes in v4:
> > - Support MT8173 platform.
> > - Re-ordered patchset. driver/clk/Makefile in 2nd patch.
> > - Extract the common part definition(mtk_gate/mtk_pll/mtk_mux) from clk-mt8135.c/clk-mt8173.c to clk-mtk.c.
> > - Refine code. Rmove unnessacary debug information and unsed defines, add prefix "mtk_" for static functions.
> > - Remove flag CLK_IGNORE_UNUSED and set flag CLK_SET_RATE_PARENT on gate/mux/fixed-factor.
> > - Use spin_lock_irqsave(&clk_ops_lock, flags) instead of mtk_clk_lock.
> > - Example above include a node for the clock controller itself, followed by the i2c controller example above.
> 
> You use pericfg and infracfg which will be used by other drivers as
> well. So please use syscon for this driver. As it is no longer a
> platform device it is present early in boot.
> The changes should look something like the patch beneath. Please
> beware that it does only show the general concept and may not even
> compile. I asked Sascha to implement the reset controller as part of
> the clk driver, as the registers addresses are mixed between both,
> clock and reset controller. Please coordinate with him to get them
> integrated (even as one series or as incremental series).

I don't really understand the "as part of the clk driver part". I now
have replaced the devm_regmap_init_mmio with syscon_node_to_regmap
in the pericfg / infracfg drivers. Is that all that you want or do you
want me to move the source code to drivers/clk/mediatek?

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
