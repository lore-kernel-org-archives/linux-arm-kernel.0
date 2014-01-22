From: b20788@freescale.com (Anson Huang)
Date: Wed, 22 Jan 2014 15:16:13 +0800
Subject: [PATCH V2] ARM: imx: correct usecount of IPG, ARM and MMDC clk
 on i.mx6sl
In-Reply-To: <20140122064740.GB16215@pengutronix.de>
References: <1390301452-10143-1-git-send-email-b20788@freescale.com>
 <20140122064740.GB16215@pengutronix.de>
Message-ID: <20140122071613.GA22213@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 07:47:40AM +0100, Sascha Hauer wrote:
> On Tue, Jan 21, 2014 at 06:50:52PM +0800, Anson Huang wrote:
> > IPG, ARM and MMDC's clock should be enabled during kernel boot up,
> > so we need to maintain their use count, otherwise, they may be
> > disabled unexpectedly if their children's clock are turned off,
> > which is not allowed.
> > 
> > Signed-off-by: Anson Huang <b20788@freescale.com>
> > ---
> >  arch/arm/mach-imx/clk-imx6sl.c |   16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm/mach-imx/clk-imx6sl.c b/arch/arm/mach-imx/clk-imx6sl.c
> > index 78f3bd6..047f4ff 100644
> > --- a/arch/arm/mach-imx/clk-imx6sl.c
> > +++ b/arch/arm/mach-imx/clk-imx6sl.c
> > @@ -291,6 +291,22 @@ static void __init imx6sl_clocks_init(struct device_node *ccm_node)
> >  		pr_warn("%s: failed to set AHB clock rate %d!\n",
> >  			__func__, ret);
> >  
> > +	/*
> > +	 * Make sure those always on clocks are enabled to maintain the correct
> > +	 * usecount and enabling/disabling of parent PLLs.
> > +	 */
> > +	ret = clk_prepare_enable(clks[IMX6SL_CLK_IPG]);
> > +	if (ret)
> > +		pr_warn("%s: failed to enable IPG clock %d\n", __func__, ret);
> > +
> > +	ret = clk_prepare_enable(clks[IMX6SL_CLK_ARM]);
> > +	if (ret)
> > +		pr_warn("%s: failed to enable ARM clock %d\n", __func__, ret);
> > +
> > +	ret = clk_prepare_enable(clks[IMX6SL_CLK_MMDC_ROOT]);
> > +	if (ret)
> > +		pr_warn("%s: failed to enable MMDC clock %d\n", __func__, ret);
> > +
> 
> Consider using a clk_init_on array like we have in clk-imx6q.c
> 
> Sascha
> 

Right, that can make code more clean, thanks for the comment, please help review V3 patch.

Anson.
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> 
