From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 23 Aug 2013 08:53:12 +0200
Subject: [PATCH 07/12] ARM: mvebu: Add a new set of registers for pmsu
In-Reply-To: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
References: <1377240797-4047-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <1377240797-4047-8-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Power Management Unit Service block also controls the Coherency
Fabric subsystem. This new set of registers is needed for the CPU idle
implementation for the Armada 370/XP, it allows to enter a deep CPU
idle state where the Coherency Fabric and the L2 cache are power down.

This patch also adds warnings if one of the base registers set can't
be ioremapped.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
 arch/arm/mach-mvebu/pmsu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 3cc4bef..1d147fe 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -25,6 +25,7 @@
 
 static void __iomem *pmsu_mp_base;
 static void __iomem *pmsu_reset_base;
+static void __iomem *pmsu_fabric_base;
 
 #define PMSU_BOOT_ADDR_REDIRECT_OFFSET(cpu)	((cpu * 0x100) + 0x24)
 #define PMSU_RESET_CTL_OFFSET(cpu)		(cpu * 0x8)
@@ -66,7 +67,11 @@ int __init armada_370_xp_pmsu_init(void)
 	if (np) {
 		pr_info("Initializing Power Management Service Unit\n");
 		pmsu_mp_base = of_iomap(np, 0);
+		WARN_ON(!pmsu_mp_base);
 		pmsu_reset_base = of_iomap(np, 1);
+		WARN_ON(!pmsu_reset_base);
+		pmsu_fabric_base = of_iomap(np, 2);
+		WARN_ON(!pmsu_fabric_base);
 	}
 
 	return 0;
-- 
1.8.1.2
