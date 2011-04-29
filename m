From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri, 29 Apr 2011 10:32:48 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <4DBA1E26.7060109@bluewatersys.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110428141046.GB10594@game.jcrosoft.org>
	<4DB9CC07.4020903@bluewatersys.com>
	<20110428230652.GB13104@game.jcrosoft.org>
	<4DB9F719.2080708@bluewatersys.com>
	<4DBA1E26.7060109@bluewatersys.com>
Message-ID: <20110429083248.GF13104@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14:10 Fri 29 Apr     , Ryan Mallon wrote:
> On 04/29/2011 11:24 AM, Ryan Mallon wrote:
> > On 04/29/2011 11:06 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> On 08:20 Fri 29 Apr     , Ryan Mallon wrote:
> >>> On 04/29/2011 02:10 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>>> On 16:04 Thu 28 Apr     , Andrew Victor wrote:
> >>>>> hi,
> >>>>>
> >>>>>>> If this eventually reduces code size then I think it is useful, but
> >>>>>>> otherwise I'm not sure I see the point?
> >>>>>> It's on purpose as the dbgu physical address is not at the same place
> >>>>>> so read the other register really does not impact the chip but if we do it
> >>>>>> later duting the boot or the life to the kernel it's an other story
> >>>>>>
> >>>>>> so the split between __cpu_is and cpu_is is necessarly
> >>>>>>
> >>>>>> all of this work is in preparation to allow multiple soc in the same kernel
> >>>>>> that's also why I map the system controller the same way on all at91 arm9
> >>>>>
> >>>>> The cpu_is() or__cpu_is() perform a at91_sys_read() of one of the DBGU
> >>>>> registers.
> >>>>>
> >>>>> But the address of the DBGU differs between CPUs regardless if you map
> >>>>> the system controller the same:
> >>>>>    at572d940hf.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
> >>>>>    at91cap9.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
> >>>>>    at91rm9200.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
> >>>>>    at91sam9260.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
> >>>>>    at91sam9261.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
> >>>>>    at91sam9263.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
> >>>>>    at91sam9g45.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
> >>>>>    at91sam9rl.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
> >>>>>
> >>>>> So I don't see how you can "detect" the CPU without first knowing
> >>>>> which CPU and therefore where the DBGU register is anyway.
> >>>>> And probing different addresses for a value is not an acceptable solution.
> >>>>>
> >>>>>
> >>>>> While having a single kernel image that supports AT91 processors is a
> >>>>> good goal, the soc.h is a totally unnecessary complication.
> >>>>> I can't think of any situation where an AT91 board.c file doesn't know
> >>>>> what processor it has.
> >>>>>
> >>>>> So instead of :
> >>>>>    boardXYZ-init ->  at91_initialize() --> magic-cpu-detection -->
> >>>>> at91XX_initialize()
> >>>>> just do:
> >>>>>    boardXYZ-init  -> at91XX_initialize()
> >>>> except there is no need to known it and board seach as the usb-926x are the
> >>>> same nearly and do not need to known on which soc they are
> >>>>
> >>>> ditto for other boards you do not need to known the soc we are on.
> >>>> And when you work on CPU module the board is the same but not the cpu on the
> >>>> module so detect the SOC allow to have one kernel for all and not multiple
> >>>> machine ID for each module and board combination
> >>>
> >>> I Agree with Andrew. When can determine everything we need from the
> >>> mach-type. For boards such as the usb-926x we have two separate
> >>> mach-types for the 9263 and the 9260 variants. The init_machine callback
> >>> can be separated in this case so that both of the boards initialise the
> >>> correct cpu type.
> >> I do work on board where is the case and I do not want to keep the limitation
> >> and yes I'll put them mainline
> >>
> >> And Russell will not accept I'll create 10 or 20 machine ID for board / cpu
> >> module combinaison just because of different I do not detect the SOC type
> >>
> >> so I'll continue to detect the soc
> > 
> > How? It has been pointed out that there is no way that this can be
> > reliably done if you have all of the at91 socs built into a single
> > kernel. You cannot know where the DBGU registers are to read determine
> > the cpu/soc type.
> > 
> > The most reliable way to do this, which also requires the least code, is
> > to have the boards explicitly specify which cpu/soc type they are. In
> > this case most of the cpu detection code can be removed. Only the minor
> > variant (i.e. 9260/9G20) detection code would need to remain.
> 
> Having another look at this, the cpu detection is already fine. For
> example, board-snapper9260.c calls at91sam9260_initialize, which in turn
> determines whether the soc is a 9xe, 9260, or 9g20 and does the
> appropriate intialisation. This all works fine because the three socs
> have the same DBGU location.
> 
> There are other obstacles to having a single kernel for all of AT91, in
> particular the big ifdef switch in include/mach/hardware.h and the whole
> AT91_BASE_SYS thing, but the cpu/soc detection should not actually need
> to be modified.
> 
> Lets fix the other problems first.
I known one by one please it's plan to get rid of this

Best Regards,
J.
