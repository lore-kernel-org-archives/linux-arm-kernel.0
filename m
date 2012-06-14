From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Thu, 14 Jun 2012 17:05:54 +0200
Subject: [PATCH 03/10] ARM: OMAP2+: PM QoS: manage the per-device latency
 constraints in hwmod
In-Reply-To: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
References: <1339686361-11526-1-git-send-email-j-pihet@ti.com>
Message-ID: <1339686361-11526-4-git-send-email-j-pihet@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Call the per-device PM QoS functions of the power domain code from the
hwmod layer, in order to apply the constraints requested to a device.

While at it, correct the functions kerneldoc.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   22 ++++++----------------
 1 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index cc173d9..4f43e0c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -3302,15 +3302,13 @@ ohsps_unlock:
 }
 
 /**
- * omap_hwmod_set_wakeuplat_constraint - set/release a wake-up latency
+ * omap_hwmod_set_wakeuplat_constraint - Set or update a wake-up latency
  * constraint
  * @oh: struct omap_hwmod* to which the target device belongs to.
  * @cookie: identifier of the constraints list for @oh.
  * @min_latency: the minimum allowed wake-up latency for @oh.
  *
- * Sets a wakeup latency contraint.  (To remove a wakeup latency
- * constraint, call omap_hwmod_remove_wakeuplat_constraint()).
- * Returns the return value from pwrdm_wakeuplat_remove_constraint(),
+ * Returns the return value from pwrdm_wakeuplat_update_constraint(),
  * or -EINVAL in case of invalid parameters.
  */
 int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie,
@@ -3321,21 +3319,17 @@ int omap_hwmod_set_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie,
 	if (!pwrdm)
 		return -EINVAL;
 
-	/*
-	 * XXX Update to use pwrdm_wakeuplat_update_constraint() when
-	 * that code is ready
-	 */
-	return -EINVAL;
+	return pwrdm_wakeuplat_update_constraint(pwrdm, cookie, min_latency);
 }
 
 /**
- * omap_hwmod_remove_wakeuplat_constraint - release a wake-up latency
+ * omap_hwmod_remove_wakeuplat_constraint - Release a wake-up latency
  * constraint
  * @oh: struct omap_hwmod* to which the target device belongs to.
  * @cookie: identifier of the constraints list for @oh.
  *
  * Removes a wakeup latency contraint.  Returns the return value from
- * pwrdm_wakeuplat_update_constraint(), or -EINVAL in case of invalid
+ * pwrdm_wakeuplat_remove_constraint(), or -EINVAL in case of invalid
  * parameters.
  */
 int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie)
@@ -3345,11 +3339,7 @@ int omap_hwmod_remove_wakeuplat_constraint(struct omap_hwmod *oh, void *cookie)
 	if (!pwrdm)
 		return -EINVAL;
 
-	/*
-	 * XXX Update to use pwrdm_wakeuplat_remove_constraint() when
-	 * that code is ready
-	 */
-	return -EINVAL;
+	return pwrdm_wakeuplat_remove_constraint(pwrdm, cookie);
 }
 
 /**
-- 
1.7.7.6
