From: julien.grall@citrix.com (Julien Grall)
Date: Sat, 25 Jul 2015 18:34:24 +0100
Subject: [PATCH] xen/events: Support event channel rebind on ARM
Message-ID: <1437845664-32098-1-git-send-email-julien.grall@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, the event channel rebind code is gated with the presence of
the vector callback.

The virtual interrupt controller on ARM has the concept of per-CPU
interrupt (PPI) which allow us to support per-VCPU event channel.
Therefore there is no need of vector callback for ARM.

Xen is already using a free PPI to notify the guest VCPU of an event.
Furthermore, the xen code initialization in Linux (see
arch/arm/xen/enlighten.c) is requesting correctly a per-CPU IRQ.

Introduce new macro xen_support_evtchn_rebind to allow architecture
decide whether rebind an event is support or not. It will always return
1 on ARM and keep the same behavior on x86.

This is also allow us to drop the usage of xen_have_vector_callback
entirely in the ARM code.

Signed-off-by: Julien Grall <julien.grall@citrix.com>
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86 at kernel.org
---
    Tested by setting the affinity manually via /proc on dom0 ARM64
---
 arch/arm/include/asm/xen/events.h   | 3 +++
 arch/arm/xen/enlighten.c            | 4 ----
 arch/arm64/include/asm/xen/events.h | 3 +++
 arch/x86/include/asm/xen/events.h   | 9 +++++++++
 drivers/xen/events/events_base.c    | 6 +-----
 include/xen/events.h                | 1 -
 6 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/arm/include/asm/xen/events.h b/arch/arm/include/asm/xen/events.h
index 8b1f37b..72d467f 100644
--- a/arch/arm/include/asm/xen/events.h
+++ b/arch/arm/include/asm/xen/events.h
@@ -20,4 +20,7 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 							    atomic64_t,	\
 							    counter), (val))
 
+/* Rebind event channel is supported by default */
+#define xen_support_evtchn_rebind()	(1)
+
 #endif /* _ASM_ARM_XEN_EVENTS_H */
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 9055c92..c50c8d3 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -45,10 +45,6 @@ static struct vcpu_info __percpu *xen_vcpu_info;
 unsigned long xen_released_pages;
 struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
 
-/* TODO: to be removed */
-__read_mostly int xen_have_vector_callback;
-EXPORT_SYMBOL_GPL(xen_have_vector_callback);
-
 static __read_mostly unsigned int xen_events_irq;
 
 static __initdata struct device_node *xen_node;
diff --git a/arch/arm64/include/asm/xen/events.h b/arch/arm64/include/asm/xen/events.h
index 8655321..259eef0 100644
--- a/arch/arm64/include/asm/xen/events.h
+++ b/arch/arm64/include/asm/xen/events.h
@@ -18,4 +18,7 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 
 #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
 
+/* Rebind event channel is supported by default */
+#define xen_support_evtchn_rebind()	(1)
+
 #endif /* _ASM_ARM64_XEN_EVENTS_H */
diff --git a/arch/x86/include/asm/xen/events.h b/arch/x86/include/asm/xen/events.h
index 608a79d..e8ed478 100644
--- a/arch/x86/include/asm/xen/events.h
+++ b/arch/x86/include/asm/xen/events.h
@@ -20,4 +20,13 @@ static inline int xen_irqs_disabled(struct pt_regs *regs)
 /* No need for a barrier -- XCHG is a barrier on x86. */
 #define xchg_xen_ulong(ptr, val) xchg((ptr), (val))
 
+/*
+ * Events delivered via platform PCI interrupts are always
+ * routed to vcpu 0 and hence cannot be rebound.
+ */
+#define xen_support_evtchn_rebind()	\
+	(!xen_hvm_domain() || xen_have_vector_callback)
+
+extern int xen_have_vector_callback;
+
 #endif /* _ASM_X86_XEN_EVENTS_H */
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 96093ae..ed620e5 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1301,11 +1301,7 @@ static int rebind_irq_to_cpu(unsigned irq, unsigned tcpu)
 	if (!VALID_EVTCHN(evtchn))
 		return -1;
 
-	/*
-	 * Events delivered via platform PCI interrupts are always
-	 * routed to vcpu 0 and hence cannot be rebound.
-	 */
-	if (xen_hvm_domain() && !xen_have_vector_callback)
+	if (!xen_support_evtchn_rebind())
 		return -1;
 
 	/* Send future instances of this interrupt to other vcpu. */
diff --git a/include/xen/events.h b/include/xen/events.h
index 7d95fdf..88da2ab 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -92,7 +92,6 @@ void xen_hvm_callback_vector(void);
 #ifdef CONFIG_TRACING
 #define trace_xen_hvm_callback_vector xen_hvm_callback_vector
 #endif
-extern int xen_have_vector_callback;
 int xen_set_callback_via(uint64_t via);
 void xen_evtchn_do_upcall(struct pt_regs *regs);
 void xen_hvm_evtchn_do_upcall(void);
-- 
2.1.4
