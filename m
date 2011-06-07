From: robherring2@gmail.com (Rob Herring)
Date: Tue,  7 Jun 2011 11:16:02 -0500
Subject: [PATCH] ARM: allow enabling SCU code on UP
Message-ID: <1307463362-18387-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

The scu_power_mode function can be used on UP builds as it drives signals
to an SOC power controller. So make it selectable for !SMP.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig          |    1 -
 arch/arm/kernel/smp_scu.c |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9adc278..8665a24 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1346,7 +1346,6 @@ config SMP_ON_UP
 
 config HAVE_ARM_SCU
 	bool
-	depends on SMP
 	help
 	  This option enables support for the ARM system coherency unit
 
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index a1e757c..79ed5e7 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -20,6 +20,7 @@
 #define SCU_INVALIDATE		0x0c
 #define SCU_FPGA_REVISION	0x10
 
+#ifdef CONFIG_SMP
 /*
  * Get the number of CPU cores from the SCU configuration
  */
@@ -50,6 +51,7 @@ void __init scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
+#endif
 
 /*
  * Set the executing CPUs power mode as defined.  This will be in
-- 
1.7.4.1
