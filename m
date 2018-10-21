From: wsa+renesas@sang-engineering.com (Wolfram Sang)
Date: Sun, 21 Oct 2018 22:00:20 +0200
Subject: [PATCH 9/9] net: phy: mdio-mux-bcm-iproc: simplify getting
 .driver_data
In-Reply-To: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
References: <20181021200021.1693-1-wsa+renesas@sang-engineering.com>
Message-ID: <20181021200021.1693-10-wsa+renesas@sang-engineering.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should get 'driver_data' from 'struct device' directly. Going via
platform_device is an unneeded step back and forth.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Build tested only. buildbot is happy.

 drivers/net/phy/mdio-mux-bcm-iproc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/mdio-mux-bcm-iproc.c b/drivers/net/phy/mdio-mux-bcm-iproc.c
index c017486e9b86..696bdf1e4576 100644
--- a/drivers/net/phy/mdio-mux-bcm-iproc.c
+++ b/drivers/net/phy/mdio-mux-bcm-iproc.c
@@ -289,8 +289,7 @@ static int mdio_mux_iproc_remove(struct platform_device *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int mdio_mux_iproc_suspend(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iproc_mdiomux_desc *md = platform_get_drvdata(pdev);
+	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
 
 	clk_disable_unprepare(md->core_clk);
 
@@ -299,8 +298,7 @@ static int mdio_mux_iproc_suspend(struct device *dev)
 
 static int mdio_mux_iproc_resume(struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
-	struct iproc_mdiomux_desc *md = platform_get_drvdata(pdev);
+	struct iproc_mdiomux_desc *md = dev_get_drvdata(dev);
 
 	clk_prepare_enable(md->core_clk);
 	mdio_mux_iproc_config(md);
-- 
2.19.0
