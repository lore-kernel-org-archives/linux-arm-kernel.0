From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 23 Feb 2018 14:38:34 +0100
Subject: [PATCH v2 6/9] serial: samsung: Fix out-of-bounds access through
 serial port index
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1519393117-31998-7-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The s3c24xx_serial_ports[] array is indexed using a value derived from
the "serialN" alias in DT, or from an incrementing probe index, which
may lead to an out-of-bounds access.

Fix this by adding a range check.

Note that the array size is defined by a Kconfig symbol
(CONFIG_SERIAL_SAMSUNG_UARTS), so this can even be triggered using
a legitimate DTB or legitimate board code.

Fixes: 13a9f6c64fdc55eb ("serial: samsung: Consider DT alias when probing ports")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Use ARRAY_SIZE(),
  - Update patch description for non-DT case.
---
 drivers/tty/serial/samsung.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
index f9fecc5ed0cee826..3f2f8c118ce09d56 100644
--- a/drivers/tty/serial/samsung.c
+++ b/drivers/tty/serial/samsung.c
@@ -1818,6 +1818,10 @@ static int s3c24xx_serial_probe(struct platform_device *pdev)
 
 	dbg("s3c24xx_serial_probe(%p) %d\n", pdev, index);
 
+	if (index >= ARRAY_SIZE(s3c24xx_serial_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n", index);
+		return -EINVAL;
+	}
 	ourport = &s3c24xx_serial_ports[index];
 
 	ourport->drv_data = s3c24xx_get_driver_data(pdev);
-- 
2.7.4
