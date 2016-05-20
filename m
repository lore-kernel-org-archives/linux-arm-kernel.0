From: kernel@martin.sperl.org (kernel at martin.sperl.org)
Date: Fri, 20 May 2016 07:23:17 +0000
Subject: [PATCH 2/2] memory: bcm2835: enable driver early in the boot process
In-Reply-To: <1463728997-8241-1-git-send-email-kernel@martin.sperl.org>
References: <1463728997-8241-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <1463728997-8241-3-git-send-email-kernel@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martin Sperl <kernel@martin.sperl.org>

Enable the critical sdram-clocks early during the boot process,
so that these clocks (and their PLLs) can not get disabled
when a different driver disables its clocks again because
it failed to probe propperly (maybe deferred).

Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
---
 drivers/memory/bcm2835-sdram.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/bcm2835-sdram.c b/drivers/memory/bcm2835-sdram.c
index 9d8cce2..7b6406d 100644
--- a/drivers/memory/bcm2835-sdram.c
+++ b/drivers/memory/bcm2835-sdram.c
@@ -431,6 +431,9 @@ static int bcm2835_sdram_probe(struct platform_device *pdev)
 	/* setup debugfs */
 	bcm2835_sdram_debugfs(pdev);
 
+	/* note that we have registered sdram */
+	dev_dbg(&pdev->dev, "registered sdram\n");
+
 	return 0;
 }
 
@@ -457,7 +460,12 @@ static struct platform_driver bcm2835_sdram_driver = {
 		.of_match_table = bcm2835_sdram_of_match_table,
 	},
 };
-module_platform_driver(bcm2835_sdram_driver);
+
+static int __init __bcm2835_sdram_driver_init(void)
+{
+	return platform_driver_register(&bcm2835_sdram_driver);
+}
+core_initcall_sync(__bcm2835_sdram_driver_init);
 
 MODULE_AUTHOR("Martin Sperl");
 MODULE_DESCRIPTION("sdram driver for bcm2835 chip");
-- 
2.1.4
