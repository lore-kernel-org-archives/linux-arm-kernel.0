From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 11 Mar 2011 13:02:50 +0530
Subject: [PATCH V3] OMAP4: PM: Set static dependency between MPUSS-EMIF and
	MPUSS-L3_1
Message-ID: <1299828770-28546-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As per OMAP4430 TRM, the dynamic dependency between MPUSS<->MEMIF
and MPUSS<->L3_MAIN_1 clockdomains is enable by default. Refer
register CM_MPU_DYNAMICDEP description for details.

But it doesn't seems to work as expected and MPUSS doesn't wakeup
from off-mode if the static dependency is not set between
MPUSS<->EMIF and MPUSS<->L3_MAIN_1 clockdomains. At times, CPU
dead-locks with above static dependencies cleared.

The issue is under investigation with hardware team.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Acked-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
V3: Added MPUSS <-> L3_MIAN_1 static dependency.

Patch applies on top of OMAP4 PM series and overnight testing
didn't show any regression with OMAP4 PM.

Relevant thread on this issue:
http://www.mail-archive.com/linux-omap at vger.kernel.org/msg46173.html
http://www.spinics.net/lists/arm-kernel/msg118006.html

 arch/arm/mach-omap2/pm44xx.c |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
index d4ad31e..e887a5d 100644
--- a/arch/arm/mach-omap2/pm44xx.c
+++ b/arch/arm/mach-omap2/pm44xx.c
@@ -198,6 +198,7 @@ void omap4_pm_off_mode_enable(int enable)
 static int __init omap4_pm_init(void)
 {
 	int ret;
+	struct clockdomain *emif_clkdm, *mpuss_clkdm, *l3_1_clkdm;
 
 	if (!cpu_is_omap44xx())
 		return -ENODEV;
@@ -213,6 +214,35 @@ static int __init omap4_pm_init(void)
 
 	(void) clkdm_for_each(clkdms_setup, NULL);
 
+	/*
+	 * FIXME: Remove the MPUSS <-> EMIF static dependency once the
+	 * dynamic dependency issue is root-caused.
+	 * The dynamic dependency between MPUSS <-> MEMIF and MPUSS <-> L3_1
+	 * doesn't seems to work as expected and MPUSS does not wakeup
+	 * from off-mode if the static dependency is not set between them.
+	 * At times CPUs dead-locks with above static dependencies cleared.
+	 */
+	mpuss_clkdm = clkdm_lookup("mpuss_clkdm");
+	emif_clkdm = clkdm_lookup("l3_emif_clkdm");
+	l3_1_clkdm = clkdm_lookup("l3_1_clkdm");
+	if ((!mpuss_clkdm) || (!emif_clkdm) || (!l3_1_clkdm))
+		goto err2;
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, emif_clkdm);
+	if (ret) {
+		pr_err("Failed to add MPUSS <-> EMIF wakeup dependency\n");
+		goto err2;
+	}
+
+	ret = clkdm_add_wkdep(mpuss_clkdm, l3_1_clkdm);
+	if (ret) {
+		pr_err("Failed to add MPUSS <-> L3_MAIN_1 wakeup dependency\n");
+		goto err2;
+	}
+
+	pr_info("OMAP4 PM: Temporary static dependency added between"
+		"MPUSS <-> EMIF and MPUSS <-> L3_MAIN_1.\n");
+
 	ret = omap4_mpuss_init();
 	if (ret) {
 		pr_err("Failed to initialise OMAP4 MPUSS\n");
-- 
1.6.0.4
