From: peter.chen@freescale.com (Peter Chen)
Date: Tue, 3 Dec 2013 15:37:09 +0800
Subject: [PATCH v4 15/17] usb: phy-mxs: add controller id
In-Reply-To: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
References: <1386056231-17258-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1386056231-17258-16-git-send-email-peter.chen@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is used to access un-regulator registers according to
different controllers.

Signed-off-by: Peter Chen <peter.chen@freescale.com>
---
 drivers/usb/phy/phy-mxs-usb.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
index 52e80d9..4c2dfcd 100644
--- a/drivers/usb/phy/phy-mxs-usb.c
+++ b/drivers/usb/phy/phy-mxs-usb.c
@@ -127,6 +127,7 @@ struct mxs_phy {
 	struct clk *clk;
 	const struct mxs_phy_data *data;
 	struct regmap *regmap_anatop;
+	int port_id;
 };
 
 static inline bool is_imx6q_phy(struct mxs_phy *mxs_phy)
@@ -392,6 +393,13 @@ static int mxs_phy_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
+	ret = of_alias_get_id(np, "usbphy");
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		return ret;
+	}
+	mxs_phy->port_id = ret;
+
 	mxs_phy->phy.io_priv		= base;
 	mxs_phy->phy.dev		= &pdev->dev;
 	mxs_phy->phy.label		= DRIVER_NAME;
-- 
1.7.8
