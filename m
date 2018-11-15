From: jagan@amarulasolutions.com (Jagan Teki)
Date: Thu, 15 Nov 2018 20:51:04 +0530
Subject: [PATCH v4 03/26] clk: sunxi-ng: Add check for maximum rate to NKM
 PLLs
In-Reply-To: <20181113132658.niwy6bqdqzaeqpv2@flea>
References: <20181113111633.20189-1-jagan@amarulasolutions.com>
 <20181113111633.20189-4-jagan@amarulasolutions.com>
 <20181113132658.niwy6bqdqzaeqpv2@flea>
Message-ID: <CAMty3ZBTaeMBFYwyJ+8HqHBDAfEOPEYBt01jho1H4c3SBKbvEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 13, 2018 at 6:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Tue, Nov 13, 2018 at 04:46:10PM +0530, Jagan Teki wrote:
> > Some NKM PLLs, frequency can be set above PLL working range.
> >
> > Add a constraint for maximum supported rate. This way, drivers can
> > specify which is maximum allowed rate for PLL.
> >
> > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > Acked-by: Stephen Boyd <sboyd@kernel.org>
>
> As Vasily reported on a previous version, this should be squashed with
> the patch 2.

Sorry, I missed it.

>
> > ---
> >  drivers/clk/sunxi-ng/ccu_nkm.c | 3 +++
> >  drivers/clk/sunxi-ng/ccu_nkm.h | 1 +
> >  2 files changed, 4 insertions(+)
> >
> > diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> > index 6b5ad990f802..b8b66cdd30bf 100644
> > --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> > +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> > @@ -128,6 +128,9 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
> >       if (rate < nkm->min_rate)
> >               return nkm->min_rate;
> >
> > +     if (nkm->max_rate && rate > nkm->max_rate)
> > +             return nkm->max_rate;
> > +
>
> I would expect the test to be the same for the minimum and maximum cases.

I don't have proper use-case for max rate test, I do verify by using
higher the rate on dclock, but nor sure.  May be I can skip the
max_rate patch?

Apart from this, any idea about this issue where SUN4I_TCON0_DCLK_REG
will only work with div upto 6 on A64 DSI panels[1], did you find the
same issue on A33?

With parent rate 330MHz, the resulting tcon divider for 30MHz [2]
clock is 11 and for the same for 55MHz [3] clock is 6.

[3] https://paste.ubuntu.com/p/drvzfHFMtY/
[2] https://paste.ubuntu.com/p/hz29CTJY2J/
[1] https://elixir.bootlin.com/linux/v4.20-rc2/source/drivers/gpu/drm/sun4i/sun4i_dotclock.c#L125
