From: dan.j.williams@intel.com (Dan Williams)
Date: Fri, 24 Jul 2015 22:38:58 -0400
Subject: [PATCH v2 11/25] gma500: switch from acpi_os_ioremap to ioremap
In-Reply-To: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150725023649.8664.59145.stgit@dwillia2-desk3.amr.corp.intel.com>
Message-ID: <20150725023858.8664.23506.stgit@dwillia2-desk3.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

acpi_os_ioremap uses cached mappings, however it appears that gma500
wants to read dynamic platform state.  Switch to ioremap() to prevent it
reading stale state from cache.

Cc: David Airlie <airlied@linux.ie>
Cc: dri-devel at lists.freedesktop.org
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/gpu/drm/gma500/opregion.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/gma500/opregion.c b/drivers/gpu/drm/gma500/opregion.c
index ab696ca7eeec..9809c26ea0cf 100644
--- a/drivers/gpu/drm/gma500/opregion.c
+++ b/drivers/gpu/drm/gma500/opregion.c
@@ -322,7 +322,7 @@ int psb_intel_opregion_setup(struct drm_device *dev)
 	INIT_WORK(&opregion->asle_work, psb_intel_opregion_asle_work);
 
 	DRM_DEBUG("OpRegion detected at 0x%8x\n", opregion_phy);
-	base = acpi_os_ioremap(opregion_phy, 8*1024);
+	base = ioremap(opregion_phy, 8*1024);
 	if (!base)
 		return -ENOMEM;
 
