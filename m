From: B44344@freescale.com (Goel Arpit-B44344)
Date: Wed, 31 Jul 2013 11:09:29 +0000
Subject: [PATCH 0/2] Make PPC macro spin_event_timeout() architecture
 independent
In-Reply-To: <CAMuHMdXP3-uKbftP-2UeZdE6X_iTi1podNDh0aVF3bJwDYssdg@mail.gmail.com>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
 <CAMuHMdXP3-uKbftP-2UeZdE6X_iTi1podNDh0aVF3bJwDYssdg@mail.gmail.com>
Message-ID: <0DFB48290CDB0C4680160EBE62E8F9A809E9A13C@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 2:38 PM, Arpit Goel <B44344@freescale.com> wrote:
> This patch-set moves USECS_PER_JIFFY to architecture timex.h from 
> architecture specific C files. Patch-set further uses this to make PPC 
> macro
> spin_event_timeout() architecture independent. This change enables 
> drivers to use spin_event_timeout() even in non-PowerPC based SoC's.
>
> This patchset has been compiled for ARM, PowerPC and x86.
>
> Patch[1/2] : Moves USECS_PER_JIFFY to architecture specific timex.h files from
>              architecture specific C files.

>  arch/arm/include/asm/timex.h      |  2 ++
>  arch/arm/kernel/time.c            |  3 ---
>  arch/m32r/include/asm/timex.h     |  2 ++
>  arch/m32r/kernel/time.c           |  3 ---
>  arch/m68k/hp300/time.c            |  4 +---
>  arch/m68k/include/asm/timex.h     |  2 ++
>  arch/s390/include/asm/timex.h     |  2 ++
>  arch/s390/kernel/time.c           |  2 --
>  arch/sparc/include/asm/timex_32.h |  2 ++  
> arch/sparc/include/asm/timex_64.h |  2 ++
>  arch/sparc/kernel/pcic.c          |  1 -

As the definition is the same on all architectures, why not move it to <linux/delay.h>?

[Arpit] I will add USECS_PER_JIFFY definition to <linux/timex.h> and will keep 
        definitions in <arch/timex.h> as it is. So that USECS_PER_JIFFY is available 
	  for generic use and architecture specific implementation can override it.	

> Patch[2/2] : Converts PPC macro spin_event_timeout() in architecture independent
>              macro.

>  include/linux/delay.h             | 40 +++++++++++++++++++++++++++++++++++++++

After your first patch, USECS_PER_JIFFY is still available only on arm/m32r/m68k/s390/sparc. What about other architectures?
If anyone uses spin_event_timeout() on e.g. x86, it will fail to compile.
 
[Arpit] After adding USEC_PER_JIFFY to <linux/timex.h>, this issue can be addressed as well.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
