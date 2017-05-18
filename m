From: cdall@linaro.org (Christoffer Dall)
Date: Thu, 18 May 2017 11:47:12 +0200
Subject: [PULL 03/13] arm: KVM: Do not use stack-protector to compile HYP code
In-Reply-To: <20170518094722.9926-1-cdall@linaro.org>
References: <20170518094722.9926-1-cdall@linaro.org>
Message-ID: <20170518094722.9926-4-cdall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marc Zyngier <marc.zyngier@arm.com>

We like living dangerously. Nothing explicitely forbids stack-protector
to be used in the HYP code, while distributions routinely compile their
kernel with it. We're just lucky that no code actually triggers the
instrumentation.

Let's not try our luck for much longer, and disable stack-protector
for code living at HYP.

Cc: stable at vger.kernel.org
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Acked-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
---
 arch/arm/kvm/hyp/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kvm/hyp/Makefile b/arch/arm/kvm/hyp/Makefile
index 3023bb5..8679405 100644
--- a/arch/arm/kvm/hyp/Makefile
+++ b/arch/arm/kvm/hyp/Makefile
@@ -2,6 +2,8 @@
 # Makefile for Kernel-based Virtual Machine module, HYP part
 #
 
+ccflags-y += -fno-stack-protector
+
 KVM=../../../../virt/kvm
 
 obj-$(CONFIG_KVM_ARM_HOST) += $(KVM)/arm/hyp/vgic-v2-sr.o
-- 
2.9.0
