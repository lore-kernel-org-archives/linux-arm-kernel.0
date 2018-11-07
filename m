From: abel.vesa@nxp.com (Abel Vesa)
Date: Wed, 7 Nov 2018 12:09:47 +0000
Subject: [PATCH v9 5/5] clk: imx: add clock driver for i.MX8MQ CCM
In-Reply-To: <153980549223.5275.1496899374465535150@swboyd.mtv.corp.google.com>
References: <1537785597-26499-1-git-send-email-abel.vesa@nxp.com>
 <1537785597-26499-6-git-send-email-abel.vesa@nxp.com>
 <153980549223.5275.1496899374465535150@swboyd.mtv.corp.google.com>
Message-ID: <20181107120946.myvj6kaoudyi4kzf@fsr-ub1664-175>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2018 at 12:44:52PM -0700, Stephen Boyd wrote:
> Quoting Abel Vesa (2018-09-24 03:39:57)
> > From: Lucas Stach <l.stach@pengutronix.de>
> > 
> > Add driver for the Clock Control Module found on i.MX8MQ.
> > 
> > This is largely based on the downstream driver from Anson Huang and
> > Bai Ping at NXP, plus the imx composite clock from Abel Vesa at NXP,
> > with only some small adaptions to mainline from me.
> 
> Can you point to the downstream driver so we can know what small
> adaptations were made.
> 

It's was implemented originally in NXP's internal tree. The adaptations
to the initial implementation are not that small anymore. I even changed the
authorship since it has changed quite a lot compared to the initial version.

> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > ---
> >  drivers/clk/imx/Makefile     |   1 +
> >  drivers/clk/imx/clk-imx8mq.c | 602 +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/imx/clk.h        |  36 +++
> >  3 files changed, 639 insertions(+)
> >  create mode 100644 drivers/clk/imx/clk-imx8mq.c
> > 
> > diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
> > index 4fabb0a..64e695c 100644
> > --- a/drivers/clk/imx/Makefile
> > +++ b/drivers/clk/imx/Makefile
> > @@ -30,3 +30,4 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
> >  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
> >  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
> >  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> > +obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
> 
> Please try to keep this alphabetical on CONFIG symbol.
> 

Fixed in the next version.

> > diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
> > new file mode 100644
> > index 0000000..aadb523
> > --- /dev/null
> > +++ b/drivers/clk/imx/clk-imx8mq.c
> > @@ -0,0 +1,602 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2018 NXP.
> > + * Copyright (C) 2017 Pengutronix, Lucas Stach <kernel@pengutronix.de>
> > + */
> > +
> > +#include <dt-bindings/clock/imx8mq-clock.h>
> > +#include <linux/clk.h>
> > +#include <linux/clkdev.h>
> 
> Are these two includes used?
> 

clkdev.h include is removed in the next version.
clk.h is needed by of_clk_get_by_name.

> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/io.h>
> > +#include <linux/of.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/types.h>
> > +
> > +#include "clk.h"
> > +
> > +static u32 share_count_sai1;
> > +static u32 share_count_sai2;
> > +static u32 share_count_sai3;
> > +static u32 share_count_sai4;
> > +static u32 share_count_sai5;
> > +static u32 share_count_sai6;
> > +static u32 share_count_dcss;
> > +static u32 share_count_nand;
> > +
> [...]
> > +
> > +static const char *imx8mq_ecspi3_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_40m", "sys1_pll_160m",
> > +                                          "sys1_pll_800m", "sys3_pll2_out", "sys2_pll_250m", "audio_pll2_out", };
> > +static const char *imx8mq_dram_core_sels[] = {"dram_pll_out", "dram_alt_root", };
> > +
> > +static const char *imx8mq_clko2_sels[] = {"osc_25m", "sys2_pll_200m", "sys1_pll_400m", "sys2_pll_166m", "audio_pll1_out",
> > +                                        "video_pll1_out", "ckil", };
> > +
> > +static struct clk_onecell_data clk_data;
> > +
> > +static void __init imx8mq_clocks_init(struct device_node *ccm_node)
> > +{
> > +       struct device_node *np;
> > +       void __iomem *base;
> > +       int i;
> > +
> > +       clks[IMX8MQ_CLK_DUMMY] = imx_clk_fixed("dummy", 0);
> > +       clks[IMX8MQ_CLK_32K] = of_clk_get_by_name(ccm_node, "ckil");
> > +       clks[IMX8MQ_CLK_25M] = of_clk_get_by_name(ccm_node, "osc_25m");
> > +       clks[IMX8MQ_CLK_27M] = of_clk_get_by_name(ccm_node, "osc_27m");
> > +       clks[IMX8MQ_CLK_EXT1] = of_clk_get_by_name(ccm_node, "clk_ext1");
> > +       clks[IMX8MQ_CLK_EXT2] = of_clk_get_by_name(ccm_node, "clk_ext2");
> > +       clks[IMX8MQ_CLK_EXT3] = of_clk_get_by_name(ccm_node, "clk_ext3");
> > +       clks[IMX8MQ_CLK_EXT4] = of_clk_get_by_name(ccm_node, "clk_ext4");
> > +
> > +       np = of_find_compatible_node(NULL, NULL, "fsl,imx8mq-anatop");
> > +       base = of_iomap(np, 0);
> > +       WARN_ON(!base);
> 
> And if that fails? return without continuing?
> 

Fixed in the next version.

> > +
> > +       clks[IMX8MQ_ARM_PLL_REF_SEL] = imx_clk_mux("arm_pll_ref_sel", base + 0x28, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > +       clks[IMX8MQ_GPU_PLL_REF_SEL] = imx_clk_mux("gpu_pll_ref_sel", base + 0x18, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > +       clks[IMX8MQ_VPU_PLL_REF_SEL] = imx_clk_mux("vpu_pll_ref_sel", base + 0x20, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> > +       clks[IMX8MQ_AUDIO_PLL1_REF_SEL] = imx_clk_mux("audio_pll1_ref_sel", base + 0x0, 16, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
> [..]
> > +       clks[IMX8MQ_CLK_DSI_CORE] = imx_clk_composite("dsi_core", imx8mq_dsi_core_sels, base + 0xbb00);
> > +       clks[IMX8MQ_CLK_DSI_PHY_REF] = imx_clk_composite("dsi_phy_ref", imx8mq_dsi_phy_sels, base + 0xbb80);
> > +       clks[IMX8MQ_CLK_DSI_DBI] = imx_clk_composite("dsi_dbi", imx8mq_dsi_dbi_sels, base + 0xbc00);
> > +       clks[IMX8MQ_CLK_DSI_ESC] = imx_clk_composite("dsi_esc", imx8mq_dsi_esc_sels, base + 0xbc80);
> > +       clks[IMX8MQ_CLK_DSI_AHB] = imx_clk_composite("dsi_ahb", imx8mq_dsi_ahb_sels, base + 0x9200);
> > +       clks[IMX8MQ_CLK_CSI1_CORE] = imx_clk_composite("csi1_core", imx8mq_csi1_core_sels, base + 0xbd00);
> > +       clks[IMX8MQ_CLK_CSI1_PHY_REF] = imx_clk_composite("csi1_phy_ref", imx8mq_csi1_phy_sels, base + 0xbd80);
> > +       clks[IMX8MQ_CLK_CSI1_ESC] = imx_clk_composite("csi1_esc", imx8mq_csi1_esc_sels, base + 0xbe00);
> > +       clks[IMX8MQ_CLK_CSI2_CORE] = imx_clk_composite("csi2_core", imx8mq_csi2_core_sels, base + 0xbe80);
> > +       clks[IMX8MQ_CLK_CSI2_PHY_REF] = imx_clk_composite("csi2_phy_ref", imx8mq_csi2_phy_sels, base + 0xbf00);
> > +       clks[IMX8MQ_CLK_CSI2_ESC] = imx_clk_composite("csi2_esc", imx8mq_csi2_esc_sels, base + 0xbf80);
> > +       clks[IMX8MQ_CLK_PCIE2_CTRL] = imx_clk_composite("pcie2_ctrl", imx8mq_pcie2_ctrl_sels, base + 0xc000);
> > +       clks[IMX8MQ_CLK_PCIE2_PHY] = imx_clk_composite("pcie2_phy", imx8mq_pcie2_phy_sels, base + 0xc080);
> > +       clks[IMX8MQ_CLK_PCIE2_AUX] = imx_clk_composite("pcie2_aux", imx8mq_pcie2_aux_sels, base + 0xc100);
> > +       clks[IMX8MQ_CLK_ECSPI3] = imx_clk_composite("ecspi3", imx8mq_ecspi3_sels, base + 0xc180);
> > +
> > +       /*FIXME, the doc is not ready now */
> 
> What does this mean?
> 

The comment does not apply anymore. It is remoed in the next version.
When the driver was initially implemented, the specs doc was not ready.

> > +       clks[IMX8MQ_CLK_ECSPI1_ROOT] = imx_clk_gate4("ecspi1_root_clk", "ecspi1", base + 0x4070, 0);
> > +       clks[IMX8MQ_CLK_ECSPI2_ROOT] = imx_clk_gate4("ecspi2_root_clk", "ecspi2", base + 0x4080, 0);
> > +       clks[IMX8MQ_CLK_ECSPI3_ROOT] = imx_clk_gate4("ecspi3_root_clk", "ecspi3", base + 0x4090, 0);
> > +       clks[IMX8MQ_CLK_ENET1_ROOT] = imx_clk_gate4("enet1_root_clk", "enet_axi", base + 0x40a0, 0);
> > +       clks[IMX8MQ_CLK_GPT1_ROOT] = imx_clk_gate4("gpt1_root_clk", "gpt1", base + 0x4100, 0);
> [...]
> > +
> > +       clks[IMX8MQ_GPT_3M_CLK] = imx_clk_fixed_factor("gpt_3m", "osc_25m", 1, 8);
> > +       clks[IMX8MQ_CLK_DRAM_ALT_ROOT] = imx_clk_fixed_factor("dram_alt_root", "dram_alt", 1, 4);
> > +
> > +       for (i = 0; i < IMX8MQ_CLK_END; i++)
> > +               if (IS_ERR(clks[i]))
> > +                       pr_err("i.MX8mq clk %u register failed with %ld\n",
> > +                              i, PTR_ERR(clks[i]));
> > +
> > +       clk_data.clks = clks;
> > +       clk_data.clk_num = ARRAY_SIZE(clks);
> > +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> 
> Any chance to move to using clk_hw based provider and clk registration
> APIs?
> 

Since a lot of the imx clocks that are already upstream and since it's not
quite a small change, I would prefer if this would go in as is. I intend to
make the switch to clk_hw based registration later, but it will take some time
for me to get that ready and that would delay the upstream of imx8mq drivers
even more.

All the new clock types introduced now are clk_hw based.

> > +
> > +       clk_set_parent(clks[IMX8MQ_CLK_AHB], clks[IMX8MQ_SYS1_PLL_133M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_NAND_USDHC_BUS], clks[IMX8MQ_SYS1_PLL_266M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_AUDIO_AHB], clks[IMX8MQ_SYS2_PLL_500M]);
> > +
> > +       /* config video_pll1 clock */
> > +       clk_set_parent(clks[IMX8MQ_VIDEO_PLL1_REF_SEL], clks[IMX8MQ_CLK_27M]);
> > +       clk_set_rate(clks[IMX8MQ_VIDEO_PLL1], 593999999);
> > +
> > +       /* increase NOC clock to achieve best DDR access performance */
> > +       clk_set_rate(clks[IMX8MQ_CLK_NOC], clk_get_rate(clks[IMX8MQ_SYS1_PLL_800M]));
> > +
> > +       /* set pcie root's parent clk source */
> > +       clk_set_parent(clks[IMX8MQ_CLK_PCIE1_CTRL], clks[IMX8MQ_SYS2_PLL_250M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_PCIE1_PHY], clks[IMX8MQ_SYS2_PLL_100M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_PCIE2_CTRL], clks[IMX8MQ_SYS2_PLL_250M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_PCIE2_PHY], clks[IMX8MQ_SYS2_PLL_100M]);
> > +
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_CORE], clks[IMX8MQ_SYS1_PLL_266M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_PHY_REF], clks[IMX8MQ_SYS2_PLL_1000M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI1_ESC], clks[IMX8MQ_SYS1_PLL_800M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_CORE], clks[IMX8MQ_SYS1_PLL_266M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_PHY_REF], clks[IMX8MQ_SYS2_PLL_1000M]);
> > +       clk_set_parent(clks[IMX8MQ_CLK_CSI2_ESC], clks[IMX8MQ_SYS1_PLL_800M]);
> 
> Can this be done with assigned clock parents and assigned clock rates?
> 

Fair enough. Removed entirely in the next version. Each driver will set its
own rate and parent in dts later on.

> > +}
> > +
> > +CLK_OF_DECLARE(imx8mq, "fsl,imx8mq-ccm", imx8mq_clocks_init);
> 
> Can you please add a comment indicating why this can't be done with a
> platform driver, or convert this to be a platform driver?
> 

Good point. Switched to platform driver.

Thanks

-- 
