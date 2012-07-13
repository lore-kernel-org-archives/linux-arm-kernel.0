From: vipulkumar.samar@st.com (Vipul Kumar Samar)
Date: Fri, 13 Jul 2012 14:53:54 +0530
Subject: [PATCH V2 7/7] net: stmmac: Overwrite platform data if passed from
 auxdata
In-Reply-To: <cover.1342171151.git.vipulkumar.samar@st.com>
References: <cover.1342171151.git.vipulkumar.samar@st.com>
Message-ID: <d72fd8775e055a0788226f1a9c1fbe3e333f6bae.1342171151.git.vipulkumar.samar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Platform data can be passed through either device tree or
auxdata_lookup. Device tree still donot have any means to provide
facility for passing platform callbacks to the driver.

If any platform data is available through auxdata_lookup then overwrite
the platform data passed through device tree.

Signed-off-by: Vipul Kumar Samar <vipulkumar.samar@st.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_platform.c  |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 680d2b8..4651579 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -114,10 +114,11 @@ static int stmmac_pltfr_probe(struct platform_device *pdev)
 			pr_err("%s: main dt probe failed", __func__);
 			goto out_unmap;
 		}
-	} else {
-		plat_dat = pdev->dev.platform_data;
 	}
 
+	if (pdev->dev.platform_data)
+		plat_dat = pdev->dev.platform_data;
+
 	/* Custom initialisation (if needed)*/
 	if (plat_dat->init) {
 		ret = plat_dat->init(pdev);
-- 
1.7.2.2
