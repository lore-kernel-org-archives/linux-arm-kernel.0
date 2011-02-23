From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 23 Feb 2011 00:11:50 -0700
Subject: [PATCH 4/8] OMAP2+: hwmod: find MPU initiator hwmod during in
	_register()
In-Reply-To: <20110223070455.5874.51326.stgit@twilight.localdomain>
References: <20110223070455.5874.51326.stgit@twilight.localdomain>
Message-ID: <20110223071146.5874.15334.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the code that looks for the MPU initiator hwmod to run during
the individual hwmod _register() function.  (Previously, it ran after
all hwmods were registered in the omap_hwmod_late_init() function.)

This is done so code can late-initialize a few individual hwmods --
for example, for the system timer -- before the entire set of hwmods is
initialized later in boot via omap_hwmod_late_init().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 9e89a58..41f548e 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1455,7 +1455,7 @@ static int _setup(struct omap_hwmod *oh, void *data)
  */
 static int __init _register(struct omap_hwmod *oh)
 {
-	int ret, ms_id;
+	int ms_id;
 
 	if (!oh || !oh->name || !oh->class || !oh->class->name ||
 	    (oh->_state != _HWMOD_STATE_UNKNOWN))
@@ -1478,9 +1478,14 @@ static int __init _register(struct omap_hwmod *oh)
 
 	oh->_state = _HWMOD_STATE_REGISTERED;
 
-	ret = 0;
+	/*
+	 * XXX Rather than doing a strcmp(), this should test a flag
+	 * set in the hwmod data, inserted by the autogenerator code.
+	 */
+	if (!strcmp(oh->name, MPU_INITIATOR_NAME))
+		mpu_oh = oh;
 
-	return ret;
+	return 0;
 }
 
 
@@ -1644,22 +1649,24 @@ static int __init _populate_mpu_rt_base(struct omap_hwmod *oh, void *data)
  *
  * Must be called after omap2_clk_init().  Resolves the struct clk names
  * to struct clk pointers for each registered omap_hwmod.  Also calls
- * _setup() on each hwmod.  Returns 0.
+ * _setup() on each hwmod.  Returns 0 upon success or -EINVAL upon error.
  */
 static int __init omap_hwmod_late_init(void)
 {
 	int r;
 
+	if (!mpu_oh) {
+		pr_err("omap_hwmod: %s: MPU initiator hwmod %s not yet registered\n",
+		       __func__, MPU_INITIATOR_NAME);
+		return -EINVAL;
+	}
+
 	r = omap_hwmod_for_each(_populate_mpu_rt_base, NULL);
 
 	/* XXX check return value */
 	r = omap_hwmod_for_each(_init_clocks, NULL);
 	WARN(r, "omap_hwmod: omap_hwmod_late_init(): _init_clocks failed\n");
 
-	mpu_oh = omap_hwmod_lookup(MPU_INITIATOR_NAME);
-	WARN(!mpu_oh, "omap_hwmod: could not find MPU initiator hwmod %s\n",
-	     MPU_INITIATOR_NAME);
-
 	omap_hwmod_for_each(_setup, NULL);
 
 	return 0;
