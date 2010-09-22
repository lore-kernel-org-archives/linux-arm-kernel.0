From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Sep 2010 18:19:28 -0600
Subject: [PATCH 1/5] OMAP: hwmod: Fix softreset status check for some new
	OMAP4 IPs
In-Reply-To: <20100922001834.8621.76144.stgit@twilight.localdomain>
References: <20100922001834.8621.76144.stgit@twilight.localdomain>
Message-ID: <20100922001925.8621.29632.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Benoit Cousson <b-cousson@ti.com>

In OMAP3 a specific SYSSTATUS register was used to get the softreset status.
Starting in OMAP4, some IPs does not have SYSSTATUS register and instead
use the SYSC softreset bit to provide the status.

Other cases might exist:
- Some IPs like McBSP does have a softreset control but no reset status.
- Some IPs that represent subsystem, like the DSS, can contains
a reset status without softreset control. The status is the aggregation
of all the sub modules reset status.

- Add a new flag (SYSC_HAS_RESET_STATUS) to identify the new programming model
and replace the previous SYSS_MISSING, that was used to flag IP with
softreset control but without the SYSSTATUS register, with a specific
SYSS_HAS_RESET_STATUS flag.

- MCSPI and MMC contains both programming models, so the legacy one
will be prevented by removing the syss offset field that become useless.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   22 +++++++++++++++++-----
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 ++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 8c27923..5027879 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -967,6 +967,12 @@ static int _read_hardreset(struct omap_hwmod *oh, const char *name)
  * enabled for this to work.  Returns -EINVAL if the hwmod cannot be
  * reset this way or if the hwmod is in the wrong state, -ETIMEDOUT if
  * the module did not reset in time, or 0 upon success.
+ *
+ * In OMAP3 a specific SYSSTATUS register is used to get the reset status.
+ * Starting in OMAP4, some IPs does not have SYSSTATUS register and instead
+ * use the SYSCONFIG softreset bit to provide the status.
+ *
+ * Note that some IP like McBSP does have a reset control but no reset status.
  */
 static int _reset(struct omap_hwmod *oh)
 {
@@ -974,8 +980,7 @@ static int _reset(struct omap_hwmod *oh)
 	int c = 0;
 
 	if (!oh->class->sysc ||
-	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET) ||
-	    (oh->class->sysc->sysc_flags & SYSS_MISSING))
+	    !(oh->class->sysc->sysc_flags & SYSC_HAS_SOFTRESET))
 		return -EINVAL;
 
 	/* clocks must be on for this operation */
@@ -993,9 +998,16 @@ static int _reset(struct omap_hwmod *oh)
 		return r;
 	_write_sysconfig(v, oh);
 
-	omap_test_timeout((omap_hwmod_readl(oh, oh->class->sysc->syss_offs) &
-			   SYSS_RESETDONE_MASK),
-			  MAX_MODULE_SOFTRESET_WAIT, c);
+	if (oh->class->sysc->sysc_flags & SYSS_HAS_RESET_STATUS)
+		omap_test_timeout((omap_hwmod_readl(oh,
+						    oh->class->sysc->syss_offs)
+				   & SYSS_RESETDONE_MASK),
+				  MAX_MODULE_SOFTRESET_WAIT, c);
+	else if (oh->class->sysc->sysc_flags & SYSC_HAS_RESET_STATUS)
+		omap_test_timeout(!(omap_hwmod_readl(oh,
+						     oh->class->sysc->sysc_offs)
+				   & SYSC_TYPE2_SOFTRESET_MASK),
+				  MAX_MODULE_SOFTRESET_WAIT, c);
 
 	if (c == MAX_MODULE_SOFTRESET_WAIT)
 		pr_warning("omap_hwmod: %s: softreset failed (waited %d usec)\n",
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 7fde44d..faa0827 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -251,8 +251,9 @@ struct omap_hwmod_ocp_if {
 #define SYSC_HAS_CLOCKACTIVITY	(1 << 4)
 #define SYSC_HAS_SIDLEMODE	(1 << 5)
 #define SYSC_HAS_MIDLEMODE	(1 << 6)
-#define SYSS_MISSING		(1 << 7)
+#define SYSS_HAS_RESET_STATUS	(1 << 7)
 #define SYSC_NO_CACHE		(1 << 8)  /* XXX SW flag, belongs elsewhere */
+#define SYSC_HAS_RESET_STATUS	(1 << 9)
 
 /* omap_hwmod_sysconfig.clockact flags */
 #define CLOCKACT_TEST_BOTH	0x0
