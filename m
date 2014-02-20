From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 20 Feb 2014 13:14:37 +0800
Subject: [PATCH v10 08/15] usb: phy-mxs: add controller id
In-Reply-To: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
References: <1392873284-9386-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1392873284-9386-9-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is used to access un-regulator registers according to
different controllers.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index cb71135..3009ab5 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -106,6 +106,7 @@ struct mxs_phy {
 	struct clk *clk;
 	const struct mxs_phy_data *data;
 	struct regmap *regmap_anatop;
+	int port_id;
 };
 
 static int mxs_phy_hw_init(struct mxs_phy *mxs_phy)
@@ -250,6 +251,11 @@ static int mxs_phy_probe(struct platform_device *pdev)
 		}
 	}
 
+	ret = of_alias_get_id(np, "usbphy");
+	if (ret < 0)
+		dev_dbg(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+	mxs_phy->port_id = ret;
+
 	mxs_phy->phy.io_priv		= base;
 	mxs_phy->phy.dev		= &pdev->dev;
 	mxs_phy->phy.label		= DRIVER_NAME;
-- 
1.7.8
