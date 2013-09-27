From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Fri, 27 Sep 2013 12:04:32 +0200
Subject: imprecise external abort using the flexcan driver on i.MX6Q
In-Reply-To: <5245535F.6020804@pengutronix.de>
References: <21060.15934.600859.167074@ipc1.ka-ro>
 <524455FD.7070808@pengutronix.de>
 <20130926155422.GQ12758@n2100.arm.linux.org.uk>
 <52445FBE.4060503@ti.com> <21061.20097.221946.197751@ipc1.ka-ro>
 <5245535F.6020804@pengutronix.de>
Message-ID: <21061.22576.404020.384558@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Marc Kleine-Budde writes:
> On 09/27/2013 11:23 AM, Lothar Wa?mann wrote:
> > Hi,
> > 
> > Santosh Shilimkar writes:
> >> On Thursday 26 September 2013 11:54 AM, Russell King - ARM Linux wrote:
> >>> On Thu, Sep 26, 2013 at 05:42:53PM +0200, Marc Kleine-Budde wrote:
> >>>> On 09/26/2013 04:01 PM, Lothar Wa?mann wrote:
> >>>>> Hi,
> >>>>>
> >>>>> when enabling the can interface with 'ifconfig can0 up' (after
> >>>>> configuring the bitrate with canconfig) on an i.MX6Q board (TX6) I'm
> >>>>> getting the following kernel dump:
> >>>>>
> >>>>> |flexcan 2094000.flexcan can0: writing ctrl=0x0a212003
> >>>>> |flexcan 2094000.flexcan can0: flexcan_set_bittiming: mcr=0x5980000f ctrl=0x0a212003
> >>>>> |flexcan 2094000.flexcan can0: flexcan_chip_start: writing mcr=0x79a2020f
> >>>>> |flexcan 2094000.flexcan can0: flexcan_chip_start: writing ctrl=0x0a21ac53
> >>>>> |Unhandled fault: imprecise external abort (0x1c06) at 0x00057adc
> >>>>
> >>>> Looks like a NULL pointer deref to me. But it doesn't make any sense,
> >>>> because the offset is way beyond the length of the struct flexcan_regs.
> >>>
> >>> NULL pointer derefs don't produce imprecise external aborts.  I believe
> >>> that the FAR is unpredictable for such aborts as well, which means the
> >>> "at xxxx" should be ignored.
> >>>
> >> yep .. FAR is never reliable for imprecise external aborts.
> >>
> >>> Bearing in mind that it is imprecise, that means that the abort happened
> >>> sometime in the past, so the PC isn't reliable either.
> >>>
> >>> The code here is:
> >>>
> >>>    0:	f57ff04e 	dsb	st
> >>>    4:	e3a01000 	mov	r1, #0
> >>>    8:	e5820000 	str	r0, [r2]
> >>>    c:	f57ff04e 	dsb	st
> >>>   10:	e5820004 	str	r0, [r2, #4]
> >>>
> >>> Given the dsbs there, it's probably the str r0, [r2] which provoked it,
> >>> and we can see from the register dump, r2 is not NULL.
> >>>
> >>> It's probably complaining that a clock necessary for the peripherals
> >>> registers to be accessible is not running.
> >>>
> >> Not sure if it helps but almost 90% of the imprecise external aborts
> >> cases I have seen on OMAP attributed to clock not being available
> >> at the IP register accesses race conditions either at SW or
> >> hardware(clock settling time). And rest of the 10 % majority falling
> >> into interconnect synchronization issues.
> >>
> > I already checked this by enabling all clocks with devmem.
> > If a clock would be missing I would expect all register wriites to
> > fail not the register write to the _second_ mailbox (after the first
> > mailbox has been successfully initialized).
> 
> They layout of the flexcan varies in the different imx chips. I'm
> comparing the datasheets at the moment. As Russell pointed out the area
> staring at offset 0x80 is by the reception FIFO engine.
> 
The layout is correct when the Rx FIFO is disabled!

removing 'FLEXCAN_MCR_FEN' from the MCR setting makes the driver work
as expected (just without receive fifo).

For the use case with the FIFO enabled, the layout has to be changed
obviously.


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
