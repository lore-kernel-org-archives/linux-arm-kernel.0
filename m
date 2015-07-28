From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:50 +0200
Subject: [PATCH v2 19/22] phy: core: Probe phy providers on demand
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-20-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a phy provider through its firmware node, probe it if it
hasn't already.

The goal is to reduce deferred probes to a minimum, as it makes it very
cumbersome to find out why a device failed to probe, and can introduce
very big delays in when a critical device is probed.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2: None

 drivers/phy/phy-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
index fc48fac003a6..c27e7d3d86ee 100644
--- a/drivers/phy/phy-core.c
+++ b/drivers/phy/phy-core.c
@@ -363,6 +363,8 @@ static struct phy *_of_phy_get(struct device_node *np, int index)
 	if (ret)
 		return ERR_PTR(-ENODEV);
 
+	fwnode_ensure_device(&args.np->fwnode);
+
 	mutex_lock(&phy_provider_mutex);
 	phy_provider = of_phy_provider_lookup(args.np);
 	if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner)) {
-- 
2.4.3
