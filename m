From: hzpeterchen@gmail.com (Peter Chen)
Date: Wed, 24 Feb 2016 17:22:52 +0800
Subject: [PATCH v2 0/3] USB: add generic onboard USB HUB driver
In-Reply-To: <CAL_Jsq+rqv1NBSUToX5BsbnBp_goUWhdczU7ETSxOrJ5D4D1rw@mail.gmail.com>
References: <CAL411-rK6qfkbQsSjvXH5VPAQAm4tMyD6fVTEgFQrpLHNGMXeA@mail.gmail.com>
 <Pine.LNX.4.44L0.1512181030590.1682-100000@iolanthe.rowland.org>
 <CAL411-qKE=12VZAN9=tUWPqkC5BfSgpQb9aNgCU6rmPLasXNHQ@mail.gmail.com>
 <CAL_Jsq+P8SBmWzNURrmNgz8soCn4QPOPid4SXF0a3TYL_SH27A@mail.gmail.com>
 <20160106032027.GA23726@shlinux2>
 <CAL_Jsq+rqv1NBSUToX5BsbnBp_goUWhdczU7ETSxOrJ5D4D1rw@mail.gmail.com>
Message-ID: <20160224092252.GA9297@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 07, 2016 at 08:18:02AM -0600, Rob Herring wrote:
> On Tue, Jan 5, 2016 at 9:20 PM, Peter Chen <hzpeterchen@gmail.com> wrote:
> > On Tue, Jan 05, 2016 at 08:36:31AM -0600, Rob Herring wrote:
> >> > 2. There are MFD USB devices, which includes several interfaces under
> >> > USB device,
> >> > like i2c, gpios, etc. Due to lack of device tree support, USB
> >> > class/device driver doesn't know
> >> > which kinds of interfaces are needed for this board.
> >>
> >> Are you talking about a device hard wired on the same board or
> >> something like GPIOs on FTDI chip which could be hot-plugged in any
> >> host (including non-DT based)?
> >
> > I talked about the case that the device hard wired on the board.
> > Hot-plug device's bus topology is unknown, we can't describe it
> > statically at dts.
> 
> Correct, upstream (the USB side) can't be described, but it is the
> downstream side we care about describing.
> 
> >> For the hotplug case, we will need a way to associate a DT overlay
> >> with the USB device and there may not even be a base DT to map the
> >> overlay into. In this case, the USB device's driver will need to load
> >> the overlay and trigger enumerating the child devices. Anyway, this is
> >> a separate issue from your problem.
> >>
> >
> > Since both you and Alan agree with my problem should be fixed at
> > bootloader, I give the kernel solution up.
> 
> Surprising, no one ever seems to agree with that solution... There
> will be people with this problem and unable to update their
> bootloader.
> 

Hi Rob, I noticed there are still some platform needs to this solution,
I would like to see if I can move this on, please review below dts
solution. In below case, there are two ports on the root hub, one is
USB HUB, the another is a USB wifi. Both of these devices need to have
power control before they can work.

At USB hcd driver, it will try to look-up all USB devices on this
controller, if the usb-pwr-ops is existed, it will try to get its
phandle, and do gpio and clock operations.

Optional properties:
- usb-pwr-ops: the power operations which need to do before this USB device
  can work.

Example:

/ {
	...

	hub_genesys_1_pwr_ops: hub_genesys_1_pwr_ops {
		compatible = "usb-pwrseq-simple";
		reset-gpios = <&gpio4 5 GPIO_ACTIVE_LOW>; /* hub reset pin */
		reset-duration-us = <10>;
		clocks = <&clks IMX6QDL_CLK_CKO>;
	};

	wifi_nxp_2_pwr_ops: wifi_nxp_2_pwr_ops {
		compatible = "usb-pwrseq-simple";
		reset-gpios = <&gpio4 6 GPIO_ACTIVE_LOW>, /* wifi_rst */
				<&gpio4 7 GPIO_ACTIVE_LOW>; /* wifi_en */
		reset-duration-us = <10>;
		clocks = <&clks IMX6QDL_CLK_CKO1>;
	};

	...
};

&usb1 {
	status = "okay";

	#address-cells = <1>;
	#size-cells = <0>;

	hub: genesys at 1 {
		compatible = "usb5e3,608";
		reg = <1>;
		usb-pwr-ops = <&hub_genesys_1_pwr_ops>
	};

	wifi: nxp at 2 {
		compatible = "usb5e3,608";
		reg = <2>;
		usb-pwr-ops = <&wifi_nxp_2_pwr_ops>
	};
}

-- 

Best Regards,
Peter Chen
