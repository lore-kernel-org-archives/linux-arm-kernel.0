From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:20:15 +0900
Subject: [PATCH 05/06] ARM: shmobile: EMEV2 SMP with SCU boot fn and args
In-Reply-To: <20130610091925.18944.68117.sendpatchset@w520>
References: <20130610091925.18944.68117.sendpatchset@w520>
Message-ID: <20130610092015.18944.61634.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Let EMEV2 make use of shmobile_boot_fn and shmobile_boot_arg
together with shmobile_boot_scu and the SCU base address.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-emev2.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-emev2.c
+++ work/arch/arm/mach-shmobile/smp-emev2.c	2013-06-05 15:00:28.000000000 +0900
@@ -40,8 +40,10 @@ static void __init emev2_smp_prepare_cpu
 {
 	scu_enable(shmobile_scu_base);
 
-	/* Tell ROM loader about our vector (in headsmp-scu.S) */
-	emev2_set_boot_vector(__pa(shmobile_secondary_vector_scu));
+	/* Tell ROM loader about our vector (in headsmp-scu.S, headsmp.S) */
+	emev2_set_boot_vector(__pa(shmobile_boot_vector));
+	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
+	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
 	/* enable cache coherency on booting CPU */
 	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
