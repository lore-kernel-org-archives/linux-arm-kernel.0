From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 7 Oct 2014 13:46:16 +0200
Subject: [PATCH] [RFC] ARM: shmobile: Add early debugging support using
 SCIF(A)
In-Reply-To: <16427778.JB7cnWY0r4@wuerfel>
References: <1412276563-21473-1-git-send-email-geert+renesas@glider.be>
 <16427778.JB7cnWY0r4@wuerfel>
Message-ID: <CAMuHMdW5qzmKrq-tj7zekaX48T8WByeo+T664+7L-kJZ35MtEQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Tue, Oct 7, 2014 at 12:49 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 02 October 2014 21:02:43 Geert Uytterhoeven wrote:
>> +       default 0xe6c40000 if DEBUG_SCIF && (ARCH_R8A73A4 || ARCH_SH7372)
>> +       default 0xe6c50000 if DEBUG_SCIF && ARCH_R8A7740
>> +       default 0xe6c80000 if DEBUG_SCIF && ARCH_SH73A0
>> +       default 0xe6e58000 if DEBUG_SCIF && ARCH_R8A7794
>> +       default 0xe6e60000 if DEBUG_SCIF && (ARCH_R8A7790 || ARCH_R8A7791 || ARCH_R8A7793)
>> +       default 0xe8008000 if DEBUG_SCIF && ARCH_R7S72100

There were two (important ones for my point below) more here:

+       default 0xffe40000 if DEBUG_SCIF && ARCH_R8A7778
+       default 0xffe42000 if DEBUG_SCIF && ARCH_R8A7779

> Just saw this patch. Note that most other entries do not depend on a particular
> SoC but instead on one of the Kconfig entries, and I would like to eventually
> change all of them to be the same way.

I thought about having separate Kconfig entries for the various serial ports,
until I started realizing that
(a) not all serial ports are at the same addresses on all SoCs (most
are, though),
    The list above corresponds to these ports and addresses (note that we
    have multiple scif0 and scif2):

        scifa0: serial at e6c40000
        scifa1: serial at e6c50000
        scifa4: serial at e6c80000
        scif2: serial at e6e58000
        scif0: serial at e6e60000
        scif2: serial at e8008000
        scif0: serial at ffe40000
        scif2: serial at ffe42000

(b) this would just add lots of sections with similar lines in Kconfig.debug.
E.g. compare

    default 0xe6c50000 if DEBUG_SCIF && ARCH_R8A7740

to

    config DEBUG_RENESAS_SCIFA1
        bool "Kernel low-level debugging messages via SCIFA1 on
Renesas ARM SoCs"
        depends on DEBUG_RENESAS_SCIF && ARCH_R8A7740
        help
                [ ....]


    default 0xe6c50000 if DEBUG_RENESAS_SCIFA1

and repeat for all serial ports...
Or do you mean something different?

> The main reason for this is that your way is a mix of two methods: if you
> build a kernel for just one SoC you get the right entry here, but if you
> build the kernel for multiple SoCs combined, you have to edit the address
> by hand.

It's not guaranteed to work if you have a kernel with support for multiple
SoCs, as some SoCs still use machine_desc.map_io(), while others don't.
ARCH_R8A73A4 and ARCH_SH7372 use the same serial port at the same
address, but ARCH_SH7372 uses machine_desc.map_io().

Note that also encoding the SoC names/families, and offering a choice option
out of

DEBUG_RENESAS_R8A73A4_SCIFA0
DEBUG_RENESAS_SH7372_SCIFA0
DEBUG_RENESAS_R8A7740_SCIFA1
DEBUG_RENESAS_SH73A0_SCIFA4
DEBUG_RENESAS_RCAR_GEN2_SCIF2
DEBUG_RENESAS_RCAR_GEN2_SCIF0
DEBUG_RENESAS_R7S72100_SCIF2
DEBUG_RENESAS_RCAR_GEN1_SCIF0
DEBUG_RENESAS_RCAR_GEN1_SCIF2

could be used to solve the machine_desc.map_io() issue.
Then we can have hardcoded addresses based on the above.

> An alternative would be to not define a default here and document the
> possible addresses in the help text for DEBUG_SCIF, so that users will
> /always/ have to manually edit these, so at least it would be consistent.

I prefer to optimize the user experience for the common case, i.e.
autoselection for the SoC you're using, and manual edit for the less common
case.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
