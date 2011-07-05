From: bjorn.forsman@gmail.com (=?UTF-8?Q?Bj=C3=B8rn_Forsman?=)
Date: Tue, 5 Jul 2011 23:42:09 +0200
Subject: [PATCH v2] ARM: kirkwood: Add support for Buffalo LS-XHL
In-Reply-To: <201107042250.42500.michael@walle.cc>
References: <1307655488-12811-1-git-send-email-michael@walle.cc>
	<1307655488-12811-2-git-send-email-michael@walle.cc>
	<BANLkTim-qB+ArwxX0o8dAqU3--Uex4TWBw@mail.gmail.com>
	<201107042250.42500.michael@walle.cc>
Message-ID: <CAEYzJUHfu=PCjW1FfuEZ4BwJ9qrrv8ZLNGKfoOXp6bcE_nuGAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/7/4 Michael Walle <michael@walle.cc>:
> Am Donnerstag 30 Juni 2011, 22:58:15 schrieb Bj?rn Forsman:
>> Hi Michael,
> [..]
>> So, the power switch also seem to suffer from some interrupt overload;
>> 10154532 IRQs for Power-auto Switch is not right...right?
>>
>> Have you seen this behaviour?
> Nope, the interrupt behaves normally for me. But i'm running this patch with
> kernel 2.6.32 and tested it briefly with 2.6.39.
>
> Could you verify, if you are triggering the bug Simon posted above?

Yes, it must be the same bug. I reverted
e59347a1d15c0b1d9fdc510520f8fa78d7d19a5b (arm: orion: Use generic irq
chip) on top of "3.0-rc5 + this LS-XHL patch" and the IRQ issues are
gone.

$ cat /proc/interrupts   # after toggling the buttons and setting fan
speed to 0 a few times
...
104:          4  orion_gpio_irq  GPIO fan alarm
105:          4  orion_gpio_irq  Function Button
106:          6  orion_gpio_irq  Power-auto Switch
107:          4  orion_gpio_irq  Power-on Switch

No system hang/reboot/lockups :-)

Compare that with /proc/interrupts from the bugged version; it lists
"-" instead of "orion_gpio_irq" as IRQ handler:

104:     100000         -  GPIO fan alarm
105:          0         -  Function Button
106:          0         -  Power-auto Switch
107:          0         -  Power-on Switch

Best regards,
Bj?rn Forsman
