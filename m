From: heiko@sntech.de (Heiko Stuebner)
Date: Mon,  1 Oct 2018 14:38:39 +0200
Subject: [PATCH v6 1/7] drm/bridge/synopsys: dsi: move
 mipi_dsi_host_unregister to __dw_mipi_dsi_remove
In-Reply-To: <20181001123845.11818-1-heiko@sntech.de>
References: <20181001123845.11818-1-heiko@sntech.de>
Message-ID: <20181001123845.11818-2-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Right now the host is only unregistered when the driver is used via the
bridge api and not via the component api, leading to the host staying
registered in cases like probe deferral.

So move the host unregister to the general remove function, so that it
gets cleaned up in all cases.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
Reviewed-by: Philippe Cornu <philippe.cornu@st.com>
Tested-by: Philippe Cornu <philippe.cornu@st.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index fd7999642cf8..07cde255cab2 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -941,6 +941,8 @@ __dw_mipi_dsi_probe(struct platform_device *pdev,
 
 static void __dw_mipi_dsi_remove(struct dw_mipi_dsi *dsi)
 {
+	mipi_dsi_host_unregister(&dsi->dsi_host);
+
 	pm_runtime_disable(dsi->dev);
 }
 
@@ -957,8 +959,6 @@ EXPORT_SYMBOL_GPL(dw_mipi_dsi_probe);
 
 void dw_mipi_dsi_remove(struct dw_mipi_dsi *dsi)
 {
-	mipi_dsi_host_unregister(&dsi->dsi_host);
-
 	__dw_mipi_dsi_remove(dsi);
 }
 EXPORT_SYMBOL_GPL(dw_mipi_dsi_remove);
-- 
2.18.0
