From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 16 Apr 2012 14:14:14 +0000
Subject: [PATCH v2 1/3] USB: Add driver for NXP ISP1301 USB transceiver
In-Reply-To: <1334582166-5485-1-git-send-email-stigge@antcom.de>
References: <1334582166-5485-1-git-send-email-stigge@antcom.de>
Message-ID: <201204161414.14624.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 16 April 2012, Roland Stigge wrote:
> This very-lowlevel driver registers the NXP ISP1301 chip via the I2C subsystem.
> The chip is the USB transceiver shared by ohci-nxp, lpc32xx_udc (gadget) and
> isp1301_omap.
> 
> Following patches let the respective USB host and gadget drivers use this
> driver, instead of duplicating ISP1301 handling.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>

All three patches:

Acked-by: Arnd Bergmann <arnd@arndb.de>

> This driver needs to be probe()d before the respective USB driver using it. For
> modules, this is handled via the module dependency. When linking statically, it
> is done via linking order in the Makefile (misc/ before host/ and the gadget/).

You can easily avoid the link order restriction now by returning -EPROBE_DEFER
from the probe function of the device that needs this one.

> Currently, only one ISP1301 chip is supported. To support multiple instances,
> we would need a mechanism to identify the respective chips via DT (and static
> resources or platform data) to be referenced by the higher level USB driver at
> isp1301_get_client(). Any suggestions?

Put a phandle into the usb device node, like:

       isp1301: usb-transceiver at 23 {
		compatible = "nxp,isp1301";
		reg = <23>;
	};

       usbd at 31020000 {
               compatible = "nxp,lpc32xx-udc";
               reg = <0x31020000 0x300>;
               interrupt-parent = <&mic>;
               interrupts = <0x3d 0>, <0x3e 0>, <0x3c 0>, <0x3a 0>;
	       transceiver = <&isp1301>;
               status = "disable";
       };

Then add a device_node argument to the isp1301_get_client() function
and change the function to use bus_find_device() with a match function
that compares the driver pointer.

Alternatively (and much more complex), you could add a generic usb-transceiver
abstraction that does this and also hides the register accesses behind
hardware independent function calls.

	Arnd
