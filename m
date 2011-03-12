From: andy@warmcat.com (Andy Green)
Date: Sat, 12 Mar 2011 22:51:09 +0000
Subject: [RFC PATCH 5/5] USBNET: SMSC95XX: if mac set in platform data no need
	for random one
In-Reply-To: <20110312224440.27728.60593.stgit@otae.warmcat.com>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
Message-ID: <20110312225109.27728.88417.stgit@otae.warmcat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is part of an RFC patch series introducing asynchronous platform
data, which may be attached to discovered bus devices at probe time
based on the device path.

As part of the series, platform_data is enabled in usbnet layer.

This patch allows smsc95xx usbnet driver to understand that the MAC
setting was handled by plaform_data sent into usbnet, and that it
does not need to overwrite the already correct MAC with a random one.

Cc: Steve Glendinning <steve.glendinning@smsc.com>
Signed-off-by: Andy Green <andy.green@linaro.org>
---

 drivers/net/usb/smsc95xx.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index bc86f4b..1d09cad 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -639,6 +639,16 @@ static int smsc95xx_ioctl(struct net_device *netdev, struct ifreq *rq, int cmd)
 
 static void smsc95xx_init_mac_address(struct usbnet *dev)
 {
+	struct usbnet_platform_data *pdata = dev->udev->dev.platform_data;
+
+	/*
+	 * if netdev platform data has taken responsibility for forcing
+	 * the MAC then nothing to do here
+	 */
+
+	if (pdata && pdata->flags & USBNET_PLATDATA_FLAG__USE_MAC)
+		return;
+
 	/* try reading mac address from EEPROM */
 	if (smsc95xx_read_eeprom(dev, EEPROM_MAC_OFFSET, ETH_ALEN,
 			dev->net->dev_addr) == 0) {
