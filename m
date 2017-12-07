From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 7 Dec 2017 11:55:08 +0100
Subject: [PATCH v3 09/15] drm/sun4i: Add A83T support
In-Reply-To: <1729482.Mgh5nx8BIs@jernej-laptop>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
 <0f8137abb37de936db82c1251556ee84fb23c7fe.1512486553.git-series.maxime.ripard@free-electrons.com>
 <1823097.lykhZvJrH4@jernej-laptop>
 <1729482.Mgh5nx8BIs@jernej-laptop>
Message-ID: <20171207105508.ps22szj3y5pjwhdd@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Dec 06, 2017 at 05:37:47PM +0100, Jernej ?krabec wrote:
> Hi,
> 
> Dne torek, 05. december 2017 ob 16:42:55 CET je Jernej ?krabec napisal(a):
> > Hi Maxime,
> > 
> > Dne torek, 05. december 2017 ob 16:10:21 CET je Maxime Ripard napisal(a):
> > > Add support for the A83T display pipeline.
> > > 
> > > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
> > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > ---
> > > 
> > >  drivers/gpu/drm/sun4i/sun4i_drv.c   |  1 +
> > >  drivers/gpu/drm/sun4i/sun4i_tcon.c  |  5 +++++
> > >  drivers/gpu/drm/sun4i/sun8i_mixer.c |  9 +++++++++
> > >  3 files changed, 15 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > b/drivers/gpu/drm/sun4i/sun4i_drv.c index 49215d91c853..6f5e721b545e
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> > > @@ -347,6 +347,7 @@ static const struct of_device_id sun4i_drv_of_table[]
> > > =
> > > { { .compatible = "allwinner,sun6i-a31s-display-engine" },
> > > 
> > >  	{ .compatible = "allwinner,sun7i-a20-display-engine" },
> > >  	{ .compatible = "allwinner,sun8i-a33-display-engine" },
> > > 
> > > +	{ .compatible = "allwinner,sun8i-a83t-display-engine" },
> > > 
> > >  	{ .compatible = "allwinner,sun8i-v3s-display-engine" },
> > >  	{ }
> > >  
> > >  };
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 92f4738101e6..9b757450555f
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > > @@ -1132,6 +1132,10 @@ static const struct sun4i_tcon_quirks
> > > sun8i_a33_quirks = { .has_lvds_pll		= true,
> > > 
> > >  };
> > > 
> > > +static const struct sun4i_tcon_quirks sun8i_a83t_lcd_quirks = {
> > > +	/* nothing is supported */
> > > +};
> > > +
> > > 
> > >  static const struct sun4i_tcon_quirks sun8i_v3s_quirks = {
> > >  
> > >  	/* nothing is supported */
> > >  
> > >  };
> > > 
> > > @@ -1144,6 +1148,7 @@ const struct of_device_id sun4i_tcon_of_table[] = {
> > > 
> > >  	{ .compatible = "allwinner,sun6i-a31s-tcon", .data = 
> &sun6i_a31s_quirks
> > >  	},
> > > 
> > > { .compatible = "allwinner,sun7i-a20-tcon", .data = &sun7i_a20_quirks }, {
> > > .compatible = "allwinner,sun8i-a33-tcon", .data = &sun8i_a33_quirks }, +	
> {
> > > .compatible = "allwinner,sun8i-a83t-tcon-lcd", .data =
> > > &sun8i_a83t_lcd_quirks }, { .compatible = "allwinner,sun8i-v3s-tcon",
> > > .data
> > > = &sun8i_v3s_quirks }, { }
> > > 
> > >  };
> > > 
> > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index ff235e3228ce..6829bec4ba68
> > > 100644
> > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > @@ -477,6 +477,11 @@ static int sun8i_mixer_remove(struct platform_device
> > > *pdev) return 0;
> > > 
> > >  }
> > > 
> > > +static const struct sun8i_mixer_cfg sun8i_a83t_mixer_cfg = {
> > > +	.vi_num = 1,
> > > +	.ui_num = 3,
> > > +};
> > > +
> > 
> > I think you should expand that structure with:
> > .ccsc = 0,
> > .scaler_mask = 0xf,
> > .mod_rate = 150000000,
> 
> I guess you could set higher clock if CLK_SET_RATE_PARENT flag is set to de_clk 
> in A83T CCU driver. BSP sets it to 500 MHz, which is a bit high...

Actually, I didn't have to change the rate used by default, so it's
not clear what it should be on the A83T.

And yeah, I'd like to avoid setting it at 500MHz without any
particular reason. The A83T draws way to much power already without
making it worse.

I'll add the CCSC and scaler_mask fields.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171207/c02352d1/attachment.sig>
