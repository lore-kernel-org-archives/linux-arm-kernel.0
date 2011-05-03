From: skannan@codeaurora.org (Saravana Kannan)
Date: Mon, 02 May 2011 19:44:24 -0700
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <20110429132613.GL5126@n2100.arm.linux.org.uk>
References: <1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>	<alpine.LFD.2.02.1104201704350.3323@ionos>	<20110420185922.GD31131@pengutronix.de>	<alpine.LFD.2.02.1104202113250.3323@ionos>	<20110421072259.GG31131@pengutronix.de>	<alpine.LFD.2.02.1104211045220.3323@ionos>	<20110429103723.GF5126@n2100.arm.linux.org.uk>	<alpine.LFD.2.02.1104291252080.3005@ionos>	<20110429110610.GJ5126@n2100.arm.linux.org.uk>	<alpine.LFD.2.02.1104291344020.3005@ionos>
	<20110429132613.GL5126@n2100.arm.linux.org.uk>
Message-ID: <4DBF6C08.90902@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2011 06:26 AM, Russell King - ARM Linux wrote:
> On Fri, Apr 29, 2011 at 02:13:06PM +0200, Thomas Gleixner wrote:
>> This are all well defined semantical problems and should be solved in
>> common code rather than having different buggy implementations in each
>> SoC clock "framework".
>
> Why are you associating functional elements in drivers/clk with the
> SoC clock framework?
>
> I think that's the root cause of this misunderstanding, and until you
> start realising that these building blocks are not part of the SoC
> implementation, we're going to continue arguing about this.

Ok, the discussion went down hill real quick after this point. So, I 
will start from here.

I will try and propose what I think might be a reasonable compromise 
based on what I have seen so far.

I think Thomas mostly cares about having the tree handling done at the 
core code level. Russell's main point seems to be that the parent can 
change for reasons other than "clk_set_parent()" and hence we can have 
the core code manage all of the parent handling.

The parent of a clock can really change for only two reasons (based on 
my experience with clocks -- in no way extensive, but not insignificant 
either):
* clk_set_rate() -- where the set rate code takes care of selecting the 
right parent for a given rate.
* clk_set_parent() -- where the "clk" is just a mux of a random bunch of 
inputs and we just allow the caller to pick the mux input. The clock 
framework might not even know what the rate/characteristic (jitter, duty 
cycle, etc) of the input are since some of them could come from an 
external source that's board specific.

A simple compromise might be to have the generic/base clk structure have 
a "parent" field. Then the generic clk_set_parent() and clk_set_rate() 
would grab the clock's mutex (currently named prepare_lock) before 
calling the clk->ops->set_rate/set_parent. I already suggested grabbing 
this mutex when Jeremy's patches were being review, but it was put off 
for later/Soc specific code (forgot what the decision was). That's why 
we see a might_sleep() in his clk_set_rate().

With the above suggestion, the Soc specific code can change the parent 
all it wants and the core code can still do the tree handling in 
clk_prepare/clk_unprepare (they already grab the mutex).

Although this might not be what each side wants, I think this is a 
reasonable compromise.

Thomas/Russell, Does it sound acceptable to both of you?

We can go to the per-clock vs. per-tree locking after we can agree on 
this. My current opinion (can change easily) is that while per-tree 
locking might be nice, it might be hard/ugly to capture it in the data 
structures. Per-clock locking will allow the soc-specific code which has 
a better idea of the tree to do per-tree locking internally while 
allowing the core code to handle propagating enable/disable up the tree.

Thanks,
Saravana

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
