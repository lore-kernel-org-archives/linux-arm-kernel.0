From: davidb@codeaurora.org (David Brown)
Date: Tue, 16 Aug 2011 10:52:13 -0700
Subject: [PATCH v2 1/4] msm_serial: Use relative resources for iomem
In-Reply-To: <1313517136-27414-1-git-send-email-davidb@codeaurora.org>
References: <1313517136-27414-1-git-send-email-davidb@codeaurora.org>
Message-ID: <1313517136-27414-2-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Device tree iomem resources are only accessible by index, and not by
name.  The msm_serial devices always have either 1 or 2 iomem
resources, that are always in the same order.  Convert the
platform_get_resource_byname into just platform_get_resource to
facilitate device tree conversion.

Signed-off-by: David Brown <davidb@codeaurora.org>
---
 drivers/tty/serial/msm_serial.c |   16 ++++++----------
 1 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index e6ba838..d9863b2 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -589,9 +589,8 @@ static void msm_release_port(struct uart_port *port)
 		iowrite32(GSBI_PROTOCOL_IDLE, msm_port->gsbi_base +
 			  GSBI_CONTROL);
 
-		gsbi_resource = platform_get_resource_byname(pdev,
-							     IORESOURCE_MEM,
-							     "gsbi_resource");
+		gsbi_resource = platform_get_resource(pdev,
+							IORESOURCE_MEM, 1);
 
 		if (unlikely(!gsbi_resource))
 			return;
@@ -612,8 +611,7 @@ static int msm_request_port(struct uart_port *port)
 	resource_size_t size;
 	int ret;
 
-	uart_resource = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						     "uart_resource");
+	uart_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!uart_resource))
 		return -ENXIO;
 
@@ -628,8 +626,7 @@ static int msm_request_port(struct uart_port *port)
 		goto fail_release_port;
 	}
 
-	gsbi_resource = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						     "gsbi_resource");
+	gsbi_resource = platform_get_resource(pdev, IORESOURCE_MEM, 1);
 	/* Is this a GSBI-based port? */
 	if (gsbi_resource) {
 		size = resource_size(gsbi_resource);
@@ -875,7 +872,7 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 	port->dev = &pdev->dev;
 	msm_port = UART_TO_MSM(port);
 
-	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "gsbi_resource"))
+	if (platform_get_resource(pdev, IORESOURCE_MEM, 1))
 		msm_port->is_uartdm = 1;
 	else
 		msm_port->is_uartdm = 0;
@@ -899,8 +896,7 @@ static int __init msm_serial_probe(struct platform_device *pdev)
 	printk(KERN_INFO "uartclk = %d\n", port->uartclk);
 
 
-	resource = platform_get_resource_byname(pdev, IORESOURCE_MEM,
-						     "uart_resource");
+	resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (unlikely(!resource))
 		return -ENXIO;
 	port->mapbase = resource->start;
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
