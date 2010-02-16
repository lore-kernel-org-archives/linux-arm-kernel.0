From: paul@pwsan.com (Paul Walmsley)
Date: Mon, 15 Feb 2010 18:24:41 -0700
Subject: [PATCH 02/19] OMAP: omap_device: when 'called from invalid state',
	print state
In-Reply-To: <20100216011942.1101.14348.stgit@localhost.localdomain>
References: <20100216011942.1101.14348.stgit@localhost.localdomain>
Message-ID: <20100216012437.1101.80544.stgit@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@deeprootsystems.com>

The omap_device_[enable|idle|shutdown] functions print a warning
when called from an invalid state.  Print the invalid state in
the warning messages.  This also uses __func__ to get the function
name.

Also, move the entire print string onto a single line to facilitate
grepping or error messages.  Recent discussions on LKML show
strong preference for grep-able code vs. strict 80 column limit.

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/plat-omap/omap_device.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/plat-omap/omap_device.c b/arch/arm/plat-omap/omap_device.c
index 40289e0..c739a04 100644
--- a/arch/arm/plat-omap/omap_device.c
+++ b/arch/arm/plat-omap/omap_device.c
@@ -466,8 +466,8 @@ int omap_device_enable(struct platform_device *pdev)
 	od = _find_by_pdev(pdev);
 
 	if (od->_state == OMAP_DEVICE_STATE_ENABLED) {
-		WARN(1, "omap_device: %s.%d: omap_device_enable() called from "
-		     "invalid state\n", od->pdev.name, od->pdev.id);
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
 		return -EINVAL;
 	}
 
@@ -505,8 +505,8 @@ int omap_device_idle(struct platform_device *pdev)
 	od = _find_by_pdev(pdev);
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED) {
-		WARN(1, "omap_device: %s.%d: omap_device_idle() called from "
-		     "invalid state\n", od->pdev.name, od->pdev.id);
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
 		return -EINVAL;
 	}
 
@@ -538,8 +538,8 @@ int omap_device_shutdown(struct platform_device *pdev)
 
 	if (od->_state != OMAP_DEVICE_STATE_ENABLED &&
 	    od->_state != OMAP_DEVICE_STATE_IDLE) {
-		WARN(1, "omap_device: %s.%d: omap_device_shutdown() called "
-		     "from invalid state\n", od->pdev.name, od->pdev.id);
+		WARN(1, "omap_device: %s.%d: %s() called from invalid state %d\n",
+		     od->pdev.name, od->pdev.id, __func__, od->_state);
 		return -EINVAL;
 	}
 
