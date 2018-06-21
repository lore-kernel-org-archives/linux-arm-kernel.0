From: Dave.Martin@arm.com (Dave Martin)
Date: Thu, 21 Jun 2018 15:57:37 +0100
Subject: [RFC PATCH 13/16] KVM: Allow 2048-bit register access via KVM_{GET,
 SET}_ONE_REG
In-Reply-To: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
References: <1529593060-542-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1529593060-542-14-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Arm SVE architecture defines registers that are up to 2048 bits
in size (with some possibility of further future expansion).

In order to avoid the need for an excessively large number of
ioctls when saving and restoring a vcpu's registers, this patch
adds a #define to make support for individual 2048-bit registers
through the KVM_{GET,SET}_ONE_REG ioctl interface official.  This
will allow each SVE register to be accessed in a single call.

There are sufficient spare bits in the register id size field for
this change, so there is no ABI impact providing that
KVM_GET_REG_LIST does not enumerate any 2048-bit register unless
userspace explicitly opts in to the relevant architecture-specific
features.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 include/uapi/linux/kvm.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b6270a3..345be88 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1106,6 +1106,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_SIZE_U256	0x0050000000000000ULL
 #define KVM_REG_SIZE_U512	0x0060000000000000ULL
 #define KVM_REG_SIZE_U1024	0x0070000000000000ULL
+#define KVM_REG_SIZE_U2048	0x0080000000000000ULL
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
-- 
2.1.4
