From: mike.kravetz@oracle.com (Mike Kravetz)
Date: Thu, 23 Mar 2017 13:55:27 -0700
Subject: [RFC PATCH 0/2] Add hstate parameter to huge_pte_offset()
In-Reply-To: <20170323125823.429-1-punit.agrawal@arm.com>
References: <20170323125823.429-1-punit.agrawal@arm.com>
Message-ID: <bde0d8a5-f361-ef4e-5cb3-1615bc2a98b0@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2017 05:58 AM, Punit Agrawal wrote:
> On architectures that support hugepages composed of contiguous pte as
> well as block entries at the same level in the page table,
> huge_pte_offset() is not able to determine the right offset to return
> when it encounters a swap entry (which is used to mark poisoned as
> well as migrated pages in the page table).
> 
> huge_pte_offset() needs to know the size of the hugepage at the
> requested address to determine the offset to return - the current
> entry or the first entry of a set of contiguous hugepages. This came
> up while enabling support for memory failure handling on arm64[0].
> 
> Patch 1 adds a hstate parameter to huge_pte_offset() to provide
> additional information about the target address. It also updates the
> signatures (and usage) of huge_pte_offset() for architectures that
> override the generic implementation. This patch has been compile
> tested on ia64 and x86.

I haven't looked at the performance implications of making huge_pte_offset
just a little slower.  But, I think you can get hstate from the parameters
passed today.

vma = find_vma(mm, addr);
h = hstate_vma(vma);

-- 
Mike Kravetz

> Patch 2 uses the size determined by the parameter added in Patch 1, to
> return the correct page table offset.
> 
> The patchset is based on top of v4.11-rc3 and the arm64 huge page
> cleanup for break-before-make[1].
> 
> Thanks,
> Punit
> 
> 
> [0] http://marc.info/?l=linux-arm-kernel&m=148772028907925&w=2
> [1] https://www.spinics.net/lists/arm-kernel/msg570422.html
> 
> Punit Agrawal (2):
>   mm/hugetlb.c: add hstate parameter to huge_pte_offset()
>   arm64: hugetlbpages: Correctly handle swap entries in
>     huge_pte_offset()
> 
>  arch/arm64/mm/hugetlbpage.c   | 33 +++++++++++++++++----------------
>  arch/ia64/mm/hugetlbpage.c    |  4 ++--
>  arch/metag/mm/hugetlbpage.c   |  2 +-
>  arch/mips/mm/hugetlbpage.c    |  2 +-
>  arch/parisc/mm/hugetlbpage.c  |  2 +-
>  arch/powerpc/mm/hugetlbpage.c |  2 +-
>  arch/s390/mm/hugetlbpage.c    |  2 +-
>  arch/sh/mm/hugetlbpage.c      |  2 +-
>  arch/sparc/mm/hugetlbpage.c   |  2 +-
>  arch/tile/mm/hugetlbpage.c    |  2 +-
>  arch/x86/mm/hugetlbpage.c     |  2 +-
>  fs/userfaultfd.c              |  7 +++++--
>  include/linux/hugetlb.h       |  2 +-
>  mm/hugetlb.c                  | 18 +++++++++---------
>  mm/page_vma_mapped.c          |  2 +-
>  mm/pagewalk.c                 |  2 +-
>  16 files changed, 45 insertions(+), 41 deletions(-)
> 
