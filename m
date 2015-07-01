From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Wed,  1 Jul 2015 19:28:54 +0100
Subject: [PATCH v7 02/11] KVM: arm64: guest debug, define API headers
In-Reply-To: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
References: <1435775343-20034-1-git-send-email-alex.bennee@linaro.org>
Message-ID: <1435775343-20034-3-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit defines the API headers for guest debugging. There are two
architecture specific debug structures:

  - kvm_guest_debug_arch, allows us to pass in HW debug registers
  - kvm_debug_exit_arch, signals exception and possible faulting address

The type of debugging being used is controlled by the architecture
specific control bits of the kvm_guest_debug->control flags in the ioctl
structure.

Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>

---
v2
   - expose hsr and pc directly to user-space
v3
   - s/control/controlled/ in commit message
   - add v8 to ARM ARM comment (ARM Architecture Reference Manual)
   - add rb tag
   - rm pc, add far
   - re-word comments on alignment
   - rename KVM_ARM_NDBG_REGS -> KVM_ARM_MAX_DBG_REGS
v4
   - now uses common HW/SW BP define
   - add a-b-tag
   - use u32 for control regs
v5
   - revert to have arch specific KVM_GUESTDBG_USE_SW/HW_BP
   - rm stale comments dbgctrl was stored as u64
v6
   - mv far comment from later patch
   - KVM_GUESTDBG_USE_HW_BP -> KVM_GUESTDBG_USE_HW
   - revert control regs to u64 (parity with GET/SET_ONE_REG)
---
 arch/arm64/include/uapi/asm/kvm.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index d268320..d82f3f3 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -100,12 +100,39 @@ struct kvm_sregs {
 struct kvm_fpu {
 };
 
+/*
+ * See v8 ARM ARM D7.3: Debug Registers
+ *
+ * The architectural limit is 16 debug registers of each type although
+ * in practice there are usually less (see ID_AA64DFR0_EL1).
+ *
+ * Although the control registers are architecturally defined as 32
+ * bits wide we use a 64 bit structure here to keep parity with
+ * KVM_GET/SET_ONE_REG behaviour which treats all system registers as
+ * 64 bit values. It also allows for the possibility of the
+ * architecture expanding the control registers without having to
+ * change the userspace ABI.
+ */
+#define KVM_ARM_MAX_DBG_REGS 16
 struct kvm_guest_debug_arch {
+	__u64 dbg_bcr[KVM_ARM_MAX_DBG_REGS];
+	__u64 dbg_bvr[KVM_ARM_MAX_DBG_REGS];
+	__u64 dbg_wcr[KVM_ARM_MAX_DBG_REGS];
+	__u64 dbg_wvr[KVM_ARM_MAX_DBG_REGS];
 };
 
 struct kvm_debug_exit_arch {
+	__u32 hsr;
+	__u64 far;	/* used for watchpoints */
 };
 
+/*
+ * Architecture specific defines for kvm_guest_debug->control
+ */
+
+#define KVM_GUESTDBG_USE_SW_BP		(1 << 16)
+#define KVM_GUESTDBG_USE_HW		(1 << 17)
+
 struct kvm_sync_regs {
 };
 
-- 
2.4.5
