From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu,  5 Apr 2018 11:46:59 +0200
Subject: [PATCH] phy: stm32: Fix printing of wrong uninitialized port number
Message-ID: <1522921619-5790-1-git-send-email-geert@linux-m68k.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

drivers/phy/st/phy-stm32-usbphyc.c: In function ?stm32_usbphyc_probe?:
drivers/phy/st/phy-stm32-usbphyc.c:364: warning: ?i? may be used uninitialized in this function

Indeed, during the first loop iteration, "i" is uninitialized.
However, "i" does not represent the intended PHY instance number to
print.

Fix this by printing the correct variable instead.

Fixes: 94c358da3a054520 ("phy: stm32: add support for STM32 USB PHY Controller (USBPHYC)")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/phy/st/phy-stm32-usbphyc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/phy/st/phy-stm32-usbphyc.c b/drivers/phy/st/phy-stm32-usbphyc.c
index bc4e78a19c913dc9..1f682c176fd6239e 100644
--- a/drivers/phy/st/phy-stm32-usbphyc.c
+++ b/drivers/phy/st/phy-stm32-usbphyc.c
@@ -367,8 +367,8 @@ static int stm32_usbphyc_probe(struct platform_device *pdev)
 		if (IS_ERR(phy)) {
 			ret = PTR_ERR(phy);
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev,
-					"failed to create phy%d: %d\n", i, ret);
+				dev_err(dev, "failed to create phy%d: %d\n",
+					port, ret);
 			goto put_child;
 		}
 
-- 
2.7.4
