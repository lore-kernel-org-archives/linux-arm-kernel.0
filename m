From: robherring2@gmail.com (Rob Herring)
Date: Thu, 11 Aug 2011 11:06:23 -0500
Subject: Subject: L2x0 OF properties do not include interrupt #
In-Reply-To: <20110811153800.GC5154@e102144-lin.cambridge.arm.com>
References: <000201cc575b$c1229010$4367b030$@rutland@arm.com>
	<201108101624.27881.arnd@arndb.de>
	<20110810142808.GL10121@e102144-lin.cambridge.arm.com>
	<201108111505.11887.arnd@arndb.de>
	<20110811130910.GA10189@e102144-lin.cambridge.arm.com>
	<4E43F5F8.4060704@gmail.com>
	<20110811153800.GC5154@e102144-lin.cambridge.arm.com>
Message-ID: <4E43FDFF.1080401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2011 10:38 AM, Will Deacon wrote:
> On Thu, Aug 11, 2011 at 04:32:08PM +0100, Rob Herring wrote:
>> On 08/11/2011 08:09 AM, Will Deacon wrote:
>>> On Thu, Aug 11, 2011 at 02:05:11PM +0100, Arnd Bergmann wrote:
>>>> On Wednesday 10 August 2011, Will Deacon wrote:
>>>>> I was hoping that it was possible to have separate properties which describe
>>>>> the interrupt. So you could have something like pmu-interrupt <75> and
>>>>> abort-interrupt <76> rather than interrupts <75, 76>.
>>>>
>>>> Ok, I see.
>>>>
>>>>> I've not played with DT bindings before though, so if it's usually done with
>>>>> an ordered list then so be it!
>>>>
>>>> A lot of the code assumes that the property is called 'interrupts' and that
>>>> it contains a fixed-length array of interrupt numbers, each for one specific
>>>> purpose.
>>>
>>> Ok, I wondered if something like that might be the case.
>>>
>>>> Given that we have so many different meanings for the interrupts, I'm
>>>> not sure how this would work best in this case. According to
>>>> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ddi0246f/CHDFHCFJ.html
>>>> this looks like a nested interrupt controller, i.e. the L2CC has its own mask
>>>> and status register with bits for each one of them. We could model these by
>>>> describing the l2cc interrupt controller with these registers and listing all
>>>> nine of the current inputs. I suspect however that it would be easier to just
>>>> assume that there is only one line for now, and treat the l2cc as a single
>>>> interrupt source with an internal status register.
>>>
>>> Given that this binding is only for the l2x0 / pl310 and I don't know of any
>>> implementation where > 1 interrupt line is wired up, I'm happy to assume a
>>> single combined interrupt line for now.
>>>
>>
>> I know of one. Although, we have the combined interrupt as well. The
>> binding should allow either way and specify the order. If the event
>> counter interrupt is 1st, then it should be the same to s/w.
> 
> You mean putting the combined interrupt first? If so, we may as well just
> specify that until somebody builds a platform that doesn't have it.
> 

No, either you have 1 interrupt and it is the combined one. or you have
the 9? separate interrupts.  Having both combined and separate hooked up
is a bit dumb, so I would not worry about that case. I would just define
the event counter interrupt 1st as that is probably the primary use.
Also, I think that was the only interrupt on the L2x0 controllers IIRC.

It's also conceivable that some of the interrupts get routed somewhere
else rather than just into the GIC.

Rob
