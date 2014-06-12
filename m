From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Thu, 12 Jun 2014 09:30:03 -0700
Subject: [PATCH v4 04/14] ARM: KVM: __kvm_vcpu_run function return result fix
 in BE case
In-Reply-To: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
References: <1402590613-3341-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1402590613-3341-5-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The __kvm_vcpu_run function returns a 64-bit result in two registers,
which has to be adjusted for BE case.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
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
1.8.1.4
