From: punit.agrawal@arm.com (Punit Agrawal)
Date: Wed, 26 Oct 2016 18:41:45 +0100
Subject: [PATCH v2 5/8] KVM: Add event to trace tlb invalidations
In-Reply-To: <20161026174148.17172-1-punit.agrawal@arm.com>
References: <20161026174148.17172-1-punit.agrawal@arm.com>
Message-ID: <20161026174148.17172-6-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As TLB operations can have an impact on system performance, add a trace
event to enable monitoring of guest TLB maintenance operations.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 include/trace/events/kvm.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 8ade3eb..4b3d07e 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -393,6 +393,23 @@ TRACE_EVENT(kvm_halt_poll_ns,
 #define trace_kvm_halt_poll_ns_shrink(vcpu_id, new, old) \
 	trace_kvm_halt_poll_ns(false, vcpu_id, new, old)
 
+TRACE_EVENT(kvm_tlb_invalidate,
+	TP_PROTO(unsigned long vcpu_pc, u32 opcode),
+	TP_ARGS(vcpu_pc, opcode),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, vcpu_pc)
+		__field(u32, opcode)
+	),
+
+	TP_fast_assign(
+		__entry->vcpu_pc = vcpu_pc;
+		__entry->opcode = opcode;
+	),
+
+	TP_printk("vcpu_pc=0x%16lx opcode=%08x", __entry->vcpu_pc, __entry->opcode)
+);
+
 #endif /* _TRACE_KVM_MAIN_H */
 
 /* This part must be outside protection */
-- 
2.9.3
