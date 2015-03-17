From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Mar 2015 11:50:42 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Tue, Mar 17, 2015 at 4:48 AM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> I've been running XIP_KERNEL with linux-3.14 on a Renesas RZ/A1 (ARCH_R7S72100) for a while now (with some bug fixes of course) so I thought I'd see if my fixes should be pushed back upstream.
>
> However, I see that all the Renesas parts are being moved to ARCH_MULTIPLATFORM, which by means of arch/arm/Kconfig disallows XIP_KERNEL.
>
> Looking back through the mailing list archives I see that there was some discussion on this, but never really a conclusion.
>
> So my question is basically: What is the correct configuration to use XIP_KERNEL with a Renesas SoC? Is the idea that I need to go carve up my own config and do everything outside the normal tree from here on out?

The issue you're facing is that ARCH_MULTIPLATFORM actually means two things:
  1. Use modern infrastructure (e.g. DT, CCF, GPIOLIB, ...) instead of board
     files with platform devices,
  2. Allow to build a single kernel that supports multiple SoC families and/or
     boards.

The first thing is not incompatible with XIP_KERNEL (AFAIK), the second is
(or rather, may be?).

Perhaps ARCH_MULTIPLATFORM should be replaced by ARCH_ARM_NEWWORLD
almost everywhere, and (new) ARCH_MULTIPLATFORM should be reserved
(if needed at all) to protect features that are not compatible with running on
multiple machines?

Besides, I think a multi-platform XIP (or nommu) kernel is possible, as long
as XIP_PHYS_ADDR (or PHYS_OFFSET) is suitable for all platforms included.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
