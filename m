From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Tue, 30 Aug 2016 12:00:56 +0100
Subject: [PATCH 7/8] ARM: sa1100/neponset: remove neponset_ncr_* GPIO
 interfaces and header
In-Reply-To: <20160830105950.GA15580@n2100.armlinux.org.uk>
References: <20160830105950.GA15580@n2100.armlinux.org.uk>
Message-ID: <E1begmm-0007Ik-EQ@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the legacy neponset_ncr_*() interfaces and definitions, which
leaves the header empty apart from the header and footer.  Remove the
header as well.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/mach-sa1100/include/mach/neponset.h | 30 ----------------------------
 arch/arm/mach-sa1100/neponset.c              | 14 +------------
 2 files changed, 1 insertion(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-sa1100/include/mach/neponset.h

diff --git a/arch/arm/mach-sa1100/include/mach/neponset.h b/arch/arm/mach-sa1100/include/mach/neponset.h
deleted file mode 100644
index 5516a52a329d..000000000000
--- a/arch/arm/mach-sa1100/include/mach/neponset.h
+++ /dev/null
@@ -1,30 +0,0 @@
-/*
- * arch/arm/mach-sa1100/include/mach/neponset.h
- *
- * Created 2000/06/05 by Nicolas Pitre <nico@fluxnic.net>
- *
- * This file contains the hardware specific definitions for Assabet
- * Only include this file from SA1100-specific files.
- *
- * 2000/05/23 John Dorsey <john+@cs.cmu.edu>
- *      Definitions for Neponset added.
- */
-#ifndef __ASM_ARCH_NEPONSET_H
-#define __ASM_ARCH_NEPONSET_H
-
-/*
- * Neponset definitions: 
- */
-#define NCR_GP01_OFF		(1<<0)
-#define NCR_TP_PWR_EN		(1<<1)
-#define NCR_MS_PWR_EN		(1<<2)
-#define NCR_ENET_OSC_EN		(1<<3)
-#define NCR_SPI_KB_WK_UP	(1<<4)
-#define NCR_A0VPP		(1<<5)
-#define NCR_A1VPP		(1<<6)
-
-void neponset_ncr_frob(unsigned int, unsigned int);
-#define neponset_ncr_set(v)	neponset_ncr_frob(0, v)
-#define neponset_ncr_clear(v)	neponset_ncr_frob(v, 0)
-
-#endif
diff --git a/arch/arm/mach-sa1100/neponset.c b/arch/arm/mach-sa1100/neponset.c
index 700659cadebb..b3c2266b2302 100644
--- a/arch/arm/mach-sa1100/neponset.c
+++ b/arch/arm/mach-sa1100/neponset.c
@@ -25,7 +25,6 @@
 
 #include <mach/hardware.h>
 #include <mach/assabet.h>
-#include <mach/neponset.h>
 #include <mach/irqs.h>
 
 #define NEP_IRQ_SMC91X	0
@@ -48,6 +47,7 @@
 #define IRR_USAR	(1 << 1)
 #define IRR_SA1111	(1 << 2)
 
+#define NCR_GP01_OFF	BIT(0)
 #define NCR_NGPIO	7
 #define MDM_CTL0_NGPIO	4
 #define MDM_CTL1_NGPIO	6
@@ -124,18 +124,6 @@ static struct gpiod_lookup_table neponset_pcmcia_table = {
 
 static struct neponset_drvdata *nep;
 
-void neponset_ncr_frob(unsigned int mask, unsigned int val)
-{
-	struct neponset_drvdata *n = nep;
-	unsigned long m = mask, v = val;
-
-	if (nep)
-		n->gpio[0]->set_multiple(n->gpio[0], &m, &v);
-	else
-		WARN(1, "nep unset\n");
-}
-EXPORT_SYMBOL(neponset_ncr_frob);
-
 /*
  * Install handler for Neponset IRQ.  Note that we have to loop here
  * since the ETHERNET and USAR IRQs are level based, and we need to
-- 
2.1.0
