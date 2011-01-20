From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 Jan 2011 16:40:04 +0000
Subject: Locking in the clk API
In-Reply-To: <20110111101314.GA774@linux-sh.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111091607.GI12552@n2100.arm.linux.org.uk>	<201101111744.59712.jeremy.kerr@canonical.com>
	<20110111101314.GA774@linux-sh.org>
Message-ID: <4D386564.2090601@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/11 10:13, Paul Mundt wrote:
> On Tue, Jan 11, 2011 at 05:44:59PM +0800, Jeremy Kerr wrote:
>> So, it sounds like the best approach is to provide an atomic clk_enable. I 
>> agree with Sascha that the clk_enable and clk_enable_atomic polarity makes the 
>> most sense, so how about:
>>
>> int clk_enable(struct clk *clk)
>> {
>> 	might_sleep();
>>
>> 	[...]
>> }
>>
>> int clk_enable_atomic(struct clk *clk)
>> {
>> 	BUG_ON(!(clk->flags & CLK_ATOMIC));
>>
>> 	[...]
>> }
>>
>> Paul: even though you mention that the atomic clocks are the usual case, I 
>> think that this way around illustrates the atomic 'restriction' at the call 
>> site more clearly. When the drivers don't care about the atomicity, 
>> clk_enable() is fine. When drivers do need an atomic clock, 
>> clk_enable_atomic() shows this requirement.
>>
> No, the sleeping clock case is and always will be a corner case, and I
> have no interest in pretending otherwise. On SH we have hundreds of
> clocks that are all usable in the atomic context and perhaps less than a
> dozen that aren't (and even in those cases much of the PLL negotiation is
> handled in hardware so there's never any visibility for the lock-down
> from the software side, other architectures also have similar behaviour).

So, how does the software deal with the clock not being available if the
PLL powers up and takes time to lock and the software goes and tries to
use the device? We need to ensure the clock is on and stable before the
clk_enable() call returns.

For all the drivers I've written so far, clk_enable() and disable()
calls are done from sleep-able contexts such as the mmc work queue
or other such systems.
