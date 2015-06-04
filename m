From: chaotian.jing@mediatek.com (Chaotian Jing)
Date: Thu, 4 Jun 2015 10:54:03 +0800
Subject: [PATCH v4 2/7] mmc: mediatek: Add Mediatek MMC driver
In-Reply-To: <20150519111558.GD6325@pengutronix.de>
References: <1432017411-2996-1-git-send-email-chaotian.jing@mediatek.com>
 <1432017411-2996-3-git-send-email-chaotian.jing@mediatek.com>
 <20150519111558.GD6325@pengutronix.de>
Message-ID: <1433386443.3304.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-05-19 at 13:15 +0200, Sascha Hauer wrote:
> On Tue, May 19, 2015 at 02:36:46PM +0800, Chaotian Jing wrote:
> > Add Mediatek MMC driver code
> > Support eMMC/SD/SDIO
> > 
> > Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> > ---
> >  drivers/mmc/host/Kconfig  |    8 +
> >  drivers/mmc/host/Makefile |    1 +
> >  drivers/mmc/host/mtk-sd.c | 1422 +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 1431 insertions(+)
> >  create mode 100644 drivers/mmc/host/mtk-sd.c
> > 
> > +
> > +	host->src_clk = devm_clk_get(&pdev->dev, "source");
> > +	if (IS_ERR(host->src_clk)) {
> > +		ret = PTR_ERR(host->src_clk);
> > +		goto host_free;
> > +	}
> > +
> > +	host->h_clk = devm_clk_get(&pdev->dev, "hclk");
> > +	if (IS_ERR(host->h_clk)) {
> > +		/* host->h_clk is optional, Only for MSDC0/3 at MT8173 */
> > +		dev_dbg(&pdev->dev,
> > +				"Invalied hclk from the device tree!\n");
> > +	}
> 
> s/Invalied/Invalid/
> 
> According to my reference manual the controller always needs a hclk. It
> seems on some controllers it is just not software controllable. If
> that's the case you should always provide a hclk to the driver and make
> this clock mandatory.
For MT8173, MSDC1, MSDC2's HCLK are in Infra, software cannot control
it. So just set the HCLK to clk_null ?

If it is, will set HCLK to clk_null at next revision, and the same
changes will make for MT8135.
> 
> Sascha
> 
