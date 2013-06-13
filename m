From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Jun 2013 15:59:46 +0900
Subject: [PATCH 08/15] ARM: shmobile: sh73a0 SMP with SCU boot fn and args
In-Reply-To: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
References: <1371106793-25071-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1371106793-25071-9-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Let sh73a0 make use of shmobile_boot_fn and shmobile_boot_arg
together with shmobile_boot_scu and the SCU base address.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/smp-sh73a0.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-sh73a0.c b/arch/arm/mach-shmobile/smp-sh73a0.c
index 496592b..d613113 100644
--- a/arch/arm/mach-shmobile/smp-sh73a0.c
+++ b/arch/arm/mach-shmobile/smp-sh73a0.c
@@ -64,9 +64,11 @@ static void __init sh73a0_smp_prepare_cpus(unsigned int max_cpus)
 {
 	scu_enable(shmobile_scu_base);
 
-	/* Map the reset vector (in headsmp-scu.S) */
+	/* Map the reset vector (in headsmp-scu.S, headsmp.S) */
 	__raw_writel(0, APARMBAREA);      /* 4k */
-	__raw_writel(__pa(shmobile_secondary_vector_scu), SBAR);
+	__raw_writel(__pa(shmobile_boot_vector), SBAR);
+	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
+	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
 	/* enable cache coherency on booting CPU */
 	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
-- 
1.8.2.1
