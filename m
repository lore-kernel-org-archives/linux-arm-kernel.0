From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Apr 2016 19:28:38 +0200
Subject: [PATCH v4 02/13] clk: sunxi: add ahb1 clock for A83T
In-Reply-To: <CAEzqOZvoMrvf-3=Tfi7MK9ZTm1EtJre5gsBdz=2wZ+D+hj056A@mail.gmail.com>
References: <1458144276-31108-1-git-send-email-vishnupatekar0510@gmail.com>
 <1458144276-31108-3-git-send-email-vishnupatekar0510@gmail.com>
 <20160317104042.GK30977@lukather>
 <CAEzqOZvoMrvf-3=Tfi7MK9ZTm1EtJre5gsBdz=2wZ+D+hj056A@mail.gmail.com>
Message-ID: <20160414172838.GS4005@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 04, 2016 at 11:07:29AM +0800, Vishnu Patekar wrote:
> Hello Maxime,
> 
> On Thu, Mar 17, 2016 at 6:40 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Thu, Mar 17, 2016 at 12:04:25AM +0800, Vishnu Patekar wrote:
> >> AHB1 on A83T is similar to ahb1 on A31, except parents are different.
> >> clock index 0b1x is PLL6.
> >>
> >> Signed-off-by: Vishnu Patekar <vishnupatekar0510@gmail.com>
> >> Acked-by: Chen-Yu Tsai <wens@csie.org>
> >> Acked-by: Rob Herring <robh@kernel.org>
> >> ---
> >>  Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
> >>  drivers/clk/sunxi/clk-sunxi.c                     | 76 +++++++++++++++++++++++
> >>  2 files changed, 77 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/sunxi.txt b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> index 834436f..cba9fe55 100644
> >> --- a/Documentation/devicetree/bindings/clock/sunxi.txt
> >> +++ b/Documentation/devicetree/bindings/clock/sunxi.txt
> >> @@ -30,6 +30,7 @@ Required properties:
> >>       "allwinner,sun6i-a31-ar100-clk" - for the AR100 on A31
> >>       "allwinner,sun9i-a80-cpus-clk" - for the CPUS on A80
> >>       "allwinner,sun6i-a31-ahb1-clk" - for the AHB1 clock on A31
> >> +     "allwinner,sun8i-a83t-ahb1-clk" - for the AHB1 clock on A83T
> >>       "allwinner,sun8i-h3-ahb2-clk" - for the AHB2 clock on H3
> >>       "allwinner,sun6i-a31-ahb1-gates-clk" - for the AHB1 gates on A31
> >>       "allwinner,sun8i-a23-ahb1-gates-clk" - for the AHB1 gates on A23
> >> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
> >> index 91de0a0..a7aab65 100644
> >> --- a/drivers/clk/sunxi/clk-sunxi.c
> >> +++ b/drivers/clk/sunxi/clk-sunxi.c
> >> @@ -344,6 +344,67 @@ static void sun6i_ahb1_recalc(struct factors_request *req)
> >>       req->rate >>= req->p;
> >>  }
> >>
> >> +#define SUN8I_A83T_AHB1_PARENT_PLL6  2
> >> +/**
> >> + * sun8i_a83t_get_ahb_factors() - calculates m, p factors for AHB
> >> + * AHB rate is calculated as follows
> >> + * rate = parent_rate >> p
> >> + *
> >> + * if parent is pll6, then
> >> + * parent_rate = pll6 rate / (m + 1)
> >> + */
> >> +
> >> +static void sun8i_a83t_get_ahb1_factors(struct factors_request *req)
> >> +{
> >> +     u8 div, calcp, calcm = 1;
> >> +
> >> +     /*
> >> +      * clock can only divide, so we will never be able to achieve
> >> +      * frequencies higher than the parent frequency
> >> +      */
> >> +     if (req->parent_rate && req->rate > req->parent_rate)
> >> +             req->rate = req->parent_rate;
> >> +
> >> +     div = DIV_ROUND_UP(req->parent_rate, req->rate);
> >> +
> >> +     /* calculate pre-divider if parent is pll6 */
> >> +     if (req->parent_index >= SUN8I_A83T_AHB1_PARENT_PLL6) {
> >> +             if (div < 4)
> >> +                     calcp = 0;
> >> +             else if (div / 2 < 4)
> >> +                     calcp = 1;
> >> +             else if (div / 4 < 4)
> >> +                     calcp = 2;
> >> +             else
> >> +                     calcp = 3;
> >> +
> >> +             calcm = DIV_ROUND_UP(div, 1 << calcp);
> >> +     } else {
> >> +             calcp = __roundup_pow_of_two(div);
> >> +             calcp = calcp > 3 ? 3 : calcp;
> >> +     }
> >> +
> >> +     req->rate = (req->parent_rate / calcm) >> calcp;
> >> +     req->p = calcp;
> >> +     req->m = calcm - 1;
> >> +}
> >> +
> >> +/**
> >> +* sun8i_a83t_ahb1_recalc() - calculates AHB clock rate from m, p factors and
> >> +*                     parent index
> >> +*/
> >> +static void sun8i_a83t_ahb1_recalc(struct factors_request *req)
> >> +{
> >> +     req->rate = req->parent_rate;
> >> +
> >> +/* apply pre-divider first if parent is pll6 */
> >
> > The comment indentation is wrong
> >
> >> +     if (req->parent_index >= SUN6I_AHB1_PARENT_PLL6)
> >
> > And this is not the right define you're using.
> >
> > I still believe that duplicating the same logic just because of
> > different dividers is not the way to go.
> >
> > You could solve that easily by adding a table for the muxes, and
> > associate it with parents and dividers, that you could store in
> > clk_factors.
> 
> I've similar solution (please ignore a83 specific functions those will
> be common for a31 and a83t).
> https://github.com/vishnupatekar/linux/commit/f7de5b48d886a672b1f6db112fbfd5d2c9849afa
> 
> is it aligned to what you're saying?

Yep. I'd even go a step further, and allow to have directly the core
deal with the pre-divider.

I guess in your prediv table you could have the index, and either the
offset and width of the divider (if it's a variable one), or its fixed
value.

The generic function would then be able to deal with the rate
adjustments, and you wouldn't need to be able to have anything related
to the parent index in the clock specific functions anymore.

Does that make sense?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160414/c8ce4bd0/attachment-0001.sig>
