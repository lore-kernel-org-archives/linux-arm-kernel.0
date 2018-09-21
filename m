From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 21 Sep 2018 15:51:47 +0530
Subject: [RFC PATCH 32/40] phy: core: Invoke pm_runtime_get_*/pm_runtime_put_*
 before invoking reset callback
In-Reply-To: <20180921102155.22839-1-kishon@ti.com>
References: <20180921102155.22839-1-kishon@ti.com>
Message-ID: <20180921102155.22839-33-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PHY drivers may try to access PHY registers in the ->reset() callback.
Invoke phy_pm_runtime_get_sync() before invoking the ->reset() callback
so that the PHY drivers don't have to enable clocks by themselves before
accessing PHY registers.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/phy/phy-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index 35fd38c5a4a1..b2f863f0866e 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -384,10 +384,16 @@ int phy_reset(struct phy *phy)
 	if (!phy || !phy->ops->reset)
 		return 0;
 
+	ret = phy_pm_runtime_get_sync(phy);
+	if (ret < 0 && ret != -ENOTSUPP)
+		return ret;
+
 	mutex_lock(&phy->mutex);
 	ret = phy->ops->reset(phy);
 	mutex_unlock(&phy->mutex);
 
+	phy_pm_runtime_put(phy);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(phy_reset);
-- 
2.17.1
