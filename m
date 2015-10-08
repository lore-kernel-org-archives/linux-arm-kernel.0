From: Peter.Chen@freescale.com (Peter Chen)
Date: Thu, 8 Oct 2015 09:52:52 +0000
Subject: Regression: USB OTG port breaks after a few hours in host mode on
 iMX6
In-Reply-To: <20151008044412.GA8169@shlinux2>
References: <20151007082222.GB21513@n2100.arm.linux.org.uk>
 <20151008044412.GA8169@shlinux2>
Message-ID: <BN3PR0301MB0849F94B72B10051ABE9CCA581350@BN3PR0301MB0849.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> On Wed, Oct 07, 2015 at 09:22:22AM +0100, Russell King - ARM Linux wrote:
> > This bug is soo obscure, I'm not even sure how to start debugging it.
> > This never used to be a problem, but I'm not sure when it started as
> > USB (in general) is not something I use regularly.
> >
> > In this setup, the USB OTG port is wired in host mode via pinmix
> > configuration of the USB OTG ID pin:
> >
> > 	MX6QDL_PAD_GPIO_1__USB_OTG_ID 0x13059
> >
> 
> If the port has only host function, you can set dr_mode = "host" at dts, it will
> configure this port for host only, and ignore id interrupt.
> 
> > The problem characterised so far: after booting the kernel, USB seems
> > to work fine.  You can plug and unplug devices from both USB host and
> > USB OTG ports, and it's detected.
> >
> > If you boot a kernel with nothing plugged in, leave it for maybe four
> > hours, then plug in a device to either port, the device will be seen
> > in the USB host port, but completely ignored in the USB OTG port.
> > Both USB OTG ports have power, confirmed last night when using a USB
> > microscope with built-in LED lighting: the LEDs are functional, the
> > device is otherwise completely ignored.
> 
> Does interrupt occur after plugging in? If not, it means wake-on-connect does
> not wake up otg port. Else, the USB PHY may not be recovered well after
> suspend.
> 
> >
> > The above is basically what I know so far: I don't know when the port
> > fails, whether in the case of "boot, wait four hours, and it's dead"
> > whether it's dead from boot: when I've tried testing it immediately
> > after boot, it's worked.
> >
> > As it takes around four hours to reproduce, and I have a massive patch
> > stack on top of the kernel for this platform, I'm unwilling to attempt
> > a git bisection to try and find when this occurred, but I know it's
> > been going on for a while now as I've noticed the same behaviour when
> > I transfer my logitech USB receiver to that port.
> >
> > I had thought it was a power issue, but the USB camera last night
> > confirmed that it's a port driver issue.
> 
> I am testing it with two boards to see if it can be reproduced.
 
I can't reproduce it for 5 hours, and will change pinmux (do the same thing with your platform),
and do the overnight test.

Peter
