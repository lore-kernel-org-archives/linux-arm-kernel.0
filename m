From: skarajga@visteon.com (Karajgaonkar, Saurabh (S.))
Date: Tue, 4 Aug 2015 09:11:05 +0000
Subject: [PATCH 6/9] usb: host: u132-hcd: Simplify return statement
In-Reply-To: <cover.1438678566.git.skarajga@visteon.com>
References: <cover.1438678566.git.skarajga@visteon.com>
Message-ID: <4a709b250542c3af2783955f53f1e980b010082a.1438678566.git.skarajga@visteon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Saurabh Karajgaonkar <skarajga@visteon.com>

Replace redundant variable use in return statement.

Signed-off-by: Saurabh Karajgaonkar <skarajga@visteon.com>
---
 drivers/usb/host/u132-hcd.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/host/u132-hcd.c b/drivers/usb/host/u132-hcd.c
index d516877..1cfb811 100644
--- a/drivers/usb/host/u132-hcd.c
+++ b/drivers/usb/host/u132-hcd.c
@@ -1542,11 +1542,8 @@ static int u132_periodic_reinit(struct u132 *u132)
 		(fit ^ FIT) | u132->hc_fminterval);
 	if (retval)
 		return retval;
-	retval = u132_write_pcimem(u132, periodicstart,
+	return u132_write_pcimem(u132, periodicstart,
 		((9 * fi) / 10) & 0x3fff);
-	if (retval)
-		return retval;
-	return 0;
 }
 
 static char *hcfs2string(int state)
@@ -2701,28 +2698,18 @@ static int u132_roothub_setportfeature(struct u132 *u132, u16 wValue,
 	if (wIndex == 0 || wIndex > u132->num_ports) {
 		return -EINVAL;
 	} else {
-		int retval;
 		int port_index = wIndex - 1;
 		struct u132_port *port = &u132->port[port_index];
 		port->Status &= ~(1 << wValue);
 		switch (wValue) {
 		case USB_PORT_FEAT_SUSPEND:
-			retval = u132_write_pcimem(u132,
+			return u132_write_pcimem(u132,
 				roothub.portstatus[port_index], RH_PS_PSS);
-			if (retval)
-				return retval;
-			return 0;
 		case USB_PORT_FEAT_POWER:
-			retval = u132_write_pcimem(u132,
+			return u132_write_pcimem(u132,
 				roothub.portstatus[port_index], RH_PS_PPS);
-			if (retval)
-				return retval;
-			return 0;
 		case USB_PORT_FEAT_RESET:
-			retval = u132_roothub_portreset(u132, port_index);
-			if (retval)
-				return retval;
-			return 0;
+			return u132_roothub_portreset(u132, port_index);
 		default:
 			return -EPIPE;
 		}
@@ -2737,7 +2724,6 @@ static int u132_roothub_clearportfeature(struct u132 *u132, u16 wValue,
 	} else {
 		int port_index = wIndex - 1;
 		u32 temp;
-		int retval;
 		struct u132_port *port = &u132->port[port_index];
 		port->Status &= ~(1 << wValue);
 		switch (wValue) {
@@ -2773,11 +2759,8 @@ static int u132_roothub_clearportfeature(struct u132 *u132, u16 wValue,
 		default:
 			return -EPIPE;
 		}
-		retval = u132_write_pcimem(u132, roothub.portstatus[port_index],
+		return u132_write_pcimem(u132, roothub.portstatus[port_index],
 			 temp);
-		if (retval)
-			return retval;
-		return 0;
 	}
 }
 
-- 
1.9.1
