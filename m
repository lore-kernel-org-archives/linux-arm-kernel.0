From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  4 Nov 2015 15:49:55 +0100
Subject: [PULL 16/21] arm/arm64: KVM: Add tracepoints for vgic and timer
In-Reply-To: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
References: <1446648600-27297-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1446648600-27297-17-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The VGIC and timer code for KVM arm/arm64 doesn't have any tracepoints
or tracepoint infrastructure defined.  Rewriting some of the timer code
handling showed me how much we need this, so let's add these simple
trace points once and for all and we can easily expand with additional
trace points in these files as we go along.

Cc: Wei Huang <wei@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/arm/arch_timer.c |  4 +++
 virt/kvm/arm/trace.h      | 63 +++++++++++++++++++++++++++++++++++++++++++++++
 virt/kvm/arm/vgic.c       |  5 ++++
 3 files changed, 72 insertions(+)
 create mode 100644 virt/kvm/arm/trace.h

diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 523816d..21a0ab2 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -28,6 +28,8 @@
 #include <kvm/arm_vgic.h>
 #include <kvm/arm_arch_timer.h>
 
+#include "trace.h"
+
 static struct timecounter *timecounter;
 static struct workqueue_struct *wqueue;
 static unsigned int host_vtimer_irq;
@@ -129,6 +131,8 @@ static void kvm_timer_update_irq(struct kvm_vcpu *vcpu, bool new_level)
 	BUG_ON(!vgic_initialized(vcpu->kvm));
 
 	timer->irq.level = new_level;
+	trace_kvm_timer_update_irq(vcpu->vcpu_id, timer->map->virt_irq,
+				   timer->irq.level);
 	ret = kvm_vgic_inject_mapped_irq(vcpu->kvm, vcpu->vcpu_id,
 					 timer->map,
 					 timer->irq.level);
diff --git a/virt/kvm/arm/trace.h b/virt/kvm/arm/trace.h
new file mode 100644
index 0000000..37d8b98
--- /dev/null
+++ b/virt/kvm/arm/trace.h
@@ -0,0 +1,63 @@
+#if !defined(_TRACE_KVM_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_KVM_H
+
+#include <linux/tracepoint.h>
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM kvm
+
+/*
+ * Tracepoints for vgic
+ */
+TRACE_EVENT(vgic_update_irq_pending,
+	TP_PROTO(unsigned long vcpu_id, __u32 irq, bool level),
+	TP_ARGS(vcpu_id, irq, level),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_id	)
+		__field(	__u32,		irq	)
+		__field(	bool,		level	)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id	= vcpu_id;
+		__entry->irq		= irq;
+		__entry->level		= level;
+	),
+
+	TP_printk("VCPU: %ld, IRQ %d, level: %d",
+		  __entry->vcpu_id, __entry->irq, __entry->level)
+);
+
+/*
+ * Tracepoints for arch_timer
+ */
+TRACE_EVENT(kvm_timer_update_irq,
+	TP_PROTO(unsigned long vcpu_id, __u32 irq, int level),
+	TP_ARGS(vcpu_id, irq, level),
+
+	TP_STRUCT__entry(
+		__field(	unsigned long,	vcpu_id	)
+		__field(	__u32,		irq	)
+		__field(	int,		level	)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_id	= vcpu_id;
+		__entry->irq		= irq;
+		__entry->level		= level;
+	),
+
+	TP_printk("VCPU: %ld, IRQ %d, level %d",
+		  __entry->vcpu_id, __entry->irq, __entry->level)
+);
+
+#endif /* _TRACE_KVM_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../../../virt/kvm/arm
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
index 84abc6f..d4669eb 100644
--- a/virt/kvm/arm/vgic.c
+++ b/virt/kvm/arm/vgic.c
@@ -34,6 +34,9 @@
 #include <asm/kvm.h>
 #include <kvm/iodev.h>
 
+#define CREATE_TRACE_POINTS
+#include "trace.h"
+
 /*
  * How the whole thing works (courtesy of Christoffer Dall):
  *
@@ -1574,6 +1577,8 @@ static int vgic_update_irq_pending(struct kvm *kvm, int cpuid,
 	int enabled;
 	bool ret = true, can_inject = true;
 
+	trace_vgic_update_irq_pending(cpuid, irq_num, level);
+
 	if (irq_num >= min(kvm->arch.vgic.nr_irqs, 1020))
 		return -EINVAL;
 
-- 
2.1.2.330.g565301e.dirty
