From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 May 2015 14:21:25 -0500
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <CADYTM3Zso8bV_8yFyx1-ATbL5AgkKBjvWWR4AsoZUNuLvFe1bQ@mail.gmail.com>
References: <20150224145401.GH29829@saruman.tx.rr.com>
 <20150224165050.GX25269@lukather>
 <20150224173357.GB25042@saruman.tx.rr.com>
 <20150225111129.GA5062@lukather>
 <54EDBBEA.8030509@visionsystems.de>
 <20150514170700.GN24269@saruman.tx.rr.com>
 <20150514174031.GP24269@saruman.tx.rr.com>
 <20150514174907.GQ24269@saruman.tx.rr.com>
 <20150514190429.GT24269@saruman.tx.rr.com>
 <CADYTM3Zso8bV_8yFyx1-ATbL5AgkKBjvWWR4AsoZUNuLvFe1bQ@mail.gmail.com>
Message-ID: <20150514192125.GU24269@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 14, 2015 at 02:19:28PM -0500, Bin Liu wrote:
> Felipe,
> 
> On Thu, May 14, 2015 at 2:04 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Thu, May 14, 2015 at 12:49:07PM -0500, Felipe Balbi wrote:
> >> On Thu, May 14, 2015 at 12:40:31PM -0500, Felipe Balbi wrote:
> >> > On Thu, May 14, 2015 at 12:07:00PM -0500, Felipe Balbi wrote:
> >> > > Hi,
> >> > >
> >> > > On Wed, Feb 25, 2015 at 01:11:22PM +0100, Yegor Yefremov wrote:
> >> > > > On 25.02.2015 12:11, Maxime Ripard wrote:
> >> > > > > On Tue, Feb 24, 2015 at 11:33:57AM -0600, Felipe Balbi wrote:
> >> > > > >> Hi,
> >> > > > >>
> >> > > > >> On Tue, Feb 24, 2015 at 05:50:50PM +0100, Maxime Ripard wrote:
> >> > > > >>> Hi Felipe,
> >> > > > >>>
> >> > > > >>> On Tue, Feb 24, 2015 at 08:54:01AM -0600, Felipe Balbi wrote:
> >> > > > >>>> Hi,
> >> > > > >>>>
> >> > > > >>>> On Tue, Feb 24, 2015 at 11:39:11AM +0100, Maxime Ripard wrote:
> >> > > > >>>>> On Thu, Feb 05, 2015 at 02:21:42PM +0100, Maxime Ripard wrote:
> >> > > > >>>>>> Hi,
> >> > > > >>>>>>
> >> > > > >>>>>> On Thu, Jan 22, 2015 at 08:37:45AM +0100, Yegor Yefremov wrote:
> >> > > > >>>>>>> I have the same experience with 3.15. The switching is working when
> >> > > > >>>>>>> CONFIG_USB_MUSB_DUAL_ROLE is set and dr_mode = "otg". But since 3.16
> >> > > > >>
> >> > > > >> since 3.16 ?
> >> > > > >
> >> > > > > That's what Yegor said. I never saw it working with 3.15 either.
> >> > > >
> >> > > > I've used 3.15.1 and 3.15.2 with this set of patches:
> >> > > > https://github.com/visionsystemsgmbh/onrisc_br_bsp/tree/master/board/vscom/kernel-patches/linux-3.15
> >> > > >
> >> > > > And it worked so far. The system:
> >> > > > http://www.visionsystems.de/produkte/baltos-ir-5221.html
> >> > >
> >> > > I've had more time to look into this (thanks Yegor for sponsoring a
> >> > > test/dev platform) what I noticed is that Connect IRQ takes seconds to
> >> > > fire up.  Below a tiny log snippet after pluging USB OTG adapter cable
> >> > > that came with IR5521:
> >> > >
> >> > > | [ 1227.200514] musb-hdrc musb-hdrc.1.auto: usbintr (100) epintr(0)
> >> > >
> >> > > Cable connected. ID is grounded. 0x100 == DRVVBUS IRQ
> >> > >
> >> > > | [ 1227.206788] musb-hdrc musb-hdrc.1.auto: VBUS on (a_wait_vrise), devctl 19
> >> > >
> >> > > MUSB starts to wait for VBUS to reach Session valid threshold
> >> > >
> >> > > | [ 1230.281159] musb-hdrc musb-hdrc.1.auto: usbintr (10) epintr(0)
> >> > >
> >> > > 3 seconds later connect interrupt happens. Looking at VBUS charge time
> >> > > with a scope, it's quite ok. VBUS charges in about 1.77ms. I'll dig
> >> > > further into this.
> >> >
> >> > even more weird. If I disconnect device from OTG adapter, rather than
> >> > OTG adapter from IR5521, this leave ID pin grounded, which means DRVVBUS
> >> > is still asserted and VBUS remains above session valid threshold.
> >> >
> >> > Even in this case, when I connect the device on the other end of the
> >> > cable, I still see some 3 seconds delay from the time device is
> >> > connected, to the time connect IRQ fires up.
> >>
> >> seems to be a problem with the USB stick I'm using. Tested two other
> >> devices and they connect right away.
> >
> > ok, fixing DRD on AM335x will take longer than I originally expected,
> > probably won't be ready for v4.2 :-(
> 
> Are you able replicate the issue with TI AM335x GP EVM? I am wondering
> if the is custom board design problem? have you checked the custom
> board schematics?

don't have either AM335x GP EVM nor schematics for this board. But it's
certainly not a problem with the board. It's very easy to replicate the
problem:

Set dr-mode to otg, load g_zero, connect to PC and as quickly as you
can, remove cable and attach otg cable with a mouse or whatever on the
other end.

First time, mouse won't enumerate (no IRQs fire) remove and connect
again. You should see a Babble IRQ.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/3f950387/attachment.sig>
