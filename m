From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Nov 2017 00:30:54 -0500
Subject: [PATCH 09/30] drm/i915: deprecate pci_get_bus_and_slot()
In-Reply-To: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
References: <1511328675-21981-1-git-send-email-okaya@codeaurora.org>
Message-ID: <1511328675-21981-10-git-send-email-okaya@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
where a PCI device is present. This restricts the device drivers to be
reused for other domain numbers.

Use pci_get_domain_bus_and_slot() with a domain number of 0 where we can't
extract the domain number. Other places, use the actual domain number from
the device.

Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
---
 drivers/gpu/drm/i915/i915_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/i915_drv.c b/drivers/gpu/drm/i915/i915_drv.c
index 9f45cfe..2ca7603 100644
--- a/drivers/gpu/drm/i915/i915_drv.c
+++ b/drivers/gpu/drm/i915/i915_drv.c
@@ -419,7 +419,9 @@ static int i915_getparam(struct drm_device *dev, void *data,
 
 static int i915_get_bridge_dev(struct drm_i915_private *dev_priv)
 {
-	dev_priv->bridge_dev = pci_get_bus_and_slot(0, PCI_DEVFN(0, 0));
+	uint16_t devfn = PCI_DEVFN(0, 0)
+
+	dev_priv->bridge_dev = pci_get_domain_bus_and_slot(0, 0, devfn);
 	if (!dev_priv->bridge_dev) {
 		DRM_ERROR("bridge device not found\n");
 		return -1;
-- 
1.9.1
