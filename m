From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 26 Apr 2016 19:16:15 +0800
Subject: [PATCH 1/2] clk: imx: do not sleep if IRQ's are still disabled
In-Reply-To: <1461663072.7839.17.camel@pengutronix.de>
References: <1454107764-19876-1-git-send-email-stefan@agner.ch>
 <20160421034520.GA19965@shlinux2.ap.freescale.net>
 <20160426012341.GB8870@tiger>
 <CAA+hA=QTNEAaMfjJoMMO5gPR8VPYBWYx=HZgjngUFJK4LxMp=g@mail.gmail.com>
 <1461663072.7839.17.camel@pengutronix.de>
Message-ID: <CAA+hA=SSQJPbzbhCY7O8JaxiUgMDjG2ATQXsCW-X5zc2inC6kw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 26, 2016 at 5:31 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Dienstag, den 26.04.2016, 13:51 +0800 schrieb Dong Aisheng:
>> Hi Shawn,
>>
>> On Tue, Apr 26, 2016 at 9:23 AM, Shawn Guo <shawnguo@kernel.org> wrote:
>> > On Thu, Apr 21, 2016 at 11:45:20AM +0800, Dong Aisheng wrote:
>> >> On Fri, Jan 29, 2016 at 02:49:23PM -0800, Stefan Agner wrote:
>> >> > If a clock gets enabled early during boot time, it can lead to a PLL
>> >> > startup. The wait_lock function makes sure that the PLL is really
>> >> > stareted up before it gets used. However, the function sleeps which
>> >> > leads to scheduling and an error:
>> >> > bad: scheduling from the idle thread!
>> >> > ...
>> >> >
>> >> > Use udelay in case IRQ's are still disabled.
>> >> >
>> >> > Signed-off-by: Stefan Agner <stefan@agner.ch>
>> >> > ---
>> >> >  drivers/clk/imx/clk-pllv3.c | 5 ++++-
>> >> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >> >
>> >> > diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
>> >> > index c05c43d..b5ff561 100644
>> >> > --- a/drivers/clk/imx/clk-pllv3.c
>> >> > +++ b/drivers/clk/imx/clk-pllv3.c
>> >> > @@ -63,7 +63,10 @@ static int clk_pllv3_wait_lock(struct clk_pllv3 *pll)
>> >> >                     break;
>> >> >             if (time_after(jiffies, timeout))
>> >> >                     break;
>> >> > -           usleep_range(50, 500);
>> >> > +           if (unlikely(irqs_disabled()))
>> >>
>> >> This causes a bit confusion that clk_pllv3_prepare is sleepable.
>> >> But this line indicates it's possible to be called in irq context.
>> >> Although it's only happened during kernel boot phase where irq is
>> >> still not enabled.
>> >> It seems schedule_debug() somehow did not catch it during early boot
>> >> phase. Maybe schedule guys can help explain.
>> >>
>> >> My question is if it's really worthy to introduce this confusion
>> >> to fix the issue since the delay is minor?
>> >
>> > I do not understand why it's confusing.  The code already obviously
>> > indicates this is a special handling for cases where irq is still not
>> > enabled, rather than for irq context.
>> >
>>
>> The code itself has nothing telling it's a special handling for the
>> case where irq is
>> still not enabled.
>> Even it tells, it may still cause confusing by adding complexity in
>> clk_pllv3_prepare()
>> which actually should be called in non-atomic context as it could sleep.
>>
>> > The patch is to fix the "bad: scheduling from the idle thread!" warning
>> > rather than minimize the delay.  Do you have an opinion on how to fix
>> > the warning?
>> >
>>
>> I just wonder maybe we could simply just using udelay(50) instead of
>> usleep_range(50, 500) to eliminate the confusing since it's minor cast.
>> What do you think of it?
>
> Why should we needless burn CPU time in the likely case of
> clk_pllv3_prepare() being called in sleepable context?
>

I think because the delay time is not big.
And pll clks are system basic clocks and less likely to be frequently
enabled/disabled.

> Using udelay() in a sleepable context is even more confusing than having
> the special case for clk_prepare() being called in atomic context IMHO.
>

I can't agree having special case by checking
unlikely(irqs_disabled()) is better
which is obviously more confusing IMHO.
I'd more like to hide it from users.

I see other platforms like samsung&tegra also implements pll using udelay.
But difference is that they implement it in .enable(I) clalback not prepare.

How about simply remove usleep_range to poll instead of using udelay?
Cause most PLL enable may be more faster than 50ns.

And according to kernel doc, for delay time less than 10ns,
udelay or polling is recommended.

> Regards,
> Lucas
>

Regards
Dong Aisheng
