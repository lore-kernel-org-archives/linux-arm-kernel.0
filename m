From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 08 Aug 2013 22:32:03 -0700
Subject: [PATCH v1 04/14] clk: Add set_rate_and_parent() op
In-Reply-To: <20130725164542.GF29694@codeaurora.org>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-5-git-send-email-sboyd@codeaurora.org>
 <4582949.WCP5JfKYES@flatron> <20130725164542.GF29694@codeaurora.org>
Message-ID: <20130809053203.5348.40567@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2013-07-25 09:45:42)
> On 07/25, Tomasz Figa wrote:
> > On Wednesday 24 of July 2013 17:43:32 Stephen Boyd wrote:
> > > Some of Qualcomm's clocks can change their parent and rate at the
> > > same time with a single register write. Add support for this
> > > hardware to the common clock framework by adding a new
> > > set_rate_and_parent() op. When the clock framework determines
> > > that both the parent and the rate are going to change during
> > > clk_set_rate() it will call the .set_rate_and_parent() op if
> > > available and fall back to calling .set_parent() followed by
> > > .set_rate() otherwise.
> > 
> > This is strange. Does you hardware support switching parent and rate 
> > separately or you always need to set both and so all the fuss here?
> 
> It supports setting the parent or setting the rate, or setting
> both at the same time.

I think that setting parent and rate at the same time is a common enough
case to merit handling it in the clock core. Probably this design will
become more common in time.

Regards,
Mike

> 
> > 
> > If the latter is the case, then maybe you can simply keep parent index and 
> > rate cached inside driver data of your clock driver and use them on any 
> > .set_rate() or .set_parent() calls?
> 
> This will not work. In fact, doing that would cause us to
> overclock hardware for a short time between switching the parent
> and the rate.
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
