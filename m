From: will.deacon@arm.com (Will Deacon)
Date: Tue, 26 Aug 2014 15:13:20 +0100
Subject: [PATCH 01/11] KVM: ARM/arm64: fix non-const declaration of function
 returning const
In-Reply-To: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
References: <1409062410-25891-1-git-send-email-will.deacon@arm.com>
Message-ID: <1409062410-25891-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sparse kicks up about a type mismatch for kvm_target_cpu:

arch/arm64/kvm/guest.c:271:25: error: symbol 'kvm_target_cpu' redeclared with different type (originally declared at ./arch/arm64/include/asm/kvm_host.h:45) - different modifiers

so fix this by adding the missing const attribute to the function
declaration.

Cc: Christoffer Dall <christoffer.dall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/kvm_host.h   | 2 +-
 arch/arm64/include/asm/kvm_host.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 6dfb404f6c46..fcb12a6f7db5 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -42,7 +42,7 @@
 
 struct kvm_vcpu;
 u32 *kvm_vcpu_reg(struct kvm_vcpu *vcpu, u8 reg_num, u32 mode);
-int kvm_target_cpu(void);
+int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
 void kvm_reset_coprocs(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e10c45a578e3..44094e559848 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -42,7 +42,7 @@
 #define KVM_VCPU_MAX_FEATURES 3
 
 struct kvm_vcpu;
-int kvm_target_cpu(void);
+int __attribute_const__ kvm_target_cpu(void);
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu);
 int kvm_arch_dev_ioctl_check_extension(long ext);
 
-- 
2.1.0.rc1
