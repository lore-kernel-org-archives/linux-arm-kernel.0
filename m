From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 13 Jan 2011 16:43:16 +0100
Subject: RFC i.MX ehci cleanup
Message-ID: <20110113154316.GA24373@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

As many of the i.MX users know the current ehci support in
arch/arm/plat-mxc/ehci.c is a mess. Basically we try to encode the
values for the USBCTRL register in pseudo generic flags, pass them via
platform data to the USB driver which again calls SoC code in ehci.c to
decode the flags again. On all i.MX SoCs (except i.MX51/53) We only need
to setup a single register which is completely static for a given
machine.  So I propose that we just provide a ehci_get function which
enables the USB clock to provide register access and let it up to the
board setting the register correctly. The following patch is an example
for the i.MX27 phycard module to describe what I'm talking about.  For
the i.MX51 we might want to provide some kind of helper function as the
USB phy setup is more complex on this SoC.

What do you think?

Sascha

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/mach-pca100.c      |   13 +++++++++++++
 arch/arm/plat-mxc/ehci.c             |   22 ++++++++++++++++++++++
 arch/arm/plat-mxc/include/mach/usb.h |   31 +++++++++++++++++++++++++++++++
 drivers/usb/host/ehci-mxc.c          |    2 +-
 4 files changed, 67 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/mach-pca100.c b/arch/arm/mach-imx/mach-pca100.c
index cccc0a0..1786e58 100644
--- a/arch/arm/mach-imx/mach-pca100.c
+++ b/arch/arm/mach-imx/mach-pca100.c
@@ -357,6 +357,7 @@ static const struct imx_fb_platform_data pca100_fb_data __initconst = {
 static void __init pca100_init(void)
 {
 	int ret;
+	void __iomem *usbbase;
 
 	/* SSI unit */
 	mxc_audmux_v1_configure_port(MX27_AUDMUX_HPCR1_SSI0,
@@ -402,6 +403,18 @@ static void __init pca100_init(void)
 	gpio_request(USBH2_PHY_CS_GPIO, "usb-host2-cs");
 	gpio_direction_output(USBH2_PHY_CS_GPIO, 1);
 
+	usbbase = mx27_ehci_get();
+	if (usbbase) {
+		writel(IMX27_USBCTRL_H2DT |
+			IMX27_USBCTRL_H2PM |
+			IMX27_USBCTRL_H2WIE |
+			IMX27_USBCTRL_H2UIE |
+			IMX27_USBCTRL_OPM, usbbase + IMX27_USBCTRL);
+		mx27_ehci_put();
+	}
+
 #if defined(CONFIG_USB_ULPI)
 	if (otg_mode_host) {
 		otg_pdata.otg = otg_ulpi_create(&mxc_ulpi_access_ops,
diff --git a/arch/arm/plat-mxc/ehci.c b/arch/arm/plat-mxc/ehci.c
index 8772ce3..7941c20 100644
--- a/arch/arm/plat-mxc/ehci.c
+++ b/arch/arm/plat-mxc/ehci.c
@@ -15,6 +15,8 @@
 
 #include <linux/platform_device.h>
 #include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/err.h>
 
 #include <mach/hardware.h>
 #include <mach/mxc_ehci.h>
@@ -367,3 +369,23 @@ error:
 }
 EXPORT_SYMBOL(mxc_initialize_usb_hw);
 
+static struct clk *ehci_clk;
+
+void __iomem *mx27_ehci_get(void)
+{
+	if (!ehci_clk)
+		ehci_clk = clk_get_sys("mxc-ehci.0", "usb");
+	if (IS_ERR(ehci_clk)) {
+		WARN_ONCE("could not get USB clock\n");
+		return NULL;
+	}
+
+	clk_enable(ehci_clk);
+
+	return MX27_IO_ADDRESS(MX27_USB_BASE_ADDR);
+}
+
+void mx27_ehci_put(void)
+{
+	clk_disable(ehci_clk);
+}
diff --git a/arch/arm/plat-mxc/include/mach/usb.h b/arch/arm/plat-mxc/include/mach/usb.h
index be27337..3c042ce 100644
--- a/arch/arm/plat-mxc/include/mach/usb.h
+++ b/arch/arm/plat-mxc/include/mach/usb.h
@@ -20,4 +20,35 @@ struct imxusb_platform_data {
 	void (*exit)(struct device *);
 };
 
+#define IMX27_USBCTRL_H1DT		(1 << 4)
+#define IMX27_USBCTRL_H2DT		(1 << 5)
+#define IMX27_USBCTRL_H1PM		(1 << 8)
+#define IMX27_USBCTRL_H1WIE		(1 << 11)
+#define IMX27_USBCTRL_H1SIC_DIFF_UNI	(0 << 13)
+#define IMX27_USBCTRL_H1SIC_DIFF_BI	(1 << 13)
+#define IMX27_USBCTRL_H1SIC_SINGLE_UNI	(2 << 13)
+#define IMX27_USBCTRL_H1SIC_SINGLE_BI	(3 << 13)
+#define IMX27_USBCTRL_H1WIR		(1 << 15)
+#define IMX27_USBCTRL_H2PM		(1 << 16)
+#define IMX27_USBCTRL_H2WIE		(1 << 19)
+#define IMX27_USBCTRL_H2UIE		(1 << 20)
+#define IMX27_USBCTRL_H2SIC_DIFF_UNI	(0 << 21)
+#define IMX27_USBCTRL_H2SIC_DIFF_BI	(1 << 21)
+#define IMX27_USBCTRL_H2SIC_SINGLE_UNI	(2 << 21)
+#define IMX27_USBCTRL_H2SIC_SINGLE_BI	(3 << 21)
+#define IMX27_USBCTRL_H2WIR		(1 << 23)
+#define IMX27_USBCTRL_OPM		(1 << 24)
+#define IMX27_USBCTRL_OWIE		(1 << 27)
+#define IMX27_USBCTRL_OUIE		(1 << 28)
+#define IMX27_USBCTRL_OSIC_DIFF_UNI	(0 << 29)
+#define IMX27_USBCTRL_OSIC_DIFF_BI	(1 << 29)
+#define IMX27_USBCTRL_OSIC_SINGLE_UNI	(2 << 29)
+#define IMX27_USBCTRL_OSIC_SINGLE_BI	(3 << 29)
+#define IMX27_USBCTRL_OWIR		(1 << 31)
+
+#define IMX27_USBCTRL			0x600
+
+void __iomem *mx27_ehci_get(void);
+void mx27_ehci_put(void);
+
 #endif /* __ASM_ARCH_MXC_USB */
diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
index fa59b26..185f86f 100644
--- a/drivers/usb/host/ehci-mxc.c
+++ b/drivers/usb/host/ehci-mxc.c
@@ -178,7 +178,7 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
 	}
 
 	/* "dr" device has its own clock */
-	if (pdev->id == 0) {
+	if (cpu_is_mx51() && pdev->id == 0) {
 		priv->phy1clk = clk_get(dev, "usb_phy1");
 		if (IS_ERR(priv->phy1clk)) {
 			ret = PTR_ERR(priv->phy1clk);
-- 
1.7.2.3

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
