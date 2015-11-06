From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Nov 2015 16:04:08 +0000
Subject: [GIT PULL] arm64 updates for 4.4
In-Reply-To: <6512377.hSX37CgtMC@wuerfel>
References: <20151104182508.GA28726@e104818-lin.cambridge.arm.com>
 <CA+55aFw3Y4x0RQPjgkZSV=NkXEoMWTq7AYRBpkqd-KMt6om6sw@mail.gmail.com>
 <20151105182718.GV7637@e104818-lin.cambridge.arm.com>
 <6512377.hSX37CgtMC@wuerfel>
Message-ID: <20151106160407.GX7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 10:57:58AM +0100, Arnd Bergmann wrote:
> On Thursday 05 November 2015 18:27:18 Catalin Marinas wrote:
> > On Wed, Nov 04, 2015 at 02:55:01PM -0800, Linus Torvalds wrote:
> > > On Wed, Nov 4, 2015 at 10:25 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > > It's good for single-process loads - if you do a lot of big fortran
> > > jobs, or a lot of big database loads, and nothing else, you're fine.
> > 
> > These are some of the arguments from the server camp: specific
> > workloads.
> 
> I think (a little overgeneralized), you want 4KB pages for any file
> based mappings,

In general, yes, but if the main/only workload on your server is mapping
large db files, the memory usage cost may be amortised. For general
purpose stuff like compiling a Linux kernel, I did some tests
(kernbench) and the page cache usage went from ~2.5GB with 4KB pages to
~6.6GB with 64KB pages, so clearly not suitable. Unfortunately I
couldn't get any meaningful performance numbers as the test was done
over slow NFS.

I'm not recommending 64KB pages but I'm closely following how it's used
and any performance figures. In terms of TLB, there are two aspects that
larger pages try to address (to the detriment of memory usage):

1. A reduction in TLB misses
2. A reduction in the cost of a TLB miss by having fewer page table
   levels (42-bit VA with 2 levels vs 3 or even 4 with 4KB).

Of course, Linus' point for making TLB faster is always good idea but
even on x86 people are looking to improve things (otherwise we may not
have had THP/hugetlb supported on this architecture).

> but larger (in some cases much larger) for anonymous
> memory. The last time this came up, I theorized about a way to change
> do_anonymous_page() to always operate on 64KB units on a normal
> 4KB page based kernel, and use the ARM64 contiguous page hint
> to get 64KB TLBs for those pages.

We have transparent huge pages for this, though the much higher 2MB
size. This would also improve the cost of a TLB miss by walking one
fewer level (point 2 above). I've seen patches for THP on file maps but
I'm not sure what the status is.

As a test, we could fake a 64KB THP by using a dummy PMD that contains
16 PTE entries, just to see how the performance goes. But this would
only address point 1 above.

> This could be done compile-time, system-wide, or per-process if
> desired, and should provide performance as good as the current
> 64KB page kernels for almost any server workloads, and in
> some cases much better than that, as long as the hints are
> actually interpreted by the CPU implementation.

Apart from anonymous mappings, could the file page cache be optimised?
Not all file accesses use mmap() (e.g. gcc compilation seems to do
sequential accesses for the C files the compiler reads), so you don't
always need a full page cache page for a file.

We could have a feature to allow sharing of partially filled page cache
pages and only break them up if mmap'ed to user. A less optimal
implementation based on the current kernel infrastructure could be
something like a cleancache driver able to store partially filled page
cache pages more efficiently (together with a more aggressive eviction
of such pages from the page cache into the cleancache).

-- 
Catalin
