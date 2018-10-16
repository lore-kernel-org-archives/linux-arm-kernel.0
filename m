From: sboyd@kernel.org (Stephen Boyd)
Date: Tue, 16 Oct 2018 14:38:59 -0700
Subject: [PATCH V4 11/11] clk: imx: add imx8qxp clk driver
In-Reply-To: <1539504194-28289-12-git-send-email-aisheng.dong@nxp.com>
References: <1539504194-28289-1-git-send-email-aisheng.dong@nxp.com>
 <1539504194-28289-12-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153972593926.5275.4006811101853084389@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-14 01:08:16)
> diff --git a/drivers/clk/imx/scu/clk-imx8qxp.c b/drivers/clk/imx/scu/clk-imx8qxp.c
> new file mode 100644
> index 0000000..958c26d
> --- /dev/null
> +++ b/drivers/clk/imx/scu/clk-imx8qxp.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP
> + *     Dong Aisheng <aisheng.dong@nxp.com>
> + */
> +
> +#include <dt-bindings/clock/imx8qxp-clock.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +#include <soc/imx/imx8qxp/lpcg.h>
> +
> +#include "clk-scu.h"
> +
> +static struct clk_hw_onecell_data *clk_data;

Please give this static global variable a more unique name as opposed to
'clk_data'.


