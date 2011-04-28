From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 28 Apr 2011 16:10:46 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
Message-ID: <20110428141046.GB10594@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:04 Thu 28 Apr     , Andrew Victor wrote:
> hi,
> 
> >> If this eventually reduces code size then I think it is useful, but
> >> otherwise I'm not sure I see the point?
> > It's on purpose as the dbgu physical address is not at the same place
> > so read the other register really does not impact the chip but if we do it
> > later duting the boot or the life to the kernel it's an other story
> >
> > so the split between __cpu_is and cpu_is is necessarly
> >
> > all of this work is in preparation to allow multiple soc in the same kernel
> > that's also why I map the system controller the same way on all at91 arm9
> 
> The cpu_is() or__cpu_is() perform a at91_sys_read() of one of the DBGU
> registers.
> 
> But the address of the DBGU differs between CPUs regardless if you map
> the system controller the same:
>    at572d940hf.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>    at91cap9.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>    at91rm9200.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>    at91sam9260.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>    at91sam9261.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>    at91sam9263.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>    at91sam9g45.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>    at91sam9rl.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
> 
> So I don't see how you can "detect" the CPU without first knowing
> which CPU and therefore where the DBGU register is anyway.
> And probing different addresses for a value is not an acceptable solution.
> 
> 
> While having a single kernel image that supports AT91 processors is a
> good goal, the soc.h is a totally unnecessary complication.
> I can't think of any situation where an AT91 board.c file doesn't know
> what processor it has.
> 
> So instead of :
>    boardXYZ-init ->  at91_initialize() --> magic-cpu-detection -->
> at91XX_initialize()
> just do:
>    boardXYZ-init  -> at91XX_initialize()
except there is no need to known it and board seach as the usb-926x are the
same nearly and do not need to known on which soc they are

ditto for other boards you do not need to known the soc we are on.
And when you work on CPU module the board is the same but not the cpu on the
module so detect the SOC allow to have one kernel for all and not multiple
machine ID for each module and board combination

Best Regards,
J.
