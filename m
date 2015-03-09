From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 09 Mar 2015 15:40:29 -0700
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <20150309215803.GD7525@pengutronix.de>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150306185730.11109.45998@quantum> <20150306192813.GG10717@pengutronix.de>
 <54FA02B7.8090703@codeaurora.org> <1425895136.3152.22.camel@pengutronix.de>
 <54FDEEFE.1060803@codeaurora.org> <20150309210735.14952.91257@quantum>
 <20150309215803.GD7525@pengutronix.de>
Message-ID: <54FE215D.7090804@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/09/15 14:58, Uwe Kleine-K?nig wrote:
>
> If you see
>
> 	round_rate(110) = 108
>
> it would be fortunate to know if you get 108 because the next available
> greater rate is > 112 or because the implementation rounds down always
> (which would mean that 111 is possible, too). For the "easy" consumers
> this probably doesn't matter much, but if you do things that affects
> a considerable part of the clock tree, you really want to know more
> about the behaviour of round_rate to effectively work with its results.
>
> So yes, please let us pick ceiling for round_rate (i.e. a fixed policy
> for all clks) and then it should even be possible to make
> clk_set_rate_range a generic function that doesn't need the min and max
> members in the clk struct and the respective parameters to
> determine_rate.
>
> What should a clock that can only provide 100 Hz return on
>
> 	clk_round_rate(clk, 60);
>
> ? 0? -ESOMETHING (for SOMETHING = ...?)?
>

Do you have any real world use cases, or is this just all theoretical?
At least in Philipp's panel case we can discuss how to make an API that
works properly. These other examples are either completely theoretical
or taken out of context and so it's unclear how they matter in practice.

Ideally I'd like an API to exist that doesn't require going back and
forth with the framework (i.e. it's "atomic" and doesn't require calling
clk_round_rate() in a loop) and that allows consumers to properly
express what they want. Right now we have a way to say min/max and a
typical rate is in the works. If we need to declare some sort of clock
provider rounding policy then we've failed to provide an API that
properly expresses all the requirements that the consumer has. It
probably means we're missing some key parameter that consumers know but
we don't accept. Maybe some more concrete examples will help clarify
what this is.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
