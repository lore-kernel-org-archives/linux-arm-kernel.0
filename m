From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 May 2011 09:46:06 +0200
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <20110520065248.GB21285@ponder.secretlab.ca>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=poU17RqAzp28CPjWHrN_+aFiyag@mail.gmail.com>
	<BANLkTindee6UMez8HyBUwd2H6mN-DknzPw@mail.gmail.com>
	<BANLkTik7BnJKWCsm2L3-GJPTaaiXFNSgaA@mail.gmail.com>
	<20110520065248.GB21285@ponder.secretlab.ca>
Message-ID: <BANLkTimMzEDm1wGu4TaYnsOQAu-e=90SAg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/20 Grant Likely <grant.likely@secretlab.ca>:
> On Thu, May 19, 2011 at 02:25:47PM +0200, Linus Walleij wrote:
>> On Thu, May 19, 2011 at 1:38 PM, Barry Song <21cnbao@gmail.com> wrote:
>>
>> >> -arch_initcall(u300_gpio_init);
>> >> -module_exit(u300_gpio_exit);
>> >>
>> > looks like the driver can't be a real module, is the module_exit
>> > suitable? it looks strange module_exit plays together with
>> > arch_initcall.
>>
>> It's a rather common design pattern in the kernel for early
>> platform drivers. Either the dependencies are resolved by the
>> different initlevels or they are resolved in probe order with
>> loadable modules. Module load will call all initlevels in order.
>>
>> It is not elegant but it is common.
>
> but it does need to be fixed. ?Unfortunately it is not simple. ?What
> is needed is a generic deferral or ability for drivers to declare
> dependences on other devices beyond their immediate parent.
>
> I've thought about this a bit on and off over the last year, but I
> haven't actually sat down to try and hack anything out yet.

Sounds like it needs to do for the kernel what systemd does for
userspace in my ears. And I wholeheartedly agree it needs
fixing.

A main concern would be that these dependencies are currently
implicit, Arjan did a great job on fixing some of it by
parallellizing initilization of drivers per initlevel and sync it at at
the end of each level, doing a clean dependecy resolution
would do away with all the initlevels eventually.

Yours,
Linus Walleij
