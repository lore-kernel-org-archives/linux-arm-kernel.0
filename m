From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 2 Jan 2018 11:01:59 -0800
Subject: [PATCH 01/33] clk_ops: change round_rate() to return unsigned long
In-Reply-To: <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
 <1514596392-22270-2-git-send-email-pure.logic@nexus-software.ie>
 <9f4bef5a-8a71-6f30-5cfb-5e8fe133e3d3@kapsi.fi>
 <6d83a5c3-6589-24bc-4ca5-4d1bbca47432@nexus-software.ie>
Message-ID: <20180102190159.GH7997@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/31, Bryan O'Donoghue wrote:
> On 30/12/17 16:36, Mikko Perttunen wrote:
> >FWIW, we had this problem some years ago with the Tegra CPU clock
> >- then it was determined that a simpler solution was to have the
> >determine_rate callback support unsigned long rates - so clock
> >drivers that need to return rates higher than 2^31 can instead
> >implement the determine_rate callback. That is what's currently
> >implemented.
> >
> >Mikko
> 
> Granted we could work around it but, having both zero and less than
> zero indicate error means you can't support larger than LONG_MAX
> which is I think worth fixing.
> 

Ok. But can you implement the determine_rate op instead of the
round_rate op for your clk? It's not a work-around, it's the
preferred solution. That would allow rates larger than 2^31 for
the clk without pushing through a change to all the drivers to
express zero as "error" and non-zero as the rounded rate.

I'm not entirely opposed to this approach, because we probably
don't care to pass the particular error value from a clk provider
to a clk consumer about what the error is. It's actually what we
proposed as the solution for clk_round_rate() to return values
larger than LONG_MAX to consumers. But doing that consumer API
change or this provider side change is going to require us to
evaluate all the consumers of these clks to make sure they don't
check for some error value that's less than zero. This series
does half the work, by changing the provider side, while ignoring
the consumer side and any potential fallout of the less than zero
to zero return value change.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
