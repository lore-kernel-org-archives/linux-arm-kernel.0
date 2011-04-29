From: ryan@bluewatersys.com (Ryan Mallon)
Date: Fri, 29 Apr 2011 20:50:36 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110429083502.GG13104@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110428141046.GB10594@game.jcrosoft.org>
	<4DB9CC07.4020903@bluewatersys.com>
	<20110428230652.GB13104@game.jcrosoft.org>
	<4DB9F719.2080708@bluewatersys.com>
	<20110429083502.GG13104@game.jcrosoft.org>
Message-ID: <4DBA7BDC.8040106@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/04/11 20:35, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>> So I don't see how you can "detect" the CPU without first knowing
>>>>>> which CPU and therefore where the DBGU register is anyway.
>>>>>> And probing different addresses for a value is not an acceptable solution.
>>>>>>
>>>>>>
>>>>>> While having a single kernel image that supports AT91 processors is a
>>>>>> good goal, the soc.h is a totally unnecessary complication.
>>>>>> I can't think of any situation where an AT91 board.c file doesn't know
>>>>>> what processor it has.
>>>>>>
>>>>>> So instead of :
>>>>>>    boardXYZ-init ->  at91_initialize() --> magic-cpu-detection -->
>>>>>> at91XX_initialize()
>>>>>> just do:
>>>>>>    boardXYZ-init  -> at91XX_initialize()
>>>>> except there is no need to known it and board seach as the usb-926x are the
>>>>> same nearly and do not need to known on which soc they are
>>>>>
>>>>> ditto for other boards you do not need to known the soc we are on.
>>>>> And when you work on CPU module the board is the same but not the cpu on the
>>>>> module so detect the SOC allow to have one kernel for all and not multiple
>>>>> machine ID for each module and board combination
>>>>
>>>> I Agree with Andrew. When can determine everything we need from the
>>>> mach-type. For boards such as the usb-926x we have two separate
>>>> mach-types for the 9263 and the 9260 variants. The init_machine callback
>>>> can be separated in this case so that both of the boards initialise the
>>>> correct cpu type.
>>> I do work on board where is the case and I do not want to keep the limitation
>>> and yes I'll put them mainline
>>>
>>> And Russell will not accept I'll create 10 or 20 machine ID for board / cpu
>>> module combinaison just because of different I do not detect the SOC type
>>>
>>> so I'll continue to detect the soc
>>
>> How? It has been pointed out that there is no way that this can be
>> reliably done if you have all of the at91 socs built into a single
>> kernel. You cannot know where the DBGU registers are to read determine
>> the cpu/soc type.
>>
>> The most reliable way to do this, which also requires the least code, is
>> to have the boards explicitly specify which cpu/soc type they are. In
>> this case most of the cpu detection code can be removed. Only the minor
>> variant (i.e. 9260/9G20) detection code would need to remain.
> 
> Except the idea here to do not do so
> as I point some board will have different soc for the cpu module
> a big real case on AT91

Can you give an example of a situation where we have the same mach-type
for two boards, where the DBGU is at a different location and therefore
not possible to differentiate between the boards?

You still haven't answered how your proposed cpu detection code would
work if all of the at91 socs were compiled into a single kernel, where
the DBGU registers are at different locations.

The current approach of boards explicitly specifying their cpu/soc type
will actually work correctly if all at91 socs are compiled into a single
kernel. Your patch set will actively break this.

~Ryan
