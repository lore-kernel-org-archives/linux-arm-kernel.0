From: antoine.tenart@bootlin.com (Antoine Tenart)
Date: Fri,  4 May 2018 15:56:32 +0200
Subject: [PATCH net-next v2 02/13] net: phy: sfp: handle non-wired SFP
 connectors
In-Reply-To: <20180504135643.23466-1-antoine.tenart@bootlin.com>
References: <20180504135643.23466-1-antoine.tenart@bootlin.com>
Message-ID: <20180504135643.23466-3-antoine.tenart@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SFP connectors can be solder on a board without having any of their pins
(LOS, i2c...) wired. In such cases the SFP link state cannot be guessed,
and the overall link status reporting is left to other layers.

In order to achieve this, a new SFP_DEV status is added, named UNKNOWN.
This mode is set when it is not possible for the SFP code to get the
link status and as a result the link status is reported to be always UP
from the SFP point of view.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 drivers/net/phy/sfp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 4686c443fc22..8e323a4b70da 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -48,6 +48,7 @@ enum {
 
 	SFP_DEV_DOWN = 0,
 	SFP_DEV_UP,
+	SFP_DEV_UNKNOWN,
 
 	SFP_S_DOWN = 0,
 	SFP_S_INIT,
@@ -737,6 +738,15 @@ static void sfp_sm_event(struct sfp *sfp, unsigned int event)
 			sfp->sm_dev_state = SFP_DEV_DOWN;
 		}
 		break;
+
+	case SFP_DEV_UNKNOWN:
+		/* We can't know the state of the SFP link. Report the
+		 * link as being up as its status has to be guessed by
+		 * other layers.
+		 */
+		if (event != SFP_E_DEV_UP)
+			sfp_link_up(sfp->sfp_bus);
+		break;
 	}
 
 	/* Some events are global */
@@ -1077,6 +1087,12 @@ static int sfp_probe(struct platform_device *pdev)
 	if (poll)
 		mod_delayed_work(system_wq, &sfp->poll, poll_jiffies);
 
+	/* We won't be able to know the state of the SFP link, report it as
+	 * unknown.
+	 */
+	if (!sfp->gpio[GPIO_MODDEF0] && !sfp->gpio[GPIO_LOS])
+		sfp->sm_dev_state = SFP_DEV_UNKNOWN;
+
 	return 0;
 }
 
-- 
2.17.0
