From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 10 Mar 2015 19:17:02 +0100
Subject: [PATCH 12/15] ARM: dts: sun4i: Enable USB DRC on Chuwi V7 CW0825
In-Reply-To: <54FF0C5D.3090706@redhat.com>
References: <1425933628-9672-1-git-send-email-hdegoede@redhat.com>
 <1425933628-9672-13-git-send-email-hdegoede@redhat.com>
 <20150310150741.GW5085@lukather> <54FF0C5D.3090706@redhat.com>
Message-ID: <20150310181702.GY5085@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 04:23:09PM +0100, Hans de Goede wrote:
> Hi,
> 
> On 03/10/2015 04:07 PM, Maxime Ripard wrote:
> >Hi Hans,
> >
> >On Mon, Mar 09, 2015 at 09:40:25PM +0100, Hans de Goede wrote:
> >>Enable the otg/drc usb controller on the Chuwi V7 CW0825 tablet.
> >>
> >>Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >>---
> >>  arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts | 31 +++++++++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>
> >>diff --git a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> >>index 97fca89..034396c 100644
> >>--- a/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> >>+++ b/arch/arm/boot/dts/sun4i-a10-chuwi-v7-cw0825.dts
> >>@@ -111,6 +111,26 @@
> >>  	status = "okay";
> >>  };
> >>
> >>+&pio {
> >>+	usb0_id_detect_pin: usb0_id_detect_pin at 0 {
> >>+		allwinner,pins = "PH4";
> >>+		allwinner,function = "gpio_in";
> >>+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >>+		allwinner,pull = <SUN4I_PINCTRL_PULL_UP>;
> >>+	};
> >>+
> >>+	usb0_vbus_detect_pin: usb0_vbus_detect_pin at 0 {
> >>+		allwinner,pins = "PH5";
> >>+		allwinner,function = "gpio_in";
> >>+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
> >>+		allwinner,pull = <SUN4I_PINCTRL_PULL_DOWN>;
> >>+	};
> >>+};
> >>+
> >>+&reg_usb0_vbus {
> >>+	status = "okay";
> >>+};
> >>+
> >>  &reg_usb2_vbus {
> >>  	status = "okay";
> >>  };
> >>@@ -121,7 +141,18 @@
> >>  	status = "okay";
> >>  };
> >>
> >>+&usb_otg {
> >>+	pinctrl-names = "default";
> >>+	pinctrl-0 = <&usb0_id_detect_pin
> >>+		     &usb0_vbus_detect_pin>;
> >>+	id_det-gpio = <&pio 7 4 GPIO_ACTIVE_HIGH>; /* PH4 */
> >>+	vbus_det-gpio = <&pio 7 5 GPIO_ACTIVE_HIGH>; /* PH5 */
> >>+	dr_mode = "otg";
> >
> >Is there a reason to not put that in the DTSI?
> 
> This is not in the dtsi because it is board specific.
> 
> >All the users seem to be wiring it as OTG.
> 
> Sofar I've only enabled the otg on a handful of boards,
> the otg on the Mele-M9 for example is connected to a usb->sata
> bridge and as such should be brought up in host only mode.
> 
> And on the wobo-i5 (which I still need to create a dts file for)
> the otg is connected to an usb wifi module.

Ok, that seems like a good reason :)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150310/3b9a10ef/attachment.sig>
