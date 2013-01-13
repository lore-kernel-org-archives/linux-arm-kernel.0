From: grinberg@compulab.co.il (Igor Grinberg)
Date: Sun, 13 Jan 2013 13:49:47 +0200
Subject: [PATCH] ARM: PXA3xx: program the CSMSADRCFG register
Message-ID: <1358077787-31518-1-git-send-email-grinberg@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Chip Select Configuration Register must be programmed to 0x2 in
order to achieve the correct behavior of the Static Memory Controller.

Without this patch devices wired to DFI and accessed through SMC cannot
be accessed after resume from S2.

Do not rely on the boot loader to program the CSMSADRCFG register by
programming it in the kernel smemc module.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-pxa/include/mach/smemc.h |    1 +
 arch/arm/mach-pxa/smemc.c              |   15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/smemc.h b/arch/arm/mach-pxa/include/mach/smemc.h
index b7de471..b802f28 100644
--- a/arch/arm/mach-pxa/include/mach/smemc.h
+++ b/arch/arm/mach-pxa/include/mach/smemc.h
@@ -37,6 +37,7 @@
 #define CSADRCFG1	(SMEMC_VIRT + 0x84)  /* Address Configuration Register for CS1 */
 #define CSADRCFG2	(SMEMC_VIRT + 0x88)  /* Address Configuration Register for CS2 */
 #define CSADRCFG3	(SMEMC_VIRT + 0x8C)  /* Address Configuration Register for CS3 */
+#define CSMSADRCFG	(SMEMC_VIRT + 0xA0)  /* Chip Select Configuration Register */
 
 /*
  * More handy macros for PCMCIA
diff --git a/arch/arm/mach-pxa/smemc.c b/arch/arm/mach-pxa/smemc.c
index 7992305..f38aa89 100644
--- a/arch/arm/mach-pxa/smemc.c
+++ b/arch/arm/mach-pxa/smemc.c
@@ -40,6 +40,8 @@ static void pxa3xx_smemc_resume(void)
 	__raw_writel(csadrcfg[1], CSADRCFG1);
 	__raw_writel(csadrcfg[2], CSADRCFG2);
 	__raw_writel(csadrcfg[3], CSADRCFG3);
+	/* CSMSADRCFG wakes up in its default state (0), so we need to set it */
+	__raw_writel(0x2, CSMSADRCFG);
 }
 
 static struct syscore_ops smemc_syscore_ops = {
@@ -49,8 +51,19 @@ static struct syscore_ops smemc_syscore_ops = {
 
 static int __init smemc_init(void)
 {
-	if (cpu_is_pxa3xx())
+	if (cpu_is_pxa3xx()) {
+		/*
+		 * The only documentation we have on the
+		 * Chip Select Configuration Register (CSMSADRCFG) is that
+		 * it must be programmed to 0x2.
+		 * Moreover, in the bit definitions, the second bit
+		 * (CSMSADRCFG[1]) is called "SETALWAYS".
+		 * Other bits are reserved in this register.
+		 */
+		__raw_writel(0x2, CSMSADRCFG);
+
 		register_syscore_ops(&smemc_syscore_ops);
+	}
 
 	return 0;
 }
-- 
1.7.3.4
