From: dtor@google.com (Dmitry Torokhov)
Date: Thu, 26 Mar 2015 16:02:17 -0700
Subject: [PATCH v1 2/3] Phy: DT binding documentation for Broadcom Cygnus
 USB PHY driver
In-Reply-To: <55134D29.80708@broadcom.com>
References: <1426886727-537-1-git-send-email-arun.ramamurthy@broadcom.com>
 <1426886727-537-3-git-send-email-arun.ramamurthy@broadcom.com>
 <551333DA.6080700@ti.com> <55134D29.80708@broadcom.com>
Message-ID: <20150326230217.GA18887@dtor-ws>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arun,

On Wed, Mar 25, 2015 at 05:04:57PM -0700, Arun Ramamurthy wrote:
> 
> 
> On 15-03-25 03:16 PM, Kishon Vijay Abraham I wrote:
> >Hi,
> >
> >On Saturday 21 March 2015 02:55 AM, Arun Ramamurthy wrote:
> >>Broadcom's Cygnus chip has a USB 2.0 host controller connected to
> >>three separate phys. One of the phs (port 2) is also connectd to
> >>a usb 2.0 device controller
> >>
> >>Reviewed-by: Ray Jui <rjui@broadcom.com>
> >>Reviewed-by: Scott Branden <sbranden@broadcom.com>
> >>Signed-off-by: Arun Ramamurthy <arun.ramamurthy@broadcom.com>
> >>
> >>---
> >>  .../bindings/phy/brcm,cygnus-usb-phy.txt           | 65 ++++++++++++++++++++++
> >>  1 file changed, 65 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
> >>
> >>diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
> >>new file mode 100644
> >>index 0000000..002bd59
> >>--- /dev/null
> >>+++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-usb-phy.txt
> >>@@ -0,0 +1,65 @@
> >>+BROADCOM CYGNUS USB PHY
> >>+
> >>+Required Properties:
> >>+	- compatible:  brcm,cygnus-usb-phy
> >>+	- reg : usbphy_regs - Base address of phy registers
> >>+			usb2h_idm_regs - Base address of host idm registers
> >>+			usb2d_idm_regs - Base address of device idm registers
> >
> >where is #phy-cells documented?
> I dont follow, isnt phy-cells a standard binding, what documentation
> is required?
> >>+The node that uses the phy must provide one integers, 0 for device and 1 for host
> >

"The node that uses phy must specify whether it should be configured as
host or device in the second cell of phy specification."

By the way, can we use not integers but symbolic constants for host and
device mode?

> >>+
> >>+NOTE: port 0 and port 1 are host only and port 2 can be configured for host or device.
> >>+
> >>+Example of phy :
> >>+	usbphy0: usbphy at 0x0301c000 {
> >>+		compatible = "brcm,cygnus-usb-phy";
> >>+		reg = <0x0301c000 0x2000>,
> >>+		      <0x18115000 0x1000>,
> >>+		      <0x18111000 0x1000>;
> >>+		status = "okay";
> >>+
> >>+		#address-cells = <1>;
> >>+		#size-cells = <0>;
> >>+		usbphy0_0: usbphy0 at 0 {
> >>+			#phy-cells = <1>;
> >>+			reg = <0>;
> >>+			status = "okay";
> >>+			phy-supply = <&vbus_p0>;
> >>+		};
> >>+
> >>+		usbphy0_1: usbphy0 at 1 {
> >>+			#phy-cells = <1>;
> >>+			reg = <1>;
> >>+			status = "okay";
> >>+		};
> >>+
> >>+		usbphy0_2: usbphy0 at 2 {
> >>+			#phy-cells = <1>;
> >>+			reg = <2>;
> >>+			status = "okay";
> >>+			phy-supply = <&vbus_p2>;
> >>+		};
> >>+	};
> >>+
> >>+Example of node using the phy:
> >>+
> >>+	/* This nodes declares all three ports as host */
> >>+	
> >>+	ehci0: usb at 0x18048000 {
> >>+		compatible = "generic-ehci";
> >>+		reg = <0x18048000 0x100>;
> >>+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
> >>+		phys = <&usbphy0_0 1 &usbphy0_1 1 &usbphy0_2 1>;
> >>+		phy-names = "usb","usb","usb";
> >
> >is it on purpose you use the same name for phy-names? it is wrong though.
> Kishon, I did use the same names on purpose. The phy-names are
> actually irrelevant because I used the new api I created
> devm_of_phy_get_by_index. I actually wasnt sure if  should take out
> the phy-name field altogether or leave it as phy-names = "usb" for
> compatibility with other bindings.

There is no issue of compatibility as existing mappings would only use 1
phy and we'll pick it up when getting phy by index. I think we should
simply drop phy-names altogether as driver does not use this property
anymore.

Thanks.

-- 
Dmitry
