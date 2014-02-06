From: andrew@lunn.ch (Andrew Lunn)
Date: Fri,  7 Feb 2014 00:42:08 +0100
Subject: [PATCH 12/21] ARM: Fix MULTI_TLB for feroceon
In-Reply-To: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
Message-ID: <1391730137-14814-13-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Feroceon has the same flush operations as v4wbi, but has an additional
flag, TLB_L2CLEAN_FR. When building with MULTI_TLB this flag is placed
into cpu_tlb.tlb_flags, so there needs to be a cpu_tlb specifically
for feroceon, rather than sharing the v4wbi.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/mm/proc-feroceon.S | 2 +-
 arch/arm/mm/tlb-v4wbi.S     | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mm/proc-feroceon.S b/arch/arm/mm/proc-feroceon.S
index db79b62c92fb..b76c2706cb02 100644
--- a/arch/arm/mm/proc-feroceon.S
+++ b/arch/arm/mm/proc-feroceon.S
@@ -607,7 +607,7 @@ __\name\()_proc_info:
 	.long	HWCAP_SWP|HWCAP_HALF|HWCAP_THUMB|HWCAP_FAST_MULT|HWCAP_EDSP
 	.long	\cpu_name
 	.long	feroceon_processor_functions
-	.long	v4wbi_tlb_fns
+	.long	fr_tlb_fns
 	.long	feroceon_user_fns
 	.long	\cache
 	 .size	__\name\()_proc_info, . - __\name\()_proc_info
diff --git a/arch/arm/mm/tlb-v4wbi.S b/arch/arm/mm/tlb-v4wbi.S
index 1f6062b6c1c1..4e053fef3487 100644
--- a/arch/arm/mm/tlb-v4wbi.S
+++ b/arch/arm/mm/tlb-v4wbi.S
@@ -28,6 +28,7 @@
  *	- mm    - mm_struct describing address space
  */
 	.align	5
+ENTRY(fr_flush_user_tlb_range)
 ENTRY(v4wbi_flush_user_tlb_range)
 	vma_vm_mm ip, r2
 	act_mm	r3				@ get current->active_mm
@@ -46,6 +47,7 @@ ENTRY(v4wbi_flush_user_tlb_range)
 	blo	1b
 	mov	pc, lr
 
+ENTRY(fr_flush_kern_tlb_range)
 ENTRY(v4wbi_flush_kern_tlb_range)
 	mov	r3, #0
 	mcr	p15, 0, r3, c7, c10, 4		@ drain WB
@@ -62,3 +64,4 @@ ENTRY(v4wbi_flush_kern_tlb_range)
 
 	/* define struct cpu_tlb_fns (see <asm/tlbflush.h> and proc-macros.S) */
 	define_tlb_functions v4wbi, v4wbi_tlb_flags
+	define_tlb_functions fr, fr_tlb_flags
-- 
1.8.5.3
