From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 30 Dec 2013 18:20:50 +0100
Subject: [PATCH 4/6] [RFC] Documentation: dt: Add Renesas RSPI/QSPI
 bindings
In-Reply-To: <3193607.9r7LL0m5xX@avalon>
References: <1387886210-3634-1-git-send-email-geert+renesas@linux-m68k.org>
 <2582506.8vb3LhHISh@avalon>
 <CAMuHMdUnf77Z1u=d8zFZk0vQtGJ9QhhCk6KVJsVKS-iMFSMUKw@mail.gmail.com>
 <3193607.9r7LL0m5xX@avalon>
Message-ID: <CAMuHMdVxKD1PZdBZiFGeR6ADovyazs6EzH24+DBUUOLupQzVnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 30, 2013 at 4:18 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> There are subtle register differences between RSPI on SH7757 and RZ/A1H,
>> cfr. what rspi_parse_platform_data() does when no platform_data is
>> passed[*]. RSPI on RZ/A1H seems to be an evolutionary step from RSPI on SH
>> towards QSPI on RCar Gen2 (but without Dual/Quad).
>>
>> [*] setup-sh7757.c doesn't pass platform data, although the rspi driver and
>> its platform data has support for DMA on SH7757, which is not used by
>> setup-sh7757.c nor any other in-tree platform.
>
> The only important difference I can see (beside the hardcoded 16-bit width
> which could be selected as the default) is that the SSH7757 RSPI has no SPL
> bits in SPDCR. I don't have access tot he SH7757 datasheet, could you please
> confirm that ?

SH7757 has RSPI Control Register 2 and the TX only mode flag, while
RSPI-RZ (and QSPI) haven't.
The number of interrupts also differ, but that's easily handled via
the interrupts
property.

BTW, I also don't have the SH7757 datasheet (will check), so my knowledge
there is purely based on the behavior of the code.

>> > in my opinion is whether we want to use
>> >
>> > compatible = "renesas,rspi-r7s72100", "renesas,rspi";
>> >
>> > or
>> >
>> > compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz", "renesas,rspi";
>>
>> So we end up with:
>>
>> compatible = "renesas,sh7757", "renesas,rspi-sh" (SH legacy)
>> compatible = "renesas,rspi-r7s72100", "renesas,rspi-rz" (Genmai)
>> compatible = "renesas,rspi-r8a7790", "renesas,qspi" (Lager)
>> compatible = "renesas,rspi-r8a7791", "renesas,qspi" (Koelsch)
>
> Don't you mean "renesas,qspi-r8a7790" and "renesas,qspi-r8a7791" ?

Oops, yes, sorry about that.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
