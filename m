From: Dave.Ebright@parsons.com (Ebright, Dave)
Date: Wed, 26 Mar 2014 14:07:37 +0000
Subject: [PATCH 1/2] ARM: dts: imx51-babbage: Add USB Host1 support
In-Reply-To: <26dd7d7d9b5f481588848b0fdd65fbbb@BL2PR03MB226.namprd03.prod.outlook.com>
References: <1395750922-3244-1-git-send-email-festevam@gmail.com>
 <07405bf6fc4841d5b0d22c07c582acb9@BL2PR03MB226.namprd03.prod.outlook.com>
 <CAOMZO5Da9poOv8KqCsSxnjs4eZkVbRPCmnJCj-OX3ps8=+y+Ww@mail.gmail.com>
 <26dd7d7d9b5f481588848b0fdd65fbbb@BL2PR03MB226.namprd03.prod.outlook.com>
Message-ID: <2DF5040C00EDCD438915E297DC199E925263C860@HSV-MB002.huntsville.ads.sparta.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter,

Yes for the i.MX51 EVK the USB host 1 has an external PHY (USB3317 HS ULPI USB transceiver) which has an integrated 3.3V regulator.  It is used in host only mode.  In the older versions (pre device tree) of the code, the isp1504 driver was used for the USB3317.  For the device tree in the usbphy1 node it is defined as usb-nop-xceiv, but in the usbh1 node phy_type is ulpi.  The reason the usb-nop-xceiv was used is because we could not find any other specific "compatible" value in the PHY drivers for the USB3317 external PHY (HS ULPI USB transceiver) for the USB host 1 port, thus using the generic driver.  Could not find an isp1504 or USB3317 driver.  Again it is a host only port and thus the generic phy driver is working at least on the i.MX51 EVK.  The hub attached to the host port comes up and have successfully attached several types of USB devices to the two ports on the attached hub.

The phy_type of ulpi is needed by the ChipIdea drivers for PHY initialization.  So it is using ulpi PHY init.

I looked for all references to ulpi_viewport_access_ops and did find that imx_otg_ulpi_create() references it, but this function is not called from any i.MX51 code (does not use ulpi viewport).  For the i.MX51 the external PHY/transceiver is not used for OTG, it is only used as a host port.

Dave 

-----Original Message-----
From: Peter Chen [mailto:Peter.Chen at freescale.com] 
Sent: Wednesday, March 26, 2014 1:36 AM
To: Fabio Estevam
Cc: Shawn Guo; linux-arm-kernel at lists.infradead.org; Fabio.Estevam at freescale.com; Ebright, Dave
Subject: RE: [PATCH 1/2] ARM: dts: imx51-babbage: Add USB Host1 support


 
> 
> On Tue, Mar 25, 2014 at 11:00 PM, Peter Chen 
> <Peter.Chen@freescale.com>
> wrote:
> 
> >> +
> >> +             usbphy1: usbphy at 1 {
> >> +                     compatible = "usb-nop-xceiv";
> >> +                     reg = <1>;
> >> +                     clocks = <&clks IMX5_CLK_USB_PHY_GATE>;
> >> +                     clock-names = "main_clk";
> >> +             };
> >>       };
> >>
> >
> > You are using usb nop phy driver (phy-generic.c) for ulpi phy, Are 
> > you sure your phy doesn't need any configurations from viewport?
> 
> I am not sure I understood your comment.
> 
> This node is the same like we do on mx53 and other i.mx SoCs.
> 

For imx53, it can work since both usbotg and host 1 use utmi internal phy.
But for SoCs before than imx53 (including imx51), the host1 uses external phy. At non-dt version, they should use ulpi phy driver.

Peter

> Both USB host and OTG are functional.
> 
> Could you please explain your concern?
> 
> Regards,
> 
> Fabio Estevam
> 
