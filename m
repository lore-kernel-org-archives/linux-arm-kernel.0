From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 25 Mar 2014 16:52:25 +0100
Subject: [PATCH] Xen: do hv callback accounting only on x86
Message-ID: <5057041.71iuvlcH4G@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch 99c8b79d3c1 "xen: Add proper irq accounting for HYPERCALL vector"
added a call to inc_irq_stat(irq_hv_callback_count) in common Xen code,
however both the inc_irq_stat function and the irq_hv_callback_count
counter are architecture specific.

This makes the code build again on ARM by moving the call into the
existing #ifdef CONFIG_X86. We may want to later do the same implementation
on ARM that x86 has though.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: David Vrabel <david.vrabel@citrix.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Xen <xen-devel@lists.xenproject.org>

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 5dd2ddf..8b91c256 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1235,6 +1235,7 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
 #ifdef CONFIG_X86
        exit_idle();
 #endif
+       inc_irq_stat(irq_hv_callback_count);

        __xen_evtchn_do_upcall();

diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index d5a3de8..dfa12a4 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -1248,8 +1248,8 @@ void xen_evtchn_do_upcall(struct pt_regs *regs)
 	irq_enter();
 #ifdef CONFIG_X86
 	exit_idle();
-#endif
 	inc_irq_stat(irq_hv_callback_count);
+#endif
 
 	__xen_evtchn_do_upcall();
 
