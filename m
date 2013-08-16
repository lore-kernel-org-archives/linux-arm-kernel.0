From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 15 Aug 2013 20:44:06 -0700
Subject: [PATCH v1 03/14] clk: Add of_clk_match() for device drivers
In-Reply-To: <20130816013118.GC27999@codeaurora.org>
References: <1374713022-6049-1-git-send-email-sboyd@codeaurora.org>
 <1374713022-6049-4-git-send-email-sboyd@codeaurora.org>
 <20130812202347.5348.76490@quantum> <20130813054839.GF14845@codeaurora.org>
 <20130815050226.4443.39100@quantum> <20130816013118.GC27999@codeaurora.org>
Message-ID: <20130816034406.4443.16767@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2013-08-15 18:31:19)
> On 08/14, Mike Turquette wrote:
> > Quoting Stephen Boyd (2013-08-12 22:48:39)
> > > On 08/12, Mike Turquette wrote:
> > > > Quoting Stephen Boyd (2013-07-24 17:43:31)
> > > > > In similar fashion as of_regulator_match() add an of_clk_match()
> > > > > function that finds an initializes clock init_data structs from
> > > > > devicetree. Drivers should use this API to find clocks that their
> > > > > device is providing and then iterate over their match table
> > > > > registering the clocks with the init data parsed.
> > > > > 
> > > > > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > > > 
> > > > Stephen,
> > > > 
> > > > In general I like this approach. Writing real device drivers for clock
> > > > controllers is The Right Way and of_clk_match helps.
> > > > 
> > > > Am I reading this correctly that the base register addresses/offsets for
> > > > the clock nodes still come from C files? For example I still see
> > > > pll8_desc defining reg stuff in drivers/clk/msm/gcc-8960.c.
> > > 
> > > I think we may be able to put the registers in DT but I don't
> > > know why we need to do that if we're already matching up nodes
> > > with C structs.
> > 
> > The reason to do so is to remove the per-clock data from the kernel
> > sources entirely. Separating logic and data.
> 
> Ok.
> 
> > 
> > > It also made me want to introduce devm_of_iomap()
> > > which just seemed wrong (if you have a dev struct why can't you
> > > use devm_ioremap()).
> > > 
> [snip]
> > > 
> > > This is great for making the kernel DT-data-driven, but I
> > > couldn't find any other driver that was describing register level
> > > details in DT.
> > 
> > Yeah, this sucks. Building a binding from a C struct is a bad idea. How
> > many permutations are there? Hopefully some clocks use the same bit
> > shifts and have reliable register offsets, with the only difference
> > being base address. If this is the case then a compatible string could
> > be done for each permutation assuming that number is low and manageable.
> 
> In the multimedia controller almost every clock has a different
> register layout. Making a compatible string for each clock is
> pretty much what I've done if you consider that I match up the
> name of the node to a struct instead of matching a compatible
> string to a struct.

Right, the data has to live somewhere and any solution that puts static
per-clock data in the kernel solves the matching in one way or another.
The "map a clock to a number" approach does the same thing, but
differently (though I like this approach better than the number mapping
one).

I guess we're at a point where two different guidelines are at odds. The
first is not to put register-level details into DT. The second is to
move data out of the kernel and stop all of the "crazy churn" that Linus
ranted about in his famous email 2-3 years back.

> In the global controller it's more sane,
> following a single register layout per compatible string.
> Remember though, all the single bit clocks (gates or what we call
> branches) have a completely random location for their on/off bit
> and status bit.

I looked at the branch clock data in gcc-8960.c and gcc-8974.c and there
are more bits to twiddle and more registers to access than I thought
there would be. As a counter example I am happy with simple gate clock
implementations specifying a single bit to enable/disable a clock in DT.
That's really not such a big deal.

However without a somewhat common pattern to this stuff you need to keep
it in C. But you said that common patterns are on the horizon for your
platform; I guess you're going to reuse some of these clock types for
that upcoming stuff, right? What do you think about taking that into
account and adding an optional 'reg' property to the binding definition?
The purpose of that would be so that the same binding here could be used
for the future stuff, but all of the data could live in DT. That's where
I'd like things to get to eventually.

Regards,
Mike

> 
> > 
> > > 
> > > The good news is that newer clock controllers follow a standard
> > > and so we can specify one or two register properties and the type
> > > of clock and we're pretty much done. The software interface
> > > hasn't been randomized like on earlier controllers and bits
> > > within registers are always the same.
> > 
> > This does not suck. Just for the sake of argument let's say that you
> > only had to deal with this new and improved register layout and not the
> > old (current) stuff. Do you still see a reason to match DT data up with
> > C struct data objects in the kernel?
> 
> I would still need to match up frequency tables unless I figure
> out a way to put that in DT too.
> 
> > 
> > > We still have some clocks
> > > that are just on/off switches though and so we'll have to put
> > > register level details like which bit turns that clock on in DT
> > > (which I believe is not preferred/allowed?). I don't see any way
> > > to avoid that if we want it to be entirely DT driven.
> > 
> > This is what I'm doing for the generic clock bindings. No one has
> > screamed over that stuff so I guess rules were meant to be broken.
> > 
>  
> 
> -- 
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
> hosted by The Linux Foundation
