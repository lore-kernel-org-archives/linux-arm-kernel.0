From: will.deacon@arm.com (Will Deacon)
Date: Fri, 24 Aug 2018 16:52:42 +0100
Subject: [RFC PATCH 07/11] asm-generic/tlb: Guard with #ifdef CONFIG_MMU
In-Reply-To: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
References: <1535125966-7666-1-git-send-email-will.deacon@arm.com>
Message-ID: <1535125966-7666-8-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The inner workings of the mmu_gather-based TLB invalidation mechanism
are not relevant to nommu configurations, so guard them with an ifdef.
This allows us to implement future functions using static inlines
without breaking the build.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 include/asm-generic/tlb.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b3353e21f3b3..859f897d3d53 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -20,6 +20,8 @@
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
+#ifdef CONFIG_MMU
+
 #ifdef CONFIG_HAVE_RCU_TABLE_FREE
 /*
  * Semi RCU freeing of the page directories.
@@ -312,4 +314,5 @@ static inline void tlb_remove_check_page_size_change(struct mmu_gather *tlb,
 
 #define tlb_migrate_finish(mm) do {} while (0)
 
+#endif /* CONFIG_MMU */
 #endif /* _ASM_GENERIC__TLB_H */
-- 
2.1.4
