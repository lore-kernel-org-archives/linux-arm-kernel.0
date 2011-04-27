From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 27 Apr 2011 15:41:03 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110427031808.GE29103@game.jcrosoft.org>
References: <1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<4DB64DC3.70609@bluewatersys.com>
	<20110426064216.GJ12904@game.jcrosoft.org>
	<4DB7299D.80308@bluewatersys.com>
	<20110426234514.GC29103@game.jcrosoft.org>
	<4DB75FA8.10207@bluewatersys.com>
	<20110427012707.GD29103@game.jcrosoft.org>
	<4DB775A5.7030306@bluewatersys.com>
	<20110427031808.GE29103@game.jcrosoft.org>
Message-ID: <4DB7904F.80005@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 03:18 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:47 Wed 27 Apr     , Ryan Mallon wrote:
>> On 04/27/2011 01:27 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>>
>>>>>> This way the cpu detection code is much clearer and easier to read and
>>>>>> only one set of __cpu_is macros are needed. The values for
>>>>>> ARCH_ID_AT91RM9200, etc can be moved into soc.c since they are not
>>>>>> needed elsewhere.
>>>>> This will never work you do not listen
>>>>>
>>>>> the DBUG is at DIFFERENT base address on the AT91
>>>>> you need to check them one by one
>>>>>
>>>>> I keep the structure to keep more imformation inside and do not want to be
>>>>> limited by a 32bit and complex encoding to maintain
>>>>>
>>>>> Best Regards,
>>>>> J.
>>>> You can only be running one machine at a time. Are you implying that
>>>> this change breaks at91_sys_read in such a way that it reads the wrong
>>>> registers? If so, then its definitely a NAK.
>>> Certernly not ALL of the current work is too allow in a UNIQUE kernel to have
>>> all the atmel inside and other vendors and boards in the same kernel
>>
>> Agreed. At the moment we still have a situation where we can only
>> compile one at91 SoC variant into the kernel. So, at the moment, we do
>> not need to deal with the fact that the DBGU exists at different
>> locations, we can just read it for the board that we are booting on.
> This patch series goal is to allow to have a UNIQUE kernel so all the drivers
> and new code are write with this requirement
> 
> so no the double implementation is needed
> 
> no new code will accepted if it's does have this in considaration

I understand that the goal is to get a single kernel supporting all of
the at91 soc variants. This is one of the goals for the devices patch
series I posted also.

I am objecting to the implementation, not the goal. I believe there is a
better, cleaner way to handle this.

>> What I am objecting to is adding two entire sets of cpu_is macros which
>> is just needless extra code with no benefit. We should determine the
>> cpu/SoC type _once_ inside a single function (at91_initialize) and the
>> the cpu_is macros should just read the shadow value. There is no reason
>> to have two sets of macros.
> Those two macro set does not have the same constrains
> 
> cpu_is is to be soc agnostic
> __cpu_is is to be soc specific

Yes. But if the __cpu_is versions are not needed outside of the
at91_initialize function (in order to first determine the cpu/soc type)
then why not move all of the code into at91_initialize (i.e. the switch
statement I proposed) and do away with the __cpu_is macros. This would
be functionally the same but doesn't add a second copy of the cpu_is macros.

> so yes they are needed

The code _inside_ them is needed, but does not need to be in the form of
the __cpu_is macros, it can be moved directly into at91_initialize which
is cleaner and simpler.

> and I'll update the __cpu_is soon so they will not use at91_sys_read anymore

When will users ever need to use the __cpu_is macros and how will they
know when to use cpu_is and when to use __cpu_is?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
