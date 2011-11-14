From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2011 01:42:07 +0530
Subject: [PATCH v4 2/4] ARM: davinci: psc: fix incorrect offsets
In-Reply-To: <1321301529-7582-1-git-send-email-nsekhar@ti.com>
References: <1321301529-7582-1-git-send-email-nsekhar@ti.com>
Message-ID: <1321301529-7582-2-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

Seperate PDSTAT and PDCTL registers are defined for
domain 0 and domain 1 where as the code always reads
the domain 0 PDSTAT register and domain 1 PDCTL register.

Fix this issue. While at it, introduce usage of macros
for register masks to improve readability.

Reviewed-by: Sergei Shtylyov <sshtylyov@mvista.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/include/mach/psc.h |    4 +++-
 arch/arm/mach-davinci/psc.c              |   16 ++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 8bf279a..8bc3fc2 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -233,7 +233,7 @@
 #define PTCMD		0x120
 #define PTSTAT		0x128
 #define PDSTAT		0x200
-#define PDCTL1		0x304
+#define PDCTL		0x300
 #define MDSTAT		0x800
 #define MDCTL		0xA00
 
@@ -246,6 +246,8 @@
 #define MDSTAT_STATE_MASK	0x3f
 #define PDSTAT_STATE_MASK	0x1f
 #define MDCTL_FORCE		BIT(31)
+#define PDCTL_NEXT		BIT(1)
+#define PDCTL_EPCGOOD		BIT(8)
 
 #ifndef __ASSEMBLER__
 
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index a0e1770..d7e210f 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -52,7 +52,7 @@ int __init davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id)
 void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 		unsigned int id, bool enable, u32 flags)
 {
-	u32 epcpr, ptcmd, ptstat, pdstat, pdctl1, mdstat, mdctl;
+	u32 epcpr, ptcmd, ptstat, pdstat, pdctl, mdstat, mdctl;
 	void __iomem *psc_base;
 	struct davinci_soc_info *soc_info = &davinci_soc_info;
 	u32 next_state = PSC_STATE_ENABLE;
@@ -79,11 +79,11 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 		mdctl |= MDCTL_FORCE;
 	__raw_writel(mdctl, psc_base + MDCTL + 4 * id);
 
-	pdstat = __raw_readl(psc_base + PDSTAT);
+	pdstat = __raw_readl(psc_base + PDSTAT + 4 * domain);
 	if ((pdstat & PDSTAT_STATE_MASK) == 0) {
-		pdctl1 = __raw_readl(psc_base + PDCTL1);
-		pdctl1 |= 0x1;
-		__raw_writel(pdctl1, psc_base + PDCTL1);
+		pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
+		pdctl |= PDCTL_NEXT;
+		__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
 
 		ptcmd = 1 << domain;
 		__raw_writel(ptcmd, psc_base + PTCMD);
@@ -92,9 +92,9 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 			epcpr = __raw_readl(psc_base + EPCPR);
 		} while ((((epcpr >> domain) & 1) == 0));
 
-		pdctl1 = __raw_readl(psc_base + PDCTL1);
-		pdctl1 |= 0x100;
-		__raw_writel(pdctl1, psc_base + PDCTL1);
+		pdctl = __raw_readl(psc_base + PDCTL + 4 * domain);
+		pdctl |= PDCTL_EPCGOOD;
+		__raw_writel(pdctl, psc_base + PDCTL + 4 * domain);
 	} else {
 		ptcmd = 1 << domain;
 		__raw_writel(ptcmd, psc_base + PTCMD);
-- 
1.6.2.4
