From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 21 Sep 2010 10:34:54 -0600
Subject: [PATCH 11/11] OMAP: hwmod: add an hardreset API for use by other core
	code
In-Reply-To: <20100921163021.20258.87587.stgit@twilight.localdomain>
References: <20100921163021.20258.87587.stgit@twilight.localdomain>
Message-ID: <20100921163453.20258.55542.stgit@twilight.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Expose an hardreset API from hwmod in order to assert / deassert all the
individual reset lines that belong to an hwmod.  This API is needed by
some of the more complicated processor drivers, e.g., DSP/Bridge,
Syslink, etc.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Beno?t Cousson <b-cousson@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod.c             |   78 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    4 +
 2 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index 3e90984..8c27923 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1829,6 +1829,84 @@ int omap_hwmod_disable_wakeup(struct omap_hwmod *oh)
 }
 
 /**
+ * omap_hwmod_assert_hardreset - assert the HW reset line of submodules
+ * contained in the hwmod module.
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to lookup and assert
+ *
+ * Some IP like dsp, ipu or iva contain processor that require
+ * an HW reset line to be assert / deassert in order to enable fully
+ * the IP.  Returns -EINVAL if @oh is null or if the operation is not
+ * yet supported on this OMAP; otherwise, passes along the return value
+ * from _assert_hardreset().
+ */
+int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *name)
+{
+	int ret;
+
+	if (!oh)
+		return -EINVAL;
+
+	mutex_lock(&oh->_mutex);
+	ret = _assert_hardreset(oh, name);
+	mutex_unlock(&oh->_mutex);
+
+	return ret;
+}
+
+/**
+ * omap_hwmod_deassert_hardreset - deassert the HW reset line of submodules
+ * contained in the hwmod module.
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to look up and deassert
+ *
+ * Some IP like dsp, ipu or iva contain processor that require
+ * an HW reset line to be assert / deassert in order to enable fully
+ * the IP.  Returns -EINVAL if @oh is null or if the operation is not
+ * yet supported on this OMAP; otherwise, passes along the return value
+ * from _deassert_hardreset().
+ */
+int omap_hwmod_deassert_hardreset(struct omap_hwmod *oh, const char *name)
+{
+	int ret;
+
+	if (!oh)
+		return -EINVAL;
+
+	mutex_lock(&oh->_mutex);
+	ret = _deassert_hardreset(oh, name);
+	mutex_unlock(&oh->_mutex);
+
+	return ret;
+}
+
+/**
+ * omap_hwmod_read_hardreset - read the HW reset line state of submodules
+ * contained in the hwmod module
+ * @oh: struct omap_hwmod *
+ * @name: name of the reset line to look up and read
+ *
+ * Return the current state of the hwmod @oh's reset line named @name:
+ * returns -EINVAL upon parameter error or if this operation
+ * is unsupported on the current OMAP; otherwise, passes along the return
+ * value from _read_hardreset().
+ */
+int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name)
+{
+	int ret;
+
+	if (!oh)
+		return -EINVAL;
+
+	mutex_lock(&oh->_mutex);
+	ret = _read_hardreset(oh, name);
+	mutex_unlock(&oh->_mutex);
+
+	return ret;
+}
+
+
+/**
  * omap_hwmod_for_each_by_class - call @fn for each hwmod of class @classname
  * @classname: struct omap_hwmod_class name to search for
  * @fn: callback function pointer to call for each hwmod in class @classname
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 590bfae..7fde44d 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -512,6 +512,10 @@ int omap_hwmod_idle(struct omap_hwmod *oh);
 int _omap_hwmod_idle(struct omap_hwmod *oh);
 int omap_hwmod_shutdown(struct omap_hwmod *oh);
 
+int omap_hwmod_assert_hardreset(struct omap_hwmod *oh, const char *name);
+int omap_hwmod_deassert_hardreset(struct omap_hwmod *oh, const char *name);
+int omap_hwmod_read_hardreset(struct omap_hwmod *oh, const char *name);
+
 int omap_hwmod_enable_clocks(struct omap_hwmod *oh);
 int omap_hwmod_disable_clocks(struct omap_hwmod *oh);
 
