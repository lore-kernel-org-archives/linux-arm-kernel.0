From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 15 Sep 2011 18:29:48 +0400
Subject: [PATCH] DaVinci: only poll EPCPR on DM644x and DM355
Message-ID: <201109151829.49256.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

EPCPR register and PDCTL.EPCGOOD bit exist only on DaVinci DM644x and DM35x,
so do not try to poll EPCPR and set PDCTL.EPCGOOD on the other SoCs -- it would
lead to lock up if some power domain hasn't been powered up by this time (which
hasn't happened yet on any board, it seems).

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent DaVinci tree plus this patch:

http://linux.davincidsp.com/pipermail/davinci-linux-open-source/2011-September/023308.html

Index: linux-davinci/arch/arm/mach-davinci/psc.c
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/psc.c
+++ linux-davinci/arch/arm/mach-davinci/psc.c
@@ -88,14 +88,19 @@ void davinci_psc_config(unsigned int dom
 		ptcmd = 1 << domain;
 		__raw_writel(ptcmd, psc_base + PTCMD);
 
-		do {
-			epcpr = __raw_readl(psc_base + EPCPR);
-		} while ((((epcpr >> domain) & 1) == 0));
-
-		pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
-		pdctl |= 0x100;
-		__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
-
+		/*
+		 * EPCPR register and PDCTL.EPCGOOD bit exist only on DaVinci
+		 * DM644x and DM35x...
+		 */
+		if (cpu_is_davinci_dm644x() || cpu_is_davinci_dm355()) {
+			do {
+				epcpr = __raw_readl(psc_base + EPCPR);
+			} while (((epcpr >> domain) & 1) == 0);
+
+			pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
+			pdctl |= 0x100;
+			__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
+		}
 	} else {
 		ptcmd = 1 << domain;
 		__raw_writel(ptcmd, psc_base + PTCMD);
