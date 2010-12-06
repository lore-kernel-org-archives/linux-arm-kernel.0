From: dave.martin@linaro.org (Dave Martin)
Date: Mon,  6 Dec 2010 17:35:36 +0000
Subject: [PATCH v2 2/3] ARM: omap4: Correct definition of do_wfi() for
	CONFIG_THUMB2_KERNEL
In-Reply-To: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
References: <1291656937-24992-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1291656937-24992-3-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For the Thumb-2 case, the "wfi" mnemonic is used, since in this
case the tools will necessarily be new enough to support it.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
KernelVersion: 2.6.37-rc4

 arch/arm/mach-omap2/include/mach/omap4-common.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/include/mach/omap4-common.h b/arch/arm/mach-omap2/include/mach/omap4-common.h
index 2744dfe..c6b1320 100644
--- a/arch/arm/mach-omap2/include/mach/omap4-common.h
+++ b/arch/arm/mach-omap2/include/mach/omap4-common.h
@@ -17,8 +17,13 @@
  * wfi used in low power code. Directly opcode is used instead
  * of instruction to avoid mulit-omap build break
  */
+#ifdef CONFIG_THUMB2_KERNEL
+#define do_wfi()			\
+		__asm__ __volatile__ ("wfi" : : : "memory")
+#else
 #define do_wfi()			\
 		__asm__ __volatile__ (".word	0xe320f003" : : : "memory")
+#endif
 
 #ifdef CONFIG_CACHE_L2X0
 extern void __iomem *l2cache_base;
-- 
1.7.1
