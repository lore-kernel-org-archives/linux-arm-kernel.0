From: b47624@freescale.com (Li Jun)
Date: Tue, 13 May 2014 09:10:36 +0800
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
Message-ID: <20140513011002.GA1781@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 13, 2014 at 09:42:48AM +0800, Shawn Guo wrote:
> On Tue, May 13, 2014 at 08:25:18AM +0800, Chen Peter-B29397 wrote:
> >  
> > > > >
> > > >
> > > > In your case, you should not set CONFIG_USB_OTG no matter at defconfig
> > > > and at menuconfig.
> > > 
> > > Hmm, at least in my testing (USB mouse/keyboard connected to OTG port),
> > > it works as before even I enable CONFIG_USB_OTG, as long as I do *not*
> > > enable CONFIG_USB_OTG_FSM.
> > > 
> > > Since it works for my case, I'm wondering why you think I shouldn't
> > > enable CONFIG_USB_OTG at all.
> > > 
> > 
> > If your device is not OTG device, there is no reason you need to enable
> > CONFIG_USB_OTG.
> 
> Whether I should enable CONFIG_USB_OTG depends on what devices I will
> use?  This is insane to me.
> 
> Look, there is an USB OTG port on my board, and it should just be the
> reason that's good enough for me to build a kernel with CONFIG_USB_OTG,
> shouldn't it?  I do not even know what type of devices will be plugged
> into this USB OTG port when I was building the kernel.
> 
> Shawn
> 

Firstly, w/o USB_OTG and USB_OTG_FSM, your OTG port will work well as before
(i.e. it can be host or can be gadget as you want, so it's enough for you if
connect normal usb device or PC host), I assume you are not wanting more here,
this dual role functionality actually is not the part of "CONFIG_USB_OTG";

What USB_OTG + USB_OTG_FSM does is *specific* for HNP and SRP, it's based on
OTG spec and will *not* work well with a normal usb device, that's the reason
behind in disable USB_OTG, which is not needed, and even impact your expecting
function in your case...

Li Jun

> > Yes, it may work for some devices when enable CONFIG_USB_OTG,
> > but it will confuse other host or device which is connected with you, eg,
> > your device will report your have supported some otg capabilities, eg, SRP or
> > HNP.
