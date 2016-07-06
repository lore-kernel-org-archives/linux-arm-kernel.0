From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  6 Jul 2016 09:54:35 +0100
Subject: [PATCH v6 17/18] dmaengine: st_fdma: Change to late_initcall_sync
In-Reply-To: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
References: <1467795276-21725-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1467795276-21725-18-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This avoids unnecessary rounds of -EPROBE_DEFER, which
in turn avoids lots of console noise from remoteproc when
all drivers are built-in.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/st_fdma.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/st_fdma.c b/drivers/dma/st_fdma.c
index f28026e..df7af95 100644
--- a/drivers/dma/st_fdma.c
+++ b/drivers/dma/st_fdma.c
@@ -869,10 +869,22 @@ static struct platform_driver st_fdma_platform_driver = {
 		.name = "st-fdma",
 		.of_match_table = st_fdma_match,
 	},
-	.probe = st_fdma_probe,
-	.remove = st_fdma_remove,
 };
-module_platform_driver(st_fdma_platform_driver);
+
+static int __init fdma_init(void)
+{
+	return platform_driver_probe(&st_fdma_platform_driver, st_fdma_probe);
+}
+
+static void __exit fdma_exit(void)
+{
+	platform_driver_unregister(&st_fdma_platform_driver);
+}
+
+/* attempt to load late, helps when built-in */
+
+late_initcall_sync(fdma_init);
+module_exit(fdma_exit);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("STMicroelectronics FDMA engine driver");
-- 
1.9.1
