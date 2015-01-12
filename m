From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 12 Jan 2015 11:53:42 +0000
Subject: Linux 3.19-rc3
In-Reply-To: <4665410.x9Uu42bKmJ@wuerfel>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>
 <20150110003540.GA32037@node.dhcp.inet.fi>
 <CA+55aFz74hjhCcdz5J4r-xK4KW7oqNDA3i=jXHW0prGMMwgMvw@mail.gmail.com>
 <4665410.x9Uu42bKmJ@wuerfel>
Message-ID: <20150112115342.GA19807@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 10, 2015 at 08:16:02PM +0000, Arnd Bergmann wrote:
> Regarding ARM64 in particular, I think it would be nice to investigate
> how to extend the THP code to cover 64KB TLBs when running with the 4KB
> page size. There is a hint bit in the page table to tell the CPU that
> a set of 16 aligned pages can share one TLB, and it would be nice to
> use that bit in Linux, and to make this case more common for anonymous
> mappings, and possible large file based mappings.

The generic THP code assumes that huge pages are done at the pmd level,
which means 2MB for arm64 with 4KB page configuration. Hugetlb allows
larger ptes which may not necessarily be at the pmd level, though we
haven't implemented this on arm64 and it's not transparent either. As a
first step it would be nice if at least we unify the APIs between
hugetlbfs and THP (set_huge_pte_at vs. set_pmd_at).

I think you could do some arch-only tricks by pretending that you have a
pte with 16 entries only and a dummy pmd (without a corresponding
hardware page table level) that can host a "huge" page (16 consecutive
ptes). But we lose the 2MB transparent huge page as I don't see
mm/huge_memory.c handling huge puds. We also lose the ability of
building 4 real level page tables since we use the pmd as a dummy one.

But it would be a nice investigation. Maybe something simpler like
getting the mm layer to prefer contiguous 64KB ranges and we do the
detection in the arch set_pte_at().

-- 
Catalin
