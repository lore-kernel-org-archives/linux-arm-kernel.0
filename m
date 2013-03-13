From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 Mar 2013 15:19:39 +0000
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <CAD6h2NRkS4qk+iqbWhaOpBHmjSYOB=YBbfNkn0X3jzNawzgNEA@mail.gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
 <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
 <1363175175.3100.37.camel@hornet>
 <CAD6h2NSUyFvhoqMsYqT=rzFZ--MWv+0vHOCtAV9n-5YO+LNTMA@mail.gmail.com>
 <1363186087.3100.72.camel@hornet>
 <CAD6h2NRkS4qk+iqbWhaOpBHmjSYOB=YBbfNkn0X3jzNawzgNEA@mail.gmail.com>
Message-ID: <1363187979.3100.93.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 15:01 +0000, Haojian Zhuang wrote:
> Yes, it's possible. Since only clocksource / clockevent is using SP804 timer
> on the VE platform. If user app or something else is using other SP804
> timer, it would be mess because of resource conflict.

How would you expose this device to the app or something else? It's an
amba_bus device, so it must be bound with an amba_driver. Otherwise
you're abusing the device model and, well, you're on your own.

The devices are managed by the system. The device tree is merely a
description of the available hardware.

> >> Imagine that only TIMINT1 signal in sp804 is routed to interrupt controller.
> >> Could system still pick any one it wants?
> >
> Then we need another new property. I try to find using minim properties.

No, we don't. See the discussion with Rob. He has an idea (using the
interrupt property only), I have another one (using already defined
interrupt-names property). I see you've just came with another one
(TIMINTC treated as TIMINT1), which is fine with me. Either way you've
got what you need to make the right decision.

> As I mentioned above, system must know the behavior first. The upper layer
> software could know which timer is used in clocksource or clockevent.

I claim otherwise. The upper layer software should know what does the
hardware offer and based on this knowledge use it in a way it wants to.

> For example, your Android system could be shared on multiple platforms. It
> could parse hardware information from DTS. (Of course, it hasn't this feature
> yet). Then it could arrange apps to use other timers.

I honestly don't know what are you suggesting here other than it looks
like an abuse to the device model.

> It's like you define console on specified UART even you have multiples UART
> port.

Where do you do this? In the Device Tree? No. In the kernel command
line, which is a runtime argument (the fact it is actually being passed
through the tree is irrelevant here) You have the serialX aliases, which
- again - simply describe the hardware ("this node is connected to a
connector labeled as serial X"). The tree doesn't tell that the user
connected his serial cable to serial1 so it should be used as the
console.

Pawe?
