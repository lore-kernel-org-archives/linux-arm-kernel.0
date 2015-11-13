From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 13 Nov 2015 08:46:24 +0100
Subject: [PATCH v2] ARM: xip: Use correct symbol for end of ROM marker
In-Reply-To: <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
References: <1447251455-22731-1-git-send-email-chris.brandt@renesas.com>
 <1447362108-4333-1-git-send-email-chris.brandt@renesas.com>
Message-ID: <CAMuHMdXsw8BBCY5-fxWLvF1vxh83DhhKGD113LTBu-8ZFV68gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Thu, Nov 12, 2015 at 10:01 PM, Chris Brandt <chris.brandt@renesas.com> wrote:
> For an XIP build, _edata_loc, not _etext, represents the end of the
> binary image that will be programmed into ROM and mapped into the
> MODULES_VADDR area.
> With an XIP kernel, nothing is loaded into RAM before boot, meaning
> you have to take into account the size of the entire binary image
> that was programmed, including the init data values that will be copied
> to RAM during kernel boot.
>
> This fixes the bug where you might lose the end of your kernel area
> after page table setup is complete.

Thanks for your patch!

> Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
> ---
> v2
> * Added change for MODULES_VADDR
> * Moved extern to new file asm/sections.h
> ---
>  arch/arm/include/asm/sections.h |    8 ++++++++
>  arch/arm/kernel/module.c        |    2 +-
>  arch/arm/mm/mmu.c               |    4 ++--
>  3 files changed, 11 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm/include/asm/sections.h

If you create an arm-specific <asm/sections.h>, you also have to remove the
line

        generic-y += sections.h

from arch/arm/include/asm/Kbuild.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
