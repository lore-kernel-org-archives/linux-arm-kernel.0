From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Tue, 25 Jun 2013 11:28:42 +0530
Subject: [PATCH v8 4/8] ARM: OMAP: USB: Add phy binding information
In-Reply-To: <1372139926-3719-1-git-send-email-kishon@ti.com>
References: <1372139926-3719-1-git-send-email-kishon@ti.com>
Message-ID: <1372139926-3719-5-git-send-email-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for controllers to get PHY in case of non dt boot, the phy
binding information (phy device name) should be added in the platform
data of the controller.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-omap2/usb-musb.c |    6 +++++-
 include/linux/usb/musb.h       |    3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 3242a55..284ba51 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -85,8 +85,12 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
 	musb_plat.mode = board_data->mode;
 	musb_plat.extvbus = board_data->extvbus;
 
-	if (cpu_is_omap44xx())
+	if (cpu_is_omap44xx()) {
 		musb_plat.has_mailbox = true;
+		musb_plat.phy_label = "omap-usb2";
+	} else if (cpu_is_omap34xx()) {
+		musb_plat.phy_label = "twl4030";
+	}
 
 	if (soc_is_am35xx()) {
 		oh_name = "am35x_otg_hs";
diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
index 053c268..596f8c8 100644
--- a/include/linux/usb/musb.h
+++ b/include/linux/usb/musb.h
@@ -104,6 +104,9 @@ struct musb_hdrc_platform_data {
 	/* for clk_get() */
 	const char	*clock;
 
+	/* phy label */
+	const char	*phy_label;
+
 	/* (HOST or OTG) switch VBUS on/off */
 	int		(*set_vbus)(struct device *dev, int is_on);
 
-- 
1.7.10.4
