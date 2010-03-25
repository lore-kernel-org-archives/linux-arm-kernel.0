From: anfei.zhou@gmail.com (anfei)
Date: Thu, 25 Mar 2010 23:35:46 +0800
Subject: flush icache if VM_EXEC in flush_cache_page
Message-ID: <20100325153546.GA10306@desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

There is a little difference of flushing icache between flush_cache_page
and flush_cache_range, why not make them the same?  I think they have
the very similar semantic except the range.  If the vma is VM_EXEC, we
should flush the icache no matter what cache type, and if it's not,  
then it's not necessary.  Is it right?


Signed-off-by: Anfei Zhou <anfei.zhou@gmail.com>
---
 arch/arm/mm/flush.c |    6 ++----
 1 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index e34f095..48a756a 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -80,12 +80,10 @@ void flush_cache_page(struct vm_area_struct *vma, unsigned long user_addr, unsig
 		return;
 	}
 
-	if (cache_is_vipt_aliasing()) {
+	if (cache_is_vipt_aliasing())
 		flush_pfn_alias(pfn, user_addr);
-		__flush_icache_all();
-	}
 
-	if (vma->vm_flags & VM_EXEC && icache_is_vivt_asid_tagged())
+	if (vma->vm_flags & VM_EXEC)
 		__flush_icache_all();
 }
 #else
-- 
1.6.4.rc1
