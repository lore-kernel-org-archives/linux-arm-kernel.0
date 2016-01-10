From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Jan 2016 20:44:50 +0100
Subject: [PATCH v6 2/3] spi: sun4i: Fix clock calculations to be
 predictable and never exceed the requested rate
In-Reply-To: <CAGNoLaMsdPe4BE7+skYR45doEcXkZGA7QdFOidUA_yPZmiE9eg@mail.gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
 <1451145186-14235-3-git-send-email-mweseloh42@gmail.com>
 <20151227210946.GL30359@lukather>
 <CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw@mail.gmail.com>
 <CAGNoLaMsdPe4BE7+skYR45doEcXkZGA7QdFOidUA_yPZmiE9eg@mail.gmail.com>
Message-ID: <20160110194450.GI9631@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2015 at 05:22:35PM +0100, Marcus Weseloh wrote:
> Hi again,
> 
> 2015-12-28 0:29 GMT+01:00 Marcus Weseloh <mweseloh42@gmail.com>:
> > 2015-12-27 22:09 GMT+01:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> [...]
> > [...]
> >>> -     /* Ensure that we have a parent clock fast enough */
> >>> +     /*
> >>> +      * Ensure that the parent clock is set to twice the max speed
> >>> +      * of the spi device (possibly rounded up by the clk driver)
> >>> +      */
> >>>       mclk_rate = clk_get_rate(sspi->mclk);
> >>> -     if (mclk_rate < (2 * tfr->speed_hz)) {
> >>> -             clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> >>> +     if (spi->max_speed_hz != sspi->cur_max_speed ||
> >>> +         mclk_rate != sspi->cur_mclk) {
> >>
> >> Do you need to cache the values? As far as I'm aware, you end up doing
> >> the computation all the time anyway.
> >
> > By caching the values we optimize the case when a single SPI slave
> > device (or even multiple slave devices with the same max_speed) are
> > used multiple times in a row. In that case, we're saving two calls:
> > clk_set_rate and clk_get_rate. I was unsure about how expensive the
> > clk_* calls were, so I thought it would be safer use caching. But
> > maybe it's not worth the extra code?
> >
> > Oh, and I just noticed a mistake in the comment: the clock driver
> > rounds up _or_ down, so I should drop the "up".
> 
> As I'm looking further into this, I think the comment should read
> "possibly rounded down", as the clk framework is expected to set a
> frequency that is less or equal to the requested frequency.

AFAIK, there's no such expectation in the clock framework. You
treating this from a maximum frequency perspective, but it would be
the exact opposite if you were talking about a minimum frequency, as
might be the case for other consumers.

> So the effect I was seeing (that I got a frequency higher than the
> requested one) is actually a bug!? Further details below.
> 
> > [...]
> >>> -     div = mclk_rate / (2 * tfr->speed_hz);
> >>> -     if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
> >>> -             if (div > 0)
> >>> -                     div--;
> >>> -
> >>> +     div = DIV_ROUND_UP(mclk_rate, 2 * tfr->speed_hz) - 1;
> >>
> >> Isn't it exactly the same thing as mclk_rate / (2 * tfr->speed_hz) ?
> >
> > It is quite often, but not in all cases. The plain division rounds to
> > the nearest integer, so it rounds down sometimes. Consider the
> > following case: we have a slow SPI device with a spi-max-frequency of
> > 50kHz. Our clock driver can't find a clock as slow as 100kHz, so it
> > sets mclk to 214,285Hz.
> 
> That clk_set_rate sets a higher frequency than requested seems to be a
> problem in itself. I had a look at clk/sunxi/clk-mod0.c and noticed a
> few small problems there. Will post an RFC patch in a couple of
> minutes.

Did you post these patches already? I think I missed them if that's
the case.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160110/69920fe3/attachment.sig>
