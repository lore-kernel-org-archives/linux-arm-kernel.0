From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 27 Nov 2015 18:50:04 +0000
Subject: [PATCH v2 10/21] arm64: KVM: Add patchable function selector
In-Reply-To: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
References: <1448650215-15218-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1448650215-15218-11-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

KVM so far relies on code patching, and is likely to use it more
in the future. The main issue is that our alternative system works
at the instruction level, while we'd like to have alternatives at
the function level.

In order to cope with this, add the "hyp_alternate_select" macro that
outputs a brief sequence of code that in turn can be patched, allowing
al alternative function to be selected.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/hyp.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/kvm/hyp/hyp.h b/arch/arm64/kvm/hyp/hyp.h
index 7ac8e11..f0427ee 100644
--- a/arch/arm64/kvm/hyp/hyp.h
+++ b/arch/arm64/kvm/hyp/hyp.h
@@ -27,6 +27,22 @@
 
 #define kern_hyp_va(v) (typeof(v))((unsigned long)v & HYP_PAGE_OFFSET_MASK)
 
+/*
+ * Generates patchable code sequences that are used to switch between
+ * two implementations of a function, depending on the availability of
+ * a feature.
+ */
+#define hyp_alternate_select(fname, orig, alt, cond)			\
+typeof(orig) * __hyp_text fname(void)					\
+{									\
+	typeof(alt) *val = orig;					\
+	asm volatile(ALTERNATIVE("nop		\n",			\
+				 "mov	%0, %1	\n",			\
+				 cond)					\
+		     : "+r" (val) : "r" (alt));				\
+	return val;							\
+}
+
 void __vgic_v2_save_state(struct kvm_vcpu *vcpu);
 void __vgic_v2_restore_state(struct kvm_vcpu *vcpu);
 
-- 
2.1.4
