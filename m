From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 19 Sep 2016 11:07:11 +0200
Subject: [PATCH 2/2] clk: imx6: initialize GPU clocks
In-Reply-To: <20160918001723.GC15478@tiger>
References: <1474017371-28966-1-git-send-email-l.stach@pengutronix.de>
 <1474017371-28966-2-git-send-email-l.stach@pengutronix.de>
 <20160918001723.GC15478@tiger>
Message-ID: <1474276031.31321.0.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, den 18.09.2016, 08:17 +0800 schrieb Shawn Guo:
> On Fri, Sep 16, 2016 at 11:16:11AM +0200, Lucas Stach wrote:
> > Initialize the GPU clock muxes to sane inputs. Until now they have
> > not been changed from their default values, which means that both
> > GPU3D shader and GPU2D core were fed by clock inputs whose rates
> > exceed the maximium allowed frequency of the cores by as much as
> > 200MHz.
> > 
> > This fixes a severe GPU stability issue on i.MX6DL.
> > 
> > Cc: stable at vger.kernel.org
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  drivers/clk/imx/clk-imx6q.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
> > index 64c243173395..751c3e7d5843 100644
> > --- a/drivers/clk/imx/clk-imx6q.c
> > +++ b/drivers/clk/imx/clk-imx6q.c
> > @@ -633,6 +633,24 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
> >  	if (IS_ENABLED(CONFIG_PCI_IMX6))
> >  		clk_set_parent(clk[IMX6QDL_CLK_LVDS1_SEL], clk[IMX6QDL_CLK_SATA_REF_100M]);
> >  
> > +	/*
> > +	 * Initialize the GPU clock muxes, so that the maximum specified clock
> > +	 * rates for the respective SoC are not exceeded.
> > +	 */
> > +	if (clk_on_imx6dl()) {
> > +		clk_set_parent(clk[IMX6QDL_CLK_GPU3D_CORE_SEL],
> > +		               clk[IMX6QDL_CLK_PLL2_PFD1_594M]);
> > +		clk_set_parent(clk[IMX6QDL_CLK_GPU2D_CORE_SEL],
> > +		               clk[IMX6QDL_CLK_PLL2_PFD1_594M]);
> > +	} else if (clk_on_imx6q()) {
> > +		clk_set_parent(clk[IMX6QDL_CLK_GPU3D_CORE_SEL],
> > +		               clk[IMX6QDL_CLK_MMDC_CH0_AXI]);
> > +		clk_set_parent(clk[IMX6QDL_CLK_GPU3D_SHADER_SEL],
> > +		               clk[IMX6QDL_CLK_PLL2_PFD1_594M]);
> > +		clk_set_parent(clk[IMX6QDL_CLK_GPU2D_CORE_SEL],
> > +		               clk[IMX6QDL_CLK_PLL3_USB_OTG]);
> > +	}
> > +
> 
> Can we handle these with assigned-clock-parents from device tree?
> 
No, we want to get rid of the GPU overclocking even with old DTs. DT
stability rules and all that...

Regards,
Lucas
