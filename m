From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 23 Feb 2011 00:11:53 -0700
Subject: [PATCH 7/8] OMAP2+: hwmod: add ability to late-init individual hwmods
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Message-ID: <20110223071152.5874.54222.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add omap_hwmod_late_init_one(), which is intended for use early in
boot to selectively init the hwmods needed for system clocksources
and clockevents, and any other hwmod that is needed in early boot.
omap_hwmod_late_init() can then be called later in the boot process.
The point is to minimize the amount of code that needs to be run early
in the boot process.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   53 +++++++++++++++++++++++++-
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 +
 2 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 1b6eb1f..83ca219 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1639,6 +1639,55 @@ static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *data)
 }
 
 /**
+ * omap_hwmod_late_init_one - XXX
+ *
+ * XXX Fix this documentation
+ *
+ * Must be called after omap2_clk_init().  Resolves the struct clk
+ * names to struct clk pointers for each registered omap_hwmod.  Also
+ * calls _setup() on each hwmod.  Returns -EINVAL upon error or 0 upon
+ * success.
+ */
+int __init omap_hwmod_late_init_one(const char *oh_name)
+{
+	struct omap_hwmod *oh;
+	int r;
+
+	pr_debug("omap_hwmod: %s: %s\n", oh_name, __func__);
+
+	if (!mpu_oh) {
+		pr_err("omap_hwmod: %s: cannot late_init_one: MPU initiator hwmod %s not yet registered\n",
+		       oh_name, MPU_INITIATOR_NAME);
+		return -EINVAL;
+	}
+
+	oh = _lookup(oh_name);
+	if (!oh) {
+		WARN(1, "omap_hwmod: %s: hwmod not yet registered\n", oh_name);
+		return -EINVAL;
+	}
+
+	if (mpu_oh->_state == _HWMOD_STATE_REGISTERED && oh != mpu_oh)
+		omap_hwmod_late_init_one(MPU_INITIATOR_NAME);
+
+	r = _populate_mpu_rt_base(oh, NULL);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "omap_hwmod: %s: couldn't set mpu_rt_base\n", oh_name);
+		return -EINVAL;
+	}
+
+	r = _init_clocks(oh, NULL);
+	if (IS_ERR_VALUE(r)) {
+		WARN(1, "omap_hwmod: %s: couldn't init clocks\n", oh_name);
+		return -EINVAL;
+	}
+
+	_setup(oh, NULL);
+
+	return 0;
+}
+
+/**
  * omap_hwmod_late_init - do some post-clock framework initialization
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk names
@@ -1657,9 +1706,9 @@ static int __init omap_hwmod_late_init(void)
 
 	r = omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
 
-	/* XXX check return value */
 	r = omap_hwmod_for_each(_init_clocks, NULL);
-	WARN(r, "omap_hwmod: omap_hwmod_late_init(): _init_clocks failed\n");
+	WARN(IS_ERR_VALUE(r),
+	     "omap_hwmod: %s: _init_clocks failed\n", __func__);
 
 	omap_hwmod_for_each(_setup, NULL);
 
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index fedd829..48b8dd3 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -30,6 +30,7 @@
 #define __ARCH_ARM_PLAT_OMAP_INCLUDE_MACH_OMAP_HWMOD_H
 
 #include <linux/kernel.h>
+#include <linux/init.h>
 #include <linux/list.h>
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
@@ -540,6 +541,8 @@ struct omap_hwmod *omap_hwmod_lookup(const char *name);
 int omap_hwmod_for_each(int (*fn)(struct omap_hwmod *oh, void *data),
 			void *data);
 
+int __init omap_hwmod_late_init_one(const char *name);
+
 int omap_hwmod_enable(struct omap_hwmod *oh);
 int _omap_hwmod_enable(struct omap_hwmod *oh);
 int omap_hwmod_idle(struct omap_hwmod *oh);
