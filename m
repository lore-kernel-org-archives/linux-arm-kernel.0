From: robherring2@gmail.com (Rob Herring)
Date: Wed, 13 Mar 2013 11:32:01 -0500
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <CAD6h2NTufx2rRwbwsgGHN42t7+_KL418++zk_C++EvFKU+ZwLg@mail.gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
 <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
 <1363175175.3100.37.camel@hornet>
 <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
 <1363186087.3100.72.camel@hornet>
 <CAD6h2NRkS4qk+iqbWhaOpBHmjSYOB=YBbfNkn0X3jzNawzgNEA@mail.gmail.com>
 <1363187979.3100.93.camel@hornet>
 <CAD6h2NTufx2rRwbwsgGHN42t7+_KL418++zk_C++EvFKU+ZwLg@mail.gmail.com>
Message-ID: <5140AA01.1010007@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/13/2013 10:59 AM, Haojian Zhuang wrote:
> On 13 March 2013 23:19, Pawel Moll <pawel.moll@arm.com> wrote:
>> On Wed, 2013-03-13 at 15:01 +0000, Haojian Zhuang wrote:
>>> Yes, it's possible. Since only clocksource / clockevent is using SP804 timer
>>> on the VE platform. If user app or something else is using other SP804
>>> timer, it would be mess because of resource conflict.
>>
>> How would you expose this device to the app or something else? It's an
>> amba_bus device, so it must be bound with an amba_driver. Otherwise
>> you're abusing the device model and, well, you're on your own.
>>
>> The devices are managed by the system. The device tree is merely a
>> description of the available hardware.
>>
> Maybe I didn't express my idea well. My point is that timer could be
> clock source
> /clock event. It could also just be a timer that user app or other device driver
> may want to use it directly. There're a lot of reason that user app or some
>  driver wants to use hardware timer. For example, the specific timer may
> keep running even system is in low power mode.
> 
> Although there's so much hardware timers available, system must choose
> one for the usage of clock source / clock event / other hardware timer usage.
> 
>>>>> Imagine that only TIMINT1 signal in sp804 is routed to interrupt controller.
>>>>> Could system still pick any one it wants?
>>>>
>>> Then we need another new property. I try to find using minim properties.
>>
>> No, we don't. See the discussion with Rob. He has an idea (using the
>> interrupt property only), I have another one (using already defined
>> interrupt-names property). I see you've just came with another one
>> (TIMINTC treated as TIMINT1), which is fine with me. Either way you've
>> got what you need to make the right decision.
>>
> After considered as second time, I think that we still need a property to meet
> alias usage. Excuse me expand it in this topic.
> 
> arm,sp804-has-irq = <offset>;

Interrupt/timer number not offset please. The offset is implied by the
fact that the h/w is an sp804. The Integrator AP is not actually an
sp804, so it's init should be handled differently with a different
compatible property.

> The offset means TIMER register offset. If it's not zero, TIMER2 is using
> irq. And it could be configured as clock event. Otherwise, TIMER1 is clock
> event.
> We must make sure that only one of all sp804 timers is using this property.
> 
> alias:
> linux,clocksource = <&sp804-A>
> linux,clockevent = <&sp804-A>
> 
> Although both of them points to timerA, only TIMER1 or TIMER2 of sp804
> is using irq. So one is clock source, and the other is clock event.
> 
> alias:
> linux,clocksource = <&sp804-A>
> linux,clockevent = <&sp804-B>
> The issue comes since system don't know whether TIMER1 or TIMER2 could
> be configured as clock source.

If you have 2 sp804's, why do you care which one is used by the OS? If
they are identical, then it doesn't matter. If they are not, then
describe how they are not identical.

The realview and versatile boards currently do this, but there is no
good reason that I see and I intend to change this.

> We still need a new property to claim it. It seems that we can't drop
> "arm,sp804-clocksource", although everybody don't like it.
> 
> What's your opinion?

As previously stated, I don't think we need this or the alias based on
current in tree users.

There is an issue that you don't know about all available timers so you
can select the one with the minimum required features leaving others
with more features (i.e. an irq) free. If you need more control like
this then you can do custom setup before or instead of calling
clocksource_of_init. None of the current platforms have this issue nor
do they use sp804 for anything beyond clksrc and clkevt. I would not
expect lots of new users of sp804 as I expect most new platforms will
use architected timers. So let's not solve imaginary problems now.

Rob
