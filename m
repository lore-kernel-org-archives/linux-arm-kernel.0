From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 15 May 2015 17:11:16 +0800
Subject: [PATCH 1/8] clk: sunxi: factors: Add m_start parameters
In-Reply-To: <20150515080546.GT4004@lukather>
References: <1430565879-28113-1-git-send-email-maxime.ripard@free-electrons.com>
 <1430565879-28113-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v669fsz_pA+B0r8efp0BMxY-D86qfLuGQCqK1POuu9PmxQ@mail.gmail.com>
 <20150515074314.GQ4004@lukather>
 <CAGb2v66jRX09k48ciR-bwMZRAioRpHKZ3D2+wVYWannjtF+G3w@mail.gmail.com>
 <20150515080546.GT4004@lukather>
Message-ID: <CAGb2v67jruYamgHpM1NRm_fvm+SnDgQy4BEvZBxPEFByQsRsrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 4:05 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, May 15, 2015 at 03:48:38PM +0800, Chen-Yu Tsai wrote:
>> On Fri, May 15, 2015 at 3:43 PM, Maxime Ripard
>> <maxime.ripard@free-electrons.com> wrote:
>> > On Thu, May 14, 2015 at 05:12:07PM +0800, Chen-Yu Tsai wrote:
>> >> On Sat, May 2, 2015 at 7:24 PM, Maxime Ripard
>> >> <maxime.ripard@free-electrons.com> wrote:
>> >> > Some clocks start incrementing the m factor at 0. Add a parameter to handle
>> >> > it just like we did for the N factor.
>> >> >
>> >> > Since the behaviour until now was to assume that the m factor was starting
>> >> > at 1, we also need to fix the other users.
>> >> >
>> >> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> >> > ---
>> >> >  drivers/clk/sunxi/clk-factors.c    | 11 ++++++++++-
>> >> >  drivers/clk/sunxi/clk-factors.h    |  2 ++
>> >> >  drivers/clk/sunxi/clk-mod0.c       |  2 ++
>> >> >  drivers/clk/sunxi/clk-sun8i-mbus.c |  2 ++
>> >> >  drivers/clk/sunxi/clk-sun9i-core.c |  6 ++++++
>> >> >  drivers/clk/sunxi/clk-sunxi.c      | 10 ++++++++++
>> >> >  6 files changed, 32 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/drivers/clk/sunxi/clk-factors.c b/drivers/clk/sunxi/clk-factors.c
>> >> > index 8c20190a3e9f..100a711c3e3d 100644
>> >> > --- a/drivers/clk/sunxi/clk-factors.c
>> >> > +++ b/drivers/clk/sunxi/clk-factors.c
>> >> > @@ -56,15 +56,24 @@ static unsigned long clk_factors_recalc_rate(struct clk_hw *hw,
>> >> >         /* Get each individual factor if applicable */
>> >> >         if (config->nwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>> >> >                 n = FACTOR_GET(config->nshift, config->nwidth, reg);
>> >> > +
>> >> >         if (config->kwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>> >> >                 k = FACTOR_GET(config->kshift, config->kwidth, reg);
>> >> > +
>> >> >         if (config->mwidth != SUNXI_FACTORS_NOT_APPLICABLE)
>> >> >                 m = FACTOR_GET(config->mshift, config->mwidth, reg);
>> >> > +       else
>> >> > +               /* Make sure we don't get a division by zero */
>> >> > +               m = 1;
>> >>
>> >> What happens when mwidth is valid, m_start = 0, and m = 0?
>> >
>> > That's a very good question. A division by zero in the kernel, I'd
>> > say.
>> >
>> > But I don't think we can end up in such a case today, and it's
>> > somewhat expected that it will happen, and no clock have looked at can
>> > actually end up in such a case.
>>
>> It's possible if the bootloader left the clock in an invalid state.
>> How about just returning 0, indicating an invalid rate, early?
>
> The value set in the register might be zero, but that will always
> really mean 1, either through m_start or m_zero. That would be a bug
> in the driver itself.

Maybe you should switch the order of these 2 patches to make it clear?
Or maybe squash them? As it currently is, m_start = 0 and m = 0 with
this patch only is a bug.

ChenYu
