From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 10 Mar 2015 00:34:16 +0100
Subject: [PATCH 0/3] clk: divider: three exactness fixes (and a rant)
In-Reply-To: <54FE215D.7090804@codeaurora.org>
References: <20150221085620.GV19388@pengutronix.de>
 <1424515225-6929-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150306185730.11109.45998@quantum>
 <20150306192813.GG10717@pengutronix.de>
 <54FA02B7.8090703@codeaurora.org>
 <1425895136.3152.22.camel@pengutronix.de>
 <54FDEEFE.1060803@codeaurora.org>
 <20150309210735.14952.91257@quantum>
 <20150309215803.GD7525@pengutronix.de>
 <54FE215D.7090804@codeaurora.org>
Message-ID: <20150309233416.GF7525@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

On Mon, Mar 09, 2015 at 03:40:29PM -0700, Stephen Boyd wrote:
> On 03/09/15 14:58, Uwe Kleine-K?nig wrote:
> > If you see
> >
> > 	round_rate(110) = 108
> >
> > it would be fortunate to know if you get 108 because the next available
> > greater rate is > 112 or because the implementation rounds down always
> > (which would mean that 111 is possible, too). For the "easy" consumers
> > this probably doesn't matter much, but if you do things that affects
> > a considerable part of the clock tree, you really want to know more
> > about the behaviour of round_rate to effectively work with its results.
> >
> > So yes, please let us pick ceiling for round_rate (i.e. a fixed policy
> > for all clks) and then it should even be possible to make
> > clk_set_rate_range a generic function that doesn't need the min and max
> > members in the clk struct and the respective parameters to
> > determine_rate.
> >
> > What should a clock that can only provide 100 Hz return on
> >
> > 	clk_round_rate(clk, 60);
> >
> > ? 0? -ESOMETHING (for SOMETHING = ...?)?
> >
> 
> Do you have any real world use cases, or is this just all theoretical?
The question about clk_round_rate(fixed_clk_100hz, 60) is an
implementation detail that we must handle after agreeing that
clk_round_rate should always round down. I faced that when I tried to
implement this rounding requirement for dividers.

> At least in Philipp's panel case we can discuss how to make an API that
> works properly. These other examples are either completely theoretical
> or taken out of context and so it's unclear how they matter in practice.
We can stick to Philipp's panel case if you want. Philipp wants to find
a rate between 100 Hz and 120 Hz and likes 110 Hz most. And the lower
abs(1 / 110 - 1 / r) the better. Let's assume the clk is provided by a
fixed clk with 10000 Hz that goes through two 4bit-dividers. (So no,
that's not a real world use case, but I imagine that something like that
can occur and should definitely be possible to handle.) Something
similar happens if you have for example an i2c bus device that has a
built-in divider. For the lowest consumer the situation is easy most of
the time: It wants a certain frequency to update a panel, or it wants at
most 100 kHz on the i2c bus. But already for the divider one step up
the clk tree it's not that easy any more.

> Ideally I'd like an API to exist that doesn't require going back and
> forth with the framework (i.e. it's "atomic" and doesn't require calling
> clk_round_rate() in a loop) and that allows consumers to properly
Why is calling "clk_round_rate() in a loop" bad? In some situations you
won't be able to do something different.

> express what they want. Right now we have a way to say min/max and a
> typical rate is in the works. If we need to declare some sort of clock
> provider rounding policy then we've failed to provide an API that
> properly expresses all the requirements that the consumer has. It
I think you don't want a way to express: "I want a frequency that I
can divide down to 110 Hz with a divider picked from [1 ... 16].".
And even if we somehow manage to create something like that in a sane
way, I think the only reliable and maintainable way to get there is to
not ask all clock types to implement this functionality.
That is, I want the complexity at a single place in the framework and
only ask easy things from the clk type implementors. A .round_rate
callback is easy for most clk types. .determine_rate a bit less and it
already promotes boilerplate because each implementation has to check
for min_rate and max_rate. And .determine_rate as it is today doesn't
even support the typical value yet.

> probably means we're missing some key parameter that consumers know but
> we don't accept. Maybe some more concrete examples will help clarify
> what this is.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
