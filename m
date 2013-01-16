From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 17 Jan 2013 08:05:41 +1300
Subject: [PATCH 2/4 v3] serial: vt8500: ioremap'd resource is never freed
In-Reply-To: <1358363143-7154-1-git-send-email-linux@prisktech.co.nz>
References: <1358363143-7154-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <1358363143-7154-3-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Memory mapped via ioremap call is never released. Rather than add an
iounmap call, change allocation function to devm_request_and_ioremap.

Also, change the error on failure for this call to -EADDRNOTAVAIL rather than
-ENOMEM.

Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
---
 drivers/tty/serial/vt8500_serial.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 4c4a58d..3e76dff 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -615,9 +615,9 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	snprintf(vt8500_port->name, sizeof(vt8500_port->name),
 		 "VT8500 UART%d", pdev->id);
 
-	vt8500_port->uart.membase = ioremap(mmres->start, resource_size(mmres));
+	vt8500_port->uart.membase = devm_request_and_ioremap(&pdev->dev, mmres);
 	if (!vt8500_port->uart.membase) {
-		ret = -ENOMEM;
+		ret = -EADDRNOTAVAIL;
 		goto err;
 	}
 
-- 
1.7.9.5
