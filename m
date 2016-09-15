From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 15 Sep 2016 17:01:58 +0800
Subject: [RFC/PATCH] usb: misc: Add a driver for TC7USB40MU
In-Reply-To: <147384270449.13546.495288874027868435@sboyd-linaro>
References: <20160914014246.31847-1-stephen.boyd@linaro.org>
 <20160914033200.GE30760@b29397-desktop>
 <147383270635.1464.10706917860873291816@sboyd-linaro>
 <20160914080321.GA21674@b29397-desktop>
 <147384270449.13546.495288874027868435@sboyd-linaro>
Message-ID: <20160915090158.GB6919@b29397-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 01:45:04AM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-09-14 01:03:21)
> > On Tue, Sep 13, 2016 at 10:58:26PM -0700, Stephen Boyd wrote:
> > > Quoting Peter Chen (2016-09-13 20:32:00)
> > > > On Tue, Sep 13, 2016 at 06:42:46PM -0700, Stephen Boyd wrote:
> > > > > On the db410c 96boards platform we have a TC7USB40MU[1] on the
> > > > > board to mux the D+/D- lines from the SoC between a micro usb
> > > > > "device" port and a USB hub for "host" roles. Upon a role switch,
> > > > > we need to change this mux to forward the D+/D- lines to either
> > > > > the port or the hub. Therefore, introduce a driver for this
> > > > > device that intercepts extcon USB_HOST events and logically
> > > > > asserts a gpio to mux the "host" D+/D- lines when a host cable is
> > > > > attached. When the cable goes away, it will logically deassert
> > > > > the gpio and mux the "device" lines.
> > > > 
> > > > Would you please draw the design? It can also help me review your
> > > > chipidea patch well.
> > > > 
> > > > 1. How many ports on the board?
> > > > 2. How the lines are connected on the board?
> > > > 
> > > 
> > > The schematic for the db410c is publically available here[2][3].
> > > 
> > > There's also the 96boards spec[4] which talks about this switch based
> > > design a little bit. See the section titled "Single USB port Example".
> > > 
> > > [2] https://github.com/96boards/documentation/blob/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf
> > > [3] https://github.com/96boards/documentation/raw/master/ConsumerEdition/DragonBoard-410c/HardwareDocs/Schematics_DragonBoard.pdf
> > > [4] https://www.96boards.org/wp-content/uploads/2015/02/96BoardsCESpecificationv1.0-EA1.pdf
> > 
> > Ok, I see several use cases for this role switch
> > 
> > 1. Using the hardware switch (218-4LPST)
> > In this case, you can set USB_SW_SEL as input gpio, and use
> > extcon-usb-gpio.c like before, just set this gpio as active
> > low at dts.
> 
> Nice! I didn't think of this case but it's good that we can support
> that with some work.
> 

After looking more, I find the main purpose of this switch is
what it writes, FORCE DSI SELECTION TO USB HOST MODE

When the switch is on, the system is host-only.
When the switch is off, the default role is device mode, and
switch the role through gpio USB_SW_SEL_PM by software.

> > 
> > 2. Using USB_HS_ID as vbus-gpio (input), and USB_SW_SEL as id-gpio (output)
> 
> This is pretty much what has been implemented. USB_HS_ID is an
> extcon-usb-gpio.c device.

At some designs, this gpio is tied to ID pin at MicroB connector, and
using a Mirco-AB cable to switch the role.

> 
> > I can't find hardware relationship between each other, maybe I miss
> > something.
> 
> I believe USB_SW_SEL is the physical switch (218-4LPST) while
> USB_SW_SEL_PM is the software controllable part using a GPIO. USB_HS_ID
> is just the vbus line from the uB connector and that line goes straight
> into the SoC via a GPIO.
> 
> > This use case (design) seems strange, usually, we use ID pin controls
> > vbus, but seldom use vbus pin control ID.
> > How you would like to implement it? When the USB cable is connected
> > (between PC), it receives vbus-gpio interrupt, then you set USB_SW_SEL
> > as low? If disconnected, you set USB_SW_SEL as high?
> 
> Right. The documented behavior is to detect the micro-usb cable and
> drive USB_SW_SEL low. When the cable is unplugged we drive USB_SW_SEL
> high. Maybe that should be changed though? If we always sampled
> USB_SW_SEL as a USB_HOST extcon and the vbus line as a USB extcon then
> we could allow the user to decide either with the physical switch or
> with some sort of software control to toggle that gpio.
> 
> > When the USB controller works at Host mode, what will happen if the user
> > connects USB cable at device port?
> 
> The devices on the two type-A connectors will be disconnected and we'll
> switch from host mode to device mode.
> 
> > 
> > 3. Using sysfs to switch the role
> > Set USB_SW_SEL according to "role" at debugfs
> 
> sysfs isn't debugfs, but yes I wonder if we need to worry about the
> debugfs role switching support here and toggle the gpio manually without
> involving extcon. That would mean we need to have a way for the chipidea
> controller to toggle this gpio/mux itself.
> 
> > 
> > Which one you would like to implement? Or anything else I miss?
> > 
> 
> Mostly #2, but I'm concerned that the DT binding is going to force that
> decision on others who may have the same switch and want to do #1 or #3.
> So how to design it in a way that makes it work in all cases? Also, what
> to do if the USB_SW_SEL switch is driven high by the physical switch?
> That will "override" any software control we might be able to use, so
> hopefully we can detect this somehow and prevent the role switch from
> happening.

>From my point, the physical switch is only used to force host mode. The
#1 and #2 can't be supported at the same time. For #3, it is not the
use case for this design. #3 is usually used for the single port which
needs to support switching role on the fly without disconnection.
So, you may only need to consider #2, you can't use extcon-usb-gpio.c
directly since you need to set one gpio to mux the dp/dm, Baolu Lu had
USB MUX patch set before which may satisfy your requirement. [1]

[1] https://lkml.org/lkml/2016/5/30/36

-- 

Best Regards,
Peter Chen
