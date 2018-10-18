From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 18 Oct 2018 10:38:19 -0700
Subject: [PATCH V5 9/9] clk: imx: add imx8qxp clk driver
In-Reply-To: <1539881347-20871-10-git-send-email-aisheng.dong@nxp.com>
References: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
 <1539881347-20871-10-git-send-email-aisheng.dong@nxp.com>
Message-ID: <153988429912.5275.13469659599335212731@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-18 09:54:15)
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
> +static struct clk_hw_onecell_data *imx8qxp_clk_data;
> +
> +static const char * const enet_sels[] = { "enet_25MHz", "enet_125MHz", };
> +static const char * const enet0_rmii_tx_sels[] = { "enet0_ref_div", "dummy", };
> +static const char * const enet1_rmii_tx_sels[] = { "enet1_ref_div", "dummy", };
> +
> +static int imx8qxp_clk_probe(struct platform_device *pdev)
> +{
> +       struct device_node *ccm_node = pdev->dev.of_node;

Where's the DT binding for this device?

> +       struct clk_hw **clks;
> +       int ret, i;
> +
> +       ret = imx_clk_scu_init();
