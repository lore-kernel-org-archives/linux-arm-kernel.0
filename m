From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 18 Dec 2010 09:58:20 +0000
Subject: [RFC] Make SMP secondary CPU up more resilient to failure.
In-Reply-To: <AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
References: <AANLkTinM524ozYQhHSpCN49LvZLePO6faHJrqxKBtyJe@mail.gmail.com>
	<20101216113407.GO9937@n2100.arm.linux.org.uk>
	<AANLkTikJFdxbXjvWUMmEXoAG4xR8G9jq30ox90Bo4SWe@mail.gmail.com>
Message-ID: <20101218095820.GI9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 16, 2010 at 05:09:48PM -0600, Andrei Warkentin wrote:
> It seems twd_calibrate_rate is the culprit (although in our case,
> since the clock is the same to both CPUs, there is no point in
> calibrating).
> We've seen this only when the device was under stress test load.

Right, I can reproduce it here on Versatile Express.  With some debugging
printk's added, what's going on is revealed.  This is what a normal cpu
up looks like:

Booting CPU3
Writng pen_release: 4294967295 -> 3
CPU3: Booted secondary processor
CPU3: Unknown IPI message 0x1
CPU3: calibrating delay
Switched to NOHz mode on CPU #3
CPU3: calibrating done
CPU3: now online
CPU3: online mask = 0000000f

However, when things go bad:

CPU3: Booted secondary processor
CPU3: calibrating delay
Booting CPU3
Switched to NOHz mode on CPU #3
Writng pen_release: 4294967295 -> 3
CPU3: Unknown IPI message 0x1
CPU3: calibrating done
CPU3: now online
CPU3: online mask = 0000000f
CPU3: processor failed to boot: -38
online mask = 0000000f

Notice that CPU3 booted before the requesting processor requested it to
boot - pen_release was -1 when CPU3 exited its hotplug lowpower function.
However, for CPU3 to get out of that, it must have seen pen_release = 3.

What I think is going on here is that the write to set pen_release back
to -1 is being cached.  When CPU3 dies, although we call flush_cache_all(),
this doesn't touch the L2x0 controller, so the update never makes it to
memory.  Then CPU3 disables its caches, and its access to pen_release
bypasses both all caches, resulting in the value in physical memory being
seen - which was the value written during the previous plug/unplug
iteration.

Reading the pen_release value in various places in CPU3's startup path
(which changes the MOESI cache conditions) prevents this 'speculative
starting' effect, as does flushing the pen_release cache line back to
memory after we set pen_release to -1 in platform_secondary_startup.

So, I can fix the underlying bug causing early CPU start in the existing
CPU hotplug implementations by ensuring that pen_release is always visibly
written.

We don't add code to patch around behaviour we don't immediately
understand - we try to understand what is going on, and fix the real
underlying problem.

So, the question now is: where is your underlying bug.  There's certainly
a few holes in your code which I've pointed out - I suggest fixing those
and re-testing, and if the problem persists, try looking at the order in
which the kernel messages appear to get a better clue what's going on.
