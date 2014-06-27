From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 27 Jun 2014 15:22:45 +0200
Subject: [PATCH 04/16] ARM: mvebu: Use the common function for Armada 375 SMP
 workaround
In-Reply-To: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
References: <1403875377-940-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1403875377-940-5-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use the common function mvebu_boot_addr_wa() introduced in the
previous commit instead of the dedicated version for Armada 375.

In bonus we don't use anymore an harcoded value to access the register
storing the boot address.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/headsmp-a9.S | 11 -----------
 arch/arm/mach-mvebu/platsmp-a9.c | 27 +++------------------------
 2 files changed, 3 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-mvebu/headsmp-a9.S b/arch/arm/mach-mvebu/headsmp-a9.S
index 5925366bc03c..e48c8c495975 100644
--- a/arch/arm/mach-mvebu/headsmp-a9.S
+++ b/arch/arm/mach-mvebu/headsmp-a9.S
@@ -16,17 +16,6 @@
 #include <linux/init.h>
 
 	__CPUINIT
-#define CPU_RESUME_ADDR_REG 0xf10182d4
-
-.global armada_375_smp_cpu1_enable_code_start
-.global armada_375_smp_cpu1_enable_code_end
-
-armada_375_smp_cpu1_enable_code_start:
-	ldr     r0, [pc, #4]
-	ldr     r1, [r0]
-	mov     pc, r1
-	.word   CPU_RESUME_ADDR_REG
-armada_375_smp_cpu1_enable_code_end:
 
 ENTRY(mvebu_cortex_a9_secondary_startup)
 	bl      v7_invalidate_l1
diff --git a/arch/arm/mach-mvebu/platsmp-a9.c b/arch/arm/mach-mvebu/platsmp-a9.c
index 96c2c59e34b6..5805c97502e3 100644
--- a/arch/arm/mach-mvebu/platsmp-a9.c
+++ b/arch/arm/mach-mvebu/platsmp-a9.c
@@ -23,29 +23,7 @@
 #include "mvebu-soc-id.h"
 #include "pmsu.h"
 
-#define CRYPT0_ENG_ID   41
-#define CRYPT0_ENG_ATTR 0x1
-#define SRAM_PHYS_BASE  0xFFFF0000
-
-#define BOOTROM_BASE    0xFFF00000
-#define BOOTROM_SIZE    0x100000
-
-extern unsigned char armada_375_smp_cpu1_enable_code_end;
-extern unsigned char armada_375_smp_cpu1_enable_code_start;
-
-void armada_375_smp_cpu1_enable_wa(void)
-{
-	void __iomem *sram_virt_base;
-
-	mvebu_mbus_del_window(BOOTROM_BASE, BOOTROM_SIZE);
-	mvebu_mbus_add_window_by_id(CRYPT0_ENG_ID, CRYPT0_ENG_ATTR,
-				SRAM_PHYS_BASE, SZ_64K);
-	sram_virt_base = ioremap(SRAM_PHYS_BASE, SZ_64K);
-
-	memcpy(sram_virt_base, &armada_375_smp_cpu1_enable_code_start,
-	       &armada_375_smp_cpu1_enable_code_end
-	       - &armada_375_smp_cpu1_enable_code_start);
-}
+#define ARMADA_375_CRYPT0_ENG_ID   41
 
 extern void mvebu_cortex_a9_secondary_startup(void);
 
@@ -69,7 +47,8 @@ static int __cpuinit mvebu_cortex_a9_boot_secondary(unsigned int cpu,
 
 		if (mvebu_get_soc_id(&dev, &rev) == 0 &&
 		    rev == ARMADA_375_Z1_REV)
-			armada_375_smp_cpu1_enable_wa();
+				mvebu_boot_addr_wa(ARMADA_375_CRYPT0_ENG_ID,
+					mvebu_system_controller_get_phys_addr());
 
 		mvebu_system_controller_set_cpu_boot_addr(mvebu_cortex_a9_secondary_startup);
 	}
-- 
1.8.1.2
