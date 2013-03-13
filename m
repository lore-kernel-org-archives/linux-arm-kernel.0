From: haojian.zhuang@linaro.org (Haojian Zhuang)
Date: Wed, 13 Mar 2013 23:01:40 +0800
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <1363186087.3100.72.camel@hornet>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
 <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
 <1363175175.3100.37.camel@hornet>
 <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
 <1363186087.3100.72.camel@hornet>
Message-ID: <CAD6h2NRkS4qk+iqbWhaOpBHmjSYOB=YBbfNkn0X3jzNawzgNEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 March 2013 22:48, Pawel Moll <pawel.moll@arm.com> wrote:
> On Wed, 2013-03-13 at 12:21 +0000, Haojian Zhuang wrote:
>> Do you mean that system wants to pick any one randomly? It's impossible.
>
> It is possible in case of the VE platform. Therefore it is not
> completely impossible. QED :-)
>
Yes, it's possible. Since only clocksource / clockevent is using SP804 timer
on the VE platform. If user app or something else is using other SP804
timer, it would be mess because of resource conflict.

>> Imagine that only TIMINT1 signal in sp804 is routed to interrupt controller.
>> Could system still pick any one it wants?
>
Then we need another new property. I try to find using minim properties.

> If you tell the system that only TIMINT1 is wired, it shouldn't even try
> to use the second timer for anything that would require the interrupt.
> Therefore, describing the hardware sufficiently, you're giving the
> system enough information to make the right decisions.
>
>> I think that clocksource or clockevent must be specified in DTS. Whatever
>> we're using alias or property.
>
> I'm convinced it does not *must* be there. I think it *can* be there,
> for platforms where the available timers are not equal (for whatever
> reason). My point is: why are you trying to force me to put some
> information into my hardware description which doesn't have any meaning
> for me?
>
As I mentioned above, system must know the behavior first. The upper layer
software could know which timer is used in clocksource or clockevent.

For example, your Android system could be shared on multiple platforms. It
could parse hardware information from DTS. (Of course, it hasn't this feature
yet). Then it could arrange apps to use other timers.

It's like you define console on specified UART even you have multiples UART
port.
