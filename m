From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 19 Feb 2011 11:16:17 +0100
Subject: platform/i2c busses: pm runtime and system sleep
In-Reply-To: <20110219100017.GA29493@n2100.arm.linux.org.uk>
References: <AANLkTinyDE3OxKup_aqsN8HJH_r5LcwkP17OtuMRpACx@mail.gmail.com>
	<201102181928.05911.rjw@sisk.pl>
	<AANLkTi=j9KeX2TSzMaKMWR6GpXjFcsjp0z8Rt+ArLXiV@mail.gmail.com>
	<201102182120.29977.rjw@sisk.pl>
	<20110218202744.GA19427@n2100.arm.linux.org.uk>
	<AANLkTim2TfG-18XN3r9m3Rq68ZD6QHUY7X82E4-XWH83@mail.gmail.com>
	<20110219100017.GA29493@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinz55AAYA7Ltgcs_z+ysedxtavW2xsdw4=4qP0_@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/2/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> [Me]
>> Both of these problems are solved by elegance if we use runtime
>> PM, since it will provide a hysteresis timeout that can be triggered
>> from interrupt context and call the idling hooks in process context.
>
> So what's the interdependence with the platform bus that was being talked
> about earlier in this thread?

That's about consistency of runtime PM semantics across
different buses as I understand it.

We have both platform bus and AMBA bus devices in the system,
so it is desireable if the semantics of their runtime PM are identical.

If I understand it, the difference is that the platform bus will call
runtime_suspend() on the device even if it was already in suspended
state, so the question is about whether the AMBA runtime PM
should do this too since it is similar to the platform bus, or if it should
go for the more intutive approach of not suspending suspended
hardware.

I think the current patch from Rabin as it stands does the latter, and
is good as it stands. It's the other buses and their drivers that
need patching.

Yours,
Linus Walleij
