From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  5 Sep 2017 23:19:59 +0200
Subject: [PATCH v2 1/2] ARM: owl: smp: Use __pa_symbol()
In-Reply-To: <20170905212000.7009-1-afaerber@suse.de>
References: <20170905212000.7009-1-afaerber@suse.de>
Message-ID: <20170905212000.7009-2-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace an occurrence of virt_to_phys() with __pa_symbol() macro.

See 64fc2a947a9873700929ec0ef02b4654a04e0476 ("ARM: 8641/1: treewide:
Replace uses of virt_to_phys with __pa_symbol").

Fixes: 172067e0bc87 ("ARM: owl: Implement CPU enable-method for S500")
Reported-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v1 -> v2: New
 
 arch/arm/mach-actions/platsmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index 12a9e331b432..7238926ab015 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -71,7 +71,7 @@ static int s500_wakeup_secondary(unsigned int cpu)
 	/* wait for CPUx to run to WFE instruction */
 	udelay(200);
 
-	writel(virt_to_phys(owl_secondary_startup),
+	writel(__pa_symbol(owl_secondary_startup),
 	       timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
 	writel(OWL_CPUx_FLAG_BOOT,
 	       timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
-- 
2.13.5
