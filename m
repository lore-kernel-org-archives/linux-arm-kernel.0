From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 27 May 2015 11:25:12 +0300
Subject: [patch -next] ARM: BCM63xx: fix an error path in
 bcm63xx_pmb_power_on_cpu()
Message-ID: <20150527082512.GC19423@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need to unlock and unmap some resourses before returning.

Fixes: 3f2a43c98d72 ('ARM: BCM63xx: Add secondary CPU PMB initialization sequence')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/arm/mach-bcm/bcm63xx_pmb.c b/arch/arm/mach-bcm/bcm63xx_pmb.c
index c39752b..de061ec 100644
--- a/arch/arm/mach-bcm/bcm63xx_pmb.c
+++ b/arch/arm/mach-bcm/bcm63xx_pmb.c
@@ -150,7 +150,7 @@ int bcm63xx_pmb_power_on_cpu(struct device_node *dn)
 	 */
 	ret = bpcm_rd(base, addr, ARM_CONTROL, &ctrl);
 	if (ret)
-		return ret;
+		goto out;
 
 	if (ctrl & CPU_RESET_N(cpu)) {
 		pr_info("PMB: CPU%d is already powered on\n", cpu);
