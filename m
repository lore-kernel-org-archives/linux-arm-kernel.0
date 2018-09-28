From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 28 Sep 2018 14:39:18 +0100
Subject: [RFC PATCH v2 14/23] KVM: Allow 2048-bit register access via ioctl
 interface
In-Reply-To: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
References: <1538141967-15375-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1538141967-15375-15-git-send-email-Dave.Martin@arm.com>
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
index 251be35..7c3c5cc 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1110,6 +1110,7 @@ struct kvm_dirty_tlb {
 #define KVM_REG_SIZE_U256	0x0050000000000000ULL
 #define KVM_REG_SIZE_U512	0x0060000000000000ULL
 #define KVM_REG_SIZE_U1024	0x0070000000000000ULL
+#define KVM_REG_SIZE_U2048	0x0080000000000000ULL
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
-- 
2.1.4
