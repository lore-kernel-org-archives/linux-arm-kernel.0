From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue,  8 Oct 2013 22:35:39 +0200
Subject: [PATCH 7/9] spi: spi-omap-uwire: replace platform_driver_probe to
 support deferred probing
In-Reply-To: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
References: <1381264542-29396-1-git-send-email-wsa@the-dreams.de>
Message-ID: <1381264542-29396-8-git-send-email-wsa@the-dreams.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subsystems like pinctrl and gpio rightfully make use of deferred probing at
core level. Now, deferred drivers won't be retried if they don't have a .probe
function specified in the driver struct. Fix this driver to have that, so the
devices it supports won't get lost in a deferred probe.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---
 drivers/spi/spi-omap-uwire.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-omap-uwire.c b/drivers/spi/spi-omap-uwire.c
index a6a8f09..9313fd3 100644
--- a/drivers/spi/spi-omap-uwire.c
+++ b/drivers/spi/spi-omap-uwire.c
@@ -557,7 +557,8 @@ static struct platform_driver uwire_driver = {
 		.name		= "omap_uwire",
 		.owner		= THIS_MODULE,
 	},
-	.remove		= uwire_remove,
+	.probe = uwire_probe,
+	.remove = uwire_remove,
 	// suspend ... unuse ck
 	// resume ... use ck
 };
@@ -579,7 +580,7 @@ static int __init omap_uwire_init(void)
 		omap_writel(val | 0x00AAA000, OMAP7XX_IO_CONF_9);
 	}
 
-	return platform_driver_probe(&uwire_driver, uwire_probe);
+	return platform_driver_register(&uwire_driver);
 }
 
 static void __exit omap_uwire_exit(void)
-- 
1.8.4.rc3
