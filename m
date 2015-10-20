From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 20 Oct 2015 18:19:04 +0200
Subject: [GIT PULL 3/6] KVM: arm: use GIC support unconditionally
In-Reply-To: <1445357947-6022-1-git-send-email-christoffer.dall@linaro.org>
References: <1445357947-6022-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1445357947-6022-4-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

The vgic code on ARM is built for all configurations that enable KVM,
but the parent_data field that it references is only present when
CONFIG_IRQ_DOMAIN_HIERARCHY is set:

virt/kvm/arm/vgic.c: In function 'kvm_vgic_map_phys_irq':
virt/kvm/arm/vgic.c:1781:13: error: 'struct irq_data' has no member named 'parent_data'

This flag is implied by the GIC driver, and indeed the VGIC code only
makes sense if a GIC is present. This changes the CONFIG_KVM symbol
to always select GIC, which avoids the issue.

Fixes: 662d9715840 ("arm/arm64: KVM: Kill CONFIG_KVM_ARM_{VGIC,TIMER}")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kvm/Kconfig b/arch/arm/kvm/Kconfig
index 210ecca..356970f 100644
--- a/arch/arm/kvm/Kconfig
+++ b/arch/arm/kvm/Kconfig
@@ -21,6 +21,7 @@ config KVM
 	depends on MMU && OF
 	select PREEMPT_NOTIFIERS
 	select ANON_INODES
+	select ARM_GIC
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select HAVE_KVM_ARCH_TLB_FLUSH_ALL
 	select KVM_MMIO
-- 
2.1.2.330.g565301e.dirty
