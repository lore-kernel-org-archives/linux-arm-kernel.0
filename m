From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 16 May 2013 15:29:57 -0700
Subject: [PATCH v2] clk: Fix race condition between clk_set_parent and
 clk_enable()
In-Reply-To: <5195502B.3070003@codeaurora.org>
References: <1367383328-25700-1-git-send-email-skannan@codeaurora.org>
 <1368677244-7279-1-git-send-email-skannan@codeaurora.org>
 <20130516204455.12127.75296@quantum> <5195502B.3070003@codeaurora.org>
Message-ID: <20130516222957.12127.25336@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Saravana Kannan (2013-05-16 14:31:23)
> On 05/16/2013 01:44 PM, Mike Turquette wrote:
> > Quoting Saravana Kannan (2013-05-15 21:07:24)
> >> Without this patch, the following race condition is possible.
> >> * clk-A has two parents - clk-X and clk-Y.
> >> * All three are disabled and clk-X is current parent.
> >> * Thread A: clk_set_parent(clk-A, clk-Y).
> >> * Thread A: <snip execution flow>
> >> * Thread A: Grabs enable lock.
> >> * Thread A: Sees enable count of clk-A is 0, so doesn't enable clk-Y.
> >> * Thread A: Updates clk-A SW parent to clk-Y
> >> * Thread A: Releases enable lock.
> >> * Thread B: clk_enable(clk-A).
> >> * Thread B: clk_enable() enables clk-Y, then enabled clk-A and returns.
> >>
> >> clk-A is now enabled in software, but not clocking in hardware since the
> >> hardware parent is still clk-X.
> >>
> >> The only way to avoid race conditions between clk_set_parent() and
> >> clk_enable/disable() is to ensure that clk_enable/disable() calls don't
> >> require changes to hardware enable state between changes to software clock
> >> topology and hardware clock topology.
> >>
> >> The options to achieve the above are:
> >> 1. Grab the enable lock before changing software/hardware topology and
> >>     release it afterwards.
> >> 2. Keep the clock enabled for the duration of software/hardware topology
> >>     change so that any additional enable/disable calls don't try to change
> >>     the hardware state. Once the topology change is complete, the clock can
> >>     be put back in its original enable state.
> >>
> >> Option (1) is not an acceptable solution since the set_parent() ops might
> >> need to sleep.
> >>
> >> Therefore, this patch implements option (2).
> >>
> >> This patch doesn't violate any API semantics. clk_disable() doesn't
> >> guarantee that the clock is actually disabled. So, no clients of a clock
> >> can assume that a clock is disabled after their last call to clk_disable().
> >> So, enabling the clock during a parent change is not a violation of any API
> >> semantics.
> >>
> >> This also has the nice side effect of simplifying the error handling code.
> >>
> >> Signed-off-by: Saravana Kannan <skannan@codeaurora.org>
> >
> > Updated to this version in clk-next.
> >
> 
> Thanks Mike. I forgot to add the Ack by Ulf. Would be nice if you can 
> put that in.
> 

Yes I picked up the Ack.

Regards,
Mike

> Btw, I did send this email to the list. But looks like this mail is 
> wedged in the series of tubes in the arm mailing list.
> 
> -Saravana
> 
> 
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
