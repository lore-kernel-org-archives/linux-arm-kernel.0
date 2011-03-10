From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 9 Mar 2011 18:06:46 -0700 (MST)
Subject: [PATCH] OMAP2+: hwmod: allow board files to prevent devices from
	being reset upon init
Message-ID: <alpine.DEB.2.00.1103091805560.15132@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Some boards can't tolerate IP blocks being reset when they are initialized.
Michael B?sch cites a case with the Nokia N810:

    http://www.spinics.net/lists/linux-omap/msg47277.html

To allow such boards to continue working normally, allow board file
maintainers to mark IP blocks to prevent them from being reset upon
init.  This is done via a hwmod function, omap_hwmod_no_setup_reset().

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Michael Buesch <mb@bu3sch.de>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   26 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    2 ++
 2 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index e282e35..816aeb9 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2218,3 +2218,29 @@ u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh)
 
 	return ret;
 }
+
+/**
+ * omap_hwmod_no_setup_reset - prevent a hwmod from being reset upon setup
+ * @oh: struct omap_hwmod *
+ *
+ * Prevent the hwmod @oh from being reset during the setup process.
+ * Intended for use by board-*.c files on boards with devices that
+ * cannot tolerate being reset.  Must be called before the hwmod has
+ * been set up.  Returns 0 upon success or negative error code upon
+ * failure.
+ */
+int omap_hwmod_no_setup_reset(struct omap_hwmod *oh)
+{
+	if (!oh)
+		return -EINVAL;
+
+	if (oh->_state != _HWMOD_STATE_REGISTERED) {
+		pr_err("omap_hwmod: %s: cannot prevent setup reset; in wrong state\n",
+			oh->name);
+		return -EINVAL;
+	}
+
+	oh->flags |= HWMOD_INIT_NO_RESET;
+
+	return 0;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 1eee85a..bba2343 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -589,6 +589,8 @@ int omap_hwmod_for_each_by_class(const char *classname,
 int omap_hwmod_set_postsetup_state(struct omap_hwmod *oh, u8 state);
 u32 omap_hwmod_get_context_loss_count(struct omap_hwmod *oh);
 
+int omap_hwmod_no_setup_reset(struct omap_hwmod *oh);
+
 /*
  * Chip variant-specific hwmod init routines - XXX should be converted
  * to use initcalls once the initial boot ordering is straightened out
-- 
1.7.2.3
