From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Mon,  4 Nov 2013 18:16:03 -0800
Subject: [PATCH 1/3] ARM: __fixup_smp read of SCU config should do byteswap in
 BE case
In-Reply-To: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
References: <1383617765-28052-1-git-send-email-victor.kamensky@linaro.org>
Message-ID: <1383617765-28052-2-git-send-email-victor.kamensky@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit "bc41b8724f24b9a27d1dcc6c974b8f686b38d554 ARM: 7846/1:
Update SMP_ON_UP code to detect A9MPCore with 1 CPU devices"
added read of SCU config register into __fixup_smp function.
Such read should be followed by byteswap, if kernel runs in
BE mode.

Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
---
 arch/arm/kernel/head.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 7801866..cd788d5 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -508,6 +508,7 @@ __fixup_smp:
 	teq	r0, #0x0		@ '0' on actual UP A9 hardware
 	beq	__fixup_smp_on_up	@ So its an A9 UP
 	ldr	r0, [r0, #4]		@ read SCU Config
+ARM_BE8(rev	r0, r0)			@ byteswap if big endian
 	and	r0, r0, #0x3		@ number of CPUs
 	teq	r0, #0x0		@ is 1?
 	movne	pc, lr
-- 
1.8.1.4
