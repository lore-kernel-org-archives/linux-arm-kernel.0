From: mturquette@baylibre.com (Michael Turquette)
Date: Tue, 11 Aug 2015 14:30:41 -0700
Subject: [PATCH v2 1/7] clk: Add a basic factor clock
In-Reply-To: <20150725073925.GK2564@lukather>
References: <1432241646-9511-1-git-send-email-maxime.ripard@free-electrons.com>
 <1432241646-9511-2-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v64rqRC24wPWz5xYZv=w2QAtsCb-pd76Qynkb5NBCptXhQ@mail.gmail.com>
 <20150523074930.GI8557@lukather> <20150724000001.642.84690@quantum>
 <20150724065017.GJ2373@lukather> <20150724182619.642.11590@quantum>
 <20150725073925.GK2564@lukather>
Message-ID: <20150811213041.31346.58562@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Maxime Ripard (2015-07-25 00:39:25)
> Hi Mike,
> 
> On Fri, Jul 24, 2015 at 11:26:19AM -0700, Michael Turquette wrote:
> > > What are the issues with maintaining them? The only drawback I'm
> > > seeing with introducing such a driver is that you can't really have a
> > > clock that is both a divider and a multiplier, but that can be solved
> > > by splitting it into two sub-clocks.
> > 
> > There are a bunch of problems with the basic clock types. First is that
> > there is some feature creep every merge window that subtly breaks an
> > existing user (e.g. the round_rate stuff in clk-divider.c), and then
> > there are the growing number of flags to handle corner cases that are
> > one-off quirks for a single chip.
> > 
> > These make it harder to maintain, but it is possible.
> 
> Ok. It's the downside of having common code I guess, everyone wants to
> use it, and the clocks are just more subject to it than other drivers :/
> 
> > The real problem with these basic clock types is that they are an
> > abstraction layer at the wrong level. Each clock type implements both
> > the policy of a given clock, as well as the machine-specific details.
> > For example clk-divider.c has made some assumptions in the past about
> > rounding the rate, or how to calculate the best divider; this is a
> > matter of policy and is useful on its own. But additionally that same
> > policy is glued to a specific implementation: memory-mapped register
> > controls for a clock divider.
> > 
> > The I/O accessor stuff needs to be addressed at some point.  Currently
> > the basic clock types assume specific patterns of access to
> > memory-mapped clock registers. There are lots of other clock controls
> > out there that talk to firmware, or over i2c, or whatever. The amount of
> > code that has to be copy/pasted for each different type of access is
> > 100%; i.e. we do not have abstractions at the right level such as
> > .get_best_div(struct clk_hw *hw, unsigned long rate).
> > 
> > What I would like to see in time is a re-usable layer for clock policy
> > (e.g. common rules for how dividers or multipliers should behave), and
> > then have that sit on top of the machine-specific callbacks that
> > directly touch the hardware, such as the .get_best_div callback above.
> 
> Can't that be solved by moving to regmap using Matthias' patches, or
> at least the IO method abstraction?

I need to look at those patches again, but I do not think they address
the problem I described above: abstraction at the wrong level (or more
specifically, combining two abstract layers into one).

I'll have more bandwidth to look at this problem after the next merge
window. The clk framework is slowly be rewritten in bits and pieces here
on the list (shh don't tell anybody) and this is on my radar and
Stephen's.

Regards,
Mike

> 
> We would then have to only provide an additional callback then for
> providers that have specific requirements about the divider
> calculation.
> 
> So far, I haven't had any usecase where I needed anything but having
> the as-close-as-possible rate, so I would expect to not provide
> anything beside whether I'd like to round down or round up, but I do
> understand that some other might have different requirements.
> 
> > For this reason I like to limit the number of new basic clock types. If
> > there is a single user then I'm inclined to have the author put it with
> > the machine-specific code. But in this case since there are two users, I
> > see the value in making a new basic clock type.
> 
> That makes sense.
> 
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
