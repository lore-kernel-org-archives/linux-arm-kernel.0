From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 25 Nov 2014 16:10:00 +0000
Subject: [PATCH 2/7] KVM: arm: guest debug, define API headers
In-Reply-To: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1416931805-23223-3-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit defines the API headers for guest debugging. There are two
architecture specific debug structures:

  - kvm_guest_debug_arch, allows us to pass in HW debug registers
  - kvm_debug_exit_arch, signals the exact debug exit and address

The type of debugging being used is control by the architecture specific
control bits of the kvm_guest_debug->control flags in the ioctl
structure.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index 8e38878..de2450c 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -93,10 +93,30 @@ struct kvm_sregs {
 struct kvm_fpu {
 };
 
+/* See ARM ARM D7.3: Debug Registers
+ *
+ * The control registers are stored as 64bit values as the setup code
+ * is shared with the normal cpu context restore code in hyp.S which
+ * is 64 bit only.
+ */
+#define KVM_ARM_NDBG_REGS 16
 struct kvm_guest_debug_arch {
+	__u64 dbg_bcr[KVM_ARM_NDBG_REGS];
+	__u64 dbg_bvr[KVM_ARM_NDBG_REGS];
+	__u64 dbg_wcr[KVM_ARM_NDBG_REGS];
+	__u64 dbg_wvr[KVM_ARM_NDBG_REGS];
 };
 
+/* Exit types which define why we did a debug exit */
+#define KVM_DEBUG_EXIT_ERROR		0x0
+#define KVM_DEBUG_EXIT_SINGLE_STEP	0x1
+#define KVM_DEBUG_EXIT_SW_BKPT		0x2
+#define KVM_DEBUG_EXIT_HW_BKPT		0x3
+#define KVM_DEBUG_EXIT_HW_WTPT		0x4
+
 struct kvm_debug_exit_arch {
+	__u64 address;
+	__u32 exit_type;
 };
 
 struct kvm_sync_regs {
@@ -198,4 +218,12 @@ struct kvm_arch_memory_slot {
 
 #endif
 
+/* Architecture related debug defines - upper 16 bits of
+ * kvm_guest_debug->control
+ */
+#define KVM_GUESTDBG_USE_SW_BP_SHIFT	16
+#define KVM_GUESTDBG_USE_SW_BP		(1 << KVM_GUESTDBG_USE_SW_BP_SHIFT)
+#define KVM_GUESTDBG_USE_HW_BP_SHIFT	17
+#define KVM_GUESTDBG_USE_HW_BP		(1 << KVM_GUESTDBG_USE_HW_BP_SHIFT)
+
 #endif /* __ARM_KVM_H__ */
-- 
2.1.3
