From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 3 Oct 2014 13:28:39 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <542E7843.8090703@renesas.com>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <542DE80D.2000600@renesas.com>
 <CAMuHMdWvYWrZBhFz7aZgV3b7S0r8OsQdPN4DBCB2+crY+Bqq=A@mail.gmail.com>
 <542E7843.8090703@renesas.com>
Message-ID: <CAMuHMdWk7BdpH9zrx8WmU2TL57uRKaFS=Uwqc+5zZoufgLYTFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Khiem-san,

On Fri, Oct 3, 2014 at 12:19 PM, Khiem Nguyen
<khiem.nguyen.xt@renesas.com> wrote:
>> Does enable CONFIG_EARLY_PRINTK help?
>
> For multi-platform defconfig, it does not help.

Make sure to also disable CONFIG_ARCH_R8A7740 and
CONFIG_ARCH_R8A7779, else arch/arm/include/debug/scif.S
will use a wrong value for SCIF_VIRT.

As there's no runtime configuration, enabling support for multiple SoCs
that need conflicting parameters may not work.

I've just verified that shmobile_defconfig + CONFIG_DEBUG_LL works
as-is for armadillo.
For r8a791/koelsch, I had to disable r8a7740 and r8a7789 support,
and either correct DEBUG_UART_PHYS manually, or also disable
r8a7794 support.

> However, I have also tried with legacy defconfig (lager_defconfig),
> kernel boot is OK.

Thanks!

> As legacy defconfig will become deprecated in near future,
> I think this patch should support multi-platform defconfig.

CONFIG_DEBUG_LL is not to be enabled in any multi-platform
defconfig. It's only meant for desperate developers, running a kernel
for one specific platform. Cfr. its help text:

config DEBUG_LL
        bool "Kernel low-level debugging functions (read help!)"
        depends on DEBUG_KERNEL
        help
          Say Y here to include definitions of printascii, printch, printhex
          in the kernel.  This is helpful if you are debugging code that
          executes before the console is initialized.

          Note that selecting this option will limit the kernel to a single
          UART definition, as specified below. Attempting to boot the kernel
          image on a different platform *will not work*, so this option should
          not be enabled for kernels that are intended to be portable.

All defconfigs enabling CONFIG_DEBUG_LL are defconfigs for
legacy platforms.
The only exceptions are bcm2835_defconfig, moxart_defconfig,
s5pv210_defconfig, and tegra_defconfig, which support only one
platform, or a family of very similar platforms.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
