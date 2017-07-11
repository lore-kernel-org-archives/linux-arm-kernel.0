From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Tue, 11 Jul 2017 08:59:11 +0200
Subject: [PATCH 9/9] ARM: multi_v7_defconfig: Enable DMA for Renesas
 serial ports
In-Reply-To: <CANqRtoSi8x7zqwV3Gp_n0dBe4Uw6LDRvC1Lheu+GrLZNYuxAHw@mail.gmail.com>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
 <1499693302-25120-10-git-send-email-geert+renesas@glider.be>
 <CANqRtoSi8x7zqwV3Gp_n0dBe4Uw6LDRvC1Lheu+GrLZNYuxAHw@mail.gmail.com>
Message-ID: <CAMuHMdXb1yAgw4AVvheYhPV=V9HeDCW2NdvhJWzoSz8i-mM3TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus,

On Tue, Jul 11, 2017 at 5:38 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Mon, Jul 10, 2017 at 10:28 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
>> DMA for (H)SCIF(A|B) serial ports on Renesas R-Car Gen2 and RZ/G1 SoCs
>> is considered stable, hence enable it by default.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  arch/arm/configs/multi_v7_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
>> index ea2075d8e185f7aa..072a455008df9751 100644
>> --- a/arch/arm/configs/multi_v7_defconfig
>> +++ b/arch/arm/configs/multi_v7_defconfig
>> @@ -330,6 +330,7 @@ CONFIG_SERIAL_IMX_CONSOLE=y
>>  CONFIG_SERIAL_SH_SCI=y
>>  CONFIG_SERIAL_SH_SCI_NR_UARTS=20
>>  CONFIG_SERIAL_SH_SCI_CONSOLE=y
>> +CONFIG_SERIAL_SH_SCI_DMA=y
>>  CONFIG_SERIAL_MSM=y
>>  CONFIG_SERIAL_MSM_CONSOLE=y
>>  CONFIG_SERIAL_VT8500=y
>
> Thanks, FWIW I'm very happy to see DMA enabled for the SCIF driver in mainline.
>
> Since enabling DMA Engine still keeps PIO support around I wonder why
> we need this Kconfig at all - other drivers seem to get by without
> this kind of thing?
> So in my opinion it would also be nice to get rid of SERIAL_SH_SCI_DMA
> completely and reducing the number of special per-driver Kconfig
> entries.

In general, I would agree, and remove the option at the blimp of an eye.
However, this driver is shared with H8/300 and SuperH.  While both could use
DMA (but it's not supported by Linux yet), I don't know if they are willing to
live with the increased static and dynamic memory footprint of SH_SCI DMA
support.

Whether we want to hide the option (and default to y if ARCH_RENESAS, i.e.
ARM) is another question.  Note that that wouldn't reduce code maintainability,
as the #ifdefs would be kept, and it would prevent building and testing
with/without DMA on ARM.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
