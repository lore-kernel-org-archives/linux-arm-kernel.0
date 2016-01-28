From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Thu, 28 Jan 2016 16:13:31 +0100
Subject: [PATCH 2/3] ARM: shmobile: r8a7779: Remove remainings of removed SCU
 boot setup code
In-Reply-To: <1453994012-12696-1-git-send-email-geert+renesas@glider.be>
References: <1453994012-12696-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1453994012-12696-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 0ca2894b5a900709 ("ARM: shmobile: Use shared SCU SMP boot code on
r8a7779") obsoleted the r8a7779-specific SCU boot code, but forgot to
remove the setup of shmobile_boot_fn and shmobile_boot_arg, which is
overwritten by shmobile_smp_scu_prepare_cpus().

Note that shmobile_scu_base wasn't initialized at that point yet anyway.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/smp-r8a7779.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/smp-r8a7779.c b/arch/arm/mach-shmobile/smp-r8a7779.c
index b854fe2095ad1461..0b024a9dbd4397e7 100644
--- a/arch/arm/mach-shmobile/smp-r8a7779.c
+++ b/arch/arm/mach-shmobile/smp-r8a7779.c
@@ -92,8 +92,6 @@ static void __init r8a7779_smp_prepare_cpus(unsigned int max_cpus)
 {
 	/* Map the reset vector (in headsmp-scu.S, headsmp.S) */
 	__raw_writel(__pa(shmobile_boot_vector), AVECR);
-	shmobile_boot_fn = virt_to_phys(shmobile_boot_scu);
-	shmobile_boot_arg = (unsigned long)shmobile_scu_base;
 
 	/* setup r8a7779 specific SCU bits */
 	shmobile_scu_base = IOMEM(R8A7779_SCU_BASE);
-- 
1.9.1
