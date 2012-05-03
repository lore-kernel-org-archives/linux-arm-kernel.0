From: chao.xie@marvell.com (Chao Xie)
Date: Thu,  3 May 2012 10:04:29 +0800
Subject: [PATCH 2/4] ARM: cache: tauros2: add disable and resume callback
In-Reply-To: <1336010671-12792-1-git-send-email-chao.xie@marvell.com>
References: <1336010671-12792-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1336010671-12792-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the SOC chips using tauros2 cache, will need disable
and resume tauros2 cache for SOC suspend/resume.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 arch/arm/mm/cache-tauros2.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mm/cache-tauros2.c b/arch/arm/mm/cache-tauros2.c
index 1fbca05..23a7643 100644
--- a/arch/arm/mm/cache-tauros2.c
+++ b/arch/arm/mm/cache-tauros2.c
@@ -108,6 +108,26 @@ static void tauros2_flush_range(unsigned long start, unsigned long end)
 
 	dsb();
 }
+
+static void tauros2_disable(void)
+{
+	__asm__ __volatile__ (
+	"mcr	p15, 1, %0, c7, c11, 0 @L2 Cache Clean All\n\t"
+	"mrc	p15, 0, %0, c1, c0, 0\n\t"
+	"bic	%0, %0, #(1 << 26)\n\t"
+	"mcr	p15, 0, %0, c1, c0, 0  @Disable L2 Cache\n\t"
+	: : "r" (0x0));
+}
+
+static void tauros2_resume(void)
+{
+	__asm__ __volatile__ (
+	"mcr	p15, 1, %0, c7, c7, 0 @L2 Cache Invalidate All\n\t"
+	"mrc	p15, 0, %0, c1, c0, 0\n\t"
+	"orr	%0, %0, #(1 << 26)\n\t"
+	"mcr	p15, 0, %0, c1, c0, 0 @Enable L2 Cache\n\t"
+	: : "r" (0x0));
+}
 #endif
 
 static inline u32 __init read_extra_features(void)
@@ -194,6 +214,8 @@ void __init tauros2_init(void)
 		outer_cache.inv_range = tauros2_inv_range;
 		outer_cache.clean_range = tauros2_clean_range;
 		outer_cache.flush_range = tauros2_flush_range;
+		outer_cache.disable = tauros2_disable;
+		outer_cache.resume = tauros2_resume;
 	}
 #endif
 
@@ -219,6 +241,8 @@ void __init tauros2_init(void)
 		outer_cache.inv_range = tauros2_inv_range;
 		outer_cache.clean_range = tauros2_clean_range;
 		outer_cache.flush_range = tauros2_flush_range;
+		outer_cache.disable = tauros2_disable;
+		outer_cache.resume = tauros2_resume;
 	}
 #endif
 
-- 
1.7.0.4
