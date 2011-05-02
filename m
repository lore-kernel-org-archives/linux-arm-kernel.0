From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 03 May 2011 08:25:38 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110502153852.GI1212@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110502153852.GI1212@game.jcrosoft.org>
Message-ID: <4DBF1342.6070406@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2011 03:38 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
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
> we have 2 different register 0xfffff200 and 0xffffee00
> which are the DBGU or the PIOA
> 
> and on the PIOA at the offset 0x40 if you try to read the cpu will always
> return 0x0, and have no effect on the soc
> 
> so I do not think there is a big issue to read 2 register to detect the soc
> automatically

This does rely on Atmel not making another soc which has the DBGU at an
address which does cause a conflict (low possibility, but would be very
annoying). It's also really ugly to read random registers until we get
the one we want.

However, I still do not see what is wrong with the current approach of
the boards explicitly specifying the soc type. The correct soc/cpu type
can already be determined without changing the code. So why are we
changing the code?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
