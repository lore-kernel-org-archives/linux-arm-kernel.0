From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Mar 2013 19:50:51 +0100
Subject: [PATCH] clk: divider: Use DIV_ROUND_CLOSEST
In-Reply-To: <f3ff0545-52cd-4b7b-967e-f81324ba0152@CH1EHSMHS040.ehs.local>
References: <2e77dfe8-8d4f-4b77-bf1b-831ad1572c23@VA3EHSMHS046.ehs.local>
 <20130320001609.8663.21043@quantum>
 <f3ff0545-52cd-4b7b-967e-f81324ba0152@CH1EHSMHS040.ehs.local>
Message-ID: <20130320185051.GA28349@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 20, 2013 at 09:32:51AM -0700, S?ren Brinkmann wrote:
> Hi Mike,
> 
> On Tue, Mar 19, 2013 at 05:16:09PM -0700, Mike Turquette wrote:
> > Quoting Soren Brinkmann (2013-01-29 17:25:44)
> > > Use the DIV_ROUND_CLOSEST macro to calculate divider values and minimize
> > > rounding errors.
> > >
> > > Cc: linux-arm-kernel at lists.infradead.org
> > > Cc: linux-kernel at vger.kernel.org
> > > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > > ---
> > > Hi,
> > >
> > > I just came across this behavior:
> > > I'm using the clk-divider as cpuclock which can be scaled through cpufreq.
> > > During boot I create an opp table which in this case holds the frequencies [MHz]
> > > 666, 333 and 222. To make sure those are actually valid frequencies I call
> > > clk_round_rate().
> > > I added a debug line in clk-divider.c:clk_divider_bestdiv() before the return
> > > in line 163 giving me:
> > >         prate:1333333320, rate:333333330, div:4
> > > for adding the 333 MHz operating point.
> > >
> > > In the running system this gives me:
> > > zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_available_frequencies
> > > 222222 333333 666666
> > > zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_cur_freq
> > >  666666
> > >
> > >  So far, so good. But now, let's scale the frequency:
> > > zynq:/sys/devices/system/cpu/cpu0/cpufreq # echo 333333 > scaling_setspeed
> > > zynq:/sys/devices/system/cpu/cpu0/cpufreq # cat scaling_cur_freq
> > >  266666
> > >
> > > And the corresponding debug line:
> > >         prate:1333333320, rate:333333000, div:5
> > >
> > > So, with DIV_ROUND_UP an actual divider of 4.00000396 becomes 5, resulting in a
> > > huge error.
> > >
> >
> > Soren,
> >
> > Thanks for the patch, and apologies for it getting lost for so long.  I
> > think that your issue is more about policy.  E.g. should we round the
> > divider up or round the divider down?  The correct answer will vary from
> > platform to platform and the clk.h api doesn't specify how
> > clk_round_rate should round, other than it must specify a rate that the
> > clock can actually run at.
> Sure, my problem seems to be caused by different subsystems using a different resolution for clock frequencies.
> 
> >
> > Unless everyone can agree that DIV_ROUND_CLOSEST gives them what they
> > want I'm more inclined to make this behavior a flag specific to struct
> > clk-divider.  E.g. CLK_DIVIDER_ROUND_CLOSEST.
> My understanding would have been, that clk_round_rate() gives me a
> frequency as close to the requested one as possible.

clk_round_rate clk_set_rate are implemented to give the closest possible
rate that *is not higher* than the desired clock. That was the
understanding by the time the clk framework was implemented.

> If the caller
> doesn't like the returned frequency he can request a different one.
> And he's eventually happy with the return value he calls
> clk_set_rate() requesting the frequency clk_round_rate() returned.
> Always rounding down seems a bit odd to me.
> 
> Another issue with the current implmentation:
> clk_divider_round_rate() calls clk_divider_bestdiv(), which uses the ROUND_UP macro, returning a rather low frequency.

And that is correct. clk_divider_bestdiv is used to calculate the
maximum parent frequency for which a given divider value does not
exceed the desired rate.

That is, when you want to have a frequency of 100Hz and your divider is
2, then your parent input clock can be between 101Hz and 200Hz,
corresponding to a call to DIV_ROUND_UP.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
