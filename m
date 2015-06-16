From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 16 Jun 2015 14:12:59 +0200
Subject: [PATCH 3/9] ARM: mvebu: do not check machine in mvebu_pm_init()
In-Reply-To: <1434456785-23696-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1434456785-23696-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1434456785-23696-4-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mvebu_pm_init() initializes the support for suspend/resume, and
before doing that, it checks if we are on a board on which
suspend/resume is actually supported. However, this check is already
done by mvebu_armada_xp_gp_pm_init(), and there is no need to
duplicate the check: callers of mvebu_pm_init() should now what they
are doing.

This commit is done in preparation to the addition of suspend/resume
support on Armada 38x.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/pm.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/pm.c b/arch/arm/mach-mvebu/pm.c
index 6573a8f..eca650b 100644
--- a/arch/arm/mach-mvebu/pm.c
+++ b/arch/arm/mach-mvebu/pm.c
@@ -182,9 +182,6 @@ int mvebu_pm_init(void (*board_pm_enter)(void __iomem *sdram_reg, u32 srcmd))
 	struct device_node *np;
 	struct resource res;
 
-	if (!of_machine_is_compatible("marvell,armadaxp"))
-		return -ENODEV;
-
 	np = of_find_compatible_node(NULL, NULL,
 				     "marvell,armada-xp-sdram-controller");
 	if (!np)
-- 
2.1.0
