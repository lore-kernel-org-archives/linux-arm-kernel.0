From: hoeun.ryu@gmail.com (Hoeun Ryu)
Date: Mon,  5 Jun 2017 18:22:20 +0900
Subject: [PATCH] arm: LPAE: kexec: clear TTBCR.T1SZ explicitly when
 PHYS_OFFSET > PAGE_OFFSET
Message-ID: <1496654569-4749-1-git-send-email-hoeun.ryu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Clearing TTBCR.T1SZ explicitly when kernel runs on a configuration of
PHYS_OFFSET > PAGE_OFFSET.
 Reading TTBCR in early boot stage might returns the value of the
previous kernel's configuration, especially in case of kexec. For
example, if normal kernel (first kernel) had run on a configuration
of PHYS_OFFSET <= PAGE_OFFSET and crash kernel (second kernel) is
running on a configuration PHYS_OFFSET > PAGE_OFFSET, which can happen
because it depends on the reserved area for crash kernel, reading
TTBCR and using the value without clearing TTBCR.T1SZ might risky
because the value doesn't have a reset value for TTBCR.T1SZ.

Signed-off-by: Hoeun Ryu <hoeun.ryu@gmail.com>
---
 arch/arm/mm/proc-v7-3level.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mm/proc-v7-3level.S b/arch/arm/mm/proc-v7-3level.S
index 5e5720e..9ac2bec 100644
--- a/arch/arm/mm/proc-v7-3level.S
+++ b/arch/arm/mm/proc-v7-3level.S
@@ -140,6 +140,7 @@ ENDPROC(cpu_v7_set_pte_ext)
 	 * otherwise booting secondary CPUs would end up using TTBR1 for the
 	 * identity mapping set up in TTBR0.
 	 */
+	bichi	\tmp, \tmp, #(1 << 16)				@ clear TTBCR.T1SZ
 	orrls	\tmp, \tmp, #TTBR1_SIZE				@ TTBCR.T1SZ
 	mcr	p15, 0, \tmp, c2, c0, 2				@ TTBCR
 	mov	\tmp, \ttbr1, lsr #20
-- 
2.7.4
