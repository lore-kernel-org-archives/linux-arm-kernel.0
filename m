From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 11 May 2017 17:18:00 +0200
Subject: [PATCH v3 2/3] arm64: dts: r8a7795: salvator-x: Add support for
 R-Car H3 ES2.0
In-Reply-To: <20170511145324.GC21895@verge.net.au>
References: <1494503934-23367-1-git-send-email-geert+renesas@glider.be>
 <1494503934-23367-3-git-send-email-geert+renesas@glider.be>
 <20170511145324.GC21895@verge.net.au>
Message-ID: <CAMuHMdU4OeSqyyDAfpKLtn+bhnhzY8w-0hDB44k53obfPYBhQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Simon,

On Thu, May 11, 2017 at 4:53 PM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, May 11, 2017 at 01:58:53PM +0200, Geert Uytterhoeven wrote:
>> Split off support for Salvator-X boards with the ES1.x revision of the
>> R-Car H3 SoC into a separate file.  The main r8a7795-salvator-x.dts file
>> now corresponds to Salvator-X with R-Car H3 ES2.0 or later.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

>> --- a/arch/arm64/boot/dts/renesas/Makefile
>> +++ b/arch/arm64/boot/dts/renesas/Makefile
>> @@ -1,4 +1,5 @@
>>  dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-salvator-x.dtb r8a7795-h3ulcb.dtb
>> +dtb-$(CONFIG_ARCH_R8A7795) += r8a7795-es1-salvator-x.dtb
>
> Probably this was already discussed but I wonder if there is any value
> in a CONFIG_ARCH_R8A7795_ES1 Kconfig symbol to allow more fine grained
> control over what is compiled into the kernel.

The plan was always to have a single binary supporting both.
So I think it makes sense to have a single DT build (as in both DTBs are
built), too.

Note that if we add and use CONFIG_ARCH_R8A7795_ES1 here, the ES1 DTB will
no longer be always created, making it even harder for people who want to
support multiple kernel versions.

E.g. to pick the correct DTB for Salvator-X with H3 ES1.0, I have the
following in my install script:

    DTB=arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dtb
    if [ ! -e $DTB ]; then
        DTB=arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dtb
    fi

If we change our mind, it means we can/should sprinkle some
"#ifdef CONFIG_ARCH_R8A7795_ES1" checks in the clk/pfc/sysc driver code?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
