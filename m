From: peter.chen@freescale.com (Peter Chen)
Date: Thu, 17 Dec 2015 10:31:19 +0800
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <1827708.e1pfN6rEID@wuerfel>
References: <1450077974-22762-1-git-send-email-peter.chen@freescale.com>
 <3023844.AYbAYqvHUZ@wuerfel>
 <CAL_Jsq+KAF6FGyOyC0JzODsSVoK4+V6umpj=cANywgui_wOKMg@mail.gmail.com>
 <1827708.e1pfN6rEID@wuerfel>
Message-ID: <20151217023118.GA3793@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 12:13:07AM +0100, Arnd Bergmann wrote:
> On Wednesday 16 December 2015 16:59:39 Rob Herring wrote:
> > On Mon, Dec 14, 2015 at 3:35 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > > On Monday 14 December 2015 15:26:11 Peter Chen wrote:
> >
> > I agree on doing it properly, but am not sure that pwrseq binding for
> > MMC is proper. The pwrseq binding is fairly limited and working around
> > the driver model IMO. Hubs may also need I2C setup which I don't think
> > could be done generically other than some defined sequence of i2c
> > transactions. The current project I'm working on needs to use I2C to
> > configure the hub to use HSIC mode for example. I really think we need
> > a pre-probe driver hook to handle this. That would allow device
> > specific setup to live in the driver.
> > 
> > Perhaps a more simple approach would be just forcing driver probe if a
> > DT node is present. I'm not all that familiar with USB drivers, but
> > presumably there is some setup before probe like setting the USB
> > device address. We'd have to allow doing that later during probe.
> 
> Yes, good idea. I was also advocating that approach for MMC at some
> point, but the power sequencing made it in the end.
> 

Currently, my design is much like Rob proposal's. I will populate all
children device under HUB's node (controller = 1st level hub), and
each special onboard USB device needs a platform driver, it can be
probed according to compatible string, and at its probe, it can register
itself as usb device if needed, and handle properties described at
its node. Sample code like below:

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 8263fc1..7451f7d 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -590,6 +590,16 @@
 &usbh1 {
 	vbus-supply = <&reg_usb_h1_vbus>;
 	status = "okay";
+
+	#address-cells = <1>;
+	#size-cells = <0>;
+	hub: usb2415 at 01 {
+		compatible = "generic-onboard-hub";
+		reg = <0x01>;
+		clocks = <&clks IMX6QDL_CLK_CKO>;
+		reset-gpios = <&gpio7 12 GPIO_ACTIVE_LOW>;
+		reset-duration-us = <10>;
+	};
 };

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 5e32ce7..2107b12 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/random.h>
 #include <linux/pm_qos.h>
+#include <linux/of_platform.h>
 
 #include <asm/uaccess.h>
 #include <asm/byteorder.h>
@@ -1334,6 +1335,20 @@ static int hub_post_reset(struct usb_interface *intf)
 	return 0;
 }
 
+static int hub_of_children_register(struct usb_device *hdev)
+{
+	struct device *dev;
+
+	if (hdev->parent)
+		dev = &hdev->dev;
+	else
+		dev = bus_to_hcd(hdev->bus)->self.controller;
+	if (!dev->of_node)
+		return 0;
+
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
+}
+
 static int hub_configure(struct usb_hub *hub,
 	struct usb_endpoint_descriptor *endpoint)
 {
@@ -1701,6 +1716,7 @@ static int hub_probe(struct usb_interface *intf, const struct usb_device_id *id)
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_device *hdev;
 	struct usb_hub *hub;
+	int ret;
 
 	desc = intf->cur_altsetting;
 	hdev = interface_to_usbdev(intf);
@@ -1820,6 +1836,12 @@ descriptor_error:
 	if (id->driver_info & HUB_QUIRK_CHECK_PORT_AUTOSUSPEND)
 		hub->quirk_check_port_auto_suspend = 1;
 
+	ret = hub_of_children_register(hdev);
+	if (ret) {
+		dev_err(&hdev->dev, "Failed to register child device\n");
+		return ret;
+	}
+
 	if (hub_configure(hub, endpoint) >= 0)
 		return 0;

At onboard general usb hub driver:

static const struct of_device_id usb_hub_generic_dt_ids[] = {
	{.compatible = "generic-onboard-hub"},
	{ },
};
MODULE_DEVICE_TABLE(of, usb_hub_generic_dt_ids);

static struct platform_driver usb_hub_generic_driver = {
	.probe = usb_hub_generic_probe,
	.remove = usb_hub_generic_remove,
	.driver = {
		.name = "usb_hub_generic_onboard",
		.of_match_table = usb_hub_generic_dt_ids,
	 },
};

static int __init usb_hub_generic_init(void)
{
	return platform_driver_register(&usb_hub_generic_driver);
}
subsys_initcall(usb_hub_generic_init);

static void __exit usb_hub_generic_exit(void)
{
	platform_driver_unregister(&usb_hub_generic_driver);
}
module_exit(usb_hub_generic_exit);

-- 

Best Regards,
Peter Chen
