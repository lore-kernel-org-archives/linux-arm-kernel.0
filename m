From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 14 Apr 2014 18:01:47 +0200
Subject: [PATCH v2] pata_arasan_cf: fix ata_host_activate() failure handling
Message-ID: <1706948.xQXQIMFS2B@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing cf_exit() and clk_put() calls to ata_host_activate()
failure path.

Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- re-order code and then drop redundant goto statement

 drivers/ata/pata_arasan_cf.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

Index: b/drivers/ata/pata_arasan_cf.c
===================================================================
--- a/drivers/ata/pata_arasan_cf.c	2014-04-14 17:26:27.308294246 +0200
+++ b/drivers/ata/pata_arasan_cf.c	2014-04-14 17:44:41.868314795 +0200
@@ -898,9 +898,12 @@ static int arasan_cf_probe(struct platfo
 
 	cf_card_detect(acdev, 0);
 
-	return ata_host_activate(host, acdev->irq, irq_handler, 0,
-			&arasan_cf_sht);
+	ret = ata_host_activate(host, acdev->irq, irq_handler, 0,
+				&arasan_cf_sht);
+	if (!ret)
+		return 0;
 
+	cf_exit(acdev);
 free_clk:
 	clk_put(acdev->clk);
 	return ret;
