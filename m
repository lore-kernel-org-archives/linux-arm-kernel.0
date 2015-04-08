From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 08 Apr 2015 10:45:09 +0100
Subject: [PATCH 1/6] ARM: keystone2: move platform notifier initialisation
 into platform init
In-Reply-To: <20150408094438.GM12732@n2100.arm.linux.org.uk>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
Message-ID: <E1YfmXl-0006Wf-HC@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We ideally want the init_meminfo function to do nothing but return the
delta to be applied to PHYS_OFFSET - it should do nothing else.  As we
can detect in platform init code whether we are running in the high
physical address space, move the platform notifier initialisation
entirely into the platform init code.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-keystone/keystone.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 06620875813a..3d58a8f4dc7e 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -27,7 +27,6 @@
 
 #include "keystone.h"
 
-static struct notifier_block platform_nb;
 static unsigned long keystone_dma_pfn_offset __read_mostly;
 
 static int keystone_platform_notifier(struct notifier_block *nb,
@@ -49,11 +48,18 @@ static int keystone_platform_notifier(struct notifier_block *nb,
 	return NOTIFY_OK;
 }
 
+static struct notifier_block platform_nb = {
+	.notifier_call = keystone_platform_notifier,
+};
+
 static void __init keystone_init(void)
 {
-	keystone_pm_runtime_init();
-	if (platform_nb.notifier_call)
+	if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START) {
+		keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
+						   KEYSTONE_LOW_PHYS_START);
 		bus_register_notifier(&platform_bus_type, &platform_nb);
+	}
+	keystone_pm_runtime_init();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -96,9 +102,6 @@ static void __init keystone_init_meminfo(void)
 
 	/* Populate the arch idmap hook */
 	arch_virt_to_idmap = keystone_virt_to_idmap;
-	platform_nb.notifier_call = keystone_platform_notifier;
-	keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
-						KEYSTONE_LOW_PHYS_START);
 
 	pr_info("Switching to high address space at 0x%llx\n", (u64)offset);
 }
-- 
1.8.3.1
