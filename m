From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Jul 2015 18:23:54 +0100
Subject: Oops at boot after commit 965278dcb8ab... when using split
 memory region
In-Reply-To: <559488CD.2050807@redhat.com>
References: <CAGGh5h061qpus=RK-iDyzbc9xG+dJXy8AosuN=aryEVZCPPhtw@mail.gmail.com>
 <20150701144612.GG2310@leverpostej>
 <20150701145354.GL7557@n2100.arm.linux.org.uk>
 <20150701154007.GH2310@leverpostej> <559488CD.2050807@redhat.com>
Message-ID: <20150703172354.GB28877@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 02, 2015 at 01:41:49AM +0100, Laura Abbott wrote:
> On 07/01/2015 08:40 AM, Mark Rutland wrote:
> > On Wed, Jul 01, 2015 at 03:53:54PM +0100, Russell King - ARM Linux wrote:
> >> On Wed, Jul 01, 2015 at 03:46:12PM +0100, Mark Rutland wrote:
> >>> On Wed, Jul 01, 2015 at 03:15:33PM +0100, jean-philippe francois wrote:
> >>>> Hi,
> >>>
> >>> Hi,
> >>>
> >>>> commit 965278dcb8ab0b1f666cc47937933c4be4aea48d, (ARM: 8356/1: mm:
> >>>> handle non-pmd-aligned end of RAM) causes my dm3730 based board to
> >>>> oops at boot when using a split memory description.
> >>>> The kernel command line parameter is :
> >>>> mem=55M at 0x80000000 mem=128M at 0x88000000
> >>>>
> >>>> If the same board is booted without the mem argument, it boots to userspace.
> >>>
> >>> Thanks for the report.
> >>>
> >>> Javier reported a similar issue [1], which was somehow fixed by Laura's
> >>> patch to update the memblock limit [2,3].
> >>>
> >>> I don't yet understand why, but if that works for you it would be an
> >>> interesting data point.
> >>>
> >>>> Below is the bootlog.
> >>>
> >>> Interesting. That blows up a lot later than I'd expect. I'll see if I
> >>> can reproduce the issue locally.
> >>
> >> Yes, I think we need to understand what's going on here, and what's
> >> causing these failures, rather than blindly applying a patch which
> >> seems to solve the problem.
> >
> > Certainly. I did not mean to imply otherwise.
> >
> > Using a similar command line I can reproduce the issue on TC2, getting a
> > hang when freeing unused kernel memory. I'm digging into that now.
> >
> > Thanks,
> > Mark.
> >
> 
> I think I see what's happening here. I can reproduce what I think is a similar
> problem with a similar memory configuration and CONFIG_HIGHMEM=n:
> 
> [    0.163354] Unable to handle kernel paging request at virtual address c3ada000
> [    0.163376] pgd = c0204000
> [    0.163398] [c3ada000] *pgd=00000000
> [    0.163569] Internal error: Oops: 5 [#1] SMP ARM
> [    0.163619] Modules linked in:
> [    0.163773] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.1.0-11357-g1c799e6-dirty #36
> [    0.163790] Hardware name: ARM-Versatile Express
> [    0.163836] task: c2838000 ti: c2826000 task.ti: c2826000
> [    0.163911] PC is at cma_init_reserved_areas+0x114/0x224
> [    0.163932] LR is at cma_init_reserved_areas+0xf8/0x224
> 
> 
> With Mark's patch, we now need to adjust the memblock limit down to the end of
> the first bank. Like my patch described, find_limits uses the memblock_limit
> to calculate the bounds for zone. Because CONFIG_HIGHMEM=n, the amount of
> memory given to the system is much smaller than the actual memory available
> in memblock instead of just flowing over into highmem. Anything that's set to
> allocate memblock from anywhere such as CMA can now allocate memory that may be
> out of bounds (the crash above was from doing pfn_to_page on a pfn out of memory
> that was actually mapped). My patch fixes the problem by properly setting memblock
> bounds so all memory is given to the system and memblock allocations will always
> be valid. Although the bug was unexpected, the root cause it fixes should still
> be correct.

That would explain what I see. I can get boot going by getting rid of
all memory above memblock_limit with memblock_remove(), which I think
agrees with your reasoning.

I'm not sure what the expectation is w.r.t. the memmap for memory
allocated outside of the MEMBLOCK_ALLOC_ACCESSIBLE region, so I don't
know whether the behaviour of CMA is correct.

Thanks,
Mark.
