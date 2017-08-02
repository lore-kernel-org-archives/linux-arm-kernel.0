From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Wed, 2 Aug 2017 10:09:54 +0530
Subject: [PATCH v2 3/5] clk: qcom: gdsc: Add support to control associated
 clks
In-Reply-To: <3e97d797-774f-fb5c-eb01-7b4761f17d91@codeaurora.org>
References: <1500526099-9935-1-git-send-email-rnayak@codeaurora.org>
 <1500526099-9935-4-git-send-email-rnayak@codeaurora.org>
 <20170727230259.GR2146@codeaurora.org>
 <b1db092a-edd8-76e9-f1d2-91bf123638d7@codeaurora.org>
 <20170728163753.GB2146@codeaurora.org>
 <3e97d797-774f-fb5c-eb01-7b4761f17d91@codeaurora.org>
Message-ID: <a123df26-228f-aab4-f99a-05a4463523c6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/31/2017 01:55 PM, Rajendra Nayak wrote:
[]..

>>>> This concerns me if we do probe defer on orphan clks. We may get
>>>> into some situation where the gdsc is setup by a clk driver that
>>>> is trying to probe before some parent clk has registered for the
>>>> clks we're "getting" here. For example, this could easily happen
>>>> if we insert XO into the tree at the top and everything defers.
>>>>
>>>> I suppose this is not a problem because in this case we don't
>>>> have any clk here that could be orphaned even if RPM clks are
>>>> inserted into the clk tree for XO? I mean to say that we won't
>>>> get into a probe defer due to orphan clk loop. I'm always afraid
>>>> someone will make hardware that send a clk from one controller to
>>>> another and then back again (we did that with pcie) and then
>>>> we'll be unable to get out of the defer loop because we'll be
>>>> deferred on orphan status.
>>>
>>> Yes, we would probably run into these issues with probe defer for
>>> orphan clks. One way to handle it could be to decouple the probing
>>> of the clocks and powerdomain parts of the controller. Like the clock
>>> driver can probe and then register a dummy device for powerdomains
>>> (like is done for tsens on 8960) so it could probe independently?
>>>
>>
>> Well is it a problem right now? I think we're OK here because we
>> don't have a "cycle" between clk providers in the clk provider
>> hierarchy. Can we clk_get() during attach and then fail attach if
>> we can't get clks at that point? If this works, we have a backup
>> plan should something go wrong, but we can ignore this concern
>> for now until it becomes a real problem.
> 
> we don't have a cycle but I was worried about gcc being deferred until
> RPM clocks are probed and MMCC getting probed in between, and MMCC init
> before GCC init would have us run into issues.
> But I should be able to defer the clk_get()'s to during pm domain attach
> and it should all work in that case.

So one issue I run into trying to move the clk_get() to during attach is,
most of these GDSCs to which we are associating the mmagic clocks are
votable and some of them happen to be ON when the gdsc driver probes.

And we have this to handle the situation..

        /*
         * Votable GDSCs can be ON due to Vote from other masters.
         * If a Votable GDSC is ON, make sure we have a Vote.
         */
        if ((sc->flags & VOTABLE) && on)
                gdsc_enable(&sc->pd);

And now since we defer clk_get() to a later point, the gdsc
can't really be enabled along with the enable/voting of the 
associated clocks.

I was thinking we do something like this instead,

	/*
	 * Votable GDSCs can be ON due to Vote from other masters.
	 * If *we* haven't Voted for it, tell genpd its actually OFF.
	 */
	if ((sc->flags & VOTABLE) && on)
		on = !on;

What do you think?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
