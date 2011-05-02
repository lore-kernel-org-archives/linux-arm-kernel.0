From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 03 May 2011 10:05:18 +1200
Subject: [PATCH 05/14] at91: use structure to store the current soc
In-Reply-To: <20110502212920.GD13724@game.jcrosoft.org>
References: <1303756284-26529-5-git-send-email-plagnioj@jcrosoft.com>
	<4DB5F0C7.2070903@bluewatersys.com>
	<20110426042131.GD12904@game.jcrosoft.org>
	<BANLkTi=vkTonFWqqaQ2X0hVLb9Uzh_DEgw@mail.gmail.com>
	<20110502153852.GI1212@game.jcrosoft.org>
	<4DBF1342.6070406@bluewatersys.com>
	<20110502202449.GB13724@game.jcrosoft.org>
	<4DBF164C.7030900@bluewatersys.com>
	<20110502205154.GC13724@game.jcrosoft.org>
	<4DBF21B0.5060202@bluewatersys.com>
	<20110502212920.GD13724@game.jcrosoft.org>
Message-ID: <4DBF2A9E.5010201@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/03/2011 09:29 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 09:27 Tue 03 May     , Ryan Mallon wrote:
>> On 05/03/2011 08:51 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>> On 08:38 Tue 03 May     , Ryan Mallon wrote:
>>>> On 05/03/2011 08:24 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
>>>>>>>> So I don't see how you can "detect" the CPU without first knowing
>>>>>>>> which CPU and therefore where the DBGU register is anyway.
>>>>>>>> And probing different addresses for a value is not an acceptable solution.
>>>>>>> we have 2 different register 0xfffff200 and 0xffffee00
>>>>>>> which are the DBGU or the PIOA
>>>>>>>
>>>>>>> and on the PIOA at the offset 0x40 if you try to read the cpu will always
>>>>>>> return 0x0, and have no effect on the soc
>>>>>>>
>>>>>>> so I do not think there is a big issue to read 2 register to detect the soc
>>>>>>> automatically
>>>>>>
>>>>>> This does rely on Atmel not making another soc which has the DBGU at an
>>>>>> address which does cause a conflict (low possibility, but would be very
>>>>>> annoying). It's also really ugly to read random registers until we get
>>>>>> the one we want.
>>>>>>
>>>>>> However, I still do not see what is wrong with the current approach of
>>>>>> the boards explicitly specifying the soc type. The correct soc/cpu type
>>>>>> can already be determined without changing the code. So why are we
>>>>>> changing the code?
>>>>> Because some hardware design architecture such as CPU module do allow to have
>>>>> the SAME board with different SOC. So have one machine ID per combinaison because
>>>>> we just change the soc is a non-sense.
>>>>
>>>> You haven't named such a piece of hardware yet. We have boards like our
>>>> own Snapper 9260/9G20 where the same mach-type is used for two boards,
>>>> one with a SAM9260 and the other with a SAM9G20. Because these are
>>>> variants of the same soc we know that the DBGU is at the same address on
>>>> both and so we can read the cpuid registers to determine which board it is.
>>> take a look on the Ronetix
>>> http://www.ronetix.at/
>>>
>>> and this is just one the example
>>
>> Why would each of those three modules not have their own mach-type? They
>> could be implemented as a single board file, with three MACHINE_START
>> sections at the bottom of the file. All three could be compiled into a
>> single kernel and the cpu_is macros can be used for the soc specific stuff.
>>
>>>> Can you give me an example of a mach-type which is used for two or more
>>>> boards that cannot be differentiated this way?
>>> today we can not do so, so people multiplicate the machine ID which is wrong
>>> and please do not only see the Snapper there is much more hardware provider
>>
>> I think that these boards are different enough (they have cpus with
>> different memory layouts) that they should be specified by their own
>> mach-type.
>>
>> Russell, what is your opinion on this? Should we use individual
>> mach-types for the above boards and have them explicitly specify their
>> cpu/soc type, or should we be aiming to have a single mach-type for all
>> of them and determine the cpu/soc type in code?
> so which means when we will have multiple board that use the SAME cpu module
> we will add X * Y boards machine ID
> 
> really not good just to avoid to read 2 registers common it's non-sense

The boards are different. They have a common base pinout, but their
peripheral pinouts are different. Multiple mach-types cost nothing and
are a well understood part of ARM Linux. Your proposed cpu detection
code adds complexity and code, and has zero benefit for any of the
boards currently in mainline.

Carrier boards are a separate issue, and there has not really been a
consensus on what the best way to solve the issue of combining system on
modules (SoMs) with carrier boards. Should the mach-type belong to the
SoM or to the system as a whole (SoM + carrier board)? There is
currently a push to get ARM to consolidate on things rather than each
sub-architecture doing things its own way. So if you want a way to
differentiate carrier boards, then I think that needs to be discussed
with other sub-architecture maintainers so that a common approach can be
devised. I don't think that cpu detection is a robust solution. Device
tree is probably the long-term solution to this.

In short, your soc detection patches add additional complexity, but have
zero effect on the possibility of supporting all of the current mainline
at91 platforms in a single kernel. We need to fix the other barriers to
this support first (such as the work Andrew Victor is doing).

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
