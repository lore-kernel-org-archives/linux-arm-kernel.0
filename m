From: alchark@gmail.com (Alexey Charkov)
Date: Tue, 13 Jul 2010 12:23:44 +0400
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <alpine.LFD.2.00.1007121855470.10598@xanadu.home>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007122122.32623.arnd@arndb.de>
	<AANLkTilWwclstZiIkpiQQ_CPXgjGD2xz-GEw27hTvAp-@mail.gmail.com>
	<alpine.LFD.2.00.1007121855470.10598@xanadu.home>
Message-ID: <AANLkTil8aDUl2T-P1eZIdiLrXc05VyWWvpCg8QmfuZDp@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/13 Nicolas Pitre <nico@fluxnic.net>:
> On Tue, 13 Jul 2010, Alexey Charkov wrote:
>
>> Actually, as the devices using these SoC's are mainly generic Chinese
>> products, I would not expect any consistency in this area. The
>> bootloader is a modification of an old U-boot, but I could not find
>> the sources for my version (yes, a GPL violation). It seems to use
>> some machine IDs in the range of 4000+, but again I would not trust
>> that. That's why I decided to hardcode the intended target devices
>> here (which is what some of the other machines do).
>
> We try to avoid those as much as possible of course.
>
> What U-Boot version is this? ?The mainline U-Boot has had the ability to
> override the built-in machine ID with an env variable for a while.
>

When booting, it prints "VT8500 U-Boot 1.2.19.1 (Dec  4 2009 -
17:14:38)". If there is a way to drop a couple of hacks, I would be
really glad, of course :) A quick grep through U-boot's commit history
did not provide me with any clue about this feature, though. Need to
search better...

>> >> +#ifdef CONFIG_MMU
>> >> +/* macro to get at IO space when running virtually */
>> >> +#define IO_ADDRESS(x) ((x) | 0xf0000000)
>> >> +#else
>> >> +#define IO_ADDRESS(x) (x)
>> >> +#endif
>> >
>> > I don't know yet what the general consensus in the arm world is about this,
>> > but this looks hacky to me. I'd recommend killing off the IO_ADDRESS macro
>> > and replacing it with proper calls to ioremap.
>> >
>> >
>>
>> I just followed the way how some of the other machine code functions:
>> mach-versatile and mach-realview both define similar macros. If using
>> ioremap is a better way, I could try to rework it.
>
> Versatile and RealView are development boards where things like MMU-less
> builds of Linux are tested. ?I doubt you'll want to run MMU-less Linux
> on your target. ?So this macro is most probably irrelevant for your
> purpose. ?And this is unrelated to whether ioremap is a better solution
> (obviously on MMU-less systems ioremap is unavailable).
>

I see the point. Will have to understand better how the whole remapped
IO works and remove the macro.

>> >> diff --git a/drivers/serial/vt8500_serial.c b/drivers/serial/vt8500_serial.c
>> >> new file mode 100644
>> >> index 0000000..21e0462
>> >> --- /dev/null
>> >> +++ b/drivers/serial/vt8500_serial.c
>> >> @@ -0,0 +1,612 @@
>> >> +/*
>> >> + * drivers/serial/vt8500_serial.c
>> >> + *
>> >> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
>> >> + *
>> >> + * Based on msm_serial.c, which is:
>> >> + * Copyright (C) 2007 Google, Inc.
>> >> + * Author: Robert Love <rlove@google.com>
>> >
>> > This device driver should probably go to the tty maintainer,
>> > Greg Kroah-Hartman <gregkh@suse.de>, with the linux-arm-kernel and
>> > linux-serial at vger.kernel.org mailing lists on Cc.
>> >
>>
>> Ok, I will split it out and submit separately. However, this code
>> depends on at least <mach/vt8500.h> to compile, so should I wait for
>> integration of the remaining parts before submitting the serial
>> driver?
>
> You should certainly split it up. ?However if you can get ACKs from the
> relevant subsystem maintainers, then it can be agreed that you push that
> (still separate) patch along with the one it depends on.
>
>
> Nicolas
>

Ok, got it. Thank you, Nicolas!

Alexey
