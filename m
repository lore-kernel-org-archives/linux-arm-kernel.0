From: sboyd@kernel.org (Stephen Boyd)
Date: Wed, 17 Oct 2018 08:20:15 -0700
Subject: [PATCH V4 11/11] clk: imx: add imx8qxp clk driver
In-Reply-To: <AM0PR04MB4211CA96D332FCC1ED3D547380FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-12-git-send-email-aisheng.dong@nxp.com>
 <153972593926.5275.4006811101853084389@swboyd.mtv.corp.google.com>
 <AM0PR04MB4211CA96D332FCC1ED3D547380FF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153978961553.5275.18366013902055673508@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-17 02:43:05)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd at kernel.org]
> > Sent: Wednesday, October 17, 2018 5:39 AM
> > To: A.s. Dong <aisheng.dong@nxp.com>; linux-clk at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org; mturquette at baylibre.com;
> > shawnguo at kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> > <linux-imx@nxp.com>; kernel at pengutronix.de; A.s. Dong
> > <aisheng.dong@nxp.com>
> > Subject: Re: [PATCH V4 11/11] clk: imx: add imx8qxp clk driver
> > 
> > Quoting A.s. Dong (2018-10-14 01:08:16)
> > > diff --git a/drivers/clk/imx/scu/clk-imx8qxp.c
> > > b/drivers/clk/imx/scu/clk-imx8qxp.c
> > > new file mode 100644
> > > index 0000000..958c26d
> > > --- /dev/null
> > > +++ b/drivers/clk/imx/scu/clk-imx8qxp.c
> > 
> > > +
> > > +static const char * const enet_sels[] = { "enet_25MHz",
> > > +"enet_125MHz", }; static const char * const enet0_rmii_tx_sels[] = {
> > > +"enet0_ref_div", "dummy", }; static const char * const
> > > +enet1_rmii_tx_sels[] = { "enet1_ref_div", "dummy", };
> > > +
> > > +static int imx8qxp_clk_probe(struct platform_device *pdev) {
> > > +       struct device_node *ccm_node = pdev->dev.of_node;
> > > +       struct clk_hw **clks;
> > > +       int ret;
> > > +
> > > +       ret = imx_clk_scu_init();
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       clk_data = devm_kzalloc(&pdev->dev, sizeof(*clk_data) +
> > > +                               sizeof(*clk_data->hws) *
> > IMX8QXP_CLK_END,
> > > +                               GFP_KERNEL);
> > > +       if (!clk_data)
> > > +               return -ENOMEM;
> > > +
> > > +       clk_data->num = IMX8QXP_CLK_END;
> > > +       clks = clk_data->hws;
> > > +
> > > +       /* Fixed clocks */
> > > +       clks[IMX8QXP_CLK_DUMMY]         =
> > imx_clk_hw_fixed("dummy", 0);
> > > +       clks[IMX8QXP_24MHZ]             =
> > imx_clk_hw_fixed("xtal_24MHz", 24000000);
> > > +       clks[IMX8QXP_GPT_3M]            =
> > imx_clk_hw_fixed("gpt_3m", 3000000);
> > > +       clks[IMX8QXP_32KHZ]             =
> > imx_clk_hw_fixed("xtal_32KHz", 32768);
> > > +
> 
> These are external clocks and should be put in Devicetree.

Ok, great!

> 
> > > +       /* ARM core */
> > > +       clks[IMX8QXP_A35_DIV]           =
> > imx_clk_divider_scu("a35_div", IMX_SC_R_A35, IMX_SC_PM_CLK_CPU);
> > > +
> > > +       clks[IMX8QXP_IPG_DMA_CLK_ROOT]  =
> > imx_clk_hw_fixed("ipg_dma_clk_root", 120000000);
> > > +       clks[IMX8QXP_AXI_CONN_CLK_ROOT] =
> > imx_clk_hw_fixed("axi_conn_clk_root", 333333333);
> > > +       clks[IMX8QXP_AHB_CONN_CLK_ROOT] =
> > imx_clk_hw_fixed("ahb_conn_clk_root", 166666666);
> > > +       clks[IMX8QXP_IPG_CONN_CLK_ROOT] =
> > imx_clk_hw_fixed("ipg_conn_clk_root", 83333333);
> > > +       clks[IMX8QXP_DC_AXI_EXT_CLK]    =
> > imx_clk_hw_fixed("axi_ext_dc_clk_root", 800000000);
> > > +       clks[IMX8QXP_DC_AXI_INT_CLK]    =
> > imx_clk_hw_fixed("axi_int_dc_clk_root", 400000000);
> > > +       clks[IMX8QXP_DC_CFG_CLK]        =
> > imx_clk_hw_fixed("cfg_dc_clk_root", 100000000);
> > > +       clks[IMX8QXP_MIPI_IPG_CLK]      =
> > imx_clk_hw_fixed("ipg_mipi_clk_root", 120000000);
> > > +       clks[IMX8QXP_IMG_AXI_CLK]       =
> > imx_clk_hw_fixed("axi_img_clk_root", 400000000);
> > > +       clks[IMX8QXP_IMG_IPG_CLK]       =
> > imx_clk_hw_fixed("ipg_img_clk_root", 200000000);
> > > +       clks[IMX8QXP_IMG_PXL_CLK]       =
> > imx_clk_hw_fixed("pxl_img_clk_root", 600000000);
> > > +       clks[IMX8QXP_HSIO_AXI_CLK]      =
> > imx_clk_hw_fixed("axi_hsio_clk_root", 400000000);
> > > +       clks[IMX8QXP_HSIO_PER_CLK]      =
> > imx_clk_hw_fixed("per_hsio_clk_root", 133333333);
> > 
> > Can these fixed rate clks come from DT? Or what's going on here?
> > 
> 
> Those are not external clocks.
> Do we have to put them in device tree as well?

No if they're not external clks then it's fine to keep specifying them
in this driver.

> 
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct of_device_id imx8qxp_match[] = {
> > > +       { .compatible = "fsl,imx8qxp-clk", },
> > > +       { /* sentinel */ }
> > > +};
> > > +
> > > +static struct platform_driver imx8qxp_clk_driver = {
> > > +       .driver = {
> > > +               .name = "imx8qxp-clk",
> > > +               .of_match_table = imx8qxp_match,
> > > +       },
> > > +       .probe = imx8qxp_clk_probe,
> > > +};
> > > +
> > > +static int __init imx8qxp_clk_init(void) {
> > > +       return platform_driver_register(&imx8qxp_clk_driver);
> > > +}
> > > +core_initcall(imx8qxp_clk_init);
> > > diff --git a/include/soc/imx/imx8qxp/lpcg.h
> > > b/include/soc/imx/imx8qxp/lpcg.h new file mode 100644 index
> > > 0000000..afbb5da
> > > --- /dev/null
> > > +++ b/include/soc/imx/imx8qxp/lpcg.h
> > > @@ -0,0 +1,186 @@
> > > +/* SPDX-License-Identifier: GPL-2.0+ */
> > > +/*
> > > + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> > > + * Copyright 2017~2018 NXP
> > > + *
> > > + */
> > > +
> > > +#ifndef _SC_LPCG_H
> > > +#define _SC_LPCG_H
> > > +
> > > +/*LSIO SS */
> > > +#define                PWM_0_LPCG              0x5D400000
> > 
> > Are these virtual or physical addresses? Because up above they're casted right
> > into void __iomem pointers, which makes me thing they're virtual addresses,
> > but then that would mean there's some sort of static iomap being used, but
> > I'm not aware of anything like that.
> 
> Yes, you're right. Those should be physical address and iomem cast is not necessary.
> Sorry about missing that.
> 

Ok. Thanks for fixing it.
