From: vladimir.murzin@arm.com (Vladimir Murzin)
Date: Fri,  2 Dec 2016 15:05:27 +0000
Subject: [RFC v3 PATCH 09/25] ARM: NOMMU: fix load of CONFIG_VECTORS_BASE
In-Reply-To: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
References: <1480691143-19845-1-git-send-email-vladimir.murzin@arm.com>
Message-ID: <1480691143-19845-10-git-send-email-vladimir.murzin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While running randconfig with NOMMU enabled following error shows up:

arch/arm/kernel/head-nommu.S: Assembler messages:
arch/arm/kernel/head-nommu.S:265: Error: invalid constant (ffffffffffff0000) after fixup
make[1]: *** [arch/arm/kernel/head-nommu.o] Error 1

That happens because CONFIG_VECTORS_BASE it is out of range of the mov
instruction. So use ldr pseudo instruction instead and let assembler
to figure out how to deal with that.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/arm/kernel/head-nommu.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/head-nommu.S b/arch/arm/kernel/head-nommu.S
index 7317554..ae80c71 100644
--- a/arch/arm/kernel/head-nommu.S
+++ b/arch/arm/kernel/head-nommu.S
@@ -251,7 +251,7 @@ ENTRY(__setup_mpu)
 	set_region_nr r0, #MPU_VECTORS_REGION
 	isb
 	/* Shared, inaccessible to PL0, rw PL1 */
-	mov	r0, #CONFIG_VECTORS_BASE	@ Cover from VECTORS_BASE
+	ldr	r0, =CONFIG_VECTORS_BASE	@ Cover from VECTORS_BASE
 	ldr	r5,=(MPU_AP_PL1RW_PL0NA | MPU_RGN_NORMAL)
 	/* Writing N to bits 5:1 (RSR_SZ) --> region size 2^N+1 */
 	mov	r6, #(((2 * PAGE_SHIFT - 1) << MPU_RSR_SZ) | 1 << MPU_RSR_EN)
-- 
1.7.9.5
