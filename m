From: balbi@ti.com (Felipe Balbi)
Date: Thu, 14 May 2015 15:10:40 -0500
Subject: MUSB dual-role on AM335x behaving weirdly
In-Reply-To: <CADYTM3Y4AnpWKQ2MJfaKHLDey9OvzKwH6BxNetJz4KmhxewggQ@mail.gmail.com>
References: <20150514170700.GN24269@saruman.tx.rr.com>
 <20150514174031.GP24269@saruman.tx.rr.com>
 <20150514174907.GQ24269@saruman.tx.rr.com>
 <20150514190429.GT24269@saruman.tx.rr.com>
 <CADYTM3Zso8bV_8yFyx1-ATbL5AgkKBjvWWR4AsoZUNuLvFe1bQ@mail.gmail.com>
 <20150514192125.GU24269@saruman.tx.rr.com>
 <CADYTM3bbEAVefFZtivJf5Z+2Q+1zDZEvNhqE5ytsOxDX7hjbdA@mail.gmail.com>
 <20150514192946.GV24269@saruman.tx.rr.com>
 <20150514194924.GW24269@saruman.tx.rr.com>
 <CADYTM3Y4AnpWKQ2MJfaKHLDey9OvzKwH6BxNetJz4KmhxewggQ@mail.gmail.com>
Message-ID: <20150514201040.GX24269@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, May 14, 2015 at 03:03:04PM -0500, Bin Liu wrote:
> Felipe,
> 
> I can see the problem with 3.14.42 the current kernel I use right now.
> See my other comments below.
> 
> On Thu, May 14, 2015 at 2:49 PM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Thu, May 14, 2015 at 02:29:46PM -0500, Felipe Balbi wrote:
> >> > >> >> > Even in this case, when I connect the device on the other end of the
> >> > >> >> > cable, I still see some 3 seconds delay from the time device is
> >> > >> >> > connected, to the time connect IRQ fires up.
> >> > >> >>
> >> > >> >> seems to be a problem with the USB stick I'm using. Tested two other
> >> > >> >> devices and they connect right away.
> >> > >> >
> >> > >> > ok, fixing DRD on AM335x will take longer than I originally expected,
> >> > >> > probably won't be ready for v4.2 :-(
> >> > >>
> >> > >> Are you able replicate the issue with TI AM335x GP EVM? I am wondering
> >> > >> if the is custom board design problem? have you checked the custom
> >> > >> board schematics?
> >> > >
> >> > > don't have either AM335x GP EVM nor schematics for this board. But it's
> >> > > certainly not a problem with the board. It's very easy to replicate the
> >> > > problem:
> >> > >
> >> > > Set dr-mode to otg, load g_zero, connect to PC and as quickly as you
> >> > > can, remove cable and attach otg cable with a mouse or whatever on the
> >> > > other end.
> >> > >
> >> > > First time, mouse won't enumerate (no IRQs fire) remove and connect
> >> > > again. You should see a Babble IRQ.
> >> >
> >> > And this only happens with 3.16+, not older kernels? I have a GP EVM,
> >> > and can try to take a look.
> >>
> >> yeah, if you can try with v4.1-rc3, that'd be great. I also see that
> >> disconnect IRQ takes a while to fire, but VBUS drops rather fast on this
> >> board (< 10ms to discharge VBUS).
> >
> > Here are some logs:
> 
> [snip]
> 
> > | [   53.162507] musb-hdrc musb-hdrc.1.auto: ** IRQ peripheral usb0001 tx0000 rx0000
> > | [   53.170201] musb-hdrc musb-hdrc.1.auto: <== DevCtl=99, int_usb=0x1
> > | [   53.176709] musb-hdrc musb-hdrc.1.auto: SUSPEND (b_peripheral) devctl 99
> > | [   53.183760] musb-hdrc musb-hdrc.1.auto: devctl 99
> > | [   53.188713] zero gadget: suspend
> > | [   53.192111] zero gadget: zero_suspend
> >
> > Gadget driver suspended
> >
> > | [   59.289314] musb-hdrc musb-hdrc.1.auto: usbintr (20) epintr(0)
> >
> > 6.09 seconds later we get Disconnect IRQ (???????????). No idea what's
> > going on here. Why 6 seconds for Disconnect IRQ to fire ?
> 
> I believe the Disconnect IRQ was because MUSB is already confused at
> this time when the ID pin is grounded before it transition to b_idle.
> 
> If I don't connect the mouse after disconnect MUSB from host, I saw it
> took about 30 sec for MUSB to transition from b_peripheral to b_idle
> which is not right. I think we need to figure out why it takes that
> long. Once MUSB can quickly get to b_idle, it should handle connect to
> host or device properly.

My feeling is that this won't be enough :-)

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150514/de3da5d4/attachment.sig>
