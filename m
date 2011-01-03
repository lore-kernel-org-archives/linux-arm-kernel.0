From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 03 Jan 2011 10:08:18 +0000
Subject: [PATCH 1/7] ARM: PL011: include revision number in boot-time port
	printk
In-Reply-To: <20110103100753.GB26785@n2100.arm.linux.org.uk>
References: <20110103100753.GB26785@n2100.arm.linux.org.uk>
Message-ID: <E1PZhKs-0007pR-BX@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Include the revision number of the PL011 primecell in the boot-time
port printk to allow proper identification of the peripheral.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/serial/amba-pl011.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/amba-pl011.c b/drivers/serial/amba-pl011.c
index 6ca7a44..2c07939 100644
--- a/drivers/serial/amba-pl011.c
+++ b/drivers/serial/amba-pl011.c
@@ -76,6 +76,7 @@ struct uart_amba_port {
 	unsigned int		lcrh_rx;	/* vendor-specific */
 	bool			oversampling;   /* vendor-specific */
 	bool			autorts;
+	char			type[12];
 };
 
 /* There is by now at least one vendor with differing details, so handle it */
@@ -622,7 +623,8 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 
 static const char *pl011_type(struct uart_port *port)
 {
-	return port->type == PORT_AMBA ? "AMBA/PL011" : NULL;
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+	return uap->port.type == PORT_AMBA ? uap->type : NULL;
 }
 
 /*
@@ -872,6 +874,8 @@ static int pl011_probe(struct amba_device *dev, struct amba_id *id)
 	uap->port.flags = UPF_BOOT_AUTOCONF;
 	uap->port.line = i;
 
+	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
+
 	amba_ports[i] = uap;
 
 	amba_set_drvdata(dev, uap);
-- 
1.6.2.5
