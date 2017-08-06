From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sun, 06 Aug 2017 18:14:22 +0300
Subject: [PATCH v2 2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks
Message-ID: <20170806151714.108596802@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_irq_get() may return 0 as well as a nagative error number on failure,
(and never on success), however omap44xx_prm_late_init() regards 0 as a
valid IRQ -- fix this.

Fixes: a8f83aefcd5a ("ARM: OMAP4+: PRM: register interrupt information from DT")
Fixes: c5b3955828ba ("ARM: OMAP4: Fix legacy code clean-up regression")
Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
Changes ion version 2:
- added the "Fixes:" tag for the commit introducing of_irq_get() call;
- rebased to the 'omap-for-v4.13/fixes' branch;
- fixed Rajendra Nayak's email;
- added + to OMAP4 in the patch subject.

 arch/arm/mach-omap2/prm44xx.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-omap/arch/arm/mach-omap2/prm44xx.c
===================================================================
--- linux-omap.orig/arch/arm/mach-omap2/prm44xx.c
+++ linux-omap/arch/arm/mach-omap2/prm44xx.c
@@ -747,7 +747,7 @@ static int omap44xx_prm_late_init(void)
 	 * Already have OMAP4 IRQ num. For all other platforms, we need
 	 * IRQ numbers from DT
 	 */
-	if (irq_num < 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
+	if (irq_num <= 0 && !(prm_init_data->flags & PRM_IRQ_DEFAULT)) {
 		if (irq_num == -EPROBE_DEFER)
 			return irq_num;
 
@@ -756,7 +756,7 @@ static int omap44xx_prm_late_init(void)
 	}
 
 	/* Once OMAP4 DT is filled as well */
-	if (irq_num >= 0) {
+	if (irq_num > 0) {
 		omap4_prcm_irq_setup.irq = irq_num;
 		omap4_prcm_irq_setup.xlate_irq = NULL;
 	}
