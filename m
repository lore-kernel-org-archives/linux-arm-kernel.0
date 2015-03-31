From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:08:01 +0100
Subject: [PATCH v2 03/10] KVM: arm: guest debug, define API headers
In-Reply-To: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1427814488-28467-4-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit defines the API headers for guest debugging. There are two
architecture specific debug structures:

  - kvm_guest_debug_arch, allows us to pass in HW debug registers
  - kvm_debug_exit_arch, signals the exact debug exit and pc

The type of debugging being used is control by the architecture specific
control bits of the kvm_guest_debug->control flags in the ioctl
structure.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2
   - expose hsr and pc directly to user-space

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 3ef77a4..6ee70a0 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -100,10 +100,24 @@ struct kvm_sregs {
 struct kvm_fpu {
 };
 
+/*
+ * See ARM ARM D7.3: Debug Registers
+ *
+ * The control registers are architecturally defined as 32 bits but are
+ * stored as 64 bit values along side the value registers and aligned
+ * with the rest 64 bit registers in the normal CPU context.
+ */
+#define KVM_ARM_NDBG_REGS 16
 struct kvm_guest_debug_arch {
+	__u64 dbg_bcr[KVM_ARM_NDBG_REGS];
+	__u64 dbg_bvr[KVM_ARM_NDBG_REGS];
+	__u64 dbg_wcr[KVM_ARM_NDBG_REGS];
+	__u64 dbg_wvr[KVM_ARM_NDBG_REGS];
 };
 
 struct kvm_debug_exit_arch {
+	__u64 pc;
+	__u32 hsr;
 };
 
 struct kvm_sync_regs {
@@ -207,4 +221,11 @@ struct kvm_arch_memory_slot {
 
 #endif
 
+/*
+ * Architecture related debug defines - upper 16 bits of
+ * kvm_guest_debug->control
+ */
+#define KVM_GUESTDBG_USE_SW_BP	        __KVM_GUESTDBG_USE_SW_BP
+#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
+
 #endif /* __ARM_KVM_H__ */
-- 
2.3.4
