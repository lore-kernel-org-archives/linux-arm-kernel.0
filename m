From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 23 Nov 2013 22:47:34 -0500
Subject: [PATCH 2/2] ARM: mm: Call setup_dma_zone() post early_paging_init()
In-Reply-To: <1385264854-30162-1-git-send-email-santosh.shilimkar@ti.com>
References: <1385264854-30162-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1385264854-30162-3-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To get updated __pv_phys_offset, setup_dma_zone() needs to be
called after early_paging_init().

Cc: Russell King <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/kernel/setup.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 6a1b8a8..987a7f5 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -873,8 +873,6 @@ void __init setup_arch(char **cmdline_p)
 	machine_desc = mdesc;
 	machine_name = mdesc->name;
 
-	setup_dma_zone(mdesc);
-
 	if (mdesc->reboot_mode != REBOOT_HARD)
 		reboot_mode = mdesc->reboot_mode;
 
@@ -892,6 +890,7 @@ void __init setup_arch(char **cmdline_p)
 	sort(&meminfo.bank, meminfo.nr_banks, sizeof(meminfo.bank[0]), meminfo_cmp, NULL);
 
 	early_paging_init(mdesc, lookup_processor_type(read_cpuid_id()));
+	setup_dma_zone(mdesc);
 	sanity_check_meminfo();
 	arm_memblock_init(&meminfo, mdesc);
 
-- 
1.7.9.5
