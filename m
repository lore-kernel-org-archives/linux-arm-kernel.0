From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 29 Aug 2014 11:59:15 +0200
Subject: [GIT PULL 1/2] ARM/ARM64: KVM: Nuke Hyp-mode tlbs before enabling MMU
In-Reply-To: <1409306356-11170-1-git-send-email-christoffer.dall@linaro.org>
References: <1409306356-11170-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <1409306356-11170-2-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>

X-Gene u-boot runs in EL2 mode with MMU enabled hence we might
have stale EL2 tlb enteris when we enable EL2 MMU on each host CPU.

This can happen on any ARM/ARM64 board running bootloader in
Hyp-mode (or EL2-mode) with MMU enabled.

This patch ensures that we flush all Hyp-mode (or EL2-mode) TLBs
on each host CPU before enabling Hyp-mode (or EL2-mode) MMU.

Cc: <stable@vger.kernel.org>
Tested-by: Mark Rutland <mark.rutland@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
Signed-off-by: Anup Patel <anup.patel@linaro.org>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm/kvm/init.S       | 4 ++++
 arch/arm64/kvm/hyp-init.S | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/kvm/init.S b/arch/arm/kvm/init.S
index 991415d..3988e72 100644
--- a/arch/arm/kvm/init.S
+++ b/arch/arm/kvm/init.S
@@ -99,6 +99,10 @@ __do_hyp_init:
 	mrc	p15, 0, r0, c10, c2, 1
 	mcr	p15, 4, r0, c10, c2, 1
 
+	@ Invalidate the stale TLBs from Bootloader
+	mcr	p15, 4, r0, c8, c7, 0	@ TLBIALLH
+	dsb	ish
+
 	@ Set the HSCTLR to:
 	@  - ARM/THUMB exceptions: Kernel config (Thumb-2 kernel)
 	@  - Endianness: Kernel config
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
2.0.0
