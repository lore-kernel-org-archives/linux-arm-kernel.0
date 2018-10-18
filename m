From: sboyd@kernel.org (Stephen Boyd)
Date: Thu, 18 Oct 2018 13:46:09 -0700
Subject: [PATCH V5 9/9] clk: imx: add imx8qxp clk driver
In-Reply-To: <AM0PR04MB42112CB1324B0994A26AB15D80F80@AM0PR04MB4211.eurprd04.prod.outlook.com>
References: <1539881347-20871-1-git-send-email-aisheng.dong@nxp.com>
 <1539881347-20871-10-git-send-email-aisheng.dong@nxp.com>
 <153988429912.5275.13469659599335212731@swboyd.mtv.corp.google.com>
 <AM0PR04MB42112CB1324B0994A26AB15D80F80@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <153989556955.53599.9032716427049619310@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting A.s. Dong (2018-10-18 11:13:39)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd at kernel.org]
> > Sent: Friday, October 19, 2018 1:38 AM
> > To: A.s. Dong <aisheng.dong@nxp.com>; linux-clk at vger.kernel.org
> > Cc: linux-arm-kernel at lists.infradead.org; mturquette at baylibre.com;
> > shawnguo at kernel.org; Fabio Estevam <fabio.estevam@nxp.com>; dl-linux-imx
> > <linux-imx@nxp.com>; kernel at pengutronix.de; A.s. Dong
> > <aisheng.dong@nxp.com>
> > Subject: Re: [PATCH V5 9/9] clk: imx: add imx8qxp clk driver
> > 
> > Quoting A.s. Dong (2018-10-18 09:54:15)
> > > +
> > > +#include <dt-bindings/clock/imx8qxp-clock.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/err.h>
> > > +#include <linux/io.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include <soc/imx/imx8qxp/lpcg.h>
> > > +
> > > +#include "clk-scu.h"
> > > +
> > > +static struct clk_hw_onecell_data *imx8qxp_clk_data;
> > > +
> > > +static const char * const enet_sels[] = { "enet_25MHz",
> > > +"enet_125MHz", }; static const char * const enet0_rmii_tx_sels[] = {
> > > +"enet0_ref_div", "dummy", }; static const char * const
> > > +enet1_rmii_tx_sels[] = { "enet1_ref_div", "dummy", };
> > > +
> > > +static int imx8qxp_clk_probe(struct platform_device *pdev) {
> > > +       struct device_node *ccm_node = pdev->dev.of_node;
> > 
> > Where's the DT binding for this device?
> 
> Sorry for missed to mention this.
> It's been merged into scu binding doc per Rob's request which has already
> been in Shawn's tree.
> 
> Please take a look at here:
> https://patchwork.kernel.org/patch/10629623/
> 

Ok I ask because it's odd to hardcode physical addresses in a clk driver
when those should come from DT in reg properties. Was Rob aware that
this clk node was combining I/O memory and message passing?
