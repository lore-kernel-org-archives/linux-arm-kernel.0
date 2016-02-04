From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  4 Feb 2016 11:00:24 +0000
Subject: [PATCH v2 07/28] ARM: KVM: Add system register accessor macros
In-Reply-To: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
References: <1454583645-10144-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1454583645-10144-8-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to move system register (CP15, mostly) access to C code,
add a few macros to facilitate this, and minimize the difference
between 32 and 64bit CP15 registers.

This will get heavily used in the following patches.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/hyp/hyp.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/kvm/hyp/hyp.h b/arch/arm/kvm/hyp/hyp.h
index c723870..727089f 100644
--- a/arch/arm/kvm/hyp/hyp.h
+++ b/arch/arm/kvm/hyp/hyp.h
@@ -27,4 +27,19 @@
 #define kern_hyp_va(v) (v)
 #define hyp_kern_va(v) (v)
 
+#define __ACCESS_CP15(CRn, Op1, CRm, Op2)	\
+	"mrc", "mcr", __stringify(p15, Op1, %0, CRn, CRm, Op2), u32
+#define __ACCESS_CP15_64(Op1, CRm)		\
+	"mrrc", "mcrr", __stringify(p15, Op1, %Q0, %R0, CRm), u64
+
+#define __write_sysreg(v, r, w, c, t)	asm volatile(w " " c : : "r" ((t)(v)))
+#define write_sysreg(v, ...)		__write_sysreg(v, __VA_ARGS__)
+
+#define __read_sysreg(r, w, c, t) ({				\
+	t __val;						\
+	asm volatile(r " " c : "=r" (__val));			\
+	__val;							\
+})
+#define read_sysreg(...)		__read_sysreg(__VA_ARGS__)
+
 #endif /* __ARM_KVM_HYP_H__ */
-- 
2.1.4
