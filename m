From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 8 Jan 2016 19:15:47 +0000
Subject: [PATCHv2 00/18] arm64: mm: rework page table creation
In-Reply-To: <20160105115414.GC24664@leverpostej>
References: <1451930211-22460-1-git-send-email-mark.rutland@arm.com>
 <568B17AA.1050002@redhat.com> <20160105115414.GC24664@leverpostej>
Message-ID: <20160108191547.GE32692@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 11:54:14AM +0000, Mark Rutland wrote:
> On Mon, Jan 04, 2016 at 05:08:58PM -0800, Laura Abbott wrote:
> > On 01/04/2016 09:56 AM, Mark Rutland wrote:
> > >Hi all,
> > >
> > >This series reworks the arm64 early page table code, in order to:
> > >
> > >(a) Avoid issues with potentially-conflicting TTBR1 TLB entries (as raised in
> > >     Jeremy's thread [1]). This can happen when splitting/merging sections or
> > >     contiguous ranges, and per a pessimistic reading of the ARM ARM may happen
> > >     for changes to other fields in translation table entries.
> > >
> > >(b) Allow for more complex page table creation early on, with tables created
> > >     with fine-grained permissions as early as possible. In the cases where we
> > >     currently use fine-grained permissions (e.g. DEBUG_RODATA and marking .init
> > >     as non-executable), this is required for the same reasons as (a), as we
> > >     must ensure that changes to page tables do not split/merge sections or
> > >     contiguous regions for memory in active use.
> 
> [...]
> 
> > >There are still opportunities for improvement:
> > >
> > >* BUG() when splitting sections or creating overlapping entries in
> > >   create_mapping, as these both indicate serious bugs in kernel page table
> > >   creation.
> > >
> > >   This will require rework to the EFI runtime services pagetable creation, as
> > >   for >4K page kernels EFI memory descriptors may share pages (and currently
> > >   such overlap is assumed to be benign).
> > 
> > Given the split_{pmd,pud} were added for DEBUG_RODATA, is there any reason
> > those can't be dropped now since it sounds like the EFI problem is for overlapping
> > entries and not splitting?
> 
> Good point. I think they can be removed.
> 
> I'll take a look into that.

Looking into this further, it turns out there is a set of cases where
we'll try to split currently for !4K page kernels.

Say you have a region starting at a PMD/PUD boundary, which ends somewhere
up to PAGE_SIZE short of the next PMD/PUD boundary. We'll round the end
up to the next PAGE_SIZE boundary and can create a PMD/PUD block entry.

Say another region shares some of that PAGE_SIZE gap. Its gets mapped at
PAGE_SIZE granularity, and we try to create a PTE page entry for the
overlap. The pmd entry is valid, so we decide we must split it. Bang.

A similar set of problems would apply for contiguous PTEs, once we
support those.

For EFI, we could skip the overlap as the spec requires that attributes
are the same within a 64K frame, efi_create_mapping contrives to
ensure that permissions are the same, and we create the mappings in
ascending VA/PA order.

However, we don't want to do that in any other case. Perhaps we can pass
a "strict" parameter and skip in the non-strict case.

Thanks,
Mark.
