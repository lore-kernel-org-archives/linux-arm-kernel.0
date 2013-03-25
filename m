From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 25 Mar 2013 11:37:50 +0100
Subject: [PATCH] clk: divider: Use DIV_ROUND_CLOSEST
In-Reply-To: <d1e87771-73df-4afd-9a02-b294d2ca62a1@AM1EHSMHS002.ehs.local>
References: <2e77dfe8-8d4f-4b77-bf1b-831ad1572c23@VA3EHSMHS046.ehs.local>
 <20130320001609.8663.21043@quantum>
 <f3ff0545-52cd-4b7b-967e-f81324ba0152@CH1EHSMHS040.ehs.local>
 <20130320185051.GA28349@pengutronix.de>
 <d1e87771-73df-4afd-9a02-b294d2ca62a1@AM1EHSMHS002.ehs.local>
Message-ID: <20130325103750.GA1906@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 09:36:14AM -0700, S?ren Brinkmann wrote:
> On Wed, Mar 20, 2013 at 07:50:51PM +0100, Sascha Hauer wrote:
> > On Wed, Mar 20, 2013 at 09:32:51AM -0700, S?ren Brinkmann wrote:
> > > Hi Mike,
> > >
> > > On Tue, Mar 19, 2013 at 05:16:09PM -0700, Mike Turquette wrote:
> > > > Quoting Soren Brinkmann (2013-01-29 17:25:44)
> > > > > Use the DIV_ROUND_CLOSEST macro to calculate divider values and minimize
> > > > > rounding errors.
> > > > >
> > > > > Cc: linux-arm-kernel at lists.infradead.org
> > > > > Cc: linux-kernel at vger.kernel.org
> > > > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > > > ---
> > > > > Hi,
> > > > >
> > > > > I just came across this behavior:
> > > > > I'm using the clk-divider as cpuclock which can be scaled through cpufreq.
> > > > > During boot I create an opp table which in this case holds the frequencies [MHz]
> > > > > 666, 333 and 222. To make sure those are actually valid frequencies I call
> > > > > clk_round_rate().
> > > > > I added a debug line in clk-divider.c:clk_divider_bestdiv() before the return
> > > > > in line 163 giving me:
> > > > >         prate:1333333320, rate:333333330, div:4
> > > > > for adding the 333 MHz operating point.
> > > > >
> > > > > In the running system this gives me:
> > > > > zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_available_frequencies
> > > > > 222222 333333 666666
> > > > > zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_cur_freq
> > > > >  666666
> > > > >
> > > > >  So far, so good. But now, let's scale the frequency:
> > > > > zynq:/sys/devices/system/cpu/cpu0/cpufreq # echo 333333 > scaling_setspeed
> > > > > zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_cur_freq
> > > > >  266666
> > > > >
> > > > > And the corresponding debug line:
> > > > >         prate:1333333320, rate:333333000, div:5
> > > > >
> > > > > So, with DIV_ROUND_UP an actual divider of 4.00000396 becomes 5, resulting in a
> > > > > huge error.
> > > > >
> > > >
> > > > Soren,
> > > >
> > > > Thanks for the patch, and apologies for it getting lost for so long.  I
> > > > think that your issue is more about policy.  E.g. should we round the
> > > > divider up or round the divider down?  The correct answer will vary from
> > > > platform to platform and the clk.h api doesn't specify how
> > > > clk_round_rate should round, other than it must specify a rate that the
> > > > clock can actually run at.
> > > Sure, my problem seems to be caused by different subsystems using a different resolution for clock frequencies.
> > >
> > > >
> > > > Unless everyone can agree that DIV_ROUND_CLOSEST gives them what they
> > > > want I'm more inclined to make this behavior a flag specific to struct
> > > > clk-divider.  E.g. CLK_DIVIDER_ROUND_CLOSEST.
> > > My understanding would have been, that clk_round_rate() gives me a
> > > frequency as close to the requested one as possible.
> >
> > clk_round_rate clk_set_rate are implemented to give the closest possible
> > rate that *is not higher* than the desired clock. That was the
> > understanding by the time the clk framework was implemented.
> >
> > > If the caller
> > > doesn't like the returned frequency he can request a different one.
> > > And he's eventually happy with the return value he calls
> > > clk_set_rate() requesting the frequency clk_round_rate() returned.
> > > Always rounding down seems a bit odd to me.
> > >
> > > Another issue with the current implmentation:
> > > clk_divider_round_rate() calls clk_divider_bestdiv(), which uses the ROUND_UP macro, returning a rather low frequency.
> >
> > And that is correct. clk_divider_bestdiv is used to calculate the
> > maximum parent frequency for which a given divider value does not
> > exceed the desired rate.
> That is not what I mean. I was pointing at, that passing the same
> frequency to round_rate and set_rate can return different results, since
> round_rate rounds up whereas set_rate rounds down. Though, it's probably
> fine since you shouldn't call set_rate with a frequency which wasn't returned
> from round_rate.

There's no rule to call clk_set_rate only with the result of
clk_round_rate. clk_round_rate is no mandatory call at all. So, if
clk_set_rate adjusts to another rate than what clk_round_rate returned,
this is a bug.

Currently it's not clear to me why in clk_set_rate and clk_round_rate in
the divider different algorithms are used, I only notice that this is
the case since the introduction of the divider.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
