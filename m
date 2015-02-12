From: Ying.Liu@freescale.com (Liu Ying)
Date: Thu, 12 Feb 2015 18:39:45 +0800
Subject: [PATCH RFC v9 01/20] clk: divider: Correct parent clk round rate
 if no bestdiv is normally found
In-Reply-To: <20150212093356.GR12209@pengutronix.de>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-2-git-send-email-Ying.Liu@freescale.com>
 <20150212093356.GR12209@pengutronix.de>
Message-ID: <20150212103944.GA1290@victor>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 10:33:56AM +0100, Sascha Hauer wrote:
> On Thu, Feb 12, 2015 at 02:01:24PM +0800, Liu Ying wrote:
> > If no best divider is normally found, we will try to use the maximum divider.
> > We should not set the parent clock rate to be 1Hz by force for being rounded.
> > Instead, we should take the maximum divider as a base and calculate a correct
> > parent clock rate for being rounded.
> 
> Please add an explanation why you think the current code is wrong and
> what this actually fixes, maybe an example?

The MIPI DSI panel's pixel clock rate is 26.4MHz and it's derived from PLL5 on
the MX6DL SabreSD board.

These are the clock tree summaries with or without the patch applied:
1) With the patch applied:
pll5_bypass_src                       1            1    24000000          0 0
   pll5                               1            1   844800048          0 0
      pll5_bypass                     1            1   844800048          0 0
         pll5_video                   1            1   844800048          0 0
            pll5_post_div             1            1   211200012          0 0
               pll5_video_div           1            1   211200012        0 0
                  ipu1_di0_pre_sel           1            1   211200012   0 0
                     ipu1_di0_pre           1            1    26400002    0 0
                        ipu1_di0_sel           1            1    26400002 0 0
                           ipu1_di0           1            1    26400002  0 0

2) Without the patch applied:
pll5_bypass_src                       1            1    24000000          0 0
   pll5                               1            1   648000000          0 0
      pll5_bypass                     1            1   648000000          0 0
         pll5_video                   1            1   648000000          0 0
            pll5_post_div             1            1   162000000          0 0
               pll5_video_div           1            1    40500000        0 0
                  ipu1_di0_pre_sel           1            1    40500000   0 0
                     ipu1_di0_pre           1            1    20250000    0 0
                        ipu1_di0_sel           1            1    20250000 0 0
                           ipu1_di0           1            1    20250000  0 0

> 
> > diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> > index c0a842b..f641d4b 100644
> > --- a/drivers/clk/clk-divider.c
> > +++ b/drivers/clk/clk-divider.c
> > @@ -311,7 +311,8 @@ static int clk_divider_bestdiv(struct clk_hw *hw, unsigned long rate,
> >  
> >  	if (!bestdiv) {
> >  		bestdiv = _get_maxdiv(divider);
> > -		*best_parent_rate = __clk_round_rate(__clk_get_parent(hw->clk), 1);
> > +		*best_parent_rate = __clk_round_rate(__clk_get_parent(hw->clk),
> > +						MULT_ROUND_UP(rate, bestdiv));
> 
> When getting into the if(!bestdiv) it means that the lowest possible
> rate we can archieve is still higher than the target rate, so setting
> the parent rate as low as possible seems sane to me. Why do you think
> this is wrong? In which case this even makes a difference?

We still should take the little left chance to get a closest target clock
rate we want(26.4MHz, in the example case above), so it looks that the lowest
parent clock rate for being rounded should be MULT_ROUND_UP(rate, bestdiv)
instead of 1Hz.

Regards,
Liu Ying

> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
