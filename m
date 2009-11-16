From: niej0001@gmail.com (Jun Nie)
Date: Mon, 16 Nov 2009 17:34:27 +0800
Subject: [PATCH 2/8] pxa: support PXA168 LCD platform dependent power on
Message-ID: <7c34ac520911160134w531a2c0aq3f1ee81b93049dd3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jun Nie <njun@marvell.com>
Date: Mon, 16 Nov 2009 17:16:35 +0800
Subject: [PATCH] pxa: support PXA168 LCD platform dependent power on

Signed-off-by: Jun Nie <njun@marvell.com>
---
 drivers/video/pxa168fb.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/video/pxa168fb.c b/drivers/video/pxa168fb.c
index aec95c4..e728be3 100644
--- a/drivers/video/pxa168fb.c
+++ b/drivers/video/pxa168fb.c
@@ -845,6 +845,23 @@ static int __init pxa168fb_probe(struct
platform_device *pdev)
 	}

 	platform_set_drvdata(pdev, fbi);
+	if (mi->pxa168fb_lcd_power) {
+		if (gpio_is_valid(mi->spi_gpio_cs)) {
+			ret = gpio_request(mi->spi_gpio_cs, "LCD_SPI_CS");
+			if (ret) {
+				dev_err(&pdev->dev,
+					"failed to request GPIO for LCD CS\n");
+				return -EIO;
+			}
+		}
+		ret = mi->pxa168fb_lcd_power(fbi, mi->spi_gpio_cs,
+				mi->spi_gpio_reset, 1);
+		if (ret) {
+			dev_err(&pdev->dev, "Failed to power up pxa168-fb\n");
+			goto failed_free_irq;
+		}
+	}
+	dev_info(fbi->dev, "frame buffer detected\n");
 	return 0;

 failed_free_irq:
-- 
1.5.4.3
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-pxa-support-PXA168-LCD-platform-dependent-power-on.patch
Type: text/x-diff
Size: 1170 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091116/fefe1210/attachment-0001.bin>
