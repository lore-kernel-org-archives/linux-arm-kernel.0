From: andreiw@motorola.com (Andrei Warkentin)
Date: Sat, 18 Dec 2010 05:54:25 -0600
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <20101218095820.GI9937@n2100.arm.linux.org.uk>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
	<20101218095820.GI9937@n2100.arm.linux.org.uk>
Message-ID: <AANLkTimLkiRkvJAYaJr0=g3zE1goXTekxFG_gj4Zza8z@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 18, 2010 at 3:58 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Thu, Dec 16, 2010 at 05:09:48PM -0600, Andrei Warkentin wrote:
>> It seems twd_calibrate_rate is the culprit (although in our case,
>> since the clock is the same to both CPUs, there is no point in
>> calibrating).
>> We've seen this only when the device was under stress test load.
>
> Right, I can reproduce it here on Versatile Express. ?With some debugging
> printk's added, what's going on is revealed. ?This is what a normal cpu
> up looks like:
>
> Booting CPU3
> Writng pen_release: 4294967295 -> 3
> CPU3: Booted secondary processor
> CPU3: Unknown IPI message 0x1
> CPU3: calibrating delay
> Switched to NOHz mode on CPU #3
> CPU3: calibrating done
> CPU3: now online
> CPU3: online mask = 0000000f
>
> However, when things go bad:
>
> CPU3: Booted secondary processor
> CPU3: calibrating delay
> Booting CPU3
> Switched to NOHz mode on CPU #3
> Writng pen_release: 4294967295 -> 3
> CPU3: Unknown IPI message 0x1
> CPU3: calibrating done
> CPU3: now online
> CPU3: online mask = 0000000f
> CPU3: processor failed to boot: -38
> online mask = 0000000f
>
> Notice that CPU3 booted before the requesting processor requested it to
> boot - pen_release was -1 when CPU3 exited its hotplug lowpower function.
> However, for CPU3 to get out of that, it must have seen pen_release = 3.
>
> What I think is going on here is that the write to set pen_release back
> to -1 is being cached. ?When CPU3 dies, although we call flush_cache_all(),
> this doesn't touch the L2x0 controller, so the update never makes it to
> memory. ?Then CPU3 disables its caches, and its access to pen_release
> bypasses both all caches, resulting in the value in physical memory being
> seen - which was the value written during the previous plug/unplug
> iteration.

This is an interesting bug, but it is a different bug. We don't have a
holding pen, the CPUs
are very much dead, and there is no early start going on - we have to
very much twiddle some HW
regs to ungate the clock and lower the reset line on the Tegra to get
the secondary started.

>
> Reading the pen_release value in various places in CPU3's startup path
> (which changes the MOESI cache conditions) prevents this 'speculative
> starting' effect, as does flushing the pen_release cache line back to
> memory after we set pen_release to -1 in platform_secondary_startup.
>
> So, I can fix the underlying bug causing early CPU start in the existing
> CPU hotplug implementations by ensuring that pen_release is always visibly
> written.
>

This should fix hot plug implementations which rely on a holding pen +
WFI while they are "dead", but
will not resolve the issue we saw.

> We don't add code to patch around behaviour we don't immediately
> understand - we try to understand what is going on, and fix the real
> underlying problem.
>

I agree. The patch does give you a safety net. For example, for this
particular bug you have just described, you would have
seen a message reporting the early start, but the offending CPU would
have never gotten past the arch_spin_lock, so it couldn't
touch kernel structures unexpectedly.

> So, the question now is: where is your underlying bug. ?There's certainly
> a few holes in your code which I've pointed out - I suggest fixing those
> and re-testing, and if the problem persists, try looking at the order in
> which the kernel messages appear to get a better clue what's going on.
>

That's a good question. I think the best answer I can come up right
now is to find another dual-core ARM platform and run our stress tests
to get it to fail in the same fashion. The issue you pointed out -
namely, the byzantine design of the hotplug code, does not affect the
up path. Proof: boot_secondary always succeeds. I am not convinced
with your writel argument either. Proof: boot_secondary always
succeeded, plus the writel expands to a write followed by a dsb and
outer cache sync. And the writel location looked polled at
boot_secondary is in memory. Doesn't the dsb drain the write buffer?
In all the failure cases the secondary was inside kernel code by the
time __cpu_up started waiting on the online bit to appear. That means
that whatever was taking it's sweet time - it was taking it from the
moment secondary_start_kernel entered to the moment the online bit was
set. I have printk logs showing that.

So the question we want to collectively answer is really - should the
stuffing in secondary_start_kernel really be taking so long, assuming
an unrealistic load? I don't have a good answer for that, yet. I'm
going to get some timings for that code.

Btw, I would guess that one of the reasons the hotplug logic is done
the way it was is because secondary_startup is garbage after init,
having been freed along with the rest of init memory. Is anybody
addressing that atm?
