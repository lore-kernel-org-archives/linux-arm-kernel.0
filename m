From: mturquette@ti.com (Turquette, Mike)
Date: Tue, 8 May 2012 10:29:34 -0700
Subject: common clock framework
In-Reply-To: <20120508090145.GG15893@opensource.wolfsonmicro.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <CAJOA=zOs8FLTRUh=LOd2f=YxFz7Sdxgp2JJurpQkdDFALcCiVw@mail.gmail.com>
 <20120505082840.GQ4141@pengutronix.de>
 <CAJOA=zPozuanQFWt10PU4mySQ1kV+YV6iO5+BOfDWGPS2Y0aYg@mail.gmail.com>
 <20120508090145.GG15893@opensource.wolfsonmicro.com>
Message-ID: <CAJOA=zOErWaAAO3pQNNSMwZce=9EnJCoNFfBY07fTm1OZ_XATg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 8, 2012 at 2:01 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Sat, May 05, 2012 at 10:44:17AM -0700, Turquette, Mike wrote:
>> + Mark & Graeme (for audio/pmic perspective)
>
>> >> Having clk_set_rate and clk_prepare both hold the same prepare_lock
>> >> mutex seems suboptimal, but it is easy. ?Having reentrant accesses to
>> >> the clock tree is going to be hard... ?I've spent some time thinking
>> >> of ways to solve this, but I would appreciate suggestions. ?I suspect
>> >> the exact same case I'm describing above will affect many SoCs.
>
>> > That's interesting. Here's another one: What will happen when Mark
>> > attaches one of his i2c wolfson chips to a omap core and wants to test
>> > his new clock driver? a clk_prepare on some clock on the wolfson chip
>> > will trigger another clk_prepare inside the i2c driver.
>> > So the reentrancy problem is not limited to prepare vs. set_rate.
>
> This sounds pretty much expected - you'll also see similar things on
> some SoCs where IPs for clocks might get clock gated when not in use and
> reentrancy could crop up while exiting low power modes.

Going down this locking path has been ugly.  I got sidetracked by the
whole spinlock/mutex raciness thing yesterday (which I abhor).  I
don't think those two can be unified unless we have sleeping spinlocks
or something similar in the future...

But I digress.  Today I'm playing with a scheme that only affects
users of the prepare_lock mutex.  Basically each clock has it's own
mutex; we hold the global prepare_lock mutex when a top-level
operation is called, then lock only the affected clocks' per-clock
mutex (while under the global lock), then release the global
prepare_lock mutex and continue the operation.

The scheme described above means that the clock tree is more
re-entrant than it used to be... however if clock A is involved in two
separate operations then one will block while the other holds clock
A's mutex.

So it's basically a hybrid scheme.  Thoughts?

Mike
