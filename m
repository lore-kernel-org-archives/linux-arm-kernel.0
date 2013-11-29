From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 29 Nov 2013 16:28:22 +0000
Subject: [PATCH] arm64: mm: Avoid set_pte_at with HugeTLB pages
In-Reply-To: <1385739261-26689-1-git-send-email-steve.capper@linaro.org>
References: <1385739261-26689-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20131129162822.GD13838@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 29, 2013 at 03:34:21PM +0000, Steve Capper wrote:
> For huge pages, given newprot a pgprot_t value for a shared writable
> VMA, and ptep a pointer to a pte belonging to this VMA; the following
> behaviour is assumed by core code:
> 
>    hugetlb_change_protection(vma, address, end, newprot);
>    ...
> 
>    huge_pte_write(huge_ptep_get(ptep)); /* should be true! */
> 
> Unfortunately, set_huge_pte_at calls set_pte_at which includes a
> side-effect that renders ptes read only if the dirty bit is unset.

And don't you also need this side-effect for huge pages?

> If one were to allocate a read only shared huge page, then fault it in,
> and then mprotect it to be writeable. A subsequent write to that huge
> page will result in a spurious call to hugetlb_cow, which causes
> corruption.

In general making a page writable also makes it dirty but I couldn't
find this for standard page tables (sys_mprotect ... change_pte_range).

Anyway, why would a fault on huge page trigger cow while one on standard
page not?

So I think we have a different problem, which I've been thinking about
but haven't bitten us with standard page tables. In handle_pte_fault()
for standard pages if the fault is write and !pte_write() we call
do_wp_page(). This is smart enough not to do a COW.

hugetlb_fault() OTOH is not that smart ;) and calls hugetlb_cow() if
!huge_pte_write(). You can fix this logic for not to do COW similarly to
do_wp_page(), though I haven't looked in detail on how it decides this.

In the arch code, what we need and it would work as an optimisation for
such faults is to add another software bit for PTE_WRITE, independent of
!PTE_RDONLY. This way you can have clean (and hardware read-only) pages
but with a software pte_write(). handle_pte_fault() would simply call
pte_mkdirty() for standard pages.

BTW, I think we have the same issue with LPAE.

-- 
Catalin
