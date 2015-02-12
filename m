From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Feb 2015 12:56:46 +0000
Subject: [PATCH RFC v9 01/20] clk: divider: Correct parent clk round rate
 if no bestdiv is normally found
In-Reply-To: <20150212122405.GW12209@pengutronix.de>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-2-git-send-email-Ying.Liu@freescale.com>
 <20150212093356.GR12209@pengutronix.de>
 <20150212103944.GA1290@victor>
 <20150212122405.GW12209@pengutronix.de>
Message-ID: <20150212125646.GT8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 01:24:05PM +0100, Sascha Hauer wrote:
> On Thu, Feb 12, 2015 at 06:39:45PM +0800, Liu Ying wrote:
> > On Thu, Feb 12, 2015 at 10:33:56AM +0100, Sascha Hauer wrote:
> > > On Thu, Feb 12, 2015 at 02:01:24PM +0800, Liu Ying wrote:
> > > > If no best divider is normally found, we will try to use the maximum divider.
> > > > We should not set the parent clock rate to be 1Hz by force for being rounded.
> > > > Instead, we should take the maximum divider as a base and calculate a correct
> > > > parent clock rate for being rounded.
> > > 
> > > Please add an explanation why you think the current code is wrong and
> > > what this actually fixes, maybe an example?
> > 
> > The MIPI DSI panel's pixel clock rate is 26.4MHz and it's derived from PLL5 on
> > the MX6DL SabreSD board.
> > 
> > These are the clock tree summaries with or without the patch applied:
> > 1) With the patch applied:
> > pll5_bypass_src                       1            1    24000000          0 0
> >    pll5                               1            1   844800048          0 0
> >       pll5_bypass                     1            1   844800048          0 0
> >          pll5_video                   1            1   844800048          0 0
> >             pll5_post_div             1            1   211200012          0 0
> >                pll5_video_div           1            1   211200012        0 0
> >                   ipu1_di0_pre_sel           1            1   211200012   0 0
> >                      ipu1_di0_pre           1            1    26400002    0 0
> >                         ipu1_di0_sel           1            1    26400002 0 0
> >                            ipu1_di0           1            1    26400002  0 0
> > 
> > 2) Without the patch applied:
> > pll5_bypass_src                       1            1    24000000          0 0
> >    pll5                               1            1   648000000          0 0
> >       pll5_bypass                     1            1   648000000          0 0
> >          pll5_video                   1            1   648000000          0 0
> >             pll5_post_div             1            1   162000000          0 0
> >                pll5_video_div           1            1    40500000        0 0
> >                   ipu1_di0_pre_sel           1            1    40500000   0 0
> >                      ipu1_di0_pre           1            1    20250000    0 0
> >                         ipu1_di0_sel           1            1    20250000 0 0
> >                            ipu1_di0           1            1    20250000  0 0
> 
> This seems to be broken since:
> 
> | commit b11d282dbea27db1788893115dfca8a7856bf205
> | Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
> | Date:   Thu Feb 13 12:03:59 2014 +0200
> | 
> |     clk: divider: fix rate calculation for fractional rates
> 
> This patch fixed a case when clk_set_rate(clk_round_rate(rate)) resulted
> in a lower frequency than clk_round_rate(rate) returned.
> 
> Since then the MULT_ROUND_UP in clk_divider_bestdiv() is inconsistent to
> the rest of the divider. Maybe this should be a simple rate * i now, but
> I'm unsure what side effects this has.
> 
> I think your patch only fixes the behaviour in your case by accident,
> it's not a correct fix for this issue.

Well, it's defined that:

	new_rate = clk_round_rate(clk, rate);

returns the rate which you would get if you did:

	clk_set_rate(clk, rate);
	new_rate = clk_get_rate(clk);

The reasoning here is that clk_round_rate() gives you a way to query what
rate you would get if you were to ask for the rate to be set, without
effecting a change in the hardware.

The idea that you should call clk_round_rate() first before clk_set_rate()
and pass the returned rounded rate into clk_set_rate() is really idiotic
given that.  Please don't do it, and please remove code which does it, and
in review comment on it.  Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
