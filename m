From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 28 Jul 2017 09:37:53 -0700
Subject: [PATCH v2 3/5] clk: qcom: gdsc: Add support to control
 associated clks
In-Reply-To: <b1db092a-edd8-76e9-f1d2-91bf123638d7@codeaurora.org>
References: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
 <1500526099-9935-4-git-send-email-rnayak@codeaurora.org>
 <20170727230259.GR2146@codeaurora.org>
 <b1db092a-edd8-76e9-f1d2-91bf123638d7@codeaurora.org>
Message-ID: <20170728163753.GB2146@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/28, Rajendra Nayak wrote:
> 
> 
> On 07/28/2017 04:32 AM, Stephen Boyd wrote:
> > On 07/20, Rajendra Nayak wrote:
> > 
> >> +		clk_disable_unprepare(sc->clks[i]);
> >> +}
> >> +
> >>  static int gdsc_enable(struct generic_pm_domain *domain)
> >>  {
> >>  	struct gdsc *sc = domain_to_gdsc(domain);
> >> @@ -193,6 +219,10 @@ static int gdsc_enable(struct generic_pm_domain *domain)
> >>  	 */
> >>  	udelay(1);
> >>  
> >> +	ret = gdsc_clk_enable(sc);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >>  	/* Turn on HW trigger mode if supported */
> >>  	if (sc->flags & HW_CTRL) {
> >>  		ret = gdsc_hwctrl(sc, true);
> >> @@ -241,6 +271,8 @@ static int gdsc_disable(struct generic_pm_domain *domain)
> >>  			return ret;
> >>  	}
> >>  
> >> +	gdsc_clk_disable(sc);
> > 
> > Can we call sleeping APIs (i.e. prepare/unprepare) from within
> > the power domains? I thought that didn't work generically because
> > someone could set their runtime PM configuration to be atomic
> > context friendly. Is there some way we can block that from
> > happening if we hook up a power domain that is no longer safe to
> > call from atomic context?
> 
> hmm, I don't see a way to do that. Perhaps we could prepare/unprepare
> these as part of the pm_domain attach/detach to a device and then
> only enable/disable them as part of the gdsc_enable/disable?
> 

The problem there is if we keep these clks prepared while the
domain is attached to a device I don't see how we can ever turn
off the XO clk and achieve XO shutdown in low power modes. A pm
domain is basically never detached, right? This is where we need
different power levels in PM domains if I understand correctly.

> > 
> > This concerns me if we do probe defer on orphan clks. We may get
> > into some situation where the gdsc is setup by a clk driver that
> > is trying to probe before some parent clk has registered for the
> > clks we're "getting" here. For example, this could easily happen
> > if we insert XO into the tree at the top and everything defers.
> > 
> > I suppose this is not a problem because in this case we don't
> > have any clk here that could be orphaned even if RPM clks are
> > inserted into the clk tree for XO? I mean to say that we won't
> > get into a probe defer due to orphan clk loop. I'm always afraid
> > someone will make hardware that send a clk from one controller to
> > another and then back again (we did that with pcie) and then
> > we'll be unable to get out of the defer loop because we'll be
> > deferred on orphan status.
> 
> Yes, we would probably run into these issues with probe defer for
> orphan clks. One way to handle it could be to decouple the probing
> of the clocks and powerdomain parts of the controller. Like the clock
> driver can probe and then register a dummy device for powerdomains
> (like is done for tsens on 8960) so it could probe independently?
> 

Well is it a problem right now? I think we're OK here because we
don't have a "cycle" between clk providers in the clk provider
hierarchy. Can we clk_get() during attach and then fail attach if
we can't get clks at that point? If this works, we have a backup
plan should something go wrong, but we can ignore this concern
for now until it becomes a real problem.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
