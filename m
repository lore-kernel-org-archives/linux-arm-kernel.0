From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  3 May 2017 11:45:37 +0100
Subject: [PATCH 02/31] arm64: KVM: Do not use stack-protector to compile EL2
 code
In-Reply-To: <20170503104606.19342-1-marc.zyngier@arm.com>
References: <20170503104606.19342-1-marc.zyngier@arm.com>
Message-ID: <20170503104606.19342-3-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We like living dangerously. Nothing explicitely forbids stack-protector
to be used in the EL2 code, while distributions routinely compile their
kernel with it. We're just lucky that no code actually triggers the
instrumentation.

Let's not try our luck for much longer, and disable stack-protector
for code living at EL2.

Cc: stable at vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/kvm/hyp/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/hyp/Makefile b/arch/arm64/kvm/hyp/Makefile
index aaf42ae8d8c3..14c4e3b14bcb 100644
--- a/arch/arm64/kvm/hyp/Makefile
+++ b/arch/arm64/kvm/hyp/Makefile
@@ -2,6 +2,8 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #
 
+ccflags-y += -fno-stack-protector
+
 KVM=../../../../virt/kvm
 
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
-- 
2.11.0
