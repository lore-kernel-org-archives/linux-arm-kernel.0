From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 22 Jul 2015 12:21:04 +0100
Subject: [PATCH v3 4/5] arm64: kvm: Adopt new alternative assembler macros
In-Reply-To: <1437564065-4356-1-git-send-email-daniel.thompson@linaro.org>
References: <1436536130-31438-1-git-send-email-daniel.thompson@linaro.org>
 <1437564065-4356-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1437564065-4356-5-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Convert the dynamic patching for ARM64_HAS_SYSREG_GIC_CPUIF over to
the newly added alternative assembler macros.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm64/kvm/hyp.S | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/hyp.S b/arch/arm64/kvm/hyp.S
index 17a8fb14f428..10915aaf0b01 100644
--- a/arch/arm64/kvm/hyp.S
+++ b/arch/arm64/kvm/hyp.S
@@ -810,7 +810,11 @@
  * Call into the vgic backend for state saving
  */
 .macro save_vgic_state
-	alternative_insn "bl __save_vgic_v2_state", "bl __save_vgic_v3_state", ARM64_HAS_SYSREG_GIC_CPUIF
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	bl	__save_vgic_v2_state
+alternative_else
+	bl	__save_vgic_v3_state
+alternative_endif
 	mrs	x24, hcr_el2
 	mov	x25, #HCR_INT_OVERRIDE
 	neg	x25, x25
@@ -827,7 +831,11 @@
 	orr	x24, x24, #HCR_INT_OVERRIDE
 	orr	x24, x24, x25
 	msr	hcr_el2, x24
-	alternative_insn "bl __restore_vgic_v2_state", "bl __restore_vgic_v3_state", ARM64_HAS_SYSREG_GIC_CPUIF
+alternative_if_not ARM64_HAS_SYSREG_GIC_CPUIF
+	bl	__restore_vgic_v2_state
+alternative_else
+	bl	__restore_vgic_v3_state
+alternative_endif
 .endm
 
 .macro save_timer_state
-- 
2.4.3
