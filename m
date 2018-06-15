From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 15 Jun 2018 18:41:16 +0200
Subject: [PATCH v2 11/27] drm/sun4i: tcon: Add support for tcon-top gate
In-Reply-To: <20180615083110.laruycabvyjmesmo@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-12-jernej.skrabec@siol.net>
 <20180615083110.laruycabvyjmesmo@flea>
Message-ID: <2948115.KggauuSURZ@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Dne petek, 15. junij 2018 ob 10:31:10 CEST je Maxime Ripard napisal(a):
> Hi,
> 
> On Tue, Jun 12, 2018 at 10:00:20PM +0200, Jernej Skrabec wrote:
> > TV TCONs connected to TCON TOP have to enable additional gate in order
> > to work.
> > 
> > Add support for such TCONs.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/sun4i/sun4i_tcon.c | 11 +++++++++++
> >  drivers/gpu/drm/sun4i/sun4i_tcon.h |  4 ++++
> >  2 files changed, 15 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > b/drivers/gpu/drm/sun4i/sun4i_tcon.c index 08747fc3ee71..0afb5a94a414
> > 100644
> > --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
> > @@ -688,6 +688,16 @@ static int sun4i_tcon_init_clocks(struct device *dev,
> > 
> >  		dev_err(dev, "Couldn't get the TCON bus clock\n");
> >  		return PTR_ERR(tcon->clk);
> >  	
> >  	}
> > 
> > +
> > +	if (tcon->quirks->has_tcon_top_gate) {
> > +		tcon->top_clk = devm_clk_get(dev, "tcon-top");
> > +		if (IS_ERR(tcon->top_clk)) {
> > +			dev_err(dev, "Couldn't get the TCON TOP bus clock\n");
> > +			return PTR_ERR(tcon->top_clk);
> > +		}
> > +		clk_prepare_enable(tcon->top_clk);
> > +	}
> > +
> 
> Is it required for the TCON itself to operate, or does the TCON
> requires the TCON TOP, which in turn requires that clock to be
> functional?
> 
> I find it quite odd to have a clock that isn't meant for a particular
> device to actually be wired to another device. I'm not saying this
> isn't the case, but it would be a first.

Documentation doesn't say much about that gate. I did few tests and TCON 
registers can be read and written even if TCON TOP TV TCON gate is disabled. 
However, there is no image, as expected.

More interestingly, I enabled test pattern directly in TCON to eliminate 
influence of the mixer. As soon as I disabled that gate, test pattern on HDMI 
screen was gone, which suggest that this gate influences something inside 
TCON.

Another test I did was that I moved enable/disable gate code to 
sun4i_tcon_channel_set_status() and it worked just as well.

I'll ask AW engineer what that gate actually does, but from what I saw, I 
would say that most appropriate location to enable/disable TCON TOP TV TCON 
gate is TCON driver. Alternatively, TCON TOP driver could check if any TV TCON 
is in use and enable appropriate gate. However, that doesn't sound right to me 
for some reason.

Best regards,
Jernej
