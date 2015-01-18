From: gnurou@gmail.com (Alexandre Courbot)
Date: Sun, 18 Jan 2015 16:04:22 +0900
Subject: [PATCH v4 3/4] gpio: Add find GPIO base in increasing order
In-Reply-To: <CACRpkdYeiaWxPeeoJjX6BKDmnk2swKCnGgJCW6p9AZ3fdFVSpQ@mail.gmail.com>
References: <1417750722-14027-1-git-send-email-wangzhou.bry@gmail.com>
 <1417750722-14027-4-git-send-email-wangzhou.bry@gmail.com>
 <CAAVeFu+Hn1Fk7PDcc4wGHFyJurX0hsW1N1prnPs2j=taGQKrKw@mail.gmail.com>
 <CACRpkdZccD_FM+m3US3e40LitH4OsX-8cSS_ju+C541330PdXw@mail.gmail.com>
 <CAAVeFuJkr9mFwJq0GdbLO7EgbffvD25bjBVdXAFZubq5Sz4MZQ@mail.gmail.com>
 <CACRpkdYeiaWxPeeoJjX6BKDmnk2swKCnGgJCW6p9AZ3fdFVSpQ@mail.gmail.com>
Message-ID: <CAAVeFu+niUcjEaDCc6BxyZ7SY66U5y+fZh4zz-4A8vZn60syCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 12:24 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Wed, Jan 14, 2015 at 9:17 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
>> On Wed, Jan 14, 2015 at 5:13 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> On Wed, Dec 10, 2014 at 9:51 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
>>>> On Fri, Dec 5, 2014 at 12:38 PM, Zhou Wang <wangzhou.bry@gmail.com> wrote:
>>>>> In function gpiochip_find_base, base number of a GPIO controller
>>>>> is found in decreasing order. ARCH_NR_GPIOS is used to define from
>>>>> which number we begin to search for base number of a GPIO controller.
>>>>>
>>>>> In fact, ARCH_NR_GPIOS brings us some multiplatform problems, like:
>>>>> http://www.spinics.net/lists/devicetree/msg60433.html
>>>>>
>>>>> This patch adds the support to find base number of a GPIO controller
>>>>> in increasing order. It will assign base number from 0.
>>>>> A new dts property called gpio-number-forward must be add to the related
>>>>> GPIO dts nodes if you want it works well.
>>>>
>>>> Global GPIO numbers are a Linux-only concept, so your property should
>>>> be named linux,gpio-number-forward.
>>>>
>>>> But even that way I don't think I like this idea. This just adds some
>>>> more mess to how the GPIO number space is constructed, and it is
>>>> already quite messy as it is. You have no guarantee over the probe
>>>> order of your GPIO controllers, so they may very well be probed in a
>>>> different order and end up with different base numbers anytime.
>>>
>>> Yup.
>>>
>>> The way stuff is usually forced ordered in device tree is to use
>>> aliases, e.g.:
>>>
>>>         aliases {
>>>                 serial0 = &pb1176_serial0;
>>>                 serial1 = &pb1176_serial1;
>>>                 serial2 = &pb1176_serial2;
>>>                 serial3 = &pb1176_serial3;
>>>                 serial4 = &fpga_serial;
>>>         };
>>>
>>> By getting the alias ID with of_alias_get_id(np, "serial")
>>> a certain serial port is assigned to be
>>> 0, 1, 2 ...
>>>
>>> I think I could accept a tweak of this patch that will register
>>> GPIOs beginning from 0 if and only if the alias mechanism is
>>> used.
>>>
>>>         aliases {
>>>                 gpio0 = &foo_gpio0;
>>>                 gpio1 = &expander;
>>>         };
>>>
>>>
>>> The actual Linux-specific integer base will *NOT* be in the
>>> device tree, but if you know how many GPIOs are on each
>>> controller the number space is still stable and predictable
>>> beginning from 0. If one want to keep track of the Linux
>>> number space one can do so with comments in the device
>>> tree or something.
>>>
>>>> I know we pushed back against this kind of solution in the past, but
>>>> it is still more reliable than having a property that affects how the
>>>> kernel's base finding function works, and will offer us a way to
>>>> eventually put ARCH_NR_GPIOS and gpiochip_find_base() to rest (at the
>>>> cost of backwards-compatibility, but we just cannot do without it).
>>>> Linus, do you agree?
>>>
>>> What do you think about the above?
>>
>> It would definitely help with the probe order, but unfortunately not
>> with the fact that GPIO bases are allocated in decreasing order
>> starting from the potentially varying ARCH_NR_GPIOS. So that alone
>> will not be able to ensure stable GPIO numbers.
>
> What I mean is that if and only if aliases are used, we
> allocate GPIOs in ascending order starting at 0.
>
> Let us remember why this is done: dynamic GPIO numbers are
> allocated in descending order because it was assumed that some
> static GPIOs are already allocated starting from 0, like on-chip
> GPIOs.
>
> We can also make it a Kconfig option, because for a large chunk
> of systems only using device tree we can
> actually allocate from zero. Notably any ARCH_MULTIPLATFORM
> should just do this if we can make a quick survey of such systems
> and see that they don't fool around setting .base in their GPIO
> chips.

Ah, in that case yes, I agree it would probably work fine.
