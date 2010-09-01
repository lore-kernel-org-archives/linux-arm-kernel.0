From: tony@atomide.com (Tony Lindgren)
Date: Wed, 1 Sep 2010 16:49:13 -0700
Subject: [PATCH 3/6] ARM: Fix v7wbi_tlb_flags for SMP on UP
Message-ID: <mailman.222.1283444448.27306.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix v7wbi_tlb_flags for SMP on UP. Note that we must enable MULTI_TLB
to avoid undefined reference to cpu_tlb error.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/include/asm/tlbflush.h |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index 1fd0db9..55e1dd9 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -189,20 +189,32 @@
 # define v6wbi_always_flags	(-1UL)
 #endif
 
+#define v7wbi_tlb_flags_common (TLB_WB | TLB_DCLEAN)
 #define v7wbi_tlb_flags_smp (TLB_WB | TLB_DCLEAN | TLB_V7_IS_BTB | \
 			 TLB_V7_UIS_FULL | TLB_V7_UIS_PAGE | TLB_V7_UIS_ASID)
 #define v7wbi_tlb_flags_up (TLB_WB | TLB_DCLEAN | TLB_BTB | \
 			 TLB_V6_U_FULL | TLB_V6_U_PAGE | TLB_V6_U_ASID)
 
 #ifdef CONFIG_SMP
+#ifdef CONFIG_SMP_ON_UP
+#define v7wbi_tlb_flags	(v7wbi_tlb_flags_smp | v7wbi_tlb_flags_up)
+#else
 #define v7wbi_tlb_flags	v7wbi_tlb_flags_smp
+#endif
 #else
 #define v7wbi_tlb_flags	v7wbi_tlb_flags_up
 #endif
 
 #ifdef CONFIG_CPU_TLB_V7
 # define v7wbi_possible_flags	v7wbi_tlb_flags
-# define v7wbi_always_flags	v7wbi_tlb_flags
+# ifdef CONFIG_SMP_ON_UP
+#  define v7wbi_always_flags	v7wbi_tlb_flags_common
+#  ifndef MULTI_TLB
+#   define MULTI_TLB 1
+#  endif
+# else
+#  define v7wbi_always_flags	v7wbi_tlb_flags
+# endif
 # ifdef _TLB
 #  define MULTI_TLB 1
 # else
-- 
1.7.1
