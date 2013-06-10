From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 10 Jun 2013 18:19:56 +0900
Subject: [PATCH 03/06] ARM: shmobile: r8a7779 SMP with SCU boot fn and args
In-Reply-To: <20130610091925.18944.68117.sendpatchset@w520>
References: <20130610091925.18944.68117.sendpatchset@w520>
Message-ID: <20130610091956.18944.57224.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Let r8a7779 make use of shmobile_boot_fn and shmobile_boot_arg
together with shmobile_boot_scu and the SCU base address.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/smp-r8a7779.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- 0001/arch/arm/mach-shmobile/smp-r8a7779.c
+++ work/arch/arm/mach-shmobile/smp-r8a7779.c	2013-06-05 14:58:21.000000000 +0900
@@ -101,8 +101,10 @@ static void __init r8a7779_smp_prepare_c
 {
 	scu_enable(shmobile_scu_base);
 
-	/* Map the reset vector (in headsmp-scu.S) */
-	__raw_writel(__pa(shmobile_secondary_vector_scu), AVECR);
+	/* Map the reset vector (in headsmp-scu.S, headsmp.S) */
+	__raw_writel(__pa(shmobile_boot_vector), AVECR);
+	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
+	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
 	/* enable cache coherency on booting CPU */
 	scu_power_mode(shmobile_scu_base, SCU_PM_NORMAL);
