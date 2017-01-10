From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 10 Jan 2017 11:38:50 +0000
Subject: [PATCH v3 3/9] KVM: Add event to trace tlb invalidations
In-Reply-To: <20170110113856.7183-1-punit.agrawal@arm.com>
References: <20170110113856.7183-1-punit.agrawal@arm.com>
Message-ID: <20170110113856.7183-4-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As TLB operations can have an impact on system performance, add a trace
event to enable monitoring of guest TLB maintenance operations.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
 include/trace/events/kvm.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/trace/events/kvm.h b/include/trace/events/kvm.h
index 8ade3eb6c640..fbe33089264c 100644
--- a/include/trace/events/kvm.h
+++ b/include/trace/events/kvm.h
@@ -393,6 +393,24 @@ TRACE_EVENT(kvm_halt_poll_ns,
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
+	TP_printk("vcpu_pc=0x%16lx opcode=%08x", __entry->vcpu_pc,
+		  __entry->opcode)
+);
+
 #endif /* _TRACE_KVM_MAIN_H */
 
 /* This part must be outside protection */
-- 
2.11.0
