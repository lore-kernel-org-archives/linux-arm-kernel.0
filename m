From: liuj97@gmail.com (Jiang Liu)
Date: Sun, 10 Mar 2013 16:01:02 +0800
Subject: [PATCH v2,
 part2 02/10] mm/ARM: use free_highmem_page() to free highmem pages
 into buddy system
In-Reply-To: <1362902470-25787-1-git-send-email-jiang.liu@huawei.com>
References: <1362902470-25787-1-git-send-email-jiang.liu@huawei.com>
Message-ID: <1362902470-25787-3-git-send-email-jiang.liu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use helper function free_highmem_page() to free highmem pages into
the buddy system.

Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mm/init.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 40a5bc2..687a114 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -519,10 +519,8 @@ static void __init free_unused_memmap(struct meminfo *mi)
 #ifdef CONFIG_HIGHMEM
 static inline void free_area_high(unsigned long pfn, unsigned long end)
 {
-	for (; pfn < end; pfn++) {
-		__free_reserved_page(pfn_to_page(pfn));
-		totalhigh_pages++;
-	}
+	for (; pfn < end; pfn++)
+		free_highmem_page(pfn_to_page(pfn));
 }
 #endif
 
@@ -571,7 +569,6 @@ static void __init free_highpages(void)
 		if (start < end)
 			free_area_high(start, end);
 	}
-	totalram_pages += totalhigh_pages;
 #endif
 }
 
-- 
1.7.9.5
