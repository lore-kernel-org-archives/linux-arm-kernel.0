From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 29 Aug 2016 19:54:09 +0200
Subject: [RFC PATCH] clk: rockchip: rk3399: support pll setting
 automatically
In-Reply-To: <CAD=FV=VMqHrKHThSNoz_i=SCwgw=OeOfaww3Ote1id66LXO8JQ@mail.gmail.com>
References: <1470144852-20708-1-git-send-email-zhengxing@rock-chips.com>
 <4830789.1bI8OsvZy1@phil>
 <CAD=FV=VMqHrKHThSNoz_i=SCwgw=OeOfaww3Ote1id66LXO8JQ@mail.gmail.com>
Message-ID: <13164913.BHiQzGsdBU@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 29. August 2016, 10:35:44 schrieb Doug Anderson:
> Hi,
> 
> On Sun, Aug 28, 2016 at 8:21 AM, Heiko St?bner <heiko@sntech.de> wrote:
> > Hi Xing, Elaine,
> > 
> > Am Dienstag, 2. August 2016, 21:34:12 schrieb Xing Zheng:
> >> From: Elaine Zhang <zhangqing@rock-chips.com>
> >> 
> >> The goal is that we can configure the most suitable pll params
> >> automatically.
> >> 
> >> If setting freq is not supported in rockchip_pll_rate_table
> >> rk3399_pll_rates[], we can set pll params automatically.
> >> 
> >> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> >> Signed-off-by: Xing Zheng <zhengxing@rock-chips.com>
> > 
> > first off, I really like that idea of calculating the generic pll
> > frequencies instead of duplicating these entries in every soc clock
> > driver.
> 
> I probably won't have time to look at this any time soon, but when I
> saw this patch fly by I was a little hesitant because:
> 
> * Not all PLL settings produce the same jitter.  On rk3288 I spent
> loads of time searching for PLL settings that would be low jitter
> enough to make a pixel clock that was happy with lots of different TVs
> / monitors.  It's true that there were certain heuristics that could
> be followed but certainly my predictions didn't always match what
> happened.
> 
> * Depending on what's using the PLL, you might want very different
> settings.  One can optimize for lock time, power usage, jitter,
> accuracy, etc.  For instance for a CPU clock that you change a lot you
> probably don't care about hitting an exact frequency and you probably
> don't care overly much about jitter, but you want low lock times.  For
> HDMI you don't care about lock times and and probably don't care about
> power usage, but you care about meeting an exact clock and really
> really care about jitter.
> 
> * I know that in the past the way I found to make some of the best
> rates for HDMI was to have the PLL make a rate that was several times
> what I wanted and then activate a divider later in the clock tree.
> That gave me the best jitter / clock accuracy.  I have no idea how to
> do that automatically, but in the past I relied on the PLL only having
> a fixed set of rates it could make so it would fail to make the lower
> clock rate (higher jitter) and eventually end up with the better one.
> 
> 
> Anyway, I don't know how to solve all of the above, but I just wanted
> to bring it up as a concern.

after talking with Doug on irc, I realized that this really can become a 
problem, as right now we have a list with known-good rates, can adjust those 
as needed and have the clock framework select the best for a certain target 
rate.

But with the automatic calculation it would open up nearly unlimited different 
rates with possible negative effects and no way to eliminate or even test most 
of them.

So it may very well be best to stay with static rates, in a component as core 
as the PLLs are?


Heiko
