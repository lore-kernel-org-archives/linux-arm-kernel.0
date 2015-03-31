From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Tue, 31 Mar 2015 16:08:00 +0100
Subject: [PATCH v2 02/10] KVM: define common __KVM_GUESTDBG_USE_SW/HW_BP values
In-Reply-To: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
References: <1427814488-28467-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1427814488-28467-3-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently x86, powerpc and soon arm64 use the same two architecture
specific bits for guest debug support for software and hardware
breakpoints. This makes the shared values explicit while leaving the
gate open for another architecture to use some other value if they
really really want to.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index ab4d473..1731569 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
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
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index d7dcef5..1438202 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -250,8 +250,8 @@ struct kvm_debug_exit_arch {
 	__u64 dr7;
 };
 
-#define KVM_GUESTDBG_USE_SW_BP		0x00010000
-#define KVM_GUESTDBG_USE_HW_BP		0x00020000
+#define KVM_GUESTDBG_USE_SW_BP		__KVM_GUESTDBG_USE_SW_BP
+#define KVM_GUESTDBG_USE_HW_BP		__KVM_GUESTDBG_USE_HW_BP
 #define KVM_GUESTDBG_INJECT_DB		0x00040000
 #define KVM_GUESTDBG_INJECT_BP		0x00080000
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 5eedf84..ce2db14 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -525,8 +525,16 @@ struct kvm_s390_irq {
 
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
-- 
2.3.4
