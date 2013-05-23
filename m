From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 15:30:52 +0200
Subject: [PATCH v2 4/6] arm: mvebu: remove hardcoded static I/O mapping
In-Reply-To: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1369315854-32724-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1369315854-32724-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have removed the need of the static I/O mapping for early
initialization reasons, and fixed the registers area length that were
broken, we can get rid of the static I/O mapping. Only the earlyprintk
mapping needs to be set up, using the debug_ll_io_init() helper
function.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/armada-370-xp.c |   11 +----------
 arch/arm/mach-mvebu/armada-370-xp.h |    2 --
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/arm/mach-mvebu/armada-370-xp.c b/arch/arm/mach-mvebu/armada-370-xp.c
index 75ebf56..c1c0556 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.c
+++ b/arch/arm/mach-mvebu/armada-370-xp.c
@@ -28,18 +28,9 @@
 #include "common.h"
 #include "coherency.h"
 
-static struct map_desc armada_370_xp_io_desc[] __initdata = {
-	{
-		.virtual	= (unsigned long) ARMADA_370_XP_REGS_VIRT_BASE,
-		.pfn		= __phys_to_pfn(ARMADA_370_XP_REGS_PHYS_BASE),
-		.length		= ARMADA_370_XP_REGS_SIZE,
-		.type		= MT_DEVICE,
-	},
-};
-
 static void __init armada_370_xp_map_io(void)
 {
-	iotable_init(armada_370_xp_io_desc, ARRAY_SIZE(armada_370_xp_io_desc));
+	debug_ll_io_init();
 }
 
 static void __init armada_370_xp_timer_and_clk_init(void)
diff --git a/arch/arm/mach-mvebu/armada-370-xp.h b/arch/arm/mach-mvebu/armada-370-xp.h
index 2070e1b..585e147 100644
--- a/arch/arm/mach-mvebu/armada-370-xp.h
+++ b/arch/arm/mach-mvebu/armada-370-xp.h
@@ -16,8 +16,6 @@
 #define __MACH_ARMADA_370_XP_H
 
 #define ARMADA_370_XP_REGS_PHYS_BASE	0xd0000000
-#define ARMADA_370_XP_REGS_VIRT_BASE	IOMEM(0xfec00000)
-#define ARMADA_370_XP_REGS_SIZE		SZ_1M
 
 /* These defines can go away once mvebu-mbus has a DT binding */
 #define ARMADA_370_XP_MBUS_WINS_BASE    (ARMADA_370_XP_REGS_PHYS_BASE + 0x20000)
-- 
1.7.9.5
