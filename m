From: christer@weinigel.se (Christer Weinigel)
Date: Sat, 15 Jan 2011 18:07:38 +0100
Subject: Locking in the clk API
In-Reply-To: <20110115145358.GC15996@n2100.arm.linux.org.uk>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111091607.GI12552@n2100.arm.linux.org.uk>
	<4D2D184A.8020405@codeaurora.org>
	<20110112090301.GS11039@n2100.arm.linux.org.uk>
	<4D31A8F1.4080301@weinigel.se>
	<20110115145358.GC15996@n2100.arm.linux.org.uk>
Message-ID: <4D31D45A.8080509@weinigel.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/15/2011 03:53 PM, Russell King - ARM Linux wrote:
> On Sat, Jan 15, 2011 at 03:02:25PM +0100, Christer Weinigel wrote:
>> On platforms that need to sleep to enable the UART clock, configuring
>> the UART as the kernel console should be equivalent to userspace opening
>> the UART device, i.e. enable the clock.  At least to me that feels like
>> an acceptable tradeoff, and if I wanted to save the last bit of power
>> I'll have to refrain from using UART as the kernel console.
>
> Well, we're not discussing a _new_ API here - we're discussing an API
> with existing users which works completely fine on the devices its
> used, with differing expectations between implementations.

Yes, so to fulfil the requirement that printk needs to call clk_enable 
from atomic contexts, document that clk_enable can not sleep.  Or add 
the clk_enable_atomic call and modify printk to use it.

>> Both of these feel like they should use a call such as clk_get_atomic
>> and be able to handle EWOULDBLOCK/EAGAIN (or whatever error code is used
>> to indicate that it would have to sleep) and delegate to a worker thread
>> to enable the clock.  To catch uses of plain clk_enable from atomic
>> contects, add a WARN_ON/BUG_ON(in_atomic()).  It won't catch everything,
>> but would help a bit at least.
>
> We've never allowed clk_get() to be called in interruptible context,
> so that's not the issue.  The issue is purely about clk_enable() and
> clk_disable() and whether they should be able to be called in atomic
> context or not.

My bad, it should have said "clk_enable_atomic".

> There's been a lot of talk on this issue for ages with no real progress
> that I'm just going to repeat: let's unify those implementations which
> use a spinlock for their clks into one consolidated solution, and
> a separate consolidated solution for those which use a mutex.
>
> This will at least allow us to have _some_ consolidation of the existing
> implementations - and it doesn't add anything to the problem at hand.
> It might actually help identify what can be done at code level to resolve
> this issue.

Won't that cause a lot of code duplication?  If it's possible to have 
one sane implementation, why not go for it at once?

   /Christer
