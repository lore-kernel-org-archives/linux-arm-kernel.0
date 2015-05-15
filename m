From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Fri, 15 May 2015 15:27:05 +0100
Subject: [PATCH v4 02/12] KVM: define common KVM_GUESTDBG_USE_SW/HW_BP bits
In-Reply-To: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
References: <1431700035-23479-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1431700035-23479-3-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently x86, powerpc and soon arm64 use the same two architecture
specific bits for guest debug support for software and hardware
breakpoints. This makes the shared values explicit.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: Andrew Jones <drjones@redhat.com>

-
v4
  - claim more bits for the common functionality
v5
  - don't use __ mechanism to move values common

diff --git a/arch/powerpc/include/uapi/asm/kvm.h b/arch/powerpc/include/uapi/asm/kvm.h
index ab4d473..6ea24a5 100644
--- a/arch/powerpc/include/uapi/asm/kvm.h
+++ b/arch/powerpc/include/uapi/asm/kvm.h
@@ -307,11 +307,9 @@ struct kvm_guest_debug_arch {
 /* Debug related defines */
 /*
  * kvm_guest_debug->control is a 32 bit field. The lower 16 bits are generic
- * and upper 16 bits are architecture specific. Architecture specific defines
+ * and upper 14 bits are architecture specific. Architecture specific defines
  * that ioctl is for setting hardware breakpoint or software breakpoint.
  */
-#define KVM_GUESTDBG_USE_SW_BP		0x00010000
-#define KVM_GUESTDBG_USE_HW_BP		0x00020000
 
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index ef1a5fc..aca4f86 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -114,8 +114,6 @@ struct kvm_fpu {
 	__u64 fprs[16];
 };
 
-#define KVM_GUESTDBG_USE_HW_BP		0x00010000
-
 #define KVM_HW_BP			1
 #define KVM_HW_WP_WRITE			2
 #define KVM_SINGLESTEP			4
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index d7dcef5..ca51d4c 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -250,8 +250,6 @@ struct kvm_debug_exit_arch {
 	__u64 dr7;
 };
 
-#define KVM_GUESTDBG_USE_SW_BP		0x00010000
-#define KVM_GUESTDBG_USE_HW_BP		0x00020000
 #define KVM_GUESTDBG_INJECT_DB		0x00040000
 #define KVM_GUESTDBG_INJECT_BP		0x00080000
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 70ac641..7c5dd11 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -570,8 +570,10 @@ struct kvm_s390_irq_state {
 
 /* for KVM_SET_GUEST_DEBUG */
 
-#define KVM_GUESTDBG_ENABLE		0x00000001
-#define KVM_GUESTDBG_SINGLESTEP		0x00000002
+#define KVM_GUESTDBG_ENABLE		(1 << 0)
+#define KVM_GUESTDBG_SINGLESTEP	(1 << 1)
+#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
+#define KVM_GUESTDBG_USE_HW_BP		(1 << 17)
 
 struct kvm_guest_debug {
 	__u32 control;
-- 
2.3.5
