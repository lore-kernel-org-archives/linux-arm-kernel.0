From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 Jan 2011 16:29:15 +0000
Subject: Locking in the clk API
In-Reply-To: <20110111031552.GJ3760@linux-sh.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org>
Message-ID: <4D3862DB.5000708@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/11 03:15, Paul Mundt wrote:
> On Tue, Jan 11, 2011 at 10:16:42AM +0800, Jeremy Kerr wrote:
>> * clk_enable: may sleep
>>
>> * clk_disable: may not sleep, but it's possible to make the global
>>   clk_disable() atomic and defer the actual disable (clk->ops.disable()) to a
>>   non-atomic context.
>>
>> * clk_get_rate: may not sleep
>>
>> * clk_set_rate: may sleep
>>
>> As we build up our requirements, we can adjust as suitable.
>>
> This looks like a complete disaster, and is also completely inconsistent
> with how the API is being used by the vast majority of users today. You
> have an API that can or can not sleep with no indication as to which is
> which based off of the API naming, which is just asking for trouble.
> 
> As it is today, most users expect that these are all usable from atomic
> context, and as far as I can tell the only special case you have are for
> some crap busses with insane latencies. In this case you should simply
> pile on _cansleep() versions of the API and make it apparent that those
> drivers are the special cases, not the other way around.

The trouble is not with the drivers, is the fact there could be a clock
tree where, say the closest to the driver is easy to control but the
base of the tree may be a PLL which requires time to settle.

Now, there's a lot of work in the 'embedded' space where the focus is on
the power consumption, so powering down PLLs when they are not needed is
a good thing to have/

> Having half of the API sleepable and the other not with no indication of
> which is which simply makes it completely unusable and error prone for
> both atomic and non-atomic contexts.

I really don't like the fact that people are doing these things in
atomic contexts, and I think we should apply some pressure to move
the atomic caller cases to use systems where they can sleep such as
using threaded-irq handlers (they work very nicely)
