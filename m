From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:20:06 +0900
Subject: [PATCH 04/06] ARM: shmobile: sh73a0 SMP with SCU boot fn and args
In-Reply-To: <20130610091925.18944.68117.sendpatchset@w520>
References: <20130610091925.18944.68117.sendpatchset@w520>
Message-ID: <20130610092006.18944.71343.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Let sh73a0 make use of shmobile_boot_fn and shmobile_boot_arg
together with shmobile_boot_scu and the SCU base address.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-sh73a0.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-sh73a0.c
+++ work/arch/arm/mach-shmobile/smp-sh73a0.c	2013-06-05 14:59:24.000000000 +0900
@@ -64,9 +64,11 @@ static void __init sh73a0_smp_prepare_cp
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
