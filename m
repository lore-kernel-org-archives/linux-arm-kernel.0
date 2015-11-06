From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 06 Nov 2015 10:57:58 +0100
Subject: [GIT PULL] arm64 updates for 4.4
In-Reply-To: <20151105182718.GV7637@e104818-lin.cambridge.arm.com>
References: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
 <CA+55aFw3Y4x0RQPjgkZSV=NkXEoMWTq7AYRBpkqd-KMt6om6sw@mail.gmail.com>
 <20151105182718.GV7637@e104818-lin.cambridge.arm.com>
Message-ID: <6512377.hSX37CgtMC@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 05 November 2015 18:27:18 Catalin Marinas wrote:
> On Wed, Nov 04, 2015 at 02:55:01PM -0800, Linus Torvalds wrote:
> > On Wed, Nov 4, 2015 at 10:25 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > It's good for single-process loads - if you do a lot of big fortran
> > jobs, or a lot of big database loads, and nothing else, you're fine.
> 
> These are some of the arguments from the server camp: specific
> workloads.

I think (a little overgeneralized), you want 4KB pages for any file
based mappings, but larger (in some cases much larger) for anonymous
memory. The last time this came up, I theorized about a way to change
do_anonymous_page() to always operate on 64KB units on a normal
4KB page based kernel, and use the ARM64 contiguous page hint
to get 64KB TLBs for those pages.

This could be done compile-time, system-wide, or per-process if
desired, and should provide performance as good as the current
64KB page kernels for almost any server workloads, and in
some cases much better than that, as long as the hints are
actually interpreted by the CPU implementation.

> > Or if you are an embedded OS and only haev one particular load you
> > worry about.
> 
> It's unlikely for embedded/mobile because of the memory usage, though
> I've seen it done on 32-bit ARMv7 (Cortex-A9). The WD My Cloud NAS at
> some point upgraded the firmware to use 64KB pages in Linux (not
> something supported by mainline). I have no idea what led to their
> decision but the workloads are very specific, I guess there was some
> gain for them.

Very interesting.

I can think of one particular use case where it makes sense: If your
storage device uses larger than 4KB sectors, making the page size
in the kernel the same as the sector size will speed up I/O.
An example for this would be low-end flash devices (USB sticks,
SD cards, not SSD) that in this year's generation tend to write
a 64KB block faster than any smaller unit on average (in absolute
terms, so doing 4KB writes is at least 16 times slower per MB
than doing 64KB writes). For an embedded system, it may hence
end up being more economical to put in four times the RAM compared
to replacing the storage with something than can handle small I/Os
efficiently.

Hard drive vendors have been talking about larger than 4K
sectors for a while. I didn't think anyone built them, but
as WD makes both the NAS and the hard drive in it, it is
theoretically possible that they did this here.

> > But it is really really nasty for any general-purpose stuff, and when
> > your hardware people tell you that it's a great way to make your TLB's
> > more effective, tell them back that they are incompetent morons, and
> > that they should just make their TLB's better.
> 
> Virtualisation, nested pages is an area where you can always squeeze a
> bit more performance even if your TLBs are fast (for example, 4 levels
> guest + 4 levels host page tables would need 24 memory accesses for a
> completely cold TLB miss). But this would normally only be an option for
> the host kernel, not aimed at general purpose guest.

Virtualization of course is what has been driving the improvements
for huge page handling, and using huge pages helps much more here
than a slight increase in page size. Then again, using 16KB pages
also increases the hugepage size from 2MB to 32MB, which can also
help.

	Arnd
