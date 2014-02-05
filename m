From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 05 Feb 2014 10:53:40 +0100
Subject: [PATCH v2 1/7] cpufreq: cpufreq-cpu0: allow optional safe voltage
 during frequency transitions
In-Reply-To: <20140201041051.9977.46568@quantum>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <2009408.gnUEcoqA3p@phil> <20140201041051.9977.46568@quantum>
Message-ID: <13010531.fmC0N07svH@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 31. Januar 2014, 20:10:51 schrieb Mike Turquette:
> Quoting Heiko St?bner (2014-01-30 07:09:04)
> 
> > On Thursday, 30. January 2014 18:23:44 Thomas Abraham wrote:
> > > Hi Mike,
> > > 
> > > On Wed, Jan 29, 2014 at 12:17 AM, Mike Turquette <mturquette@linaro.org>
> > 
> > wrote:
> > > > On Mon, Jan 27, 2014 at 9:30 PM, Thomas Abraham <ta.omasab@gmail.com>
> > 
> > wrote:
> > > >> Hi Mike,
> > > >> 
> > > >> On Tue, Jan 28, 2014 at 1:55 AM, Mike Turquette
> > > >> <mturquette@linaro.org>
> > 
> > wrote:
> > > >>> Quoting Thomas Abraham (2014-01-18 04:10:51)
> > > > 
> > > > As far as I can tell
> > > > the remux does not happen because it is necessary to generate the
> > > > required clock rate, but because we don't want to run the ARM core out
> > > > of spec for a short time while the PLL relocks. Assuming I have that
> > > > part of it right, I prefer for the parent mux operation to be a part
> > > > of the CPUfreq driver's .target callback instead of hidden away in the
> > > > clock driver.
> > > 
> > > The re-parenting is mostly done to keep the ARM CPU clocked while the
> > > PLL is stopped, reprogrammed and restarted. One of the side effects of
> > > that is, the clock speed of the temporary parent could be higher then
> > > what is allowed due to the ARM voltage at the time of re-parenting.
> > > That is the reason to use the safe voltage.
> > 
> > The Rockchip-SoCs use something similar, so I'm following quite closely
> > what Thomas is trying to do here, as similar solution would also solve
> > this issue for me.
> > 
> > On some Rockchip-SoCs even stuff like pclk and hclk seems to be sourced
> > from the divided armclk, creating additional constraints.
> > 
> > But on the RKs (at least in the upstream sources) the armclk is simply
> > equal to the pll output. A divider exists, but is only used to make sure
> > that the armclk stays below the original rate when sourced from the
> > temp-parent, like> 
> >         if (clk_get_rate(temp_parent) > clk_get_rate(main_parent)
> >         
> >                 set_divider(something so that rate(temp) <= rate(main)
> >         
> >         clk_set_parent(...)
> > 
> > Isn't there a similar possiblity on your platform, as it would remove the
> > need for the safe-voltage?
> > 
> > 
> > In general I also like the approach of hiding the rate-change logic inside
> > this composite clock, as the depending clocks can be easily kept in sync.
> > As with the Rockchips the depending clocks are different for each of the
> > three Cortex-A9 SoCs I looked at, it would be "interesting" if all of
> > this would need to be done in a cpufreq driver.
> 
> I wonder if hiding these details inside of the composite clock
> implementation indicates the lack of some needed feature in the clk
> core? I've discussed the idea of "coordinated rate changes" before. E.g:
> 
> _________________________________________________________
> 
> |  clk	|  opp-low	|  opp-mid	|  opp-fast	|
> |
> |pll	| 300000	|  600000	|  600000	|
> |
> |div	| 150000	|  300000	|  600000	|
> |
> |mpu_clk| 150000	|  300000       |  600000	|
> |
> |periph	| 150000	|  150000	|  300000	|
> 
> ---------------------------------------------------------
> 
> A call to clk_set_rate() against any of those clocks will result in all
> of their dividers being updated. At the implementation level this might
> look something like this extremely simplified pseudocode:
> 
> int clk_set_rate(struct clk* clk, unsigned long rate)
> {
> 	/* trap clks that support coordinated rate changes */
> 	if (clk->ops->coordinate_rate)
> 		return clk->ops->coordinate_rate(clk->hw, rate);
> 	...
> }
> 
> and,
> 
> struct coord_rates {
> 	struct clk_hw *hw;
> 	struct clk *parent;
> 	struct clk *rate;
> };
> 
> and in the clock driver,
> 
> #define PLL 0
> #define DIV 1
> #define MPU 2
> #define PER 3
> 
> #define NR_OPP 4
> #define NR_CLK 4
> 
> struct coord_rates my_opps[NR_OPP][NR_CLK]; // populated from DT data
> 
> int my_coordinate_rate_callback(struct clk_hw *hw, unsigned long rate)
> {
> 	struct coord_rate **selected_opp;
> 
> 	for(i = 0; i < NR_OPP; i++) {
> 		for(j = 0; j < NR_CLK; j++) {
> 			if (my_opps[i][j]->hw == hw &&
> 				my_opps[i][j]->rate == rate)
> 				selected_opp = my_opps[i];
> 				break;
> 		}
> 	}
> 
> 	/*
> 	 * order of operations is specific to my hardware and should be
> 	 * managed by my clock driver, not generic code
> 	 */
> 
> 	__clk_set_parent(selected_opp[DIV]->hw, temp_parent);
> 	__clk_set_rate(selected_opp[PLL]->hw, selected_opp[PLL]->rate);
> 	__clk_set_parent(selected_opp[DIV]->hw,
> 				selected_opp[PLL]->hw->clk);
> 	...
> 
> 	/*
> 	 * note that the above could be handled by a switch-case or
> 	 * something else
> 	 */
> }
> 
> Thoughts? Please forgive any gaps in my logic or abuse of C.
> 
> I have long thought that something like the above would someday go into
> a generic dvfs layer instead of the clock framework, but maybe starting
> with the clk framework makes more sense?

Similar to Thomas, this looks like the thing I'd need for my core clocks.

Also to me this really looks like something belonging to the clock framework, 
as we at this point really only have some clocks that in all cases need to be 
set together, independent of it beeing embedded in some scaling context or 
something else.


Heiko
