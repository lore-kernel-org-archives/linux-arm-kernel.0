From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 15 Nov 2011 01:42:06 +0530
Subject: [PATCH v4 1/4] ARM: davinci: psc: fix incorrect mask
Message-ID: <1321301529-7582-1-git-send-email-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Murali Karicheri <m-karicheri2@ti.com>

There are 5 LSB bits defined in PDSTAT and the code
currently uses a mask of 1 bit to check the status.

Use a proper mask per the hardware specification.
While at it, use a #define for the mask to improve
readability.

Reviewed-by: Sergei Shtylyov <sshtylyov@mvista.com>
Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/mach-davinci/include/mach/psc.h |    1 +
 arch/arm/mach-davinci/psc.c              |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index fa59c09..8bf279a 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -244,6 +244,7 @@
 #define PSC_STATE_ENABLE	3
 
 #define MDSTAT_STATE_MASK	0x3f
+#define PDSTAT_STATE_MASK	0x1f
 #define MDCTL_FORCE		BIT(31)
 
 #ifndef __ASSEMBLER__
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index 1fb6bdf..a0e1770 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -80,7 +80,7 @@ void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 	__raw_writel(mdctl, psc_base + MDCTL + 4 * id);
 
 	pdstat = __raw_readl(psc_base + PDSTAT);
-	if ((pdstat & 0x00000001) == 0) {
+	if ((pdstat & PDSTAT_STATE_MASK) == 0) {
 		pdctl1 = __raw_readl(psc_base + PDCTL1);
 		pdctl1 |= 0x1;
 		__raw_writel(pdctl1, psc_base + PDCTL1);
-- 
1.6.2.4
