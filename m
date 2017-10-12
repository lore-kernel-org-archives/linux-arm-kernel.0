From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 12 Oct 2017 12:41:37 +0200
Subject: [PATCH 33/37] KVM: arm/arm64: Move arm64-only vgic-v2-sr.c file to
 arm64
In-Reply-To: <20171012104141.26902-1-christoffer.dall@linaro.org>
References: <20171012104141.26902-1-christoffer.dall@linaro.org>
Message-ID: <20171012104141.26902-34-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vgic-v2-sr.c file now only contains the logic to replay unaligned
accesses to the virtual CPU interface on 16K and 64K page systems, which
is only relevant on 64-bit platforms.  Therefore move this file to the
arm64 KVM tree, remove the compile directive from the 32-bit side
makefile, and remove the ifdef in the C file.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/hyp/Makefile                         | 1 -
 arch/arm64/kvm/hyp/Makefile                       | 2 +-
 {virt/kvm/arm => arch/arm64/kvm}/hyp/vgic-v2-sr.c | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)
 rename {virt/kvm/arm => arch/arm64/kvm}/hyp/vgic-v2-sr.c (98%)

diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
index 8679405..4be5061 100644
--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -6,7 +6,6 @@ ccflags-y += -fno-stack-protector
 
 KVM=../../../../virt/kvm
 
-obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
 
diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index 14c4e3b..b746fa5 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -6,10 +6,10 @@ ccflags-y += -fno-stack-protector
 
 KVM=../../../../virt/kvm
 
-obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v3-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/timer-sr.o
 
+obj-$(CONFIG_KVM_ARM_HOST) += vgic-v2-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += sysreg-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += debug-sr.o
 obj-$(CONFIG_KVM_ARM_HOST) += entry.o
diff --git a/virt/kvm/arm/hyp/vgic-v2-sr.c b/arch/arm64/kvm/hyp/vgic-v2-sr.c
similarity index 98%
rename from virt/kvm/arm/hyp/vgic-v2-sr.c
rename to arch/arm64/kvm/hyp/vgic-v2-sr.c
index b433257..fcd7b4e 100644
--- a/virt/kvm/arm/hyp/vgic-v2-sr.c
+++ b/arch/arm64/kvm/hyp/vgic-v2-sr.c
@@ -22,7 +22,6 @@
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_hyp.h>
 
-#ifdef CONFIG_ARM64
 /*
  * __vgic_v2_perform_cpuif_access -- perform a GICV access on behalf of the
  *				     guest.
@@ -76,4 +75,3 @@ int __hyp_text __vgic_v2_perform_cpuif_access(struct kvm_vcpu *vcpu)
 
 	return 1;
 }
-#endif
-- 
2.9.0
