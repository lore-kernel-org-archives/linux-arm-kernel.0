From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 12 Jul 2010 20:38:26 -0400 (EDT)
Subject: [PATCH][RFC] arm: Add basic support for VIA/WonderMedia SoC's
In-Reply-To: <AANLkTilWwclstZiIkpiQQ_CPXgjGD2xz-GEw27hTvAp-@mail.gmail.com>
References: <20100712165025.GA13818@alchark-u3s.alchark.ru>
	<201007122122.32623.arnd@arndb.de>
	<AANLkTilWwclstZiIkpiQQ_CPXgjGD2xz-GEw27hTvAp-@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1007121855470.10598@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 13 Jul 2010, Alexey Charkov wrote:

> Actually, as the devices using these SoC's are mainly generic Chinese
> products, I would not expect any consistency in this area. The
> bootloader is a modification of an old U-boot, but I could not find
> the sources for my version (yes, a GPL violation). It seems to use
> some machine IDs in the range of 4000+, but again I would not trust
> that. That's why I decided to hardcode the intended target devices
> here (which is what some of the other machines do).

We try to avoid those as much as possible of course.

What U-Boot version is this?  The mainline U-Boot has had the ability to 
override the built-in machine ID with an env variable for a while.

> >> +#ifdef CONFIG_MMU
> >> +/* macro to get at IO space when running virtually */
> >> +#define IO_ADDRESS(x) ((x) | 0xf0000000)
> >> +#else
> >> +#define IO_ADDRESS(x) (x)
> >> +#endif
> >
> > I don't know yet what the general consensus in the arm world is about this,
> > but this looks hacky to me. I'd recommend killing off the IO_ADDRESS macro
> > and replacing it with proper calls to ioremap.
> >
> >
> 
> I just followed the way how some of the other machine code functions:
> mach-versatile and mach-realview both define similar macros. If using
> ioremap is a better way, I could try to rework it.

Versatile and RealView are development boards where things like MMU-less 
builds of Linux are tested.  I doubt you'll want to run MMU-less Linux 
on your target.  So this macro is most probably irrelevant for your 
purpose.  And this is unrelated to whether ioremap is a better solution 
(obviously on MMU-less systems ioremap is unavailable).

> >> diff --git a/arch/arm/tools/mach-types b/arch/arm/tools/mach-types
> >> index 8f10d24..f5745d1 100644
> >> --- a/arch/arm/tools/mach-types
> >> +++ b/arch/arm/tools/mach-types
> >> @@ -12,7 +12,7 @@
> >> ?#
> >> ?# ? http://www.arm.linux.org.uk/developer/machines/?action=new
> >> ?#
> >> -# Last update: Sat May 1 10:36:42 2010
> >> +# Last update: Sat Jun 19 13:07:40 2010
> >> ?#
> >> ?# machine_is_xxx ? ? CONFIG_xxxx ? ? ? ? ? ? MACH_TYPE_xxx ? ? ? ? ? number
> >> ?#
> >
> > If you need the updated version of this file, it would probably make
> > sense to build the patch instead a kernel tree that already contains
> > the latest version, rather than Linus' tree.
> >
> 
> I just couldn't find any. It seems that most (all?) trees have at most
> 99a0099a8, which is dated May 1 (too old).

I think what you did is OK.  It is best to include the whole file as 
generated from the machine registry database when you need it.  This way 
the merge conflict can easily be resolved by simply keeping the latest 
version from either merged branches.


> >> diff --git a/drivers/serial/vt8500_serial.c b/drivers/serial/vt8500_serial.c
> >> new file mode 100644
> >> index 0000000..21e0462
> >> --- /dev/null
> >> +++ b/drivers/serial/vt8500_serial.c
> >> @@ -0,0 +1,612 @@
> >> +/*
> >> + * drivers/serial/vt8500_serial.c
> >> + *
> >> + * Copyright (C) 2010 Alexey Charkov <alchark@gmail.com>
> >> + *
> >> + * Based on msm_serial.c, which is:
> >> + * Copyright (C) 2007 Google, Inc.
> >> + * Author: Robert Love <rlove@google.com>
> >
> > This device driver should probably go to the tty maintainer,
> > Greg Kroah-Hartman <gregkh@suse.de>, with the linux-arm-kernel and
> > linux-serial at vger.kernel.org mailing lists on Cc.
> >
> 
> Ok, I will split it out and submit separately. However, this code
> depends on at least <mach/vt8500.h> to compile, so should I wait for
> integration of the remaining parts before submitting the serial
> driver?

You should certainly split it up.  However if you can get ACKs from the 
relevant subsystem maintainers, then it can be agreed that you push that 
(still separate) patch along with the one it depends on.


Nicolas
