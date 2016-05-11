From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 11 May 2016 18:01:45 +0200
Subject: [PATCH 1/3] drm/omap: include linux/seq_file.h where needed
In-Reply-To: <1462982509-342936-1-git-send-email-arnd@arndb.de>
References: <1462982509-342936-1-git-send-email-arnd@arndb.de>
Message-ID: <1462982509-342936-2-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The omapdrm driver relies on this header to be included
implicitly, but this does not always work, and I get
this error in randconfig builds:

gpu/drm/omapdrm/dss/hdmi_phy.c: In function 'hdmi_phy_dump':
gpu/drm/omapdrm/dss/hdmi_phy.c:34:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]
gpu/drm/omapdrm/dss/hdmi_wp.c: In function 'hdmi_wp_dump':
gpu/drm/omapdrm/dss/hdmi_wp.c:26:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]
gpu/drm/omapdrm/dss/hdmi_pll.c: In function 'hdmi_pll_dump':
gpu/drm/omapdrm/dss/hdmi_pll.c:30:2: error: implicit declaration of function 'seq_printf' [-Werror=implicit-function-declaration]

This adds the #include statements in all files that have
a seq_printf statement.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/omapdrm/dss/hdmi_phy.c   | 1 +
 drivers/gpu/drm/omapdrm/dss/hdmi_pll.c   | 1 +
 drivers/gpu/drm/omapdrm/dss/hdmi_wp.c    | 1 +
 drivers/gpu/drm/omapdrm/omap_debugfs.c   | 2 ++
 drivers/gpu/drm/omapdrm/omap_dmm_tiler.c | 1 +
 drivers/gpu/drm/omapdrm/omap_fb.c        | 2 ++
 drivers/gpu/drm/omapdrm/omap_gem.c       | 1 +
 7 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
index 1f5d19c119ce..f98b750fc499 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_phy.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/seq_file.h>
 #include <video/omapdss.h>
 
 #include "dss.h"
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
index 06e23a7c432c..f1015e8b8267 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_pll.c
@@ -16,6 +16,7 @@
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/seq_file.h>
 
 #include <video/omapdss.h>
 
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
index 13442b9052d1..055f62fca5dc 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi_wp.c
@@ -14,6 +14,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
+#include <linux/seq_file.h>
 #include <video/omapdss.h>
 
 #include "dss.h"
diff --git a/drivers/gpu/drm/omapdrm/omap_debugfs.c b/drivers/gpu/drm/omapdrm/omap_debugfs.c
index 6f5fc14fc015..479bf24050f8 100644
--- a/drivers/gpu/drm/omapdrm/omap_debugfs.c
+++ b/drivers/gpu/drm/omapdrm/omap_debugfs.c
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/seq_file.h>
+
 #include <drm/drm_crtc.h>
 #include <drm/drm_fb_helper.h>
 
diff --git a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
index de275a5be1db..4ceed7a9762f 100644
--- a/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
+++ b/drivers/gpu/drm/omapdrm/omap_dmm_tiler.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/platform_device.h> /* platform_device() */
 #include <linux/sched.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/time.h>
 #include <linux/vmalloc.h>
diff --git a/drivers/gpu/drm/omapdrm/omap_fb.c b/drivers/gpu/drm/omapdrm/omap_fb.c
index 610962396eb0..dce41e176a64 100644
--- a/drivers/gpu/drm/omapdrm/omap_fb.c
+++ b/drivers/gpu/drm/omapdrm/omap_fb.c
@@ -17,6 +17,8 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/seq_file.h>
+
 #include <drm/drm_crtc.h>
 #include <drm/drm_crtc_helper.h>
 
diff --git a/drivers/gpu/drm/omapdrm/omap_gem.c b/drivers/gpu/drm/omapdrm/omap_gem.c
index 907154f5b67c..d2d879da6287 100644
--- a/drivers/gpu/drm/omapdrm/omap_gem.c
+++ b/drivers/gpu/drm/omapdrm/omap_gem.c
@@ -17,6 +17,7 @@
  * this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/seq_file.h>
 #include <linux/shmem_fs.h>
 #include <linux/spinlock.h>
 #include <linux/pfn_t.h>
-- 
2.7.0
