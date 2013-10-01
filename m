From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:34:19 +0900
Subject: [PATCH 8/8] ARM: shmobile: r8a7778: add usb phy power control function
In-Reply-To: <cover.1380530437.git.horms+renesas@verge.net.au>
References: <cover.1380530437.git.horms+renesas@verge.net.au>
Message-ID: <f39d35fcc2cd7a24ec3128adffd7876953999e1f.1380530437.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

USB phy initialisation function is needed from not only
USB Host but also USB Function too.
This patch adds usb phy common control function.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7778.h |  2 ++
 arch/arm/mach-shmobile/setup-r8a7778.c        | 37 +++++++++++++++++++--------
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7778.h b/arch/arm/mach-shmobile/include/mach/r8a7778.h
index adfcf51..ea1dca6 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7778.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7778.h
@@ -35,4 +35,6 @@ extern void r8a7778_clock_init(void);
 extern void r8a7778_init_irq_extpin(int irlm);
 extern void r8a7778_pinmux_init(void);
 
+extern int r8a7778_usb_phy_power(bool enable);
+
 #endif /* __ASM_R8A7778_H__ */
diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index 6a2657e..e484d14 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
@@ -95,29 +95,46 @@ static struct sh_timer_config sh_tmu1_platform_data __initdata = {
 		&sh_tmu##idx##_platform_data,		\
 		sizeof(sh_tmu##idx##_platform_data))
 
-/* USB */
-static struct usb_phy *phy;
+int r8a7778_usb_phy_power(bool enable)
+{
+	static struct usb_phy *phy = NULL;
+	int ret = 0;
+
+	if (!phy)
+		phy = usb_get_phy(USB_PHY_TYPE_USB2);
+
+	if (IS_ERR(phy)) {
+		pr_err("kernel doesn't have usb phy driver\n");
+		return PTR_ERR(phy);
+	}
+
+	if (enable)
+		ret = usb_phy_init(phy);
+	else
+		usb_phy_shutdown(phy);
 
+	return ret;
+}
+
+/* USB */
 static int usb_power_on(struct platform_device *pdev)
 {
-	if (IS_ERR(phy))
-		return PTR_ERR(phy);
+	int ret = r8a7778_usb_phy_power(true);
+
+	if (ret)
+		return ret;
 
 	pm_runtime_enable(&pdev->dev);
 	pm_runtime_get_sync(&pdev->dev);
 
-	usb_phy_init(phy);
-
 	return 0;
 }
 
 static void usb_power_off(struct platform_device *pdev)
 {
-	if (IS_ERR(phy))
+	if (r8a7778_usb_phy_power(false))
 		return;
 
-	usb_phy_shutdown(phy);
-
 	pm_runtime_put_sync(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 }
@@ -353,8 +370,6 @@ void __init r8a7778_add_standard_devices(void)
 
 void __init r8a7778_init_late(void)
 {
-	phy = usb_get_phy(USB_PHY_TYPE_USB2);
-
 	platform_device_register_full(&ehci_info);
 	platform_device_register_full(&ohci_info);
 }
-- 
1.8.4
