From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 14 May 2014 17:50:38 +0200
Subject: [RFC PATCHv1 4/7] ARM: kernel: allow the SCU to be enabled even on
 !SMP
In-Reply-To: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400082641-23871-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400082641-23871-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Certain non-SMP platforms rely on the SCU being enabled to provide
hardware I/O coherency between DMA masters and the CPU. Therefore, the
scu_enable() hook should not be reduced to a no-op when CONFIG_SMP is
disabled.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/include/asm/smp_scu.h | 2 +-
 arch/arm/kernel/smp_scu.c      | 2 --
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/smp_scu.h b/arch/arm/include/asm/smp_scu.h
index 0393fba..e78f72d 100644
--- a/arch/arm/include/asm/smp_scu.h
+++ b/arch/arm/include/asm/smp_scu.h
@@ -37,7 +37,7 @@ static inline int scu_power_mode(void __iomem *scu_base, unsigned int mode)
 }
 #endif
 
-#if defined(CONFIG_SMP) && defined(CONFIG_HAVE_ARM_SCU)
+#if defined(CONFIG_HAVE_ARM_SCU)
 void scu_enable(void __iomem *scu_base);
 #else
 static inline void scu_enable(void __iomem *scu_base) {}
diff --git a/arch/arm/kernel/smp_scu.c b/arch/arm/kernel/smp_scu.c
index 1aafa0d..09d21b0 100644
--- a/arch/arm/kernel/smp_scu.c
+++ b/arch/arm/kernel/smp_scu.c
@@ -22,7 +22,6 @@
 #define SCU_INVALIDATE		0x0c
 #define SCU_FPGA_REVISION	0x10
 
-#ifdef CONFIG_SMP
 /*
  * Get the number of CPU cores from the SCU configuration
  */
@@ -62,7 +61,6 @@ void scu_enable(void __iomem *scu_base)
 	 */
 	flush_cache_all();
 }
-#endif
 
 /*
  * Set the executing CPUs power mode as defined.  This will be in
-- 
1.9.3
