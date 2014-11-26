From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 26 Nov 2014 17:55:32 +0000
Subject: [PATCH 2/2] ARM: tegra: irq: nuke leftovers from non-DT support
In-Reply-To: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
References: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <1417024532-5777-3-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GIC is now always initialized from DT on tegra, and there is
no point in keeping non-DT init code.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm/mach-tegra/irq.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-tegra/irq.c b/arch/arm/mach-tegra/irq.c
index ab95f53..7f87a50 100644
--- a/arch/arm/mach-tegra/irq.c
+++ b/arch/arm/mach-tegra/irq.c
@@ -283,13 +283,5 @@ void __init tegra_init_irq(void)
 	gic_arch_extn.irq_set_wake = tegra_set_wake;
 	gic_arch_extn.flags = IRQCHIP_MASK_ON_SUSPEND;
 
-	/*
-	 * Check if there is a devicetree present, since the GIC will be
-	 * initialized elsewhere under DT.
-	 */
-	if (!of_have_populated_dt())
-		gic_init(0, 29, distbase,
-			IO_ADDRESS(TEGRA_ARM_PERIF_BASE + 0x100));
-
 	tegra114_gic_cpu_pm_registration();
 }
-- 
2.1.3
