From: Peter.Chen@freescale.com (Peter Chen)
Date: Tue, 13 May 2014 02:40:09 +0000
Subject: i.MX6 USB OTG support is broken on linux-next
In-Reply-To: <20140513014247.GH8330@dragon>
References: <20140509130046.GP2794@dragon>
 <20140510111003.GA1593@shlinux1.ap.freescale.net>
 <20140510131815.GT2794@dragon>
 <4285b0d55d2545b99c4ba6b703e65a12@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140511014027.GV2794@dragon>
 <71b1887d2f014021b084df703b15dc6a@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140512135437.GA8330@dragon>
 <04dad7ad8f0247b9bef4fea1db8a8bc8@BL2PR03MB226.namprd03.prod.outlook.com>
 <20140513014247.GH8330@dragon>
Message-ID: <d7270923af3841ab9d25ba9c53fe7ddc@BL2PR03MB226.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >
> > > > >
> > > >
> > > > In your case, you should not set CONFIG_USB_OTG no matter at
> > > > defconfig and at menuconfig.
> > >
> > > Hmm, at least in my testing (USB mouse/keyboard connected to OTG
> > > port), it works as before even I enable CONFIG_USB_OTG, as long as I
> > > do *not* enable CONFIG_USB_OTG_FSM.
> > >
> > > Since it works for my case, I'm wondering why you think I shouldn't
> > > enable CONFIG_USB_OTG at all.
> > >
> >
> > If your device is not OTG device, there is no reason you need to
> > enable CONFIG_USB_OTG.
> 
> Whether I should enable CONFIG_USB_OTG depends on what devices I will use?
> This is insane to me.
> 

Sorry, here, your device = your board

> Look, there is an USB OTG port on my board, and it should just be the
> reason that's good enough for me to build a kernel with CONFIG_USB_OTG,
> shouldn't it?  I do not even know what type of devices will be plugged
> into this USB OTG port when I was building the kernel.
> 

There is NO term for "OTG port" at USB spec, it only has a term of "OTG device",
which means " Device that provides both host and peripheral capabilities
over a single Micro-AB receptacle". If your device is an "OTG device",
and supports role switch without disconnect your usb cable (HNP),
you should set CONFIG_USB_OTG.

Taking imx6 sabreSD board as an example, it is a Micro-B port.
>From what kinds of port (A or B), we don't know which capabilities your
device has, with different cables, you will get different functions.
Currently, the capabilities are decided by: controller capabilities (otg,
host/device-only, etc) and can be override by dts due to board design.
otg has special protocol and TPL requirements, it is decided by
kernel configuration.

The Kconfig description for USB_OTG is not very accurate, it should mention
the HNP and SRP supported are needed for that config, not just dual-role
switch through ID pin, I will submit a patch for that

Peter

> Shawn
> 
> > Yes, it may work for some devices when enable CONFIG_USB_OTG, but it
> > will confuse other host or device which is connected with you, eg,
> > your device will report your have supported some otg capabilities, eg,
> > SRP or HNP.
