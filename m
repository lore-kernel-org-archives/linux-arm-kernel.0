From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon,  4 Aug 2014 10:46:47 +0200
Subject: [GIT PULL 30/51] ARM: KVM: __kvm_vcpu_run function return result fix
 in BE case
In-Reply-To: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
References: <1407142028-31105-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1407142028-31105-31-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Victor Kamensky <victor.kamensky@linaro.org>

The __kvm_vcpu_run function returns a 64-bit result in two registers,
which has to be adjusted for BE case.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/kvm/interrupts.S | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/kvm/interrupts.S b/arch/arm/kvm/interrupts.S
index 24d4e65..01dcb0e 100644
--- a/arch/arm/kvm/interrupts.S
+++ b/arch/arm/kvm/interrupts.S
@@ -199,8 +199,13 @@ after_vfp_restore:
 
 	restore_host_regs
 	clrex				@ Clear exclusive monitor
+#ifndef CONFIG_CPU_ENDIAN_BE8
 	mov	r0, r1			@ Return the return code
 	mov	r1, #0			@ Clear upper bits in return value
+#else
+	@ r1 already has return code
+	mov	r0, #0			@ Clear upper bits in return value
+#endif /* CONFIG_CPU_ENDIAN_BE8 */
 	bx	lr			@ return to IOCTL
 
 /********************************************************************
-- 
2.0.0
