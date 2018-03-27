From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 27 Mar 2018 12:31:49 -0400
Subject: [net-next PATCH v2 10/10] net: netcp: support probe deferral
In-Reply-To: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
References: <1522168309-12338-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <1522168309-12338-11-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The netcp driver shouldn't proceed until the knav qmss and dma
devices are ready. So return -EPROBE_DEFER if these devices are not
ready.

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 drivers/net/ethernet/ti/netcp_core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/ti/netcp_core.c b/drivers/net/ethernet/ti/netcp_core.c
index 9c51b25..736f6f7 100644
--- a/drivers/net/ethernet/ti/netcp_core.c
+++ b/drivers/net/ethernet/ti/netcp_core.c
@@ -2158,6 +2158,10 @@ static int netcp_probe(struct platform_device *pdev)
 	struct netcp_module *module;
 	int ret;
 
+	if (!knav_dma_device_ready() ||
+	    !knav_qmss_device_ready())
+		return -EPROBE_DEFER;
+
 	if (!node) {
 		dev_err(dev, "could not find device info\n");
 		return -ENODEV;
-- 
1.9.1
