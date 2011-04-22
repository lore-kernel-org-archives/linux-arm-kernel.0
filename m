From: skannan@codeaurora.org (Saravana Kannan)
Date: Thu, 21 Apr 2011 21:54:03 -0700
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104211632240.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>	<alpine.LFD.2.02.1104201704350.3323@ionos>	<20110420185922.GD31131@pengutronix.de>	<alpine.LFD.2.02.1104202113250.3323@ionos>	<20110421074214.GE15233@pengutronix.de>	<alpine.LFD.2.02.1104211113030.3323@ionos>	<20110421120656.GF15233@pengutronix.de>
	<alpine.LFD.2.02.1104211632240.3323@ionos>
Message-ID: <4DB109EB.6000709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/21/2011 08:38 AM, Thomas Gleixner wrote:
> On Thu, 21 Apr 2011, Sascha Hauer wrote:
>> On Thu, Apr 21, 2011 at 11:21:53AM +0200, Thomas Gleixner wrote:
>> That's why I tried to sort out some common patterns (divider, gates,
>> muxes) and put them into drivers/clk for other people to use it. It's
>> enough to build a whole clock tree out of it (except plls and special
>> stuff). All things you mentioned which are missing in the common clock
>> stuff can be added without touching the i.MX specific parts. You want
>> the framework (once it actually is one) to handle the parents? just move
>> the parent handling out of drivers/clk/clk-[divider|mux|gate].c to
>> drivers/clk/clk.c. Refcounting shall be fixed? do so in
>> drivers/clk/clkdev.c.
>
> The point is that we want to do stuff like that now - BEFORE anyone
> starts using struct clk and the helper functions.
>
>> I didn't say that the patches I posted shall be moved upstream as-is. I
>> only wanted to show how a clock tree can look like when we sort out
>> common patterns.
>
> We really want to get some sensible functionality for starting.
>
> So what I can see now from the discussion is that we should at least
> add the following fields to struct clk:
>
>         unsigned long  flags;
>         unsigned long   rate;
>         struct clk     *parent;
>         unsigned int   users;
>
> Add the parent propagation to the clk_enable disable prepare unprepare
> functions.
>
> And we should add right away:
>
>         struct hlist_head childs;
>         struct hlist_node node;
>
> Plus infrastructure to register clocks with the parent. Advanced
> things like bottom up propagation of clock rate changes is something
> we can do later, but we really want to make proper registration a
> required change for users of the new stuff.
>
> That brings in another question and this really needs to be answered
> now: Locking
>
> I'm pushing hard on this because I know that retrofitting proper
> locking schemes is going to be a nightmare.
>
> You already have a lock nesting problem when you do parent
> propagation. With your code you do the parent propagation in the child
> callback under the prepare_mutex or the enable_lock.
>
> This is going to end up in lockdep being quite unhappy unless you want
> tons of different lock classes for this stuff. i.e.
>
>       clk_prepare(clk2)
> 	mutex_lock(clk2->mutex);
> 	   clk->prepare(clk);
> 		clk_prepare(clk1)
> 		    mutex_lock(clk1->mutex);	
>
> And you _CANNOT_ call clk1->prepare() from your clk2 prepare function
> as it would forgo the serialization and the prepare refcounting. And
> this kind of scheme is going to be even more problematic if you do
> bottom up propagation because you will run into lock inversion.
>
> I seriously doubt that the fine grained per clock locking is going to
> work out at all.
>
> How do you protect changes to the tree hierarchy against a traversal
> of a concurrent clk->prepare... propagation? Not at all, because you
> CANNOT. And you cannot use RCU for this either.
>
> So what's the point of the per clk locks? I can't see one at all.
>
> All those callbacks are not high frequency called functions, so if you
> want to make this a true framework which deals with tons of
> interesting stuff like propagation, reparenting and rate changes from
> bottom up then there is only one way to do that: global serialization.
>
> There is no way around that. Everything else is going to be the
> locking hell and racy all over the place.

We (MSM guys) had to go thru this thought process when we did some 
internal reorg of the clock code. Per clock locks prevent us from 
slowing down clock manipulation of some fast clocks when there is 
another call going on to manipulate slow clocks. There are some clocks 
that are not controlled by writing to registers directly and they are 
extremely slow compared to the usual set of clocks.

One thing we did to handle the locking issue was to have a lock per 
"class" of clocks. For example, we had one lock for clocks controlled by 
writing to registers, one lock for voting clocks that just do 
aggregation and one lock for these extremely slow clocks. Since each 
class of clocks are generally implemented in their own file, having one 
lock per class was just a matter of declaring a static-global lock 
inside the file and grabbing it before you do any transaction.

For example, there are some clocks that need to disable all the children 
before changing their rate. So, what happens if someone calls 
clk_enable() on the child when the parent is going thru a set rate 
process. Since both these will grab the same "fast clocks lock", we 
don't have any problems.

(Just read Colin's email)

As Colin said in his email, a global lock is less of an issue with the 
clk_prepare/unprepare() APIs now in place. But even among 
prepare/unprepare or enable/disable, some clocks might take much longer 
than others. For example, prepare for a clock might just need enabling a 
PLL, but for another clock it might need enabling a PLL and increasing 
some voltage. If the voltage control is going to go thru I2C, then it's 
going to be pretty bad for the other clock doing the prepare.

I think if we have the parent/child relationship captured in the generic 
framework, we might be able to get away with per clock locking if we 
always make sure we grab the locks in a top-down or bottom-up fashion. 
We could even throw in some flags if we know that a clock will have a 
stable parent (one that doesn't change rates or need to lock children) 
to reduce how deep we have to traverse the tree.

-Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
