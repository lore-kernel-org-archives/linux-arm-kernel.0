From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 08:20:23 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110428141046.GB10594@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110428141046.GB10594@game.jcrosoft.org>
Message-ID: <4DB9CC07.4020903@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2011 02:10 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 16:04 Thu 28 Apr     , Andrew Victor wrote:
>> hi,
>>
>>>> If this eventually reduces code size then I think it is useful, but
>>>> otherwise I'm not sure I see the point?
>>> It's on purpose as the dbgu physical address is not at the same place
>>> so read the other register really does not impact the chip but if we do it
>>> later duting the boot or the life to the kernel it's an other story
>>>
>>> so the split between __cpu_is and cpu_is is necessarly
>>>
>>> all of this work is in preparation to allow multiple soc in the same kernel
>>> that's also why I map the system controller the same way on all at91 arm9
>>
>> The cpu_is() or__cpu_is() perform a at91_sys_read() of one of the DBGU
>> registers.
>>
>> But the address of the DBGU differs between CPUs regardless if you map
>> the system controller the same:
>>    at572d940hf.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>>    at91cap9.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>>    at91rm9200.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>>    at91sam9260.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>>    at91sam9261.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>>    at91sam9263.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>>    at91sam9g45.h:#define AT91_DBGU	(0xffffee00 - AT91_BASE_SYS)
>>    at91sam9rl.h:#define AT91_DBGU	(0xfffff200 - AT91_BASE_SYS)
>>
>> So I don't see how you can "detect" the CPU without first knowing
>> which CPU and therefore where the DBGU register is anyway.
>> And probing different addresses for a value is not an acceptable solution.
>>
>>
>> While having a single kernel image that supports AT91 processors is a
>> good goal, the soc.h is a totally unnecessary complication.
>> I can't think of any situation where an AT91 board.c file doesn't know
>> what processor it has.
>>
>> So instead of :
>>    boardXYZ-init ->  at91_initialize() --> magic-cpu-detection -->
>> at91XX_initialize()
>> just do:
>>    boardXYZ-init  -> at91XX_initialize()
> except there is no need to known it and board seach as the usb-926x are the
> same nearly and do not need to known on which soc they are
> 
> ditto for other boards you do not need to known the soc we are on.
> And when you work on CPU module the board is the same but not the cpu on the
> module so detect the SOC allow to have one kernel for all and not multiple
> machine ID for each module and board combination

I Agree with Andrew. When can determine everything we need from the
mach-type. For boards such as the usb-926x we have two separate
mach-types for the 9263 and the 9260 variants. The init_machine callback
can be separated in this case so that both of the boards initialise the
correct cpu type.

For cases such as the Snapper 9260/9G20, where a single mach-type is
used for two boards, we can then read the DBGU registers because the
location is the same for the 9260 and 9G20 (same sub-family). I don't
think there are any boards in the kernel which share a mach-type, but
have different sub-families and therefore different locations for DBGU.

If we took the approach that the boards must explicitly specify (as
closely as possible) their cpu/soc type then we could remove much of the
cpu detection code. We will still need the sub-family detection (e.g.
9260/9G20, CAP9 revision, etc) to distinguish some boards.

As Andrew says, cpu detection will not reliably work if we have a kernel
where all boards are compiled in. We have a chicken and egg problem in
that we need to know the cpu type in order to know where the DBGU
registers are, and we need to read the DBGU registers in order to
determine the cpu type. Catch 22.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
