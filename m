From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:40:43 +0100
Subject: [PATCH v2 1/4] linux-headers: partial sync from my kernel tree (DEV)
In-Reply-To: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
References: <1427816446-31586-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1427816446-31586-2-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I assume I'll properly merge the KVM Headers direct from Linux when
done. These headers came from:

https://git.linaro.org/people/alex.bennee/linux.git/shortlog/refs/heads/guest-debug/4.0-rc6-v2

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

---
v2
  - update ABI to include ->far

diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 3ef77a4..73f21e4 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -100,10 +100,25 @@ struct kvm_sregs {
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
+	__u64 far;	/* used for watchpoints */
 };
 
 struct kvm_sync_regs {
@@ -207,4 +222,11 @@ struct kvm_arch_memory_slot {
 
 #endif
 
+/*
+ * Architecture related debug defines - upper 16 bits of
+ * kvm_guest_debug->control
+ */
+#define KVM_GUESTDBG_USE_SW_BP	        __KVM_GUESTDBG_USE_SW_BP
+#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
+
 #endif /* __ARM_KVM_H__ */
diff --git a/linux-headers/asm-powerpc/kvm.h b/linux-headers/asm-powerpc/kvm.h
index ab4d473..1731569 100644
--- a/linux-headers/asm-powerpc/kvm.h
+++ b/linux-headers/asm-powerpc/kvm.h
@@ -310,8 +310,8 @@ struct kvm_guest_debug_arch {
  * and upper 16 bits are architecture specific. Architecture specific defines
  * that ioctl is for setting hardware breakpoint or software breakpoint.
  */
-#define KVM_GUESTDBG_USE_SW_BP		0x00010000
-#define KVM_GUESTDBG_USE_HW_BP		0x00020000
+#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
+#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
 
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
diff --git a/linux-headers/asm-x86/kvm.h b/linux-headers/asm-x86/kvm.h
index d7dcef5..1438202 100644
--- a/linux-headers/asm-x86/kvm.h
+++ b/linux-headers/asm-x86/kvm.h
@@ -250,8 +250,8 @@ struct kvm_debug_exit_arch {
 	__u64 dr7;
 };
 
-#define KVM_GUESTDBG_USE_SW_BP		0x00010000
-#define KVM_GUESTDBG_USE_HW_BP		0x00020000
+#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
+#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
 #define KVM_GUESTDBG_INJECT_DB		0x00040000
 #define KVM_GUESTDBG_INJECT_BP		0x00080000
 
diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
index 60a54c8..fa6c2ac 100644
--- a/linux-headers/linux/kvm.h
+++ b/linux-headers/linux/kvm.h
@@ -226,6 +226,7 @@ struct kvm_run {
 			__u32 count;
 			__u64 data_offset; /* relative to kvm_run start */
 		} io;
+		/* KVM_EXIT_DEBUG */
 		struct {
 			struct kvm_debug_exit_arch arch;
 		} debug;
@@ -274,6 +275,7 @@ struct kvm_run {
 			__u32 data;
 			__u8  is_write;
 		} dcr;
+		/* KVM_EXIT_INTERNAL_ERROR */
 		struct {
 			__u32 suberror;
 			/* Available with KVM_CAP_INTERNAL_ERROR_DATA: */
@@ -284,6 +286,7 @@ struct kvm_run {
 		struct {
 			__u64 gprs[32];
 		} osi;
+		/* KVM_EXIT_PAPR_HCALL */
 		struct {
 			__u64 nr;
 			__u64 ret;
@@ -522,8 +525,16 @@ struct kvm_s390_irq {
 
 /* for KVM_SET_GUEST_DEBUG */
 
-#define KVM_GUESTDBG_ENABLE		0x00000001
-#define KVM_GUESTDBG_SINGLESTEP		0x00000002
+#define KVM_GUESTDBG_ENABLE		(1 << 0)
+#define KVM_GUESTDBG_SINGLESTEP	(1 << 1)
+
+/*
+ * Architecture specific stuff uses the top 16 bits of the field,
+ * however there is some shared commonality for the common cases
+ */
+#define __KVM_GUESTDBG_USE_SW_BP	(1 << 16)
+#define __KVM_GUESTDBG_USE_HW_BP	(1 << 17)
+
 
 struct kvm_guest_debug {
 	__u32 control;
@@ -760,6 +771,8 @@ struct kvm_ppc_smmu_info {
 #define KVM_CAP_PPC_ENABLE_HCALL 104
 #define KVM_CAP_CHECK_EXTENSION_VM 105
 #define KVM_CAP_S390_USER_SIGP 106
+#define KVM_CAP_GUEST_DEBUG_HW_BPS 107
+#define KVM_CAP_GUEST_DEBUG_HW_WPS 108
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.3.4
