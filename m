From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 24 Oct 2016 10:53:12 +0200
Subject: Build regressions/improvements in v4.9-rc2
In-Reply-To: <1477298556-1522-1-git-send-email-geert@linux-m68k.org>
References: <1477298556-1522-1-git-send-email-geert@linux-m68k.org>
Message-ID: <CAMuHMdU8bgMR2U-mdjkyqXnUxbYMqfUUSNRoGc8+Mk5tZVDF4g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 10:42 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v4.9-rc2[1] to v4.9-rc1[3], the summaries are:
>   - build errors: +10/-21

  + /home/kisskb/slave/src/arch/arm/include/asm/dma-mapping.h: error:
invalid suffix "xUL" on integer constant:  => 84:1
  + /home/kisskb/slave/src/include/linux/dma-mapping.h: error: invalid
suffix "xUL" on integer constant:  => 190:1, 193:1
  + /home/kisskb/slave/src/include/linux/mm.h: error: invalid suffix
"xUL" on integer constant:  => 555:1
  + /home/kisskb/slave/src/include/linux/scatterlist.h: error: invalid
suffix "xUL" on integer constant:  => 142:1

arm-randconfig

Not a new problem. Real issue is "CONFIG_PAGE_OFFSET=" in .config,
leading to:

    ./include/generated/autoconf.h:1113:28: error: invalid suffix
"xUL" on integer constant
     #define CONFIG_PAGE_OFFSET 0x

Why is CONFIG_PAGE_OFFSET empty?

    scripts/kconfig/conf  --oldconfig Kconfig
    .config:316:warning: symbol value '' invalid for PAGE_OFFSET

config PAGE_OFFSET
        hex
        default PHYS_OFFSET if !MMU

# CONFIG_MMU is not set
but CONFIG_PHYS_OFFSET does not exist in .config??

config PHYS_OFFSET
        hex "Physical address of main memory" if MMU
        depends on !ARM_PATCH_PHYS_VIRT
        default DRAM_BASE if !MMU
        default 0x00000000 if ARCH_EBSA110 || \
                        ARCH_FOOTBRIDGE || \
                        ARCH_INTEGRATOR || \
                        ARCH_IOP13XX || \
                        ARCH_KS8695 || \
                        ARCH_REALVIEW
        default 0x10000000 if ARCH_OMAP1 || ARCH_RPC
        default 0x20000000 if ARCH_S5PV210
        default 0xc0000000 if ARCH_SA1100
        help
          Please provide the physical address corresponding to the
          location of main memory in your system.

CONFIG_DRAM_BASE=0x00800000

Aha, CONFIG_ARM_PATCH_PHYS_VIRT=y

> [1] http://kisskb.ellerman.id.au/kisskb/head/11104/ (all 262 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/11053/ (all 262 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
