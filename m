From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 8 Nov 2016 14:09:09 +0000
Subject: [PATCH v2 0/2] arm64: fix the bugs found in the hugetlb test
In-Reply-To: <1478583879-14654-1-git-send-email-shijie.huang@arm.com>
References: <1478583879-14654-1-git-send-email-shijie.huang@arm.com>
Message-ID: <20161108140909.GF29087@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 01:44:37PM +0800, Huang Shijie wrote:
> (3) The test result in the Softiron and Juno-r1 boards:
> 
>    This detail test result shows below (both the "make func" & "make stress"):
> 
>     4KB granule:
> 
>         1.1) PTE + Contiguous bit : 4K x 16 = 64K (per huge page size)
>              Test result          : PASS
> 
>         1.2) PMD                  : 2M x  1 = 2M  (per huge page size)
>              Test result          : PASS
> 
>         1.3) PMD + Contiguous bit : 2M x 16 = 32M (per huge page size)
>              Test result          : PASS
> 
>     64KB granule:
> 
>         3.1) PTE + Contiguous bit : 64K x 32 = 2M (per huge page size)
>              Test result          : PASS
> 
>         3.2) PMD + Contiguous bit : 512M x 32 = 16G (per huge page size)
>              Test result          : no hardware to support this test

Don't we have support for single (non-contiguous) PMD huge page with 64K
pages (512M per huge page)? I gave it a try and it seems to work (though
without your patches applied ;)).

> Huang Shijie (2):
>   arm64: hugetlb: remove the wrong pmd check in find_num_contig()
>   arm64: hugetlb: fix the wrong address for several functions

For these patches:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

I'm not sure whether Will plans to push them into 4.9. AFAICT, the
contiguous huge pages never worked properly, so we may not count it as a
regression but a new feature. If Will doesn't take them, I'll queue the
patches for 4.10.

BTW, I think we also need to fix this (no functional change though):

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 2e49bd252fe7..0a4c97b618ec 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -323,7 +323,7 @@ __setup("hugepagesz=", setup_hugepagesz);
 static __init int add_default_hugepagesz(void)
 {
 	if (size_to_hstate(CONT_PTES * PAGE_SIZE) == NULL)
-		hugetlb_add_hstate(CONT_PMD_SHIFT);
+		hugetlb_add_hstate(CONT_PTE_SHIFT);
 	return 0;
 }
 arch_initcall(add_default_hugepagesz);

-- 
Catalin
