From: amit.virdi@st.com (Amit Virdi)
Date: Wed, 27 Nov 2013 17:24:04 +0530
Subject: [PATCH] ARM: asm: Configure caches as per the defconfig
Message-ID: <1385553244-1513-1-git-send-email-amit.virdi@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Amit VIRDI <Amit.VIRDI@st.com>

In the current implementation of the decompression code, the caches are enabled
irrespective of their configuration in the deconfig. This makes setting the
ICACHE and DCACHE disable options from the menuconfig irrelevant. Change this
implementation to enable caches only if specified in the defconfig.

Signed-off-by: Amit Virdi <amit.virdi@st.com>
---
 arch/arm/boot/compressed/head.S | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/compressed/head.S b/arch/arm/boot/compressed/head.S
index 066b034..1ec87cf 100644
--- a/arch/arm/boot/compressed/head.S
+++ b/arch/arm/boot/compressed/head.S
@@ -721,8 +721,14 @@ __armv7_mmu_cache_on:
 #endif
 		mrc	p15, 0, r0, c1, c0, 0	@ read control reg
 		bic	r0, r0, #1 << 28	@ clear SCTLR.TRE
-		orr	r0, r0, #0x5000		@ I-cache enable, RR cache replacement
-		orr	r0, r0, #0x003c		@ write buffer
+#ifndef CONFIG_CPU_ICACHE_DISABLE
+		orr	r0, r0, #0x1000		@ I-cache enable
+#endif
+#ifndef CONFIG_CPU_DCACHE_DISABLE
+		orr	r0, r0, #0x0004		@ D-cache enable
+#endif
+		orr	r0, r0, #0x4000		@ RR cache replacement
+		orr	r0, r0, #0x0038		@ write buffer
 		bic	r0, r0, #2		@ A (no unaligned access fault)
 		orr	r0, r0, #1 << 22	@ U (v6 unaligned access model)
 						@ (needed for ARM1176)
-- 
1.8.0
