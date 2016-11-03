From: jon.mason@broadcom.com (Jon Mason)
Date: Thu, 3 Nov 2016 12:45:41 -0400
Subject: [PATCH v5 5/7] net: ethernet: bgmac: device tree phy enablement
In-Reply-To: <35b16640-8600-8c48-2f04-886dc925229d@milecki.pl>
References: <1478106488-11779-1-git-send-email-jon.mason@broadcom.com>
 <1478106488-11779-6-git-send-email-jon.mason@broadcom.com>
 <35b16640-8600-8c48-2f04-886dc925229d@milecki.pl>
Message-ID: <20161103164540.GA24723@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 03, 2016 at 09:31:21AM +0100, Rafal Milecki wrote:
> On 11/02/2016 06:08 PM, Jon Mason wrote:
> >Change the bgmac driver to allow for phy's defined by the device tree
> 
> This is a late review, I know, sorry... :(
> 
> 
> >+static int bcma_phy_direct_connect(struct bgmac *bgmac)
> >+{
> >+	struct fixed_phy_status fphy_status = {
> >+		.link = 1,
> >+		.speed = SPEED_1000,
> >+		.duplex = DUPLEX_FULL,
> >+	};
> >+	struct phy_device *phy_dev;
> >+	int err;
> >+
> >+	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, -1, NULL);
> >+	if (!phy_dev || IS_ERR(phy_dev)) {
> >+		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
> >+		return -ENODEV;
> >+	}
> >+
> >+	err = phy_connect_direct(bgmac->net_dev, phy_dev, bgmac_adjust_link,
> >+				 PHY_INTERFACE_MODE_MII);
> >+	if (err) {
> >+		dev_err(bgmac->dev, "Connecting PHY failed\n");
> >+		return err;
> >+	}
> >+
> >+	return err;
> >+}
> 
> This bcma specific function looks exactly the same as...
> 
> 
> >+static int platform_phy_direct_connect(struct bgmac *bgmac)
> >+{
> >+	struct fixed_phy_status fphy_status = {
> >+		.link = 1,
> >+		.speed = SPEED_1000,
> >+		.duplex = DUPLEX_FULL,
> >+	};
> >+	struct phy_device *phy_dev;
> >+	int err;
> >+
> >+	phy_dev = fixed_phy_register(PHY_POLL, &fphy_status, -1, NULL);
> >+	if (!phy_dev || IS_ERR(phy_dev)) {
> >+		dev_err(bgmac->dev, "Failed to register fixed PHY device\n");
> >+		return -ENODEV;
> >+	}
> >+
> >+	err = phy_connect_direct(bgmac->net_dev, phy_dev, bgmac_adjust_link,
> >+				 PHY_INTERFACE_MODE_MII);
> >+	if (err) {
> >+		dev_err(bgmac->dev, "Connecting PHY failed\n");
> >+		return err;
> >+	}
> >+
> >+	return err;
> >+}
> 
> This one.
> 
> Would that make sense to keep bgmac_phy_connect_direct and just use it in
> bcma/platform code?

Yes, I was having the same internal debate.  I hate the duplication of
code, but I really wanted to keep the PHY logic out of the bgmac.c
file.  Do you think it is acceptable to make this an inline function
in bgmac.h?

Thanks,
Jon
