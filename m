From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:46 -0800
Subject: [PATCH 04/35] davinci: move PSC register definitions from psc.c to
	psc.h
In-Reply-To: <1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

The motivation behind the change is to use the same
definitions in the assembly code responsible for
suspending the SoC, a part of which is to clock gate
the DDR2 clock.

Note that the assembly code cannot invoke the C function
meant for this. The main reason being that stack in DDR2
cannot be accessed while DDR2 clock is being clock gated.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/psc.h |   11 +++++++++++
 arch/arm/mach-davinci/psc.c              |   11 -----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/psc.h b/arch/arm/mach-davinci/include/mach/psc.h
index 171173c..2776b23 100644
--- a/arch/arm/mach-davinci/include/mach/psc.h
+++ b/arch/arm/mach-davinci/include/mach/psc.h
@@ -180,6 +180,17 @@
 #define DA8XX_LPSC1_CR_P3_SS		26
 #define DA8XX_LPSC1_L3_CBA_RAM		31
 
+/* PSC register offsets */
+#define EPCPR		0x070
+#define PTCMD		0x120
+#define PTSTAT		0x128
+#define PDSTAT		0x200
+#define PDCTL1		0x304
+#define MDSTAT		0x800
+#define MDCTL		0xA00
+
+#define MDSTAT_STATE_MASK 0x1f
+
 extern int davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id);
 extern void davinci_psc_config(unsigned int domain, unsigned int ctlr,
 		unsigned int id, char enable);
diff --git a/arch/arm/mach-davinci/psc.c b/arch/arm/mach-davinci/psc.c
index 04a3cb7..adf6b5c 100644
--- a/arch/arm/mach-davinci/psc.c
+++ b/arch/arm/mach-davinci/psc.c
@@ -25,17 +25,6 @@
 #include <mach/cputype.h>
 #include <mach/psc.h>
 
-/* PSC register offsets */
-#define EPCPR		0x070
-#define PTCMD		0x120
-#define PTSTAT		0x128
-#define PDSTAT		0x200
-#define PDCTL1		0x304
-#define MDSTAT		0x800
-#define MDCTL		0xA00
-
-#define MDSTAT_STATE_MASK 0x1f
-
 /* Return nonzero iff the domain's clock is active */
 int __init davinci_psc_is_clk_active(unsigned int ctlr, unsigned int id)
 {
-- 
1.6.6.rc2.1.g42108
