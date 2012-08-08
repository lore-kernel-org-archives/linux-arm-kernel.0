From: arnd@arndb.de (Arnd Bergmann)
Date: Wed,  8 Aug 2012 23:27:58 +0200
Subject: [PATCH 10/10] leds: renesas: fix error handling
In-Reply-To: <1344461278-28245-1-git-send-email-arnd@arndb.de>
References: <1344461278-28245-1-git-send-email-arnd@arndb.de>
Message-ID: <1344461278-28245-11-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

bfe4c041 "leds: convert Renesas TPU LED driver to devm_kzalloc() and
cleanup error exit path" introduced a possible case in which r_tpu_probe
calls iounmap on a wild pointer. This changes the one case that was
missed in the same way as the other error paths.

Without this patch, building kota2_defconfig results in:

drivers/leds/leds-renesas-tpu.c: In function 'r_tpu_probe':
drivers/leds/leds-renesas-tpu.c:246:6: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]
drivers/leds/leds-renesas-tpu.c:308:17: warning: 'p' may be used uninitialized in this function [-Wuninitialized]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Bryan Wu <bryan.wu@canonical.com>
Cc: Magnus Damm <damm@opensource.se>

--- a/drivers/leds/leds-renesas-tpu.c
+++ b/drivers/leds/leds-renesas-tpu.c
@@ -247,7 +247,7 @@ static int __devinit r_tpu_probe(struct platform_device *pdev)

        if (!cfg) {
                dev_err(&pdev->dev, "missing platform data\n");
-               goto err0;
+               return -ENODEV;
        }

        p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
---
 drivers/leds/leds-renesas-tpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/leds-renesas-tpu.c b/drivers/leds/leds-renesas-tpu.c
index 9ee12c2..771ea06 100644
--- a/drivers/leds/leds-renesas-tpu.c
+++ b/drivers/leds/leds-renesas-tpu.c
@@ -247,7 +247,7 @@ static int __devinit r_tpu_probe(struct platform_device *pdev)
 
 	if (!cfg) {
 		dev_err(&pdev->dev, "missing platform data\n");
-		goto err0;
+		return -ENODEV;
 	}
 
 	p = devm_kzalloc(&pdev->dev, sizeof(*p), GFP_KERNEL);
-- 
1.7.10
