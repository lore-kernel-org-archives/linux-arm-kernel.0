From: kevin@bracey.fi (Kevin Bracey)
Date: Mon, 22 Apr 2013 20:03:48 +0300
Subject: [PATCH] ARM: smp: call platform's cpu_die in ipi_cpu_stop
In-Reply-To: <20130418195735.GF14496@n2100.arm.linux.org.uk>
References: <1365251824-4852-1-git-send-email-kevin@bracey.fi>
 <1365251824-4852-2-git-send-email-kevin@bracey.fi>
 <20130418171801.GC14496@n2100.arm.linux.org.uk>
 <20130418182534.GD14496@n2100.arm.linux.org.uk> <51704D31.10808@bracey.fi>
 <20130418195735.GF14496@n2100.arm.linux.org.uk>
Message-ID: <51756D74.1070604@bracey.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/04/2013 22:57, Russell King - ARM Linux wrote:
> Well, the idea as far as hotplug CPU is concerned is that we guarantee
> in core code that platform_cpu_kill() will not be called until it is
> safe for the dying CPU to be powered off - so the synchronisation is
> done by the core code.  That's always been what the completion stuff
> is about in arch/arm/kernel/smp.c.
>
> It was missing the cache bits because (a) the ARM development platforms
> don't actually take the CPUs offline, and (b) we never really had an
> API at the time hotplug CPU was designed to flush just the local CPUs
> L1 cache.
>
> Now, practically, most platforms which cut power/clocks to the CPU do
> it in one of two ways.  Either they do it in their cpu_die() callback,
> via WFI, or they do it from a running CPU via the cpu_kill() callback.
>
> Either way, platforms are not expected to have any further
> synchronisation.  Once that complete() call has returned, the dying
> CPU is expected to become dead very shortly after that point - whether
> that be as a result of cpu_kill() or cpu_die().
>
> The whole point is to stop platforms having to implement synchronisation
> in these callbacks, with all the bugs that will cause.  The patch I
> posted took about an hour of thought and walking through, and discussion
> with Will to make sure that all issues had been covered.  Taking a CPU
> offline safely is far from trivial, and the less code that a platform
> has to do the better.
>
>
Okay, so in the final analysis, would this be a reasonable summary?

* Generally a hotplug platform will implement either cpu_kill, or 
cpu_die, but not normally both;

* it should be up to the core code to ensure that a CPU is safe to be 
killed before cpu_kill is entered, w.r.t. non-platform-specifics like 
the cache;

* if both calls are implemented, cpu_kill can't assume that cpu_die will 
be called, so shouldn't depend on co-ordinating with it;

* because cpu_kill is used in panic-type contexts, it shouldn't be 
attempting anything complex anyway;

* the current framework wouldn't straightforwardly support a 
platform-specific requirement for hotplug-out like "hardware register X 
must be poked after the dying core has entered STANDBYWFI", due to the 
above restrictions.

I can't say for certain at this stage whether I do have a requirement 
like the last, but I fear I might do. So at present, I'd be fine with 
your patch dealing with the cache, but I'm just worried that it won't be 
enough.

It just all still feels a little bit off; the system is overly 
constrained by the ipi_cpu_stop case. It feels to me that life would be 
simpler if there was a distinction between "hotplug cpu kill" and 
"emergency cpu kill", which would then permit more ambitious platform 
hotplug code. Is there some way I've missed that would allow me to 
distinguish the two cases in the current framework?

Kevin
