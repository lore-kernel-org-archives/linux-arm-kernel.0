From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Mon, 2 May 2011 17:38:52 +0200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
Message-ID: <20110502153852.GI1212@game.jcrosoft.org>
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
we have 2 different register 0xfffff200 and 0xffffee00
which are the DBGU or the PIOA

and on the PIOA at the offset 0x40 if you try to read the cpu will always
return 0x0, and have no effect on the soc

so I do not think there is a big issue to read 2 register to detect the soc
automatically

Best Regards,
J.
