From: richard.zhao@linaro.org (Richard Zhao)
Date: Sun, 13 May 2012 08:59:54 +0800
Subject: [PATCH 2/2] mfd: anatop: permit adata be NULL when access register
In-Reply-To: <1336870794-6351-1-git-send-email-richard.zhao@freescale.com>
References: <1336870794-6351-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336870794-6351-2-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes anatop register access easier. Anatop has many misc registers,
which may not be a specific driver.

There's only one anatop device for a running system, so we use a global
variable to store struct anatop.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 drivers/mfd/anatop-mfd.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/mfd/anatop-mfd.c b/drivers/mfd/anatop-mfd.c
index 3bb7c49..b0313210 100644
--- a/drivers/mfd/anatop-mfd.c
+++ b/drivers/mfd/anatop-mfd.c
@@ -41,8 +41,15 @@
 #include <linux/of_address.h>
 #include <linux/mfd/anatop.h>
 
+/* For any running system, there's only one anatop device. */
+static struct anatop *anatop_data;
+
 u32 anatop_read_reg(struct anatop *adata, u32 addr)
 {
+	BUG_ON(!anatop_data);
+	if (!adata)
+		adata = anatop_data;
+
 	return readl(adata->ioreg + addr);
 }
 EXPORT_SYMBOL_GPL(anatop_read_reg);
@@ -51,6 +58,10 @@ void anatop_write_reg(struct anatop *adata, u32 addr, u32 data, u32 mask)
 {
 	u32 val;
 
+	BUG_ON(!anatop_data);
+	if (!adata)
+		adata = anatop_data;
+
 	data &= mask;
 
 	spin_lock(&adata->reglock);
@@ -83,6 +94,7 @@ static int __devinit of_anatop_probe(struct platform_device *pdev)
 	drvdata->ioreg = ioreg;
 	spin_lock_init(&drvdata->reglock);
 	platform_set_drvdata(pdev, drvdata);
+	anatop_data = drvdata;
 	of_platform_populate(np, of_anatop_match, NULL, dev);
 
 	return 0;
-- 
1.7.9.5
