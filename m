From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Sat, 11 Jan 2014 13:59:45 +0100
Subject: [PATCH 1/2] usb: chipidea: usbmisc: Add support for
 i.MX27/i.MX31 CPUs
In-Reply-To: <528074C2.9070707@gtsys.com.hk>
References: <1384067901-9377-1-git-send-email-shc_work@mail.ru>
 <1384145140.400290349@f353.i.mail.ru>
 <52806C24.8040100@gtsys.com.hk>
 <1384148852.19743495@f117.i.mail.ru>
 <528074C2.9070707@gtsys.com.hk>
Message-ID: <20140111125945.GB24479@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 11, 2013 at 02:10:10PM +0800, Chris Ruehl wrote:
> On Monday, November 11, 2013 01:47 PM, Alexander Shiyan wrote:
> >>On Monday, November 11, 2013 12:45 PM, Alexander Shiyan wrote:
> >>>>Hi Alexander,
> >>>>
> >>>>On Sunday, November 10, 2013 03:18 PM, Alexander Shiyan wrote:
> >>>>>This adds i.MX27 and i.MX31 as the next user of the usbmisc driver.
> >>>>>
> >>>>>Signed-off-by: Alexander Shiyan<shc_work@mail.ru>
> >>>>>---
> >>>>>    drivers/usb/chipidea/usbmisc_imx.c | 42 ++++++++++++++++++++++++++++++++++++++
> >>>>>    1 file changed, 42 insertions(+)
> >>>>>
> >>>>>diff --git a/drivers/usb/chipidea/usbmisc_imx.c b/drivers/usb/chipidea/usbmisc_imx.c
> >>>...
> >>>>>+static int usbmisc_imx27_init(struct imx_usbmisc_data *data)
> >>>>>+{
> >>>>>+	unsigned long flags;
> >>>>>+	u32 val;
> >>>>>+
> >>>>>+	switch (data->index) {
> >>>>>+	case 0:
> >>>>>+		val = MX27_OTG_PM_BIT;
> >>>>>+		break;
> >>>>>+	case 1:
> >>>>>+		val = MX27_H1_PM_BIT;
> >>>>>+		break;
> >>>>>+	case 2:
> >>>>>+		val = MX27_H2_PM_BIT;
> >>>>>+		break;
> >>>>>+	default:
> >>>>>+		return -EINVAL;
> >>>>>+	};
> >>>>>+
> >>>>
> >>>>     From my understanding this can not work, the usbmisc->base not point into the
> >>>>usb control register (USB_CTRL). Reference manual 30.5.1.1 says
> >>>>BASE + 0x600
> >>>>you must add the offset to the readl instruction.
> >>>
> >>>Why not work?
> >>>usbotg: usb at 10024000
> >>>usbh1: usb at 10024200
> >>>usbh2: usb at 10024400
> >>>usbmisc: usbmisc at 10024600
> >>>So, offset to USB_CTRL should already be defined by DTS.
> >>
> >>in the usbmisc_imx_probe() the base pointer is loaded from
> >>
> >>res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >>data->base = devm_ioremap_resource(&pdev->dev, res);
> >>
> >>(and I did not see any of_ operations)
> >
> >Yes, and this is an address of usbmisc node, not otg.
> 
> Sorry, you are right. I misunderstood because I didn't see any of
> sample DTS files define usbmisc yet.
> 
> At this point might be good to patch the imx27.dtsi with the usb defines.
> 
> --- a/arch/arm/boot/dts/imx27.dtsi
> +++ b/arch/arm/boot/dts/imx27.dtsi
> @@ -30,6 +30,9 @@
>                 spi0 = &cspi1;
>                 spi1 = &cspi2;
>                 spi2 = &cspi3;
> +               usb0 = &usbotg;
> +               usb1 = &usbh1;
> +               usb2 = &usbh2;
>         };
> 
> @@ -404,6 +419,44 @@
>                                 iram = <&iram>;
>                         };
> 
> +                       usbotg: usb at 10024000 {
> +                               compatible = "fsl,imx27-usb";
> +                               reg = <0x10024000 0x200>;
> +                               interrupts = <56>;
> +                               clocks = <&clks 75>, <&clks 62>;
> +                               clock-names = "ipg", "ahb";
> +                               dr_mode = "host";
> +                               phy_type = "ulpi";
> +                               status = "disabled";
> +                       };
> +
> +                       usbh1: usb at 10024200 {
> +                               compatible = "fsl,imx27-usb";
> +                               reg = <0x10024200 0x200>;
> +                               interrupts = <54>;
> +                               clocks = <&clks 75>, <&clks 62>;
> +                               clock-names = "ipg", "ahb";
> +                               dr_mode = "host";
> +                               phy_type = "serial";
> +                               status = "disabled";
> +                       };
> +
> +                       usbh2: usb at 10024400 {
> +                               compatible = "fsl,imx27-usb";
> +                               reg = <0x10024400 0x200>;
> +                               interrupts = <55>;
> +                               clocks = <&clks 75>, <&clks 62>;
> +                               clock-names = "ipg", "ahb";
> +                               dr_mode = "host";
> +                               phy_type = "ulpi";
> +                               status = "disabled";
> +                       };
> +
> +                       usbmisc: usbmisc at 10024600 {
> +                               compatible = "fsl,imx27-usb";
> +                               reg = <0x10024600 0x4>;
> +                       };
I didn't try to get this up yet, but I wonder if the last compatible
here should better be fsl,imx27-usbmisc?!

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
