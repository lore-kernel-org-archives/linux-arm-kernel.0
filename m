From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu,  9 Apr 2015 16:34:04 +0200
Subject: [PATCH 1/6] drm/cache: Build-in drm_clflush_*() functions
Message-ID: <1428590049-20357-1-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Irrespective of whether or not the DRM core is built as a module, build
the cache flush functions into the kernel. This is required because the
implementation may require functions that shouldn't be exported to most
drivers. DRM is somewhat of a special case here because it requires the
cache maintenance functions to properly flush pages backed by shmemfs.
These pages are directly given to display hardware for scanout, so they
must be purged from any caches to avoid visual corruption on screen.

To achieve this, add a new boolean Kconfig symbol that drivers can
select if they use any of these functions. drm_cache.c is then built if
and only if this symbol is selected. TTM and the i915 driver already use
these functions, so make them select DRM_CACHE.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Cc: Daniel Vetter <daniel.vetter@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/Kconfig      | 5 +++++
 drivers/gpu/drm/Makefile     | 3 ++-
 drivers/gpu/drm/i915/Kconfig | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index 47f2ce81b412..25bffdb89304 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -21,6 +21,10 @@ menuconfig DRM
 	  details.  You should also select and configure AGP
 	  (/dev/agpgart) support if it is available for your platform.
 
+config DRM_CACHE
+	bool
+	depends on DRM
+
 config DRM_MIPI_DSI
 	bool
 	depends on DRM
@@ -55,6 +59,7 @@ config DRM_LOAD_EDID_FIRMWARE
 config DRM_TTM
 	tristate
 	depends on DRM
+	select DRM_CACHE
 	help
 	  GPU memory management subsystem for devices with multiple
 	  GPU memory types. Will be enabled automatically if a device driver
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 7d4944e1a60c..1ad54a0e4467 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -4,7 +4,7 @@
 
 ccflags-y := -Iinclude/drm
 
-drm-y       :=	drm_auth.o drm_bufs.o drm_cache.o \
+drm-y       :=	drm_auth.o drm_bufs.o \
 		drm_context.o drm_dma.o \
 		drm_fops.o drm_gem.o drm_ioctl.o drm_irq.o \
 		drm_lock.o drm_memory.o drm_drv.o drm_vm.o \
@@ -33,6 +33,7 @@ obj-$(CONFIG_DRM_KMS_HELPER) += drm_kms_helper.o
 CFLAGS_drm_trace_points.o := -I$(src)
 
 obj-$(CONFIG_DRM)	+= drm.o
+obj-$(CONFIG_DRM_CACHE) += drm_cache.o
 obj-$(CONFIG_DRM_MIPI_DSI) += drm_mipi_dsi.o
 obj-$(CONFIG_DRM_TTM)	+= ttm/
 obj-$(CONFIG_DRM_TDFX)	+= tdfx/
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 74acca9bcd9d..237be03e8a7c 100644
--- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -10,6 +10,7 @@ config DRM_I915
 	# the shmem_readpage() which depends upon tmpfs
 	select SHMEM
 	select TMPFS
+	select DRM_CACHE
 	select DRM_KMS_HELPER
 	select DRM_PANEL
 	select DRM_MIPI_DSI
-- 
2.3.2
