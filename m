From: adharmap@codeaurora.org (Abhijeet Dharmapurikar)
Date: Fri, 20 Nov 2009 12:29:10 -0800
Subject: [PATCH 1/2] system: mb,
	wmb and rmb should do a memory barrier even for non SMP
Message-ID: <1258748951-10548-1-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If a system is UP noncoherent it still needs a mechanism for enforcing
transfers. Make mb, wmb, rmb do a memory barrier on v6+ architectures.

Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
---
These patches  are a summary of the discussion about changing coherent memory
to return Normal Noncached instead of Strongly Ordered on ARMv7. The
discussion could be found at 
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/002824.html

It picks up changes to mb,rmb and wmb as suggested by Catalin at 
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/002772.html
AND 
definition of pgprot_dmacoherent() by Russell King at 
http://lists.infradead.org/pipermail/linux-arm-kernel/2009-October/002822.html

Note that mb, rmb and wmb will expand to dmb() only for v7 and above
architectures, since coherent memory was changed to Normal Noncached only for
v7 and above architectures.

Russell and Catalin, since you were the original creator of these changes can
you sign-off on these?
 
 arch/arm/include/asm/system.h |   23 +++++++++++++++++------
 1 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index ac44fa8..d68e135 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -140,20 +140,31 @@ extern unsigned int user_debug;
 #endif
 
 #ifndef CONFIG_SMP
-#define mb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
-#define rmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
-#define wmb()	do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
+#if __LINUX_ARM_ARCH__ <=  6
+#define mb()    do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
+#define rmb()   do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
+#define wmb()   do { if (arch_is_coherent()) dmb(); else barrier(); } while (0)
+#else
+/*
+ * pgprot_noncached() creates Normal uncached mappings, therefore mandatory
+ * barriers are needed.
+ */
+#define mb()            dmb()
+#define rmb()           dmb()
+#define wmb()           dmb()
+#endif
 #define smp_mb()	barrier()
 #define smp_rmb()	barrier()
 #define smp_wmb()	barrier()
 #else
-#define mb()		dmb()
-#define rmb()		dmb()
-#define wmb()		dmb()
+#define mb()            dmb()
+#define rmb()           dmb()
+#define wmb()           dmb()
 #define smp_mb()	dmb()
 #define smp_rmb()	dmb()
 #define smp_wmb()	dmb()
 #endif
+
 #define read_barrier_depends()		do { } while(0)
 #define smp_read_barrier_depends()	do { } while(0)
 
-- 
1.5.6.3
