From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Jul 2017 23:16:59 +0800
Subject: [PATCH 09/18] drm/sun4i: tcon: Adjust dotclock dividers range
In-Reply-To: <20170720145500.kpwj7iscrwyjqi5q@flea>
References: <cover.a5e7407c191c66e264164d017f64582039c56acb.1499955058.git-series.maxime.ripard@free-electrons.com>
 <74db696da66cffafe1e729fe2df73b437c8fd483.1499955058.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v67WtqukOHPNkyzA+s8GAUR6fnomvT6Sqp8547euHH3G-Q@mail.gmail.com>
 <20170720145500.kpwj7iscrwyjqi5q@flea>
Message-ID: <CAGb2v67zXwvC7cGTDpr+UrbU9rXKM01M5Z14AidEUWRQp95ZNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 20, 2017 at 10:55 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Jul 14, 2017 at 12:14:37PM +0800, Chen-Yu Tsai wrote:
>> On Thu, Jul 13, 2017 at 10:13 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > It seems like the dotclock dividers are a bit less strict range, and can
>> > operate even with a smaller than 6 divider. Loose the boundaries a bit.
>> >
>> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> > ---
>> >  drivers/gpu/drm/sun4i/sun4i_dotclock.c | 20 +++++++++++++++++++-
>> >  1 file changed, 19 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/gpu/drm/sun4i/sun4i_dotclock.c b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> > index d401156490f3..0b844c0dd102 100644
>> > --- a/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> > +++ b/drivers/gpu/drm/sun4i/sun4i_dotclock.c
>> > @@ -77,7 +77,25 @@ static long sun4i_dclk_round_rate(struct clk_hw *hw, unsigned long rate,
>> >         u8 best_div = 1;
>> >         int i;
>> >
>> > -       for (i = 6; i <= 127; i++) {
>> > +       /*
>> > +        * There's something odd here.
>> > +        *
>> > +        * In the A13 user manual, this is stated to be >= 6 when
>> > +        * dclk1 and dclk2 are used (without any hint on how to use
>> > +        * them), and >= 4 when only dclk is used.
>>
>> You set it in TCON0_IO_POL_REG, which sets the clock phase delay.
>
> oh, so it's d for delay? I assumed it was for dotclock.

The manual says "data clock" for register 0x44 (TCON0_DCLK_REG)

>
>> I think we were setting this before, but you removed it as part of
>> the previous TCON clean up patches?
>
> Hmmm, I might have.. :)
>
>> In the A33, there are even more options, like DCLK / 2 (with 0 or 90
>> degree phase delay).
>
> Where did you find this documentation? I was under the impression that
> all that DCLK stuff was in the higher bits of the DCLK register, but
> apparently there's more to it.

Same section, TCON0_IO_POL_REG register bits.

The bits in TCON0_IO_POL_REG are likely a mux, letting you select which
one that is actually used on the external (with regard to the TCON) pin.

>
>> > +        *
>> > +        * In the A33 user manual, when only dclk is used, it is set
>> > +        * to be >= 6 in the former case, and >= 1 in the
>> > +        * latter. There's also some (obscure) explanations about the
>> > +        * dclk1 and dclk2 vs dclk that seems to be in the upper 4
>> > +        * bits. What those clocks are and what bit does what is not
>> > +        * really clear.
>>
>> Looks like mux bits to me. How they differ from TCON0_IO_POL_REG is
>> beyond me ATM.
>
> It might be some additional dividers too.

Might be something like this:

TCON CH0 clk ----- dclk_en   - no delay        --------------[mux]--- dclk out
               \\- dclk1_en  - 1/3 phase delay --------------////
                \- dclk2_en  - 2/3 phase delay --------------///
                 \ dclkm2_en - /2 divider - no delay --------//
                                          \ 90 degree delay -/

ChenYu

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
