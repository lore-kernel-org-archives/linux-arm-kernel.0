From: pranavkumar@linaro.org (Pranavkumar Sawargaonkar)
Date: Wed, 30 Jul 2014 15:16:47 +0530
Subject: [PATCH] ARM64: KVM: Nuke EL2 mode tlbs before enabling MMU for EL2
Message-ID: <1406713607-27150-1-git-send-email-pranavkumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Gene u-boot runs in EL2 mode with MMU enabled hence we might
have stale EL2 tlb enteris when we enable EL2 MMU on each host CPU.

This can happen on any ARM64 board running bootloader in EL2
with MMU enabled.

This patch ensures that we flush all EL2 TLBs on each host CPU
before enabling EL2 MMU. This is very similar to what we do
for EL1 TLBs before enabling EL1 MMU.
(Refer __cpu_setup() of arch/arm64/mm/proc.S)

Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
---
 arch/arm64/kvm/hyp-init.S |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kvm/hyp-init.S b/arch/arm64/kvm/hyp-init.S
index d968796..c319116 100644
--- a/arch/arm64/kvm/hyp-init.S
+++ b/arch/arm64/kvm/hyp-init.S
@@ -80,6 +80,10 @@ __do_hyp_init:
 	msr	mair_el2, x4
 	isb
 
+	/* Invalidate the stale TLBs from Bootloader */
+	tlbi	alle2
+	dsb	sy
+
 	mrs	x4, sctlr_el2
 	and	x4, x4, #SCTLR_EL2_EE	// preserve endianness of EL2
 	ldr	x5, =SCTLR_EL2_FLAGS
-- 
1.7.9.5
