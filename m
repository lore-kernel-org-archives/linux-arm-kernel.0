From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Thu, 12 Mar 2015 22:08:13 +0100
Subject: [PATCH v2 05/18] reset: Add reset_controller_of_init() function
In-Reply-To: <CAL_Jsq+_ridpAaUwpqo91xB6Ea1ctCWfYTYUrcZ=gB_0FiBD4g@mail.gmail.com>
References: <1424455277-29983-1-git-send-email-mcoquelin.stm32@gmail.com>
 <8729383.kvUZDm4dQz@wuerfel>
 <CALszF6BkTOLR+VNkRKfvEBG5ZyaYL+9fZ4EAPVu5b_imCvEQoQ@mail.gmail.com>
 <6773745.i9mx5zmPP4@wuerfel>
 <CAL_Jsq+_ridpAaUwpqo91xB6Ea1ctCWfYTYUrcZ=gB_0FiBD4g@mail.gmail.com>
Message-ID: <CALszF6AiZ_9Hgz36hyVTSWdtf06QxHnWKjNEjVdU7v7j8m1GiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-03-10 22:30 GMT+01:00 Rob Herring <robherring2@gmail.com>:
> On Tue, Mar 10, 2015 at 3:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 10 March 2015 16:28:44 Maxime Coquelin wrote:
>>> 2015-03-10 16:00 GMT+01:00 Arnd Bergmann <arnd@arndb.de>:
>>> > On Friday 20 February 2015 19:01:04 Maxime Coquelin wrote:
>>> >> Some platforms need to initialize the reset controller before the timers.
>>> >>
>>> >> This patch introduces a reset_controller_of_init() function that can be
>>> >> called before the timers intialization.
>>> >>
>>> >> Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
>>> >>
>>> >
>>> > Not sure about this. It seems like the cleanest approach if we get
>>> > a lot of these, but then again it is probably very rare, and I'd
>>> > like to avoid adding such infrastructure if it's just for one
>>> > SoC. Could we add a hack in the machine initialization instead?
>>>
>>> Sun6i also need to initialize the reset controller early. Today, they
>>> hack the machine initialization.
>>> With two SoCs having the same need, what should we do?
>>
>> Good question, I'd like to hear some other opinions on this first.
>
> 2 is still far from the common case.
>
>>> > I think ideally this would be done in the boot loader before we
>>> > even start Linux, but I don't know if that's possible for you.
>>>
>>> From what I understand, the only constraint is to perform it after the
>>> clock is enabled.
>>> So this should be possible to do it in the bootloader, but it means
>>> also adding timers clocks ungating in the bootloader.
>>
>> Ungating the timer clock input seems like a reasonable thing to
>> do for the bootloader, I think a lot of platforms rely on this
>> elsewhere (but enough of them don't, which is why we have the
>> early clk init).
>
> +1
>
> If the bootloader is u-boot, then you need a timer anyway.

Ok, I moved it to the bootloader, and use the reset as optional in the
timer driver.

Thanks,
Maxime
>
> Rob
