From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Aug 2016 13:38:12 +0100
Subject: [PATCH 2/5] arm64: KVM: Allow kvm_skip_instr32 to be shared between
 kernel and HYP code
In-Reply-To: <1471610295-1456-1-git-send-email-marc.zyngier@arm.com>
References: <1471610295-1456-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1471610295-1456-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we're going to start emulating some instruction while in HYP,
we need to be able to move the PC forward. Pretty easy for AArch64,
but quite fidly for AArch32 (think Thumb2 and the IT state).

In order to be able to reuse the existing code in HYP, move the bulk
of it to kvm_emulate.h, and let the implementation located in
emulate.c use it. HYP will be able to use it at the expense of an
additional copy in the object file, but we can at least share the
source code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 49 ++++++++++++++++++++++++++++++++++++
 arch/arm64/kvm/emulate.c             | 45 +--------------------------------
 2 files changed, 50 insertions(+), 44 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 4cdeae3..60db363 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -311,4 +311,53 @@ static inline unsigned long vcpu_data_host_to_guest(struct kvm_vcpu *vcpu,
 	return data;		/* Leave LE untouched */
 }
 
+/**
+ * kvm_adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
+ * @vcpu:	The VCPU pointer
+ *
+ * When exceptions occur while instructions are executed in Thumb IF-THEN
+ * blocks, the ITSTATE field of the CPSR is not advanced (updated), so we have
+ * to do this little bit of work manually. The fields map like this:
+ *
+ * IT[7:0] -> CPSR[26:25],CPSR[15:10]
+ */
+static inline void kvm_adjust_itstate(struct kvm_vcpu *vcpu)
+{
+	unsigned long itbits, cond;
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
+	bool is_arm = !(cpsr & COMPAT_PSR_T_BIT);
+
+	if (is_arm || !(cpsr & COMPAT_PSR_IT_MASK))
+		return;
+
+	cond = (cpsr & 0xe000) >> 13;
+	itbits = (cpsr & 0x1c00) >> (10 - 2);
+	itbits |= (cpsr & (0x3 << 25)) >> 25;
+
+	/* Perform ITAdvance (see page A2-52 in ARM DDI 0406C) */
+	if ((itbits & 0x7) == 0)
+		itbits = cond = 0;
+	else
+		itbits = (itbits << 1) & 0x1f;
+
+	cpsr &= ~COMPAT_PSR_IT_MASK;
+	cpsr |= cond << 13;
+	cpsr |= (itbits & 0x1c) << (10 - 2);
+	cpsr |= (itbits & 0x3) << 25;
+	*vcpu_cpsr(vcpu) = cpsr;
+}
+
+static void inline kvm_skip_aarch32_instr(struct kvm_vcpu *vcpu,
+					  bool is_wide_instr)
+{
+	bool is_thumb;
+
+	is_thumb = !!(*vcpu_cpsr(vcpu) & COMPAT_PSR_T_BIT);
+	if (is_thumb && !is_wide_instr)
+		*vcpu_pc(vcpu) += 2;
+	else
+		*vcpu_pc(vcpu) += 4;
+	kvm_adjust_itstate(vcpu);
+}
+
 #endif /* __ARM64_KVM_EMULATE_H__ */
diff --git a/arch/arm64/kvm/emulate.c b/arch/arm64/kvm/emulate.c
index df76590..d5f6a29 100644
--- a/arch/arm64/kvm/emulate.c
+++ b/arch/arm64/kvm/emulate.c
@@ -105,53 +105,10 @@ bool kvm_condition_valid32(const struct kvm_vcpu *vcpu)
 }
 
 /**
- * adjust_itstate - adjust ITSTATE when emulating instructions in IT-block
- * @vcpu:	The VCPU pointer
- *
- * When exceptions occur while instructions are executed in Thumb IF-THEN
- * blocks, the ITSTATE field of the CPSR is not advanced (updated), so we have
- * to do this little bit of work manually. The fields map like this:
- *
- * IT[7:0] -> CPSR[26:25],CPSR[15:10]
- */
-static void kvm_adjust_itstate(struct kvm_vcpu *vcpu)
-{
-	unsigned long itbits, cond;
-	unsigned long cpsr = *vcpu_cpsr(vcpu);
-	bool is_arm = !(cpsr & COMPAT_PSR_T_BIT);
-
-	if (is_arm || !(cpsr & COMPAT_PSR_IT_MASK))
-		return;
-
-	cond = (cpsr & 0xe000) >> 13;
-	itbits = (cpsr & 0x1c00) >> (10 - 2);
-	itbits |= (cpsr & (0x3 << 25)) >> 25;
-
-	/* Perform ITAdvance (see page A2-52 in ARM DDI 0406C) */
-	if ((itbits & 0x7) == 0)
-		itbits = cond = 0;
-	else
-		itbits = (itbits << 1) & 0x1f;
-
-	cpsr &= ~COMPAT_PSR_IT_MASK;
-	cpsr |= cond << 13;
-	cpsr |= (itbits & 0x1c) << (10 - 2);
-	cpsr |= (itbits & 0x3) << 25;
-	*vcpu_cpsr(vcpu) = cpsr;
-}
-
-/**
  * kvm_skip_instr - skip a trapped instruction and proceed to the next
  * @vcpu: The vcpu pointer
  */
 void kvm_skip_instr32(struct kvm_vcpu *vcpu, bool is_wide_instr)
 {
-	bool is_thumb;
-
-	is_thumb = !!(*vcpu_cpsr(vcpu) & COMPAT_PSR_T_BIT);
-	if (is_thumb && !is_wide_instr)
-		*vcpu_pc(vcpu) += 2;
-	else
-		*vcpu_pc(vcpu) += 4;
-	kvm_adjust_itstate(vcpu);
+	kvm_skip_aarch32_instr(vcpu, is_wide_instr);
 }
-- 
2.1.4
