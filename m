From: heiko@sntech.de (Heiko Stuebner)
Date: Wed, 20 Jan 2016 23:29:56 +0100
Subject: [PATCH v2] clk-divider: make sure read-only dividers do not write
 to their register
In-Reply-To: <20160120221604.GC12841@codeaurora.org>
References: <8710207.gKyLbM2bKY@phil> <3578615.iBrKplh45Q@phil>
 <20160120221604.GC12841@codeaurora.org>
Message-ID: <2694181.qDMgtzpC9k@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 20. Januar 2016, 14:16:56 schrieb Stephen Boyd:
> On 01/20, Heiko Stuebner wrote:
> > Commit e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1")
> > removed the special ops struct for read-only clocks and instead opted
> > to handle them regularly.
> > 
> > On the rk3368 this results in breakage as aclkm now gets set a value.
> > While it is the same divider value, the A53 core still doesn't like it,
> > which can result in the cpu ending up in a hang.
> > The reason being that "ACLKENMasserts one clock cycle before the rising
> > edge of ACLKM" and the clock should only be touched when STANDBYWFIL2
> > is asserted.
> > 
> > So make sure read-only clocks don't touch the clock-register at all
> > even if only writing the same value, as even writing the same value
> > may not be safe in all cases.
> > 
> > Fixes: e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1")
> > Reported-by: Zhang Qing <zhangqing@rock-chips.com>
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > Reviewed-by: James Hogan <james.hogan@imgtec.com>
> > ---
> 
> Hmph, the same patch[1] has been sitting in my inbox for months
> now but I never got a response to my last question and then
> forgot about it. I'll repeat the question here and hopefully we
> can finish the discussion.
> 
> Maybe it would make more sense to have different ops for read
> only dividers? The clk_set_rate op would be empty, while we would
> have proper recalc_rate and round_rate ops. We can't just flat
> out revert commit e6d5e7d90be9 (clk-divider: Fix READ_ONLY when
> divider > 1, 2014-11-14) because that will introduce the problem
> that it was fixing, but as long as we implement round_rate in
> addition to recalc_rate it should work.
> 
> [1]
> http://lkml.kernel.org/r/1428392806-14538-1-git-send-email-jy0922.shim at sa
> msung.com

Sorry for the second submission then. That really is from quite a while ago. 
Reintroducing a secondary ops-struct with a round-rate sounds fine for my 
side - I'll give that a shot tomorrow.


Heiko
