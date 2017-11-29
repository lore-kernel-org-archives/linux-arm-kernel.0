From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 29 Nov 2017 16:55:13 +0100
Subject: [PATCH v2 05/18] drm/sun4i: Force the mixer rate at 150MHz
In-Reply-To: <2326800.o3FEWRaSfH@jernej-laptop>
References: <cover.d89f3ea4e1698f9343aef4852977c80edc75f21a.1511797218.git-series.maxime.ripard@free-electrons.com>
 <9630064.mDmGGWOQGt@jernej-laptop>
 <20171128085826.snmflonvbic5put3@flea.home>
 <2326800.o3FEWRaSfH@jernej-laptop>
Message-ID: <20171129155513.vf3i7lkticvucr3s@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 10:56:31PM +0100, Jernej ?krabec wrote:
> Hi!
> 
> Dne torek, 28. november 2017 ob 09:58:26 CET je Maxime Ripard napisal(a):
> > On Mon, Nov 27, 2017 at 05:07:04PM +0100, Jernej ?krabec wrote:
> > > Hi Maxime,
> > > 
> > > Dne ponedeljek, 27. november 2017 ob 16:41:29 CET je Maxime Ripard 
> napisal(a):
> > > > It seems like the mixer can only run properly when clocked at 150MHz. In
> > > > order to have something more robust than simply a fire-and-forget
> > > > assigned-clocks-rate, let's put that in the code.
> > > > 
> > > > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > > ---
> > > > 
> > > >  drivers/gpu/drm/sun4i/sun8i_mixer.c | 7 +++++++
> > > >  1 file changed, 7 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > b/drivers/gpu/drm/sun4i/sun8i_mixer.c index cb193c5f1686..c0cdccf772a2
> > > > 100644
> > > > --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> > > > @@ -315,6 +315,13 @@ static int sun8i_mixer_bind(struct device *dev,
> > > > struct
> > > > device *master, }
> > > > 
> > > >  	clk_prepare_enable(mixer->mod_clk);
> > > > 
> > > > +	/*
> > > > +	 * It seems that we need to enforce that rate for whatever
> > > > +	 * reason for the mixer to be functional. Make sure it's the
> > > > +	 * case.
> > > > +	 */
> > > > +	clk_set_rate(mixer->mod_clk, 150000000);
> > > > +
> > > 
> > > H3 mixer works at much higher rate and if we want to support tv out, it
> > > must be dividable by 432 MHz, so either 432 MHz or maybe even 864 MHz.
> > > 
> > > We talked about that few months ago.
> > > 
> > > I guess this should be read from mixer configuration structure.
> > 
> > That works for me. Actually, I didn't need it at all for the LVDS
> > output on the A83t, the default seems to work just fine. Do you know
> > what it's related to? Maybe we can make that a bit more dynamic?
> 
> There doesn't seem to be any rule to determine which frequency is best, except 
> on H3. Obviously, it must be high enough to process data for current 
> resolution, which means 150 MHz should be just enough for 1920x1080 at 60Hz. I 
> guess we should just check BSP configuration and use same rate since AW 
> engineers may know something we don't.

Yeah, that makes sense. And the fact that it's in the kernel allows us
to change for something smarter when we want (and if we need) to.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171129/610c59bd/attachment.sig>
