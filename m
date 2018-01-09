From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Tue, 09 Jan 2018 16:54:34 +0100
Subject: [linux-sunxi] Re: [PATCH 01/11] clk: sunxi-ng: Don't set k if
 width is 0 for nkmp plls
In-Reply-To: <CAGb2v6463B-JVw5A9C39iiuo7Xzj3Bq06m6VzdAUqr0b-S91MQ@mail.gmail.com>
References: <20171230210203.24115-1-jernej.skrabec@siol.net>
 <3625461.aU9oqMdpo3@jernej-laptop>
 <CAGb2v6463B-JVw5A9C39iiuo7Xzj3Bq06m6VzdAUqr0b-S91MQ@mail.gmail.com>
Message-ID: <1542502.H6M8hg3JYZ@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chen-Yu,

Dne ponedeljek, 08. januar 2018 ob 10:19:47 CET je Chen-Yu Tsai napisal(a):
> On Fri, Jan 5, 2018 at 3:28 AM, Jernej ?krabec <jernej.skrabec@siol.net> 
wrote:
> > Hi,
> > 
> > Dne ?etrtek, 04. januar 2018 ob 15:45:18 CET je Chen-Yu Tsai napisal(a):
> >> On Sun, Dec 31, 2017 at 5:01 AM, Jernej Skrabec <jernej.skrabec@siol.net>
> > 
> > wrote:
> >> > For example, A83T have nmp plls which are modelled as nkmp plls. Since
> >> > k
> >> > is not specified, it has offset 0, shift 0 and lowest value 1. This
> >> > means that LSB bit is always set to 1, which may change clock rate.
> >> > 
> >> > Fix that by applying k factor only if k width is greater than 0.
> >> > 
> >> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> >> > ---
> >> > 
> >> >  drivers/clk/sunxi-ng/ccu_nkmp.c | 21 +++++++++++++--------
> >> >  1 file changed, 13 insertions(+), 8 deletions(-)
> >> > 
> >> > diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c
> >> > b/drivers/clk/sunxi-ng/ccu_nkmp.c index e58c95787f94..709f528af2b3
> >> > 100644
> >> > --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> >> > +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> >> > @@ -81,7 +81,7 @@ static unsigned long ccu_nkmp_recalc_rate(struct
> >> > clk_hw
> >> > *hw,>
> >> > 
> >> >                                         unsigned long parent_rate)
> >> >  
> >> >  {
> >> >  
> >> >         struct ccu_nkmp *nkmp = hw_to_ccu_nkmp(hw);
> >> > 
> >> > -       unsigned long n, m, k, p;
> >> > +       unsigned long n, m, k = 1, p;
> >> > 
> >> >         u32 reg;
> >> >         
> >> >         reg = readl(nkmp->common.base + nkmp->common.reg);
> >> > 
> >> > @@ -92,11 +92,13 @@ static unsigned long ccu_nkmp_recalc_rate(struct
> >> > clk_hw *hw,>
> >> > 
> >> >         if (!n)
> >> >         
> >> >                 n++;
> >> > 
> >> > -       k = reg >> nkmp->k.shift;
> >> > -       k &= (1 << nkmp->k.width) - 1;
> >> > -       k += nkmp->k.offset;
> >> > -       if (!k)
> >> > -               k++;
> >> > +       if (nkmp->k.width) {
> >> > +               k = reg >> nkmp->k.shift;
> >> > +               k &= (1 << nkmp->k.width) - 1;
> >> > +               k += nkmp->k.offset;
> >> > +               if (!k)
> >> > +                       k++;
> >> > +       }
> >> 
> >> The conditional shouldn't be necessary. With nkmp->k.width = 0,
> >> you'd simply get k & 0, which is 0, which then gets bumped up to 1,
> >> unless k.offset > 1, which would be a bug.
> >> 
> >> >         m = reg >> nkmp->m.shift;
> >> >         m &= (1 << nkmp->m.width) - 1;
> >> > 
> >> > @@ -153,12 +155,15 @@ static int ccu_nkmp_set_rate(struct clk_hw *hw,
> >> > unsigned long rate,>
> >> > 
> >> >         reg = readl(nkmp->common.base + nkmp->common.reg);
> >> >         reg &= ~GENMASK(nkmp->n.width + nkmp->n.shift - 1,
> >> >         nkmp->n.shift);
> >> > 
> >> > -       reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1,
> >> > nkmp->k.shift);
> >> > +       if (nkmp->k.width)
> >> > +               reg &= ~GENMASK(nkmp->k.width + nkmp->k.shift - 1,
> >> > +                               nkmp->k.shift);
> >> > 
> >> >         reg &= ~GENMASK(nkmp->m.width + nkmp->m.shift - 1,
> >> >         nkmp->m.shift);
> >> >         reg &= ~GENMASK(nkmp->p.width + nkmp->p.shift - 1,
> >> >         nkmp->p.shift);
> >> >         
> >> >         reg |= (_nkmp.n - nkmp->n.offset) << nkmp->n.shift;
> >> > 
> >> > -       reg |= (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;
> >> > +       if (nkmp->k.width)
> >> > +               reg |= (_nkmp.k - nkmp->k.offset) << nkmp->k.shift;
> >> 
> >> I think a better way would be
> >> 
> >>         reg |= ((_nkmp.k - nkmp->k.offset) << nkmp->k.shift) &
> >>         
> >>                GENMASK(nkmp->k.width + nkmp->k.shift - 1, nkmp->k.shift);
> >> 
> >> And do this for all the factors, not just k. This pattern is what
> >> regmap_update_bits does, which seems much safer. I wonder what
> >> GENMASK() with a negative value would do though...
> > 
> > You're right, GENMASK(-1, 0) equals 0 (calculated by hand, not tested).
> > This seems much more elegant solution.
> > 
> > Semi-related question: All nmp PLLs have much wider N range than real nkmp
> > PLLs. This causes integer overflow when using nkmp formula from datasheet.
> > Usually, N is 1-256 for nmp PLLs, which means that for very high N
> > factors, it overflows. This also causes issue that M factor is never
> > higher than 1.
> Sounds like we can't use u8 for storing the factors. At least the
> intermediate values we use to calculate the rates.

Only issue with u8 could be max field in struct ccu_mult_internal for K factor. 
But since it's not used, there is no issue. All intermediate variables in 
ccu_nkmp are wider.

> 
> > I was wondering, if patch would be acceptable which would change this
> > formula:
> > 
> > RATE = (24MHz * N * K) / (M * P)
> > 
> > to this:
> > 
> > RATE ((24MHz / M) * N * K) / P
> > 
> > I checked all M factors and are all in 1-4 or 1-2 range, which means it
> > wouldn't have any impact for real nkmp PLLs when parent is 24 MHz clock
> > which is probably always.
> > 
> > What do you think?
> 
> I think this is acceptable. M is normally the pre-divider, so this
> actually fits how the hardware works, including possible rounding
> errors.

Ok, I'll add a patch for that in v2.

Best regards,
Jernej

> 
> ChenYu
> 
> > I discovered that when I tried to set A83T PLL_VIDEO to 346.5 MHz which is
> > possible only when above formula is changed.
> > 
> > Best regards,
> > Jernej
> > 
> >> ChenYu
> >> 
> >> >         reg |= (_nkmp.m - nkmp->m.offset) << nkmp->m.shift;
> >> >         reg |= ilog2(_nkmp.p) << nkmp->p.shift;
> >> > 
> >> > --
> >> > 2.15.1
> > 
> > --
> > You received this message because you are subscribed to the Google Groups
> > "linux-sunxi" group. To unsubscribe from this group and stop receiving
> > emails from it, send an email to
> > linux-sunxi+unsubscribe at googlegroups.com. For more options, visit
> > https://groups.google.com/d/optout.
