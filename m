From: mzoran@crowfest.net (Michael Zoran)
Date: Tue, 01 Nov 2016 01:26:04 -0700
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
Message-ID: <1477988764.6288.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2016-10-31 at 21:34 +0100, Stefan Wahren wrote:
> I inspired by this issue [1] i build up a slightly modified setup
> with a
> Raspberry Pi B (mainline kernel 4.9rc3), a powered 7 port USB hub and
> 5 Prolific
> PL2303 USB to serial convertors. I modified the usb_test for dwc2
> [2], which
> only tries to open all ttyUSB devices one after the other.?
> 
> Unfortunately the complete system stuck after opening the first
> ttyUSB device (
> heartbeat LED stop blinking, no reaction to debug UART). The only way
> to
> reanimate the system is to powerdown the USB hub with the USB to
> serial
> convertors.
> 
> [1] - https://github.com/raspberrypi/linux/issues/1692
> [2] - https://gist.github.com/lategoodbye/dd0d30af27b6f101b03d5923b27
> 9dbaa
> 
> pi at raspberrypi:~$ lsusb -t
> /:??Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> ????|__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/3p, 480M
> ????????|__ Port 1: Dev 3, If 0, Class=Vendor Specific Class,
> Driver=smsc95xx,
> 480M
> ????????|__ Port 2: Dev 11, If 0, Class=Hub, Driver=hub/4p, 480M
> ????????????|__ Port 3: Dev 15, If 0, Class=Vendor Specific Class,
> Driver=pl2303, 12M
> ????????????|__ Port 1: Dev 12, If 0, Class=Hub, Driver=hub/4p, 480M
> ????????????????|__ Port 2: Dev 14, If 0, Class=Vendor Specific
> Class,
> Driver=pl2303, 12M
> ????????????????|__ Port 3: Dev 16, If 0, Class=Vendor Specific
> Class,
> Driver=pl2303, 12M
> ????????????|__ Port 4: Dev 17, If 0, Class=Vendor Specific Class,
> Driver=pl2303, 12M
> ????????????|__ Port 2: Dev 13, If 0, Class=Vendor Specific Class,
> Driver=pl2303, 12M
> 

Since I didn't see a response, I'll go ahead and add my two cents. 
Hopefully nobody minds me chiming in here.

I see these kinds of issues with USB on the RPI all the time. 
Typically, it's just the USB that breaks down not a hang in the CPU.

The issue is that I think the USB controller in the RPI chipset was
designed for the cellphone/set top box market.  In those markets, the
USB port is only used to connect to one device at a time.  For example,
with a cell phone you might connect it to a PC to transfer data.  On a
set top box, you might plug in a USB flash drive with video to play.

The RPI doesn't have a proper USB controller like you find in a PC. 
Instead it has a fixed number of hardware slots(I think the number is
between 5-7) that are used for pending transfers. Once the slots are
full, very little can be done.  And because USB 2.0 is based on
polling, the connected USB devices are constantly polled even if
nothing is happening.

The DWC_OTG driver works a bit better even though it's not perfect. 
That driver makes an attempt to schedule USB activity and send it to
the hardware a bit at a time just like a PC USB controller does. 
Unfortunatly, to get the precision required on some of the lower end
RPIs, it's necessary to use FIQ which is somewhat outside the Linux
driver model.

Although I don't completely agree that FIQ is necessary on the high end
RPIs with multiple cores.   In fact, I have a few local modifications
to the interrupt controller driver to round robin dispatch IRQs between
core to get more concurrency at the expense of more CPU cache misses. I
think this reduces the need for FIQ, but some other disagree...

  
