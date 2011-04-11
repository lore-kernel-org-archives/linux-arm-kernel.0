From: Jiri.Pinkava@vscht.cz (=?UTF-8?B?SmnFmcOtIFBpbmthdmE=?=)
Date: Mon, 11 Apr 2011 05:15:17 +0200
Subject: [PATCH] nand: Fix S3C NAND clock stop
In-Reply-To: <4DA261DA.2050404@oracle.com>
References: <1302485262-8401-1-git-send-email-jiri.pinkava@vscht.cz>
	<4DA261DA.2050404@oracle.com>
Message-ID: <4DA27245.6@vscht.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Current implementation of s3c2410_nand_select_chip call
clk_disable every time when chip = -1 (de-select). This happend
multiple times even if chip was already de-selected. This causes
disabling clock even if they are already disabled and due to
nature of clock subsytem implementation this causes nand clock
to be disabled and newer enabled again.

Signed-off-by: Jiri Pinkava <jiri.pinkava@vscht.cz>
---
  drivers/mtd/nand/s3c2410.c |   57 
+++++++++++++++++++++++++++++++------------
  1 files changed, 41 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/nand/s3c2410.c b/drivers/mtd/nand/s3c2410.c
index 33d832d..fbc37dc 100644
--- a/drivers/mtd/nand/s3c2410.c
+++ b/drivers/mtd/nand/s3c2410.c
@@ -54,8 +54,14 @@ static int hardware_ecc = 1;
  static int hardware_ecc = 0;
  #endif

+#define CLOCK_DISABLE	0
+#define CLOCK_ENABLE	1
+#define CLOCK_SUSPEND	2
+
+static int clock_state = CLOCK_DISABLE;
+
  #ifdef CONFIG_MTD_NAND_S3C2410_CLKSTOP
-static int clock_stop = 1;
+static const int clock_stop = 1;
  #else
  static const int clock_stop = 0;
  #endif
@@ -159,11 +165,33 @@ static struct s3c2410_platform_nand 
*to_nand_plat(struct platform_device *dev)
  	return dev->dev.platform_data;
  }

-static inline int allow_clk_stop(struct s3c2410_nand_info *info)
+static inline int allow_clk_suspend(struct s3c2410_nand_info *info)
  {
  	return clock_stop;
  }

+/**
+ * s3c2410_nand_clk_set_state - Enable, disable or suspend NAND clock.
+ * @info: The controller instance.
+ * @new_state: State to which clock should be set.
+ */
+static void s3c2410_nand_clk_set_state(struct s3c2410_nand_info *info,
+		int new_state)
+{
+	if (!allow_clk_suspend(info) && new_state == CLOCK_SUSPEND)
+		return;
+
+	if (clock_state == CLOCK_ENABLE) {
+		if (new_state != CLOCK_ENABLE)
+			clk_disable(info->clk);
+	} else {
+		if (new_state == CLOCK_ENABLE)
+			clk_enable(info->clk);
+	}
+
+	clock_state = new_state;
+}
+
  /* timing calculations */

  #define NS_IN_KHZ 1000000
@@ -333,8 +361,8 @@ static void s3c2410_nand_select_chip(struct mtd_info 
*mtd, int chip)
  	nmtd = this->priv;
  	info = nmtd->info;

-	if (chip != -1 && allow_clk_stop(info))
-		clk_enable(info->clk);
+	if (chip != -1)
+		s3c2410_nand_clk_set_state(info, CLOCK_ENABLE);

  	cur = readl(info->sel_reg);

@@ -356,8 +384,8 @@ static void s3c2410_nand_select_chip(struct mtd_info 
*mtd, int chip)

  	writel(cur, info->sel_reg);

-	if (chip == -1 && allow_clk_stop(info))
-		clk_disable(info->clk);
+	if (chip == -1)
+		s3c2410_nand_clk_set_state(info, CLOCK_SUSPEND);
  }

  /* s3c2410_nand_hwcontrol
@@ -694,8 +722,7 @@ static int s3c24xx_nand_remove(struct 
platform_device *pdev)
  	/* free the common resources */

  	if (info->clk != NULL && !IS_ERR(info->clk)) {
-		if (!allow_clk_stop(info))
-			clk_disable(info->clk);
+		s3c2410_nand_clk_set_state(info, CLOCK_DISABLE);
  		clk_put(info->clk);
  	}

@@ -947,7 +974,7 @@ static int s3c24xx_nand_probe(struct platform_device 
*pdev)
  		goto exit_error;
  	}

-	clk_enable(info->clk);
+	s3c2410_nand_clk_set_state(info, CLOCK_ENABLE);

  	/* allocate and map the resource */

@@ -1026,9 +1053,9 @@ static int s3c24xx_nand_probe(struct 
platform_device *pdev)
  		goto exit_error;
  	}

-	if (allow_clk_stop(info)) {
+	if (allow_clk_suspend(info)) {
  		dev_info(&pdev->dev, "clock idle support enabled\n");
-		clk_disable(info->clk);
+		s3c2410_nand_clk_set_state(info, CLOCK_SUSPEND);
  	}

  	pr_debug("initialised ok\n");
@@ -1059,8 +1086,7 @@ static int s3c24xx_nand_suspend(struct 
platform_device *dev, pm_message_t pm)

  		writel(info->save_sel | info->sel_bit, info->sel_reg);

-		if (!allow_clk_stop(info))
-			clk_disable(info->clk);
+		s3c2410_nand_clk_set_state(info, CLOCK_DISABLE);
  	}

  	return 0;
@@ -1072,7 +1098,7 @@ static int s3c24xx_nand_resume(struct 
platform_device *dev)
  	unsigned long sel;

  	if (info) {
-		clk_enable(info->clk);
+		s3c2410_nand_clk_set_state(info, CLOCK_ENABLE);
  		s3c2410_nand_inithw(info);

  		/* Restore the state of the nFCE line. */
@@ -1082,8 +1108,7 @@ static int s3c24xx_nand_resume(struct 
platform_device *dev)
  		sel |= info->save_sel & info->sel_bit;
  		writel(sel, info->sel_reg);

-		if (allow_clk_stop(info))
-			clk_disable(info->clk);
+		s3c2410_nand_clk_set_state(info, CLOCK_SUSPEND);
  	}

  	return 0;
-- 
1.7.4.4
