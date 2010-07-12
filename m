From: alchark@gmail.com (Alexey Charkov)
Date: Tue, 13 Jul 2010 00:03:07 +0400
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <201007122122.32623.arnd@arndb.de>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007122122.32623.arnd@arndb.de>
Message-ID: <AANLkTilWwclstZiIkpiQQ_CPXgjGD2xz-GEw27hTvAp-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/12 Arnd Bergmann <arnd@arndb.de>:
> On Monday 12 July 2010 18:50:25 Alexey Charkov wrote:
>>
>> This adds basic support for machine initialization, interrupts, timers and
>> serial console on VIA/WonderMedia VT8500 and WM8505 Systems-on-Chip.
>>
>> Signed-off-by: Alexey Charkov <alchark@gmail.com>
>> ---
>>
>> These SoC's are used in quite many netbooks and tablets produced in China
>> and sold online at relatively low prices (typically below 100 USD).
>>
>> Support for WM8505 is known incomplete, while VT8500 is tested by me on the
>> hardware and at least prints kernel messages to the serial console with timing
>> information.
>
> That was quick. Marek already said most of what I had to say about the
> patch, and more. Here are some other minor comments. First of all, I'd
> suggest moving all of the descriptory text above into the changelog
> (above ---), since that looks like useful information to people that might
> want to try out the code.
>
>> + ? ? ? ? ? ? .section ? ? ? ?".start", "ax"
>> +
>> +__VT8500_start:
>> + ? ? ? ? ? ? /* Override the obscure machine id from bootloader */
>> +#ifdef CONFIG_MACH_BV07
>> + ? ? ? ? ? ? mov ? ? r7, #(MACH_TYPE_BV07 & ~0xf)
>> + ? ? ? ? ? ? orr ? ? r7, r7, #(MACH_TYPE_BV07 & 0xf)
>> +#elif defined CONFIG_MACH_WM8505_7IN_NETBOOK
>> + ? ? ? ? ? ? mov ? ? r7, #(MACH_TYPE_WM8505_7IN_NETBOOK & ~0xf)
>> + ? ? ? ? ? ? orr ? ? r7, r7, #(MACH_TYPE_WM8505_7IN_NETBOOK & 0xf)
>> +#endif
>
> Do you have any way to detect the actual machines from the existing
> boot loader? The way you do it here, the kernel ends up being usable
> on only one of the machines at a time.
>

Actually, as the devices using these SoC's are mainly generic Chinese
products, I would not expect any consistency in this area. The
bootloader is a modification of an old U-boot, but I could not find
the sources for my version (yes, a GPL violation). It seems to use
some machine IDs in the range of 4000+, but again I would not trust
that. That's why I decided to hardcode the intended target devices
here (which is what some of the other machines do).

>> +#ifdef CONFIG_MMU
>> +/* macro to get at IO space when running virtually */
>> +#define IO_ADDRESS(x) ((x) | 0xf0000000)
>> +#else
>> +#define IO_ADDRESS(x) (x)
>> +#endif
>
> I don't know yet what the general consensus in the arm world is about this,
> but this looks hacky to me. I'd recommend killing off the IO_ADDRESS macro
> and replacing it with proper calls to ioremap.
>
>

I just followed the way how some of the other machine code functions:
mach-versatile and mach-realview both define similar macros. If using
ioremap is a better way, I could try to rework it.

>> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
>> index 8f10d24..f5745d1 100644
>> --- a/arch/arm/tools/mach-types
>> +++ b/arch/arm/tools/mach-types
>> @@ -12,7 +12,7 @@
>> ?#
>> ?# ? http://www.arm.linux.org.uk/developer/machines/?action=new
>> ?#
>> -# Last update: Sat May 1 10:36:42 2010
>> +# Last update: Sat Jun 19 13:07:40 2010
>> ?#
>> ?# machine_is_xxx ? ? CONFIG_xxxx ? ? ? ? ? ? MACH_TYPE_xxx ? ? ? ? ? number
>> ?#
>
> If you need the updated version of this file, it would probably make
> sense to build the patch instead a kernel tree that already contains
> the latest version, rather than Linus' tree.
>

I just couldn't find any. It seems that most (all?) trees have at most
99a0099a8, which is dated May 1 (too old).

>> diff --git a/drivers/serial/vt8500_serial.c b/drivers/serial/vt8500_serial.c
>> new file mode 100644
>> index 0000000..21e0462
>> --- /dev/null
>> +++ b/drivers/serial/vt8500_serial.c
>> @@ -0,0 +1,612 @@
>> +/*
>> + * drivers/serial/vt8500_serial.c
>> + *
>> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
>> + *
>> + * Based on msm_serial.c, which is:
>> + * Copyright (C) 2007 Google, Inc.
>> + * Author: Robert Love <rlove@google.com>
>
> This device driver should probably go to the tty maintainer,
> Greg Kroah-Hartman <gregkh@suse.de>, with the linux-arm-kernel and
> linux-serial at vger.kernel.org mailing lists on Cc.
>

Ok, I will split it out and submit separately. However, this code
depends on at least <mach/vt8500.h> to compile, so should I wait for
integration of the remaining parts before submitting the serial
driver?

>> +struct vt8500_port {
>> + ? ? struct uart_port ? ? ? ?uart;
>> + ? ? char ? ? ? ? ? ? ? ? ? ?name[16];
>> + ? ? struct clk ? ? ? ? ? ? ?*clk;
>> + ? ? unsigned int ? ? ? ? ? ?ier;
>> +};
>> +
>> +#define UART_TO_VT8500(uart_port) ? ?((struct vt8500_port *) uart_port)
>
> Instead of the direct cast from one type to another, please use
> container_of(), which is more type safe.
>

Thanks, I'll do that. Probably msm_serial would also need conversion
then (the construct is taken from there).

>> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
>> index f10db6e..20ba8c3 100644
>> --- a/include/linux/serial_core.h
>> +++ b/include/linux/serial_core.h
>> @@ -186,6 +186,9 @@
>> ?#define PORT_ALTERA_JTAGUART 91
>> ?#define PORT_ALTERA_UART ? ? 92
>>
>> +/* VIA VT8500 SoC */
>> +#define PORT_VT8500 ? ?93
>> +
>> ?#ifdef __KERNEL__
>>
>
> In the linux-next tree, number 94 is already being used, so you should
> probably use 95 as the next free number when sending the driver to the
> serial list.
>
> Otherwise, as I mentioned before, nice work!
>
> ? ? ? ?Arnd
>

Thanks!

Alexey
