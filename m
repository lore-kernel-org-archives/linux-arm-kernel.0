From: dev@lynxeye.de (Lucas Stach)
Date: Fri,  5 Dec 2014 20:21:57 +0100
Subject: [PATCH] serial: of-serial: fetch line number from DT
Message-ID: <1417807317-30580-1-git-send-email-dev@lynxeye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The general agreed way to specify a fixed line number
for a serial console is to provide a "serial" alias
in the devicetree. Start parsing this property in
of_serial.

Signed-off-by: Lucas Stach <dev@lynxeye.de>
Acked-by: Olof Johansson <olof@lixom.net>
---
As 3.16-rc6 landed the fix to avoid the regression that this patch
was causing on Tegra it should be safe to reapply it.

v2: move assignment outside if clause
---
 drivers/tty/serial/of_serial.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/tty/serial/of_serial.c b/drivers/tty/serial/of_serial.c
index 8bc2563..8225960 100644
--- a/drivers/tty/serial/of_serial.c
+++ b/drivers/tty/serial/of_serial.c
@@ -101,6 +101,11 @@ static int of_platform_serial_setup(struct platform_device *ofdev,
 	if (of_property_read_u32(np, "fifo-size", &prop) == 0)
 		port->fifosize = prop;
 
+	/* Check for a fixed line number */
+	ret = of_alias_get_id(np, "serial");
+	if (ret >= 0)
+		port->line = ret;
+
 	port->irq = irq_of_parse_and_map(np, 0);
 	port->iotype = UPIO_MEM;
 	if (of_property_read_u32(np, "reg-io-width", &prop) == 0) {
-- 
2.1.0
