From: rokhanna@nvidia.com (Rohit Khanna)
Date: Wed, 6 Jun 2018 16:29:03 -0700
Subject: [PATCH V6] arm64: alternative:flush cache with unpatched code
Message-ID: <1528327743-29263-1-git-send-email-rokhanna@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the current implementation,  __apply_alternatives patches
flush_icache_range and then executes it without invalidating the icache.
Thus, icache can contain some of the old instructions for
flush_icache_range. This can cause unpredictable behavior as during
execution we can get a mix of old and new instructions for
flush_icache_range.

This patch modifies __apply_alternatives so that it uses non hot-patched
__flush_icache_all after applying all the alternatives.

Signed-off-by: Rohit Khanna <rokhanna@nvidia.com>
---
 arch/arm64/kernel/alternative.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/alternative.c b/arch/arm64/kernel/alternative.c
index 5c4bce4ac381..047139f570ac 100644
--- a/arch/arm64/kernel/alternative.c
+++ b/arch/arm64/kernel/alternative.c
@@ -154,10 +154,8 @@ static void __apply_alternatives(void *alt_region, bool use_linear_alias)
 			alt_cb  = ALT_REPL_PTR(alt);
 
 		alt_cb(alt, origptr, updptr, nr_inst);
-
-		flush_icache_range((uintptr_t)origptr,
-				   (uintptr_t)(origptr + nr_inst));
 	}
+	__flush_icache_all();
 }
 
 /*
-- 
2.1.4
