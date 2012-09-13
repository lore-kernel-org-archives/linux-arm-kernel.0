From: horms@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2012 10:00:42 +0900
Subject: [PATCH 2/2] arm: Add ARM ERRATA 782773 workaround
In-Reply-To: <5050CD87.4020800@codeaurora.org>
References: <1347434097-7924-1-git-send-email-horms@verge.net.au>
 <1347434097-7924-3-git-send-email-horms@verge.net.au>
 <5050CD87.4020800@codeaurora.org>
Message-ID: <20120913010041.GD7622@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 12, 2012 at 10:59:35AM -0700, Stephen Boyd wrote:
> On 09/12/12 00:14, Simon Horman wrote:
> > @@ -1423,6 +1423,15 @@ config ARM_ERRATA_775420
> >           deadlock. This workaround puts DSB before executing ISB at the
> >           beginning of the abort exception handler.
> >  
> > +config ARM_ERRATA_782773
> > +	bool "ARM errata: Updating a translation entry might cause an unexpected translation fault"
> > +	depends on CPU_V7
> > +	help
> > +	  This option enables the workaround for the 782773 Cortex-A9 (all r0,
> > +	  ,r2 and r3 revisions) erratum. It might cause MMU exception in case
> 
> Seems to be an extra comma here.

Thanks, here is an updated version.

From: Kouei Abe <kouei.abe.cp@rms.renesas.com>

arm: Add ARM ERRATA 782773 workaround

Signed-off-by: Kouei Abe <kouei.abe.cp@rms.renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/Kconfig             |    9 +++++++++
 arch/arm/mm/proc-v7-2level.S |    8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 74fbdf7..6367fd9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1423,6 +1423,15 @@ config ARM_ERRATA_775420
          deadlock. This workaround puts DSB before executing ISB at the
          beginning of the abort exception handler.
 
+config ARM_ERRATA_782773
+	bool "ARM errata: Updating a translation entry might cause an unexpected translation fault"
+	depends on CPU_V7
+	help
+	  This option enables the workaround for the 782773 Cortex-A9 (all r0,
+	  r2 and r3 revisions) erratum. It might cause MMU exception in case
+	  page table walk happens just after updating the existing
+	  with setting page table in L1 data cache.
+
 endmenu
 
 source "arch/arm/common/Kconfig"
diff --git a/arch/arm/mm/proc-v7-2level.S b/arch/arm/mm/proc-v7-2level.S
index fd045e7..9207b9f 100644
--- a/arch/arm/mm/proc-v7-2level.S
+++ b/arch/arm/mm/proc-v7-2level.S
@@ -103,9 +103,17 @@ ENTRY(cpu_v7_set_pte_ext)
 	tstne	r1, #L_PTE_PRESENT
 	moveq	r3, #0
 
+#ifdef CONFIG_ARM_ERRATA_782773
+	mrs	r2, cpsr			@ save cpsr
+	cpsid	if				@ disable interrupts
+	mcr	p15, 0, r0, c7, c14, 1		@ clean & invalidate D line
+#endif
  ARM(	str	r3, [r0, #2048]! )
  THUMB(	add	r0, r0, #2048 )
  THUMB(	str	r3, [r0] )
+#ifdef CONFIG_ARM_ERRATA_782773
+	msr	cpsr_c, r2			@ load cpsr
+#endif
 	mcr	p15, 0, r0, c7, c10, 1		@ flush_pte
 #endif
 	mov	pc, lr
-- 
1.7.10.4
