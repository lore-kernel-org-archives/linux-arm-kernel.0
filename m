From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jan 2016 11:54:14 +0000
Subject: [PATCHv2 00/18] arm64: mm: rework page table creation
In-Reply-To: <568B17AA.1050002@redhat.com>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <568B17AA.1050002@redhat.com>
Message-ID: <20160105115414.GC24664@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 05:08:58PM -0800, Laura Abbott wrote:
> On 01/04/2016 09:56 AM, Mark Rutland wrote:
> >Hi all,
> >
> >This series reworks the arm64 early page table code, in order to:
> >
> >(a) Avoid issues with potentially-conflicting TTBR1 TLB entries (as raised in
> >     Jeremy's thread [1]). This can happen when splitting/merging sections or
> >     contiguous ranges, and per a pessimistic reading of the ARM ARM may happen
> >     for changes to other fields in translation table entries.
> >
> >(b) Allow for more complex page table creation early on, with tables created
> >     with fine-grained permissions as early as possible. In the cases where we
> >     currently use fine-grained permissions (e.g. DEBUG_RODATA and marking .init
> >     as non-executable), this is required for the same reasons as (a), as we
> >     must ensure that changes to page tables do not split/merge sections or
> >     contiguous regions for memory in active use.

[...]

> >There are still opportunities for improvement:
> >
> >* BUG() when splitting sections or creating overlapping entries in
> >   create_mapping, as these both indicate serious bugs in kernel page table
> >   creation.
> >
> >   This will require rework to the EFI runtime services pagetable creation, as
> >   for >4K page kernels EFI memory descriptors may share pages (and currently
> >   such overlap is assumed to be benign).
> 
> Given the split_{pmd,pud} were added for DEBUG_RODATA, is there any reason
> those can't be dropped now since it sounds like the EFI problem is for overlapping
> entries and not splitting?

Good point. I think they can be removed.

I'll take a look into that.

> This series points out that my attempt to allow set_memory_* to
> work on regular kernel memory[1] is broken right now because it breaks down
> the larger block sizes.

What's the rationale for set_memory_* on kernel mappings? I see
"security", but I couldn't figure out a concrete use-case. Is there any
example of a subsystem that wants to use this?

For statically-allocated data, an alternative approach would be for such
memory to be mapped with minimal permissions from the outset (e.g. being
placed in .rodata), and when elevated permissions are required a
(temporary) memremap'd alias could be used, like what patch_map does to
modify ROX kernel/module text.

For dynamically-allocated data, we could create (minimal permission)
mappings in the vmalloc region and pass those around. The linear map
alias would still be writeable, but as the offset between the two isn't
linear (and the owner of that allocation doesn't have to know/care about
the linear map address), it would be much harder to find the linear map
address to attack. An alias with elevated permissions could be used as
required, or if it's a one-time RW->RO switch, the mapping could me
modified in-place as the granularity wouldn't change.

> Do you have any suggestions for a cleaner approach
> short of requiring all memory mapped with 4K pages? The only solution I see
> right now is having a separate copy of page tables to switch to. Any idea
> other idea I come up with would have problems if we tried to invalidate an
> entry before breaking it down.

The other option I looked into was to have a completely independent
TTBR0 mapping (like the idmap or efi runtime tables), and have that map
code for modifying page tables. That way you could modify the tables
in-place (with TTBR1 disabled for the duration of the modification).

That ended up having its own set of problems, as you could only rely on
self-contained position independent code, which ruled out most kernel
APIs (including locking/atomic primitives due to debug paths). That gets
worse when secondaries are online and you have to synchronise those
disabling/invalidating/enabling the TTBR1 mapping.

Other than that I haven't managed to come up with other functional
ideas. The RCU-like approach is the cleanest I've found so far.

Thanks,
Mark.

> Thanks,
> Laura
> 
> [1]https://lkml.kernel.org/g/<1447207057-11323-1-git-send-email-labbott@fedoraproject.org>
