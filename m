From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 5 Nov 2018 11:11:10 +0100
Subject: [linux-sunxi] Re: [PATCH v2 02/15] clk: sunxi-ng: Add check for
 minimal rate to NKM PLLs
In-Reply-To: <e7566001-8933-adbb-4c30-7a3f66ebae4e@openedev.com>
References: <20181023155035.9101-1-jagan@amarulasolutions.com>
 <20181023155035.9101-3-jagan@amarulasolutions.com>
 <20181024180436.5n3i3z6h2yezc4cv@flea>
 <CAMty3ZC2wn-DjR+93yc-n-bAmVCHaEqR_=4XPddoo+7LjebTEg@mail.gmail.com>
 <20181029085843.3bslqwktxbp2ywk2@flea>
 <e7566001-8933-adbb-4c30-7a3f66ebae4e@openedev.com>
Message-ID: <20181105101110.agfik3oppd6ck25c@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2018 at 06:10:47PM +0530, Jagan Teki wrote:
> On 29/10/18 2:28 PM, Maxime Ripard wrote:
> > On Thu, Oct 25, 2018 at 04:25:59PM +0530, Jagan Teki wrote:
> > > On Wed, Oct 24, 2018 at 11:34 PM Maxime Ripard
> > > <maxime.ripard@bootlin.com> wrote:
> > > > 
> > > > On Tue, Oct 23, 2018 at 09:20:22PM +0530, Jagan Teki wrote:
> > > > > Some NKM PLLs doesn't work well when their output clock rate is set below
> > > > > certain rate.
> > > > > 
> > > > > So, add support for minimal rate for relevant PLLs.
> > > > > 
> > > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > > > > ---
> > > > > Changes for v2:
> > > > > - new patch
> > > > > 
> > > > >   drivers/clk/sunxi-ng/ccu_nkm.c | 7 +++++++
> > > > >   drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
> > > > >   2 files changed, 8 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> > > > > index 841840e35e61..d17539dc88dd 100644
> > > > > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> > > > > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> > > > > @@ -125,6 +125,13 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> > > > >        if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > > > >                rate *= nkm->fixed_post_div;
> > > > > 
> > > > > +     if (rate < nkm->min_rate) {
> > > > > +             rate = nkm->min_rate;
> > > > > +             if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> > > > > +                     rate /= nkm->fixed_post_div;
> > > > 
> > > > I'm not sure this is right. Is the post divider taken into account to
> > > > calculate the minimum, or is the minimum on the rate before the fixed
> > > > post divider.
> > > 
> > > Since we are returning from here, we need to take care post div which
> > > is actually doing at the end of round_rate.
> > 
> > That's not my point though. Does the rate needs to be superior to min
> > / post_div, or min?
> 
> ie what I'm trying to say, since it's common code min or max should /
> post_div and PLL_MIPI doesn't use any post_div.
> 
> We need to take care post_div though the current test (PLL_MIPI) in not used
> since it's common code. just like nkmp, nm etc.
> 
> > 
> > > > 
> > > > How did you test this?
> > > 
> > > I've not used this on PLL_MIPI atleast, so I didn't test this.
> > 
> > If you've never tested this, why are you adding that code?
> 
> Like above, it's common code. otherwise might effect.

Adding untested, unverified and unneeded code is just bloat, nothing
else.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181105/f346d14c/attachment.sig>
