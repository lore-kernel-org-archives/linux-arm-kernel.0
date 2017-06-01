From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Thu, 1 Jun 2017 19:23:37 +0300
Subject: [PATCH 3/4] arm64/kasan: don't allocate extra shadow memory
In-Reply-To: <20170601162338.23540-1-aryabinin@virtuozzo.com>
References: <20170601162338.23540-1-aryabinin@virtuozzo.com>
Message-ID: <20170601162338.23540-3-aryabinin@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We used to read several bytes of the shadow memory in advance.
Therefore additional shadow memory mapped to prevent crash if
speculative load would happen near the end of the mapped shadow memory.

Now we don't have such speculative loads, so we no longer need to map
additional shadow memory.

Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm64/mm/kasan_init.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 687a358a3733..81f03959a4ab 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -191,14 +191,8 @@ void __init kasan_init(void)
 		if (start >= end)
 			break;
 
-		/*
-		 * end + 1 here is intentional. We check several shadow bytes in
-		 * advance to slightly speed up fastpath. In some rare cases
-		 * we could cross boundary of mapped shadow, so we just map
-		 * some more here.
-		 */
 		vmemmap_populate((unsigned long)kasan_mem_to_shadow(start),
-				(unsigned long)kasan_mem_to_shadow(end) + 1,
+				(unsigned long)kasan_mem_to_shadow(end),
 				pfn_to_nid(virt_to_pfn(start)));
 	}
 
-- 
2.13.0