> +
> +static const char * const enet_sels[] = { "enet_25MHz", "enet_125MHz", };
> +static const char * const enet0_rmii_tx_sels[] = { "enet0_ref_div", "dummy", };
> +static const char * const enet1_rmii_tx_sels[] = { "enet1_ref_div", "dummy", };
> +
> +static int imx8qxp_clk_probe(struct platform_device *pdev)
> +{
> +       struct device_node *ccm_node = pdev->dev.of_node;
> +       struct clk_hw **clks;
> +       int ret;
> +
> +       ret = imx_clk_scu_init();
> +       if (ret)
> +               return ret;
> +
> +       clk_data = devm_kzalloc(&pdev->dev, sizeof(*clk_data) +
> +                               sizeof(*clk_data->hws) * IMX8QXP_CLK_END,
> +                               GFP_KERNEL);
> +       if (!clk_data)
> +               return -ENOMEM;
> +
> +       clk_data->num = IMX8QXP_CLK_END;
> +       clks = clk_data->hws;
> +
> +       /* Fixed clocks */
> +       clks[IMX8QXP_CLK_DUMMY]         = imx_clk_hw_fixed("dummy", 0);
> +       clks[IMX8QXP_24MHZ]             = imx_clk_hw_fixed("xtal_24MHz", 24000000);
> +       clks[IMX8QXP_GPT_3M]            = imx_clk_hw_fixed("gpt_3m", 3000000);
> +       clks[IMX8QXP_32KHZ]             = imx_clk_hw_fixed("xtal_32KHz", 32768);
> +
> +       /* ARM core */
> +       clks[IMX8QXP_A35_DIV]           = imx_clk_divider_scu("a35_div", IMX_SC_R_A35, IMX_SC_PM_CLK_CPU);
> +
> +       clks[IMX8QXP_IPG_DMA_CLK_ROOT]  = imx_clk_hw_fixed("ipg_dma_clk_root", 120000000);
> +       clks[IMX8QXP_AXI_CONN_CLK_ROOT] = imx_clk_hw_fixed("axi_conn_clk_root", 333333333);
> +       clks[IMX8QXP_AHB_CONN_CLK_ROOT] = imx_clk_hw_fixed("ahb_conn_clk_root", 166666666);
> +       clks[IMX8QXP_IPG_CONN_CLK_ROOT] = imx_clk_hw_fixed("ipg_conn_clk_root", 83333333);
> +       clks[IMX8QXP_DC_AXI_EXT_CLK]    = imx_clk_hw_fixed("axi_ext_dc_clk_root", 800000000);
> +       clks[IMX8QXP_DC_AXI_INT_CLK]    = imx_clk_hw_fixed("axi_int_dc_clk_root", 400000000);
> +       clks[IMX8QXP_DC_CFG_CLK]        = imx_clk_hw_fixed("cfg_dc_clk_root", 100000000);
> +       clks[IMX8QXP_MIPI_IPG_CLK]      = imx_clk_hw_fixed("ipg_mipi_clk_root", 120000000);
> +       clks[IMX8QXP_IMG_AXI_CLK]       = imx_clk_hw_fixed("axi_img_clk_root", 400000000);
> +       clks[IMX8QXP_IMG_IPG_CLK]       = imx_clk_hw_fixed("ipg_img_clk_root", 200000000);
> +       clks[IMX8QXP_IMG_PXL_CLK]       = imx_clk_hw_fixed("pxl_img_clk_root", 600000000);
> +       clks[IMX8QXP_HSIO_AXI_CLK]      = imx_clk_hw_fixed("axi_hsio_clk_root", 400000000);
> +       clks[IMX8QXP_HSIO_PER_CLK]      = imx_clk_hw_fixed("per_hsio_clk_root", 133333333);

Can these fixed rate clks come from DT? Or what's going on here?

> +
> +       clks[IMX8QXP_UART0_DIV]         = imx_clk_divider_scu("uart0_div", IMX_SC_R_UART_0, IMX_SC_PM_CLK_PER);
> +       clks[IMX8QXP_UART0_IPG_CLK]     = imx_clk_gate2_scu("uart0_ipg_clk", "ipg_dma_clk_root", (void __iomem *)(LPUART_0_LPCG), 16, 0);
> +       clks[IMX8QXP_UART0_CLK]         = imx_clk_gate_scu("uart0_clk", "uart0_div", IMX_SC_R_UART_0, IMX_SC_PM_CLK_PER, (void __iomem *)(LPUART_0_LPCG), 0, 0);
> +
[...]
> +       clks[IMX8QXP_IMG_PDMA_2_CLK]            = imx_clk_gate2_scu("img_pdma2_clk", "pxl_img_clk_root", (void __iomem *)(IMG_PDMA_2_LPCG), 0, 0);
> +       clks[IMX8QXP_IMG_PDMA_3_CLK]            = imx_clk_gate2_scu("img_pdma3_clk", "pxl_img_clk_root", (void __iomem *)(IMG_PDMA_3_LPCG), 0, 0);
> +       clks[IMX8QXP_IMG_PDMA_4_CLK]            = imx_clk_gate2_scu("img_pdma4_clk", "pxl_img_clk_root", (void __iomem *)(IMG_PDMA_4_LPCG), 0, 0);
> +       clks[IMX8QXP_IMG_PDMA_5_CLK]            = imx_clk_gate2_scu("img_pdma5_clk", "pxl_img_clk_root", (void __iomem *)(IMG_PDMA_5_LPCG), 0, 0);
> +       clks[IMX8QXP_IMG_PDMA_6_CLK]            = imx_clk_gate2_scu("img_pdma6_clk", "pxl_img_clk_root", (void __iomem *)(IMG_PDMA_6_LPCG), 0, 0);
> +       clks[IMX8QXP_IMG_PDMA_7_CLK]            = imx_clk_gate2_scu("img_pdma7_clk", "pxl_img_clk_root", (void __iomem *)(IMG_PDMA_7_LPCG), 0, 0);

All the casts in here shouldn't be necessary, see below.

> +
> +       /* MIPI CSI SS */
> +       clks[IMX8QXP_CSI0_I2C0_DIV]     = imx_clk_divider_scu("mipi_csi0_i2c0_div", IMX_SC_R_CSI_0_I2C_0, IMX_SC_PM_CLK_PER);
> +       clks[IMX8QXP_CSI0_PWM0_DIV]     = imx_clk_divider_scu("mipi_csi0_pwm0_div", IMX_SC_R_CSI_0_PWM_0, IMX_SC_PM_CLK_PER);
> +       clks[IMX8QXP_CSI0_CORE_DIV]     = imx_clk_divider_scu("mipi_csi0_core_div", IMX_SC_R_CSI_0, IMX_SC_PM_CLK_PER);
> +       clks[IMX8QXP_CSI0_ESC_DIV]      = imx_clk_divider_scu("mipi_csi0_esc_div", IMX_SC_R_CSI_0, IMX_SC_PM_CLK_MISC);
> +       clks[IMX8QXP_CSI0_IPG_CLK_S]    = imx_clk_gate2_scu("mipi_csi0_ipg_s", "ipg_mipi_csi_clk_root", (void __iomem *)(MIPI_CSI_0_LPCG + 0x8), 16, 0);
> +       clks[IMX8QXP_CSI0_IPG_CLK]      = imx_clk_gate2_scu("mipi_csi0_ipg", "mipi_csi0_ipg_s", (void __iomem *)(MIPI_CSI_0_LPCG), 16, 0);
> +       clks[IMX8QXP_CSI0_APB_CLK]      = imx_clk_gate2_scu("mipi_csi0_apb_clk", "ipg_mipi_csi_clk_root", (void __iomem *)(MIPI_CSI_0_LPCG + 0x4), 16,  0);
> +       clks[IMX8QXP_CSI0_I2C0_IPG_CLK] = imx_clk_gate2_scu("mipi_csi0_i2c0_ipg_s", "ipg_mipi_csi_clk_root", (void __iomem *)(MIPI_CSI_0_LPCG + 0x14), 16, 0);
> +       clks[IMX8QXP_CSI0_I2C0_CLK]     = imx_clk_gate_scu("mipi_csi0_i2c0_clk", "mipi_csi0_i2c0_div", IMX_SC_R_CSI_0_I2C_0, IMX_SC_PM_CLK_PER, (void __iomem *)(MIPI_CSI_0_LPCG + 0x14), 0, 0);
> +       clks[IMX8QXP_CSI0_PWM0_IPG_CLK] = imx_clk_gate2_scu("mipi_csi0_pwm0_ipg_s", "ipg_mipi_csi_clk_root", (void __iomem *)(MIPI_CSI_0_LPCG + 0x10), 16, 0);
> +       clks[IMX8QXP_CSI0_PWM0_CLK]     = imx_clk_gate_scu("mipi_csi0_pwm0_clk", "mipi_csi0_pwm0_div", IMX_SC_R_CSI_0_PWM_0, IMX_SC_PM_CLK_PER, (void __iomem *)(MIPI_CSI_0_LPCG + 0x10), 0, 0);
> +       clks[IMX8QXP_CSI0_CORE_CLK]     = imx_clk_gate_scu("mipi_csi0_core_clk", "mipi_csi0_core_div", IMX_SC_R_CSI_0, IMX_SC_PM_CLK_PER, (void __iomem *)(MIPI_CSI_0_LPCG + 0x18), 16, 0);
> +       clks[IMX8QXP_CSI0_ESC_CLK]      = imx_clk_gate_scu("mipi_csi0_esc_clk", "mipi_csi0_esc_div", IMX_SC_R_CSI_0, IMX_SC_PM_CLK_MISC, (void __iomem *)(MIPI_CSI_0_LPCG + 0x1C), 16, 0);
> +
> +       /* HSIO SS */
> +       clks[IMX8QXP_HSIO_PCIE_MSTR_AXI_CLK]    = imx_clk_gate2_scu("hsio_pcie_mstr_axi_clk", "axi_hsio_clk_root", (void __iomem *)(HSIO_PCIE_X1_LPCG), 16, 0);
> +       clks[IMX8QXP_HSIO_PCIE_SLV_AXI_CLK]     = imx_clk_gate2_scu("hsio_pcie_slv_axi_clk", "axi_hsio_clk_root", (void __iomem *)(HSIO_PCIE_X1_LPCG), 20, 0);
> +       clks[IMX8QXP_HSIO_PCIE_DBI_AXI_CLK]     = imx_clk_gate2_scu("hsio_pcie_dbi_axi_clk", "axi_hsio_clk_root", (void __iomem *)(HSIO_PCIE_X1_LPCG), 24, 0);
> +       clks[IMX8QXP_HSIO_PCIE_X1_PER_CLK]      = imx_clk_gate2_scu("hsio_pcie_x1_per_clk", "per_hsio_clk_root", (void __iomem *)(HSIO_PCIE_X1_CRR3_LPCG), 16, 0);
> +       clks[IMX8QXP_HSIO_PHY_X1_PER_CLK]       = imx_clk_gate2_scu("hsio_phy_x1_per_clk", "per_hsio_clk_root", (void __iomem *)(HSIO_PHY_X1_CRR1_LPCG), 16, 0);
> +       clks[IMX8QXP_HSIO_MISC_PER_CLK]         = imx_clk_gate2_scu("hsio_misc_per_clk", "per_hsio_clk_root", (void __iomem *)(HSIO_MISC_LPCG), 16, 0);
> +       clks[IMX8QXP_HSIO_PHY_X1_APB_CLK]       = imx_clk_gate2_scu("hsio_phy_x1_apb_clk", "per_hsio_clk_root", (void __iomem *)(HSIO_PHY_X1_LPCG), 16, 0);
> +       clks[IMX8QXP_HSIO_GPIO_CLK]             = imx_clk_gate2_scu("hsio_gpio_clk", "per_hsio_clk_root", (void __iomem *)(HSIO_GPIO_LPCG), 16, 0);
> +       clks[IMX8QXP_HSIO_PHY_X1_PCLK]          = imx_clk_gate2_scu("hsio_phy_x1_pclk", "dummy", (void __iomem *)(HSIO_PHY_X1_LPCG), 0, 0);
> +
> +       imx_check_clk_hws(clks, clk_data->num);
> +
> +       of_clk_add_hw_provider(ccm_node, of_clk_hw_onecell_get, clk_data);
> +
> +       pr_info("i.MX8QXP clock tree init done.\n");

Please no "I'm alive!" messages.

> +
> +       return 0;
> +}
> +
> +static const struct of_device_id imx8qxp_match[] = {
> +       { .compatible = "fsl,imx8qxp-clk", },
> +       { /* sentinel */ }
> +};
> +
> +static struct platform_driver imx8qxp_clk_driver = {
> +       .driver = {
> +               .name = "imx8qxp-clk",
> +               .of_match_table = imx8qxp_match,
> +       },
> +       .probe = imx8qxp_clk_probe,
> +};
> +
> +static int __init imx8qxp_clk_init(void)
> +{
> +       return platform_driver_register(&imx8qxp_clk_driver);
> +}
> +core_initcall(imx8qxp_clk_init);
> diff --git a/include/soc/imx/imx8qxp/lpcg.h b/include/soc/imx/imx8qxp/lpcg.h
> new file mode 100644
> index 0000000..afbb5da
> --- /dev/null
> +++ b/include/soc/imx/imx8qxp/lpcg.h
> @@ -0,0 +1,186 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright (C) 2016 Freescale Semiconductor, Inc.
> + * Copyright 2017~2018 NXP
> + *
> + */
> +
> +#ifndef _SC_LPCG_H
> +#define _SC_LPCG_H
> +
> +/*LSIO SS */
> +#define                PWM_0_LPCG              0x5D400000

Are these virtual or physical addresses? Because up above they're casted
right into void __iomem pointers, which makes me thing they're virtual
addresses, but then that would mean there's some sort of static iomap
being used, but I'm not aware of anything like that.
