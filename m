From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Fri, 23 Feb 2018 14:38:31 +0100
Subject: [PATCH v2 3/9] serial: imx: Fix out-of-bounds access through serial
 port index
In-Reply-To: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
References: <1519393117-31998-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1519393117-31998-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The imx_ports[] array is indexed using a value derived from the
"serialN" alias in DT, or from platform data, which may lead to an
out-of-bounds access.

Fix this by adding a range check.

Fixes: ff05967a07225ab6 ("serial/imx: add of_alias_get_id() reference back")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Fix Fixes reference,
  - Add blank line,
  - Use ARRAY_SIZE(),
  - Update patch description for platform data.
---
 drivers/tty/serial/imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 1d7ca382bc12b238..7c9bdc8e34ac9109 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -2042,6 +2042,12 @@ static int serial_imx_probe(struct platform_device *pdev)
 	else if (ret < 0)
 		return ret;
 
+	if (sport->port.line >= ARRAY_SIZE(imx_ports)) {
+		dev_err(&pdev->dev, "serial%d out of range\n",
+			sport->port.line);
+		return -EINVAL;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
-- 
2.7.4
