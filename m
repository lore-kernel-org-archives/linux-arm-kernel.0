From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Thu, 12 Jun 2014 09:30:00 -0700
Subject: [PATCH v4 01/14] ARM: KVM: switch hypervisor into BE mode in case of
 BE host
In-Reply-To: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1402590613-3341-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch hypervisor to run in BE mode if image is compiled
with CONFIG_CPU_BIG_ENDIAN.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/init.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 1b9844d..74f0718 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -22,6 +22,7 @@
 #include <asm/kvm_asm.h>
 #include <asm/kvm_arm.h>
 #include <asm/kvm_mmu.h>
+#include <asm/assembler.h>
 
 /********************************************************************
  * Hypervisor initialization
@@ -70,6 +71,8 @@ __do_hyp_init:
 	cmp	r0, #0			@ We have a SP?
 	bne	phase2			@ Yes, second stage init
 
+ARM_BE8(setend	be) @ Switch to Big Endian mode if needed
+
 	@ Set the HTTBR to point to the hypervisor PGD pointer passed
 	mcrr	p15, 4, r2, r3, c2
 
-- 
1.8.1.4
