From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 19 May 2011 22:05:25 +0800
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <BANLkTinABWucqESqSRYJV+-frm6vDmpxFQ@mail.gmail.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<BANLkTi=poU17RqAzp28CPjWHrN_+aFiyag@mail.gmail.com>
	<BANLkTindee6UMez8HyBUwd2H6mN-DknzPw@mail.gmail.com>
	<BANLkTik7BnJKWCsm2L3-GJPTaaiXFNSgaA@mail.gmail.com>
	<BANLkTim2rv9QHDd2zjBfyVqG9dSGCM=PAw@mail.gmail.com>
	<BANLkTinABWucqESqSRYJV+-frm6vDmpxFQ@mail.gmail.com>
Message-ID: <BANLkTim=iwHY2NhWuK6qmhAdez-5AiJDBw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/19 Linus Walleij <linus.walleij@linaro.org>:
> On Thu, May 19, 2011 at 2:35 PM, Barry Song <21cnbao@gmail.com> wrote:
>> 2011/5/19 Linus Walleij <linus.walleij@linaro.org>:
>>> On Thu, May 19, 2011 at 1:38 PM, Barry Song <21cnbao@gmail.com> wrote:
>>>>
>>>> looks like the driver can't be a real module, is the module_exit
>>>> suitable? it looks strange module_exit plays together with
>>>> arch_initcall.
>>>
>>> It's a rather common design pattern in the kernel for early
>>> platform drivers. Either the dependencies are resolved by the
>>> different initlevels or they are resolved in probe order with
>>> loadable modules. Module load will call all initlevels in order.
>>>
>>> It is not elegant but it is common.
>>
>> Linus, thanks for your reply. module_exit and related functions are
>> really useless codes. but people have done that before, then we have
>> no way except following.
>> u300_gpio_exit never gets chance to run and when we disassemble
>> vmlinux, u300_gpio_exit() ?function should be not in the final binary
>> at all, just a symbol name is left.
>
> I know. I can make the Kconfig options tristate if it makes you feel
> better...
what i feel headache is that it is really difficult and unpredicted
for an internal gpio driver to be removable in lots of read products
because gpio is probably the last bottom module other drivers need.
even it can be called in arch/arm/plat(mach).

i am not sure whether  i am thinking right. gpio and pinmux are more
things of bottom level APIs like dma/clock tree but not like device
drivers.  but i really think you have sent a great pinmux core
framework.

we once thought we could have a plat-common above all
plat-xxx/mach-xxx, and let the plat-common provide the cores of dma,
clk, gpio, pinmux(pinmux core from you), for example, all common API
and abstract level codes like gpio_request can be there, and SoCs just
implement some hardware-related callbacks required by plat-common in
themselves plat-xxx .

>
> Linus Walleij
>
