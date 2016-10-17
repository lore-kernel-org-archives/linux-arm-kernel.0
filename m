From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 17 Oct 2016 21:45:31 +0200
Subject: [PATCH v3 3/4] net: smc91x: take into account half-word workaround
In-Reply-To: <1476733532-29716-1-git-send-email-robert.jarzmik@free.fr>
References: <1476733532-29716-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1476733532-29716-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For device-tree builds, platforms such as mainstone, idp and stargate2
must have their u16 writes all aligned on 32 bit boundaries. This is
already enabled in platform data builds, and this patch adds it to
device-tree builds.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
Since v1: rename dt property to pxa-u16-align4
---
 drivers/net/ethernet/smsc/smc91x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/smsc/smc91x.c b/drivers/net/ethernet/smsc/smc91x.c
index 705d99b2d947..65077c77082a 100644
--- a/drivers/net/ethernet/smsc/smc91x.c
+++ b/drivers/net/ethernet/smsc/smc91x.c
@@ -2326,6 +2326,8 @@ static int smc_drv_probe(struct platform_device *pdev)
 		if (!device_property_read_u32(&pdev->dev, "reg-shift",
 					      &val))
 			lp->io_shift = val;
+		lp->cfg.pxa_u16_align4 =
+			device_property_read_bool(&pdev->dev, "pxa-u16-align4");
 	}
 #endif
 
-- 
2.1.4
