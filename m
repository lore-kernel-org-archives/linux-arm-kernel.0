From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Thu, 10 May 2012 10:35:02 +0300
Subject: [RFC 1/1] Driver Core: don't oops with unregistered driver in
 driver_find_device()
Message-ID: <1336635302-29260-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

driver_find_device() can be called with an unregistered driver. Need
to check driver_private to see if it's populated or not, especially
under deferrable probe.

Signed-off-by: Hiroshi DOYU <hdoyu@nvidia.com>
---
In [PATCHv5 2/3] ARM: tegra: Add SMMU enabler in AHB:
  http://article.gmane.org/gmane.linux.ports.tegra/4658

"tegra_ahb_driver" may not be populated when it's called.
---
 drivers/base/driver.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/base/driver.c b/drivers/base/driver.c
index 3ec3896..207c27d 100644
--- a/drivers/base/driver.c
+++ b/drivers/base/driver.c
@@ -80,7 +80,7 @@ struct device *driver_find_device(struct device_driver *drv,
 	struct klist_iter i;
 	struct device *dev;
 
-	if (!drv)
+	if (!drv || !drv->p)
 		return NULL;
 
 	klist_iter_init_node(&drv->p->klist_devices, &i,
-- 
1.7.5.4
