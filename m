From: ben-linux@fluff.org (Ben Dooks)
Date: Thu, 20 Jan 2011 16:32:44 +0000
Subject: Locking in the clk API
In-Reply-To: <20110111045423.GP3760@linux-sh.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>	<20110111031552.GJ3760@linux-sh.org>	<201101111211.30172.jeremy.kerr@canonical.com>
	<20110111045423.GP3760@linux-sh.org>
Message-ID: <4D3863AC.4020209@fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/01/11 04:54, Paul Mundt wrote:
> Hi Jeremy,
> 
> On Tue, Jan 11, 2011 at 12:11:29PM +0800, Jeremy Kerr wrote:
>>> This looks like a complete disaster, and is also completely inconsistent
>>> with how the API is being used by the vast majority of users today.
>>
>> I've been basing this on the mxc clock code, which acquires a mutex for all 
>> clk_enable()s. This may not be representative of the majority of clock usage.
>>
>> From a qui

[snip]

> One other thing to be aware of is that the clkdev code maintains its own
> list mutex, so the addition and deletion of clkdev lookups in addition to
> the clkdev-backed clk_get() will all be sleepable. It would however be
> possible to back a one-shot atomic-safe clk_get() with a mutex_trylock()
> for the common cases, but it's not entirely obvious that it would be
> worth the complexity it would introduce.

Anyone looking up clks on the fly really should think more carefully
about this, as it is firstly possible to be an expensive operation on
systems with multiple clocks, and secondly, in my view, stupid.

> If you're going to do this work it would also be helpful to spell out the
> locking semantics within linux/clk.h at the same time (it might even be
> worthwhile doing this incrementally and getting all of the platforms
> in-line before attempting to consolidate things too aggressively), as
> it's apparent from the cases you cite there are at least a couple of
> boards that aren't quite in line with what everyone else is doing.
> 
> In general we have to accept that the dynamic creation, deletion, and
> looking up of clocks is going to be a sleepable case, and the rest will
> likely have to be split out in to _cansleep and default atomic-safe
> variants.

I would vote for all clk lookup and reference counting code be made
sleep-able and define it as such.

> set_rate/parent and friends likewise are done atomically for some and
> sleepable for others, so it doesn't seem like there's going to be much
> choice other than simply splitting out the API for these cases.

And we fall into another problem here, if we set_parent of a clock,
which causes one clock to start and another to stop, then what
happens with non-atomic clocks?

if not, we're going to have drivers either keeping clocks on all
the time, or having to put duplicated enable/set-parent/disable
logic in all over the place.
