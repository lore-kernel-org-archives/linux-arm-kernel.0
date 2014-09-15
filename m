From: frans.klaver@xsens.com (Frans Klaver)
Date: Mon, 15 Sep 2014 16:00:10 +0200
Subject: [PATCH 4/4] tty: omap-serial: support setting of hardware flow
 control in dts
In-Reply-To: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
References: <1410789610-23059-1-git-send-email-frans.klaver@xsens.com>
Message-ID: <1410789610-23059-5-git-send-email-frans.klaver@xsens.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes hardware flow control availability configurable from the
device tree.

Signed-off-by: Frans Klaver <frans.klaver@xsens.com>
---
 Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
 drivers/tty/serial/omap-serial.c                         | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 342eedd..1b629e9 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -8,3 +8,4 @@ Required properties:
 
 Optional properties:
 - clock-frequency : frequency of the clock input to the UART
+- has-hw-flow-control : the hardware has flow control capability
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 398139a..bff6874 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1597,6 +1597,10 @@ static struct omap_uart_port_info *of_get_uart_port_info(struct device *dev)
 
 	of_property_read_u32(dev->of_node, "clock-frequency",
 					 &omap_up_info->uartclk);
+
+	if (of_property_read_bool(dev->of_node, "has-hw-flow-control"))
+		omap_up_info->flags |= UPF_HARD_FLOW;
+
 	return omap_up_info;
 }
 
-- 
2.1.0
