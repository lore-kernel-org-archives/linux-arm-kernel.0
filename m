From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 14 Apr 2016 20:53:32 +0800
Subject: [PATCH 2/4] i2c: designware-platdrv: fix unbalanced clk enable and
 prepare
In-Reply-To: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
References: <1460638414-5987-1-git-send-email-jszhang@marvell.com>
Message-ID: <1460638414-5987-3-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If i2c_dw_probe() fail, we should call i2c_dw_plat_prepare_clk() to
disable and unprepare the clk, otherwise the clk enable and prepare
is left unbalanced.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/i2c/busses/i2c-designware-platdrv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-platdrv.c b/drivers/i2c/busses/i2c-designware-platdrv.c
index 00f9e99..1488cea 100644
--- a/drivers/i2c/busses/i2c-designware-platdrv.c
+++ b/drivers/i2c/busses/i2c-designware-platdrv.c
@@ -268,6 +268,8 @@ rpm_disable:
 		pm_runtime_put_noidle(&pdev->dev);
 	}
 
+	i2c_dw_plat_prepare_clk(dev, false);
+
 	return r;
 }
 
-- 
2.8.0.rc3
