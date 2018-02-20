From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 20 Feb 2018 10:40:21 +0100
Subject: [PATCH 6/9] serial: samsung: Fix out-of-bounds access through DT alias
In-Reply-To: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
References: <1519119624-1268-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1519119624-1268-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c24xx_serial_ports[] array is indexed using a value derived from
the "serialN" alias in DT, which may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using a
legitimate DTB.

Fixes: 3ac337e76a1c637b ("serial: samsung: Fix out-of-bounds access through DT alias")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/tty/serial/samsung.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f9fecc5ed0cee826..9ea42197ceefabba 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1818,6 +1818,10 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
+	if (index >= CONFIG_SERIAL_SAMSUNG_UARTS) {
+		dev_err(&pdev->dev, "serial%d out of range\n", index);
+		return -EINVAL;
+	}
 	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
-- 
2.7.4
