From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 17 Mar 2015 17:20:01 +0100
Subject: XIP_KERNEL and !ARCH_MULTIPLATFORM
In-Reply-To: <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
References: <HK2PR06MB0561CC16649A9C1F341CC6648A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdUR3oLp3RMcdEkMiqX92bosYE=f8tOKA1L_y59KMPuEJw@mail.gmail.com>
 <HK2PR06MB05613B2FBF8466204FA98A9D8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
 <CAMuHMdU3J1uzD5VAgHgF5NNzw_E7Njf7wU7kJ7oPuCKm7N_Arg@mail.gmail.com>
 <HK2PR06MB0561FE47407CA32AA8DDEFCF8A030@HK2PR06MB0561.apcprd06.prod.outlook.com>
Message-ID: <CAMuHMdUS84s=uLYVk8BtRoKFmBzw7aT1eQCfGF1nx22hTqf15A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chris,

On Tue, Mar 17, 2015 at 5:08 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
>> Now, to solve your problem: can you get it to work by dropping XIP_KERNEL's dependency on !ARCH_MULTIPLATFORM in arch/arm/Kconfig?
>
> Nope, because CONFIG_PHYS_OFFSET doesn't get defined:
>         " (.head.text+0x68): undefined reference to `CONFIG_PHYS_OFFSET'"
>
> config PHYS_OFFSET
>         hex "Physical address of main memory" if MMU
>         depends on !ARM_PATCH_PHYS_VIRT
>
> That was patch #1 to get XIP working in the 3.14 kernel.
>
> So, putting that patch in for ARCH_MULTIPLATFORM:
> config ARCH_MULTIPLATFORM
>         bool "Allow multiple platforms to be selected"
>         depends on MMU
>         select ARCH_WANT_OPTIONAL_GPIOLIB
>         select ARM_HAS_SG_CHAIN
> -       select ARM_PATCH_PHYS_VIRT
> +       select ARM_PATCH_PHYS_VIRT if !XIP_KERNEL
>
> That will get you to be able to set PHYS_OFFSET and then build, but still not actually work.
>
> For code, it looks like I still need to apply my 3.14 patches to:
>     arch/arm/mm/mmu.c
>     arch/arm/mm/proc-v7.S
>     scripts/link-vmlinux.sh
>
> Unfortunately, I'm still missing something to boot all the way up. Looking at  __log_buf I can see it was starting to boot (4.0.0-rc4), but dies early on.

DEBUG_LL=y may help you here. It's easier than doing a post-mortem analysis
on __log_buf from U-Boot.
As we still have anti-social platforms, you best remove all non-SCIF default
addresses from the DEBUG_UART_PHYS section in arch/arm/Kconfig.debug though.

> So, I'm assuming something in the kernel has changed since 3.14 and I have to track it down.

3.14 has (limited) RZ/A1H multi-platform support. Perhaps you can try getting
XIP to work with a multi-platform v3.14 kernel first, and find out what broke
in newer versions later?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
