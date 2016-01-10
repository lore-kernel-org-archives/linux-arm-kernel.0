From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 10 Jan 2016 19:14:28 +0100
Subject: [PATCH v6 2/3] spi: sun4i: Fix clock calculations to be
 predictable and never exceed the requested rate
In-Reply-To: <CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw@mail.gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
 <1451145186-14235-3-git-send-email-mweseloh42@gmail.com>
 <20151227210946.GL30359@lukather>
 <CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw@mail.gmail.com>
Message-ID: <20160110181428.GH9631@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 28, 2015 at 12:29:16AM +0100, Marcus Weseloh wrote:
> Hi,
> 
> 2015-12-27 22:09 GMT+01:00 Maxime Ripard <maxime.ripard@free-electrons.com>:
> > On Sat, Dec 26, 2015 at 04:53:05PM +0100, Marcus Weseloh wrote:
> >> This patch fixes multiple problems with the current clock calculations:
> >>
> >> 1. The A10/A20 datasheet contains the formula AHB_CLK / (2^(n+1)) to
> >> calculate SPI_CLK from CDR1, but this formula is wrong. The actual
> >> formula - determined by analyzing the actual waveforms - is
> >> AHB_CLK / (2^n).
> >>
> >> 2. The divisor calculations for CDR1 and CDR2 both rounded to the
> >> nearest integer. This could lead to a transfer speed that is higher than
> >> the requested speed. This patch changes both calculations to always
> >> round down.
> >>
> >> 3. The mclk frequency was only ever increased, never decreased. This could
> >> lead to unpredictable transfer speeds, depending on the order in which
> >> transfers with different speeds where serviced by the SPI driver.
> >
> > These 3 should probably be separate patches (and be Cc'd to stable
> 
> Will do. But I have the feeling that at least 1. and 2. should be in
> the same patch as they touch the same lines of code. Do you think that
> would be ok?

It can also be two subsequent patches that are part of the same serie.

> And before CC'ing stable, I would love to have someone with access to
> A10 hardware and a scope (or even a bus pirate) check that the A10 SPI
> controller does indeed have the same "bug". I strongly think so, but
> would sleep better if it could be confirmed.

We never noticed any significant difference between the two. By now,
if there was any, we probably would be aware of it. And if there's
any, we can always send a subsequent patch.

> >> -     /* Ensure that we have a parent clock fast enough */
> >> +     /*
> >> +      * Ensure that the parent clock is set to twice the max speed
> >> +      * of the spi device (possibly rounded up by the clk driver)
> >> +      */
> >>       mclk_rate = clk_get_rate(sspi->mclk);
> >> -     if (mclk_rate < (2 * tfr->speed_hz)) {
> >> -             clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> >> +     if (spi->max_speed_hz != sspi->cur_max_speed ||
> >> +         mclk_rate != sspi->cur_mclk) {
> >
> > Do you need to cache the values? As far as I'm aware, you end up doing
> > the computation all the time anyway.
> 
> By caching the values we optimize the case when a single SPI slave
> device (or even multiple slave devices with the same max_speed) are
> used multiple times in a row. In that case, we're saving two calls:
> clk_set_rate and clk_get_rate. I was unsure about how expensive the
> clk_* calls were, so I thought it would be safer use caching. But
> maybe it's not worth the extra code?

Unless you can point that there's a significant performance
difference, I'm not sure it's worth it.

> Oh, and I just noticed a mistake in the comment: the clock driver
> rounds up _or_ down, so I should drop the "up".
> 
> [...]
> >> -     div = mclk_rate / (2 * tfr->speed_hz);
> >> -     if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
> >> -             if (div > 0)
> >> -                     div--;
> >> -
> >> +     div = DIV_ROUND_UP(mclk_rate, 2 * tfr->speed_hz) - 1;
> >
> > Isn't it exactly the same thing as mclk_rate / (2 * tfr->speed_hz) ?
> 
> It is quite often, but not in all cases. The plain division rounds to
> the nearest integer, so it rounds down sometimes. Consider the
> following case: we have a slow SPI device with a spi-max-frequency of
> 50kHz. Our clock driver can't find a clock as slow as 100kHz, so it
> sets mclk to 214,285Hz.
> 
> Using the old calculation we get: 214,285 / (2 * 50,000) = 2, so div =
> 1 as the old code subtracts 1 two lines further down
> The new calculation results in: DIV_ROUND_UP(214,285, 2 * 50,000)  =
> 3, so div = 2 if we add the -1

Except that you have that extra - 1 after your DIV_ROUND_UP
calculation in the line you add.  so you have to remove 1 from that
line above, and then 1 again when we set the register, which ends up
being the exact same thing, or am I missing something?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160110/dd375ba3/attachment.sig>
