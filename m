From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 17 Jan 2016 19:51:43 +0100
Subject: [PATCH v6 2/3] spi: sun4i: Fix clock calculations to be
 predictable and never exceed the requested rate
In-Reply-To: <CAGNoLaNi72=T6SzGK-Y-b1X6jNx6M-c2oMSQ85sREp9REs5SKQ@mail.gmail.com>
References: <1451145186-14235-1-git-send-email-mweseloh42@gmail.com>
 <1451145186-14235-3-git-send-email-mweseloh42@gmail.com>
 <20151227210946.GL30359@lukather>
 <CAGNoLaPcBAqDqFuff7sWWADjVH3Z-LWhZatSmzvEm4mLSrSNvw@mail.gmail.com>
 <20160110181428.GH9631@lukather>
 <CAGNoLaNi72=T6SzGK-Y-b1X6jNx6M-c2oMSQ85sREp9REs5SKQ@mail.gmail.com>
Message-ID: <20160117185143.GL4581@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 10, 2016 at 10:11:11PM +0100, Marcus Weseloh wrote:
> >> >> -     /* Ensure that we have a parent clock fast enough */
> >> >> +     /*
> >> >> +      * Ensure that the parent clock is set to twice the max speed
> >> >> +      * of the spi device (possibly rounded up by the clk driver)
> >> >> +      */
> >> >>       mclk_rate = clk_get_rate(sspi->mclk);
> >> >> -     if (mclk_rate < (2 * tfr->speed_hz)) {
> >> >> -             clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> >> >> +     if (spi->max_speed_hz != sspi->cur_max_speed ||
> >> >> +         mclk_rate != sspi->cur_mclk) {
> >> >
> >> > Do you need to cache the values? As far as I'm aware, you end up doing
> >> > the computation all the time anyway.
> >>
> >> By caching the values we optimize the case when a single SPI slave
> >> device (or even multiple slave devices with the same max_speed) are
> >> used multiple times in a row. In that case, we're saving two calls:
> >> clk_set_rate and clk_get_rate. I was unsure about how expensive the
> >> clk_* calls were, so I thought it would be safer use caching. But
> >> maybe it's not worth the extra code?
> >
> > Unless you can point that there's a significant performance
> > difference, I'm not sure it's worth it.
> 
> I did actually notice a significant transfer latency when a new mod0
> clock frequency is set, probably due to the __delay in
> drivers/clk/sunxi/clk-factors.c (line 147). So my feeling is that the
> caching is worth it... at least for the case when there are two slave
> devices with different transfer speeds accessing the same SPI module.

I'm not sure we even need that delay in the first place, at least not
for all the clocks using factor.

AFAIK, the only case where it's useful is for PLL, and all of them
have a bit you can busy-wait on that will let you know when the clock
has stabilized.

> >> [...]
> >> >> -     div = mclk_rate / (2 * tfr->speed_hz);
> >> >> -     if (div <= (SUN4I_CLK_CTL_CDR2_MASK + 1)) {
> >> >> -             if (div > 0)
> >> >> -                     div--;
> >> >> -
> >> >> +     div = DIV_ROUND_UP(mclk_rate, 2 * tfr->speed_hz) - 1;
> >> >
> >> > Isn't it exactly the same thing as mclk_rate / (2 * tfr->speed_hz) ?
> >>
> >> It is quite often, but not in all cases. The plain division rounds to
> >> the nearest integer, so it rounds down sometimes. Consider the
> >> following case: we have a slow SPI device with a spi-max-frequency of
> >> 50kHz. Our clock driver can't find a clock as slow as 100kHz, so it
> >> sets mclk to 214,285Hz.
> >>
> >> Using the old calculation we get: 214,285 / (2 * 50,000) = 2, so div =
> >> 1 as the old code subtracts 1 two lines further down
> >> The new calculation results in: DIV_ROUND_UP(214,285, 2 * 50,000)  =
> >> 3, so div = 2 if we add the -1
> >
> > Except that you have that extra - 1 after your DIV_ROUND_UP
> > calculation in the line you add.  so you have to remove 1 from that
> > line above, and then 1 again when we set the register, which ends up
> > being the exact same thing, or am I missing something?
> 
> The -1 after the DIV_ROUND_UP is already the -1 that is needed to set
> the register. There's no need for another -1 after that (and there
> isn't one in the code).

I was probably hallucinating :) My bad.

That being said, I still have a hard time figuring out what would not
be solved simply by removing the div--, which seems to match what your
commit log says.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160117/0c4e7218/attachment-0001.sig>
