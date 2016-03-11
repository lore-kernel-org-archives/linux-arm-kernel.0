From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 11 Mar 2016 10:44:41 +0000
Subject: [PATCH] arm64: kasan: Use actual memory node when populating the
 kernel image shadow
In-Reply-To: <CAKv+Gu_sJ5N9DinfVWC5k1dbuX_=3w97u8FGnK2w_JtRrF4JDA@mail.gmail.com>
References: <1457636243-17382-1-git-send-email-catalin.marinas@arm.com>
 <CAKv+Gu_sJ5N9DinfVWC5k1dbuX_=3w97u8FGnK2w_JtRrF4JDA@mail.gmail.com>
Message-ID: <20160311104441.GA27733@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 11, 2016 at 09:31:02AM +0700, Ard Biesheuvel wrote:
> On 11 March 2016 at 01:57, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > With the 16KB or 64KB page configurations, the generic
> > vmemmap_populate() implementation warns on potential offnode
> > page_structs via vmemmap_verify() because the arm64 kasan_init() passes
> > NUMA_NO_NODE instead of the actual node for the kernel image memory.
> >
> > Fixes: f9040773b7bb ("arm64: move kernel image to base of vmalloc area")
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Reported-by: James Morse <james.morse@arm.com>
> 
> I still think using vmemmap_populate() is somewhat of a hack here, and
> the fact that we have different versions for 4k pages and !4k pages,
> while perhaps justified for the actual real purpose of allocating
> struct page arrays, makes this code more fragile than it needs to be.

I agree, kasan is hijacking API meant for something else.

> How difficult would it be to simply have a kasan specific
> vmalloc_shadow() function that performs a
> memblock_alloc/create_mapping, and does the right thing wrt aligning
> the edges, rather than putting knowledge about how vmemmap_populate
> happens to align its allocations into the kasan code?

With a long flight from Bangkok, who knows, I may see some patches on
Monday ;)

Anyway, I think we also need to change the 4K pages vmemmap_populate to
do a vmemmap_verify in all cases, something like below (untested):

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index d2d8b8c2e17f..c0f61235a6ec 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -642,8 +642,8 @@ int __meminit vmemmap_populate(unsigned long start, unsigned long end, int node)
 				return -ENOMEM;
 
 			set_pmd(pmd, __pmd(__pa(p) | PROT_SECT_NORMAL));
-		} else
-			vmemmap_verify((pte_t *)pmd, node, addr, next);
+		}
+		vmemmap_verify((pte_t *)pmd, node, addr, next);
 	} while (addr = next, addr != end);
 
 	return 0;

-- 
Catalin
