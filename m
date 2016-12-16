From: minchan@kernel.org (Minchan Kim)
Date: Fri, 16 Dec 2016 15:39:40 +0900
Subject: jemalloc testsuite stalls in memset
In-Reply-To: <mvm4m2535pc.fsf@hawking.suse.de>
References: <mvmmvfy37g1.fsf@hawking.suse.de> <20161214235031.GA2912@bbox>
 <mvm4m2535pc.fsf@hawking.suse.de>
Message-ID: <20161216063940.GA1334@bbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Dec 15, 2016 at 10:24:47AM +0100, Andreas Schwab wrote:
> On Dez 15 2016, Minchan Kim <minchan@kernel.org> wrote:
> 
> > You mean program itself access the address(ie, 0xffffb7400000) is hang
> > while access the address from the debugger is OK?
> 
> Yes.
> 
> > Can you reproduce it easily?
> 
> 100%
> 
> > Did you test it in real machine or qemu on x86?
> 
> Both real and kvm.
> 
> > Could you show me how I can reproduce it?
> 
> Just run make check.
> 
> > I want to test it in x86 machine, first of all.
> > Unfortunately, I don't have any aarch64 platform now so maybe I have to
> > run it on qemu on x86 until I can set up aarch64 platform if it is reproducible
> > on real machine only.
> >
> >> 
> >> The kernel has been configured with transparent hugepages.
> >> 
> >> CONFIG_TRANSPARENT_HUGEPAGE=y
> >> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> >> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> >> CONFIG_TRANSPARENT_HUGE_PAGECACHE=y
> >
> > What's the exact kernel version?
> 
> Anything >= your commit.

Thanks for the info. I cannot setup testing enviroment but when I read code,
it seems we need pmd_wrprotect for non-hardware dirty architecture.

Below helps?

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e10a4fe..dc37c9a 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1611,6 +1611,7 @@ int madvise_free_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 			tlb->fullmm);
 		orig_pmd = pmd_mkold(orig_pmd);
 		orig_pmd = pmd_mkclean(orig_pmd);
+		orig_pmd = pmd_wrprotect(orig_pmd);
 
 		set_pmd_at(mm, addr, pmd, orig_pmd);
 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
