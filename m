From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 27 Apr 2011 13:47:17 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110427012707.GD29103@game.jcrosoft.org>
References: <20110425180847.GA12904@game.jcrosoft.org>
	<1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<4DB64DC3.70609@bluewatersys.com>
	<20110426064216.GJ12904@game.jcrosoft.org>
	<4DB7299D.80308@bluewatersys.com>
	<20110426234514.GC29103@game.jcrosoft.org>
	<4DB75FA8.10207@bluewatersys.com>
	<20110427012707.GD29103@game.jcrosoft.org>
Message-ID: <4DB775A5.7030306@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/27/2011 01:27 PM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>
>>>> This way the cpu detection code is much clearer and easier to read and
>>>> only one set of __cpu_is macros are needed. The values for
>>>> ARCH_ID_AT91RM9200, etc can be moved into soc.c since they are not
>>>> needed elsewhere.
>>> This will never work you do not listen
>>>
>>> the DBUG is at DIFFERENT base address on the AT91
>>> you need to check them one by one
>>>
>>> I keep the structure to keep more imformation inside and do not want to be
>>> limited by a 32bit and complex encoding to maintain
>>>
>>> Best Regards,
>>> J.
>> You can only be running one machine at a time. Are you implying that
>> this change breaks at91_sys_read in such a way that it reads the wrong
>> registers? If so, then its definitely a NAK.
> Certernly not ALL of the current work is too allow in a UNIQUE kernel to have
> all the atmel inside and other vendors and boards in the same kernel

Agreed. At the moment we still have a situation where we can only
compile one at91 SoC variant into the kernel. So, at the moment, we do
not need to deal with the fact that the DBGU exists at different
locations, we can just read it for the board that we are booting on.

What I am objecting to is adding two entire sets of cpu_is macros which
is just needless extra code with no benefit. We should determine the
cpu/SoC type _once_ inside a single function (at91_initialize) and the
the cpu_is macros should just read the shadow value. There is no reason
to have two sets of macros.

> and for at91_sys_read it's not a big deal as I'm going to drop it at the end
> the timers does not use it anymore and the other drivers will update also one
> by one

Okay. But it shouldn't get broken now.

>> Your patch does this:
>>
>> static inline unsigned long at91_cpu_identify(void)
>> {
>> 	return (at91_sys_read(AT91_DBGU_CIDR) & ~AT91_CIDR_VERSION);
>> }
>>
> Yeah as I said already I need to fix a lots of place and I do it step by step
> so for now on I do not update the at91_cpu_identify & co but I will in time

Right. But the point is, if __cpu_is_at91rm9200 calls at91_cpu_identify,
then why can't we drop the __cpu_is_at91rm9200 call entirely and just
work out the cpu/SoC type in a big switch statement?

In short, what is the benefit of the __cpu_is macros if they are never
used outside of at91_initialize?

>> ...
>>
>> #ifdef CONFIG_ARCH_AT91RM9200
>> #define __cpu_is_at91rm9200()	(at91_cpu_identify() == ARCH_ID_AT91RM9200)
>> #else
>> #define __cpu_is_at91rm9200()	(0)
>> #endif
>>
>> ...
>>
>> void __init at91_initialize(unsigned long main_clock)
>> {
>> 	...
>> 	if (__cpu_is_at91rm9200()) {
>> 		cpu_id.is_at91rm9200_soc;
>> 		current_soc = at91rm9200_soc;
>> 	}
>> 	...
>> }
>>
>>
>> So at91_initialize calls the __cpu_is macros, which in turn read the
>> AT91_DBGU registers via at91_sys_read. What I am proposing above is to
>> replace the massive collection of if statements with a simpler switch
>> statement and replacing the __cpu_is macros with direct register reads
>> via at91_sys_read, which results in far less code and more readable
>> code. If your version works, then how can mine not?
> Because It will never allow you to have a __cpu_is_ soc specific
> which is the goal here

You already have the existing cpu_is versions (which would now use the
shadowed value rather than register reads). After at91_initialize has
determined the cpu/SoC type the __cpu_is macros are no longer used right?

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
