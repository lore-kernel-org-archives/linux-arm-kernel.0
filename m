From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Nov 2015 18:27:18 +0000
Subject: [GIT PULL] arm64 updates for 4.4
In-Reply-To: <CA+55aFw3Y4x0RQPjgkZSV=NkXEoMWTq7AYRBpkqd-KMt6om6sw@mail.gmail.com>
References: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
 <CA+55aFw3Y4x0RQPjgkZSV=NkXEoMWTq7AYRBpkqd-KMt6om6sw@mail.gmail.com>
Message-ID: <20151105182718.GV7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 02:55:01PM -0800, Linus Torvalds wrote:
> On Wed, Nov 4, 2015 at 10:25 AM, Catalin Marinas
> <catalin.marinas@arm.com> wrote:
> >
> > - Support for 16KB pages, with the additional bonus of a 36-bit VA
> >   space, though the latter only depending on EXPERT
> 
> So I told the ppc people this many years ago, and I guess I'll tell
> you guys too: 16kB pages are not actually useful, and anybody who
> thinks they are have not actually done the math.

Without doing any benchmarks (not just the maths but taking TLB misses
into account), I agree with you. As a note, I don't actually expect this
feature to be used in practice, firstly because it is an optional
architecture feature and secondly because people wanting a bigger page
size (like Red Hat) went to the extreme 64KB size already. But adding
this option to the kernel doesn't cost us much (some macro clean-up) and
it's something the CPU validation people would most likely use.

Who knows, maybe those people who went for 64KB pages get burnt and go
for 16KB as an intermediate step before moving back to 4KB.

> It's good for single-process loads - if you do a lot of big fortran
> jobs, or a lot of big database loads, and nothing else, you're fine.

These are some of the arguments from the server camp: specific
workloads.

> Or if you are an embedded OS and only haev one particular load you
> worry about.

It's unlikely for embedded/mobile because of the memory usage, though
I've seen it done on 32-bit ARMv7 (Cortex-A9). The WD My Cloud NAS at
some point upgraded the firmware to use 64KB pages in Linux (not
something supported by mainline). I have no idea what led to their
decision but the workloads are very specific, I guess there was some
gain for them.

> But it is really really nasty for any general-purpose stuff, and when
> your hardware people tell you that it's a great way to make your TLB's
> more effective, tell them back that they are incompetent morons, and
> that they should just make their TLB's better.

Virtualisation, nested pages is an area where you can always squeeze a
bit more performance even if your TLBs are fast (for example, 4 levels
guest + 4 levels host page tables would need 24 memory accesses for a
completely cold TLB miss). But this would normally only be an option for
the host kernel, not aimed at general purpose guest.

> To make them understand the problem, compare it to having a 256-byte
> cacheline. They might understand it then, because you're talking about
> things that they almost certainly *also* wanted to do, but did the
> numbers on, and realized it was bad.

The difference is that a 256-byte cacheline is hard-wired and the cache
size fixed when you build the silicon. OTOH, the page size is
configurable and I would be very worried if 4KB pages are ever
deprecated. The counter argument from the HW camp is usually that the
architecture is not designed just for the current RAM limits and not
even for the current Linux implementation. It's more like "in 10 years
time we may afford to waste a lot more memory *or* Linux may find a way
to merge/compress partially filled page cache pages (well, those not
mapped to user) *or* some other workloads emerge, so we better have the
option in early".

I don't see the 4KB page configuration ever going away from the ARM
cores and the mobile camp is pretty much tied to it. We'll have to wait
until we see some real workloads on servers and what the larger page
impact is. Hopefully the ecosystem (software, silicon vendors) will
eventually converge to the best solution (which could simply be smaller
pages and better TLBs). In the meantime, I'm giving them enough Kconfig
rope to use it as they see appropriate. The architecture specification
does a similar thing.

-- 
Catalin
