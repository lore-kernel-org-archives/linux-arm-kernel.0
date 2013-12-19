From: leigh@solinno.co.uk (Leigh Brown)
Date: Thu, 19 Dec 2013 11:13:09 +0000
Subject: [PATCH] net: mvmdio: fix interrupt timeout handling
Message-ID: <1387451589-15491-1-git-send-email-leigh@solinno.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

orion_mdio_wait_ready uses wait_event_timeout to wait for the
SMI interrupt to fire.  wait_event_timeout waits for between
"timeout - 1" and "timeout" jiffies.  In this case a 1ms timeout
when HZ is 1000 results in a wait of 0 to 1 jiffies, causing
premature timeouts.

This fix ensures a minimum timeout of 2 jiffies, ensuring
wait_event_timeout will always wait at least 1 jiffie.

Issue reported by Nicolas Schichan.

Tested-by: Nicolas Schichan <nschichan@freebox.fr>
Signed-off-by: Leigh Brown <leigh@solinno.co.uk>
---
 drivers/net/ethernet/marvell/mvmdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mvmdio.c b/drivers/net/ethernet/marvell/mvmdio.c
index 7354960..a42a750 100644
--- a/drivers/net/ethernet/marvell/mvmdio.c
+++ b/drivers/net/ethernet/marvell/mvmdio.c
@@ -92,6 +92,12 @@ static int orion_mdio_wait_ready(struct mii_bus *bus)
 			if (time_is_before_jiffies(end))
 				++timedout;
 	        } else {
+			/* wait_event_timeout does not guarantee a delay of at
+			 * least one whole jiffie, so timeout must be no less
+			 * than two.
+			 */
+			 if (timeout < 2)
+			 	timeout = 2;
 			wait_event_timeout(dev->smi_busy_wait,
 				           orion_mdio_smi_is_done(dev),
 				           timeout);
-- 
1.8.5.1
