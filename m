From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Fri, 6 Jan 2012 21:48:31 +0300
Subject: [PATCH v2] DaVinci: can only power up domains on DM644x
In-Reply-To: <201201062140.33712.sshtylyov@ru.mvista.com>
References: <201109151829.49256.sshtylyov@ru.mvista.com>
 <201201062140.33712.sshtylyov@ru.mvista.com>
Message-ID: <201201062148.32025.sshtylyov@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only DM644x has the domain power up procedure documented; for all other SoCs a
bootloader probably should have powered the domain up. Print error message and
give up if it hasn't done so.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Duh, forgot a newline in the message!

 arch/arm/mach-davinci/psc.c |    8 ++++++++
 1 file changed, 8 insertions(+)

Index: linux-davinci/arch/arm/mach-davinci/psc.c
===================================================================
--- linux-davinci.orig/arch/arm/mach-davinci/psc.c
+++ linux-davinci/arch/arm/mach-davinci/psc.c
@@ -81,6 +81,14 @@ void davinci_psc_config(unsigned int dom
 
 	pdstat = __raw_readl(psc_base + PDSTAT + 4 * domain);
 	if ((pdstat & PDSTAT_STATE_MASK) == 0) {
+		/* Only DM644x has the domain power up procedure documented. */
+		if (!cpu_is_davinci_dm644x()) {
+			pr_err("Don't know how to power on domain %u of PSC%u, "
+			       "probably bootloader should have done this!\n",
+			       domain, ctlr);
+			BUG();
+		}
+
 		pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
 		pdctl |= PDCTL_NEXT;
 		__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
