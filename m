From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Tue, 17 Feb 2015 05:37:54 +0800
Subject: [PATCH 1/1] ARM: coresignth: fix system halt when etm enable and add
 nosmp to command line
Message-ID: <1424122674-21361-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

when nosmp set, only 1 core enabled. try to access disable core will halt.
dts need added arm,primecell-periphid =  <id> for none-boot core
otherwise amba_device_add will halt when read peripheral id.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 drivers/coresight/coresight-etm3x.c | 4 ++++
 drivers/coresight/of_coresight.c    | 3 +--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/coresight/coresight-etm3x.c b/drivers/coresight/coresight-etm3x.c
index 73c3669..d312952 100644
--- a/drivers/coresight/coresight-etm3x.c
+++ b/drivers/coresight/coresight-etm3x.c
@@ -1829,6 +1829,10 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		return ret;
 
 	drvdata->cpu = pdata ? pdata->cpu : 0;
+	if (drvdata->cpu < 0) {
+		ret = -EINVAL;
+		goto err_arch_supported;
+	}
 
 	get_online_cpus();
 	etmdrvdata[drvdata->cpu] = drvdata;
diff --git a/drivers/coresight/of_coresight.c b/drivers/coresight/of_coresight.c
index c3efa41..6804bbd 100644
--- a/drivers/coresight/of_coresight.c
+++ b/drivers/coresight/of_coresight.c
@@ -196,8 +196,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 		if (cell) {
 			hwid = of_read_number(cell, of_n_addr_cells(dn));
 			index = get_logical_index(hwid);
-			if (index != -EINVAL)
-				pdata->cpu = index;
+			pdata->cpu = index;
 		}
 	}
 
-- 
1.9.1
