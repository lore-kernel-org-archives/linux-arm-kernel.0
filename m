From: balbi@ti.com (Felipe Balbi)
Date: Fri, 6 Dec 2013 14:46:29 -0600
Subject: [PATCH v4 4/4] USB: OMAP1: Tahvo USB transceiver driver
In-Reply-To: <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
 <1386339187-28466-5-git-send-email-aaro.koskinen@iki.fi>
Message-ID: <20131206204629.GL21086@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 04:13:07PM +0200, Aaro Koskinen wrote:
> Add Tahvo USB transceiver driver.
> 
> Based on old code from linux-omap tree. The original driver was written
> by Juha Yrj?l?, Tony Lindgren, and Timo Ter?s.
> 
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>

compile error:


  CC [M]  drivers/usb/phy/phy-tahvo.o
drivers/usb/phy/phy-tahvo.c: In function ?tahvo_usb_probe?:
drivers/usb/phy/phy-tahvo.c:371:2: error: too many arguments to function ?extcon_dev_register?
  ret = extcon_dev_register(&tu->extcon, &pdev->dev);
  ^
In file included from drivers/usb/phy/phy-tahvo.c:26:0:
include/linux/extcon.h:186:12: note: declared here
 extern int extcon_dev_register(struct extcon_dev *edev);
            ^
make[1]: *** [drivers/usb/phy/phy-tahvo.o] Error 1
make: *** [drivers/usb/phy/] Error 2

fixed it up with:

diff --git a/drivers/usb/phy/phy-tahvo.c b/drivers/usb/phy/phy-tahvo.c
index 7cf1766..8bb833e 100644
--- a/drivers/usb/phy/phy-tahvo.c
+++ b/drivers/usb/phy/phy-tahvo.c
@@ -368,7 +368,9 @@ static int tahvo_usb_probe(struct platform_device *pdev)
 
 	tu->extcon.name = DRIVER_NAME;
 	tu->extcon.supported_cable = tahvo_cable;
-	ret = extcon_dev_register(&tu->extcon, &pdev->dev);
+	tu->extcon.dev.parent = &pdev->dev;
+
+	ret = extcon_dev_register(&tu->extcon);
 	if (ret) {
 		dev_err(&pdev->dev, "could not register extcon device: %d\n",
 			ret);

please make sure it still works with v3.13-rc2 + this patch.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/328d1b3e/attachment.sig>
