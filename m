From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Sep 2010 15:02:50 -0700
Subject: [PATCH] ARM: Add SMP and UP macros for inline assembly
Message-ID: <mailman.226.1283447719.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We can't use the macros in asm/assembler.h in C inline functions.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 55974d2..340795c 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -154,6 +154,10 @@
 	.long	9999b,9001f;			\
 	.popsection
 
+/*
+ * SMP and UP defines for assembly code. See also asm/smp_plat.h
+ * for the SMP and UP defines for inline code.
+ */
 #ifdef CONFIG_SMP
 #define SMP(instr...)						\
 9998:	instr
diff --git a/arch/arm/include/asm/smp_plat.h b/arch/arm/include/asm/smp_plat.h
index e621530..8db3512 100644
--- a/arch/arm/include/asm/smp_plat.h
+++ b/arch/arm/include/asm/smp_plat.h
@@ -18,4 +18,25 @@ static inline int cache_ops_need_broadcast(void)
 	return ((read_cpuid_ext(CPUID_EXT_MMFR3) >> 12) & 0xf) < 1;
 }
 
+/*
+ * SMP and UP defines for inline functions. See also asm/assembler.h
+ * for the SMP and UP defines for assembly code.
+ */
+#ifdef CONFIG_SMP
+#define _str(s...)	#s
+#define _9998(s...)	_str(9998:	s\n)
+
+#define SMP(instr...)						\
+	_9998(instr)
+
+#define UP(instr...)						\
+	_str(.pushsection ".smpalt.init", "a"\n)		\
+	_str(.word	9998b\n)				\
+	_str(instr\n)						\
+	_str(.popsection\n)
+#else
+#define SMP(instr...)
+#define UP(instr...)	_str(instr)
+#endif
+
 #endif
