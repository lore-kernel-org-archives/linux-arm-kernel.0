From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Tue,  9 Feb 2010 18:13:35 +0100
Subject: [PATCH 2/3] mx31moboard: make usbh2 enable gpio claim more atomic
In-Reply-To: <1265735616-476-1-git-send-email-valentin.longchamp@epfl.ch>
References: <1265735616-476-1-git-send-email-valentin.longchamp@epfl.ch>
Message-ID: <1265735616-476-3-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is more cosmetic than fixing a real problem, but the code looks
more logical like that

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mach-mx31moboard.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mx3/mach-mx31moboard.c b/arch/arm/mach-mx3/mach-mx31moboard.c
index 63f991f..6056b64 100644
--- a/arch/arm/mach-mx3/mach-mx31moboard.c
+++ b/arch/arm/mach-mx3/mach-mx31moboard.c
@@ -352,9 +352,7 @@ static struct fsl_usb2_platform_data usb_pdata = {
 
 static int moboard_usbh2_hw_init(struct platform_device *pdev)
 {
-	int ret = gpio_request(USBH2_EN_B, "usbh2-en");
-	if (ret)
-		return ret;
+	int ret;
 
 	mxc_iomux_set_gpr(MUX_PGP_UH2, true);
 
@@ -371,6 +369,9 @@ static int moboard_usbh2_hw_init(struct platform_device *pdev)
 	mxc_iomux_set_pad(MX31_PIN_SRXD3, USB_PAD_CFG);
 	mxc_iomux_set_pad(MX31_PIN_STXD3, USB_PAD_CFG);
 
+	ret = gpio_request(USBH2_EN_B, "usbh2-en");
+	if (ret)
+		return ret;
 	gpio_direction_output(USBH2_EN_B, 0);
 
 	return 0;
-- 
1.6.3.3
