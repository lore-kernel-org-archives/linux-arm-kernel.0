From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Mon, 8 Oct 2012 10:35:46 +0800
Subject: [PATCH v2] serial: vt8500: fix possible memory leak in
 vt8500_serial_probe()
Message-ID: <CAPgLHd9oM+AnBenTNivOT+w8iK+GvPH+i4xyFjn1qqt65Tys+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

vt8500_port is malloced in vt8500_serial_probe() and should be freed
before leaving from the error handling cases, otherwise it will
cause memory leak.
Fix it by move the allocation of vt8500_port after those test.

dpatch engine is used to auto generate this patch.
(https://github.com/weiyj/dpatch)

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Acked-by: Tony Prisk <linux@prisktech.co.nz>
---
v1 -> v2: move the allocation of vt8500_port after those test
---
 drivers/tty/serial/vt8500_serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 205d4cf..4354fe5 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -567,10 +567,6 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 	if (!mmres || !irqres)
 		return -ENODEV;
 
-	vt8500_port = kzalloc(sizeof(struct vt8500_port), GFP_KERNEL);
-	if (!vt8500_port)
-		return -ENOMEM;
-
 	if (np)
 		port = of_alias_get_id(np, "serial");
 		if (port > VT8500_MAX_PORTS)
@@ -593,6 +589,10 @@ static int __devinit vt8500_serial_probe(struct platform_device *pdev)
 		return -EBUSY;
 	}
 
+	vt8500_port = kzalloc(sizeof(struct vt8500_port), GFP_KERNEL);
+	if (!vt8500_port)
+		return -ENOMEM;
+
 	vt8500_port->uart.type = PORT_VT8500;
 	vt8500_port->uart.iotype = UPIO_MEM;
 	vt8500_port->uart.mapbase = mmres->start;
