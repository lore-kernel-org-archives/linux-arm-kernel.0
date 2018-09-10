From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 10 Sep 2018 17:28:11 +0300
Subject: [PATCH 04/10] phy: dphy: Add configuration helpers
In-Reply-To: <20180910141603.gnwpkmemevaxbi7b@flea>
References: <cover.ee6158898d563fcc01d45c9652501180bccff0f0.1536138624.git-series.maxime.ripard@bootlin.com>
 <1923627.Ifno3EcWVN@avalon> <20180910141603.gnwpkmemevaxbi7b@flea>
Message-ID: <3954754.hq6Pmoh9iE@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Monday, 10 September 2018 17:16:03 EEST Maxime Ripard wrote:
> On Fri, Sep 07, 2018 at 05:26:29PM +0300, Laurent Pinchart wrote:
> >>>> + */
> >>>> +int phy_mipi_dphy_get_default_config(unsigned long pixel_clock,
> >>>> +				     unsigned int bpp,
> >>>> +				     unsigned int lanes,
> >>>> +				     struct phy_configure_opts_mipi_dphy *cfg)
> >>>> +{
> >>>> +	unsigned long hs_clk_rate;
> >>>> +	unsigned long ui;
> >>>> +
> >>>> +	if (!cfg)
> >>>> +		return -EINVAL;
> >>> 
> >>> Should we really expect cfg to be NULL ?
> >> 
> >> It avoids a kernel panic and it's not in a hot patch, so I'd say yes?
> > 
> > A few line below you divide by the lanes parameter without checking
> > whether it is equal to 0 first, which would also cause issues.
> 
> You say that like it would be a bad thing to test for this.
> 
> > I believe that invalid values in input parameters should only be handled
> > explicitly when considered acceptable for the caller to pass such values.
> > In this case a NULL cfg pointer is a bug in the caller, which would get
> > noticed during development if the kernel panics.
> 
> In the common case, yes. In the case where that pointer is actually
> being lost by the caller somewhere down the line and you have to wait
> for a while before it happens, then having the driver inoperant
> instead of just having a panic seems like the right thing to do.

But why would it happen in the first place ? Why would the pointer be more 
likely here to be NULL than to contain, for instance, an uninitialized value, 
which we don't guard against ?

-- 
Regards,

Laurent Pinchart
