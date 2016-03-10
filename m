From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 10 Mar 2016 18:57:23 +0000
Subject: [PATCH] arm64: kasan: Use actual memory node when populating the
 kernel image shadow
Message-ID: <1457636243-17382-1-git-send-email-catalin.marinas@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the 16KB or 64KB page configurations, the generic
vmemmap_populate() implementation warns on potential offnode
page_structs via vmemmap_verify() because the arm64 kasan_init() passes
NUMA_NO_NODE instead of the actual node for the kernel image memory.

Fixes: f9040773b7bb ("arm64: move kernel image to base of vmalloc area")
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: James Morse <james.morse@arm.com>
---
 arch/arm64/mm/kasan_init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/kasan_init.c b/arch/arm64/mm/kasan_init.c
index 56e19d150c21..a164183f3481 100644
--- a/arch/arm64/mm/kasan_init.c
+++ b/arch/arm64/mm/kasan_init.c
@@ -152,7 +152,8 @@ void __init kasan_init(void)
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
-	vmemmap_populate(kimg_shadow_start, kimg_shadow_end, NUMA_NO_NODE);
+	vmemmap_populate(kimg_shadow_start, kimg_shadow_end,
+			 pfn_to_nid(virt_to_pfn(_text)));
 
 	/*
 	 * vmemmap_populate() has populated the shadow region that covers the
