From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 15 Feb 2016 09:46:05 +0100
Subject: [PATCH v2] ARM: mm: mark section-aligned portion of rodata NX
In-Reply-To: <4300378.sBT9DdB2Gc@wuerfel>
References: <20151207223534.GA13722@www.outflux.net>
 <CAGXu5jLDK8eVO2kUD1cB3TArL8k8pF=igc3O04Fa40QgQ2pwNw@mail.gmail.com>
 <20160211180032.GY10826@n2100.arm.linux.org.uk>
 <4300378.sBT9DdB2Gc@wuerfel>
Message-ID: <CAMuHMdVUXH-_PB+DNuCbTTXD6Zmy4iG9i=-ame4PDVAOKv2tvQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2016 at 10:45 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 11 February 2016 18:00:32 Russell King - ARM Linux wrote:
>> On Fri, Jan 22, 2016 at 01:19:03PM -0800, Kees Cook wrote:
>> > On Tue, Dec 8, 2015 at 10:38 AM, Kees Cook <keescook@chromium.org> wrote:
>> > > On Mon, Dec 7, 2015 at 11:47 PM, Ard Biesheuvel
>> > > <ard.biesheuvel@linaro.org> wrote:
>> > >> On 7 December 2015 at 23:35, Kees Cook <keescook@chromium.org> wrote:
>> > >>>  /*
>> > >>> + * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
>> > >>> + * be the first section-aligned location after __start_rodata. Otherwise,
>> > >>> + * it will be equal to __start_rodata.
>> > >>> + */
>> > >>> +__start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
>> ...
>>
>> I'm afraid this causes build errors on two configurations:
>>
>> ./arch/arm/kernel/vmlinux.lds:701: undefined symbol `SECTION_SHIFT' referenced in expression
>>
>> which I think is down to the new __start_rodata_section_aligned line.
>>
>> Olof's builder errored out with this for both allnoconfig and
>> lpc18xx_defconfig builds.  Both probably due to CONFIG_MMU being
>> unset, and hence no definition for SECTION_SHIFT.
>>
>> I think you need to make this conditional on CONFIG_MMU.
>
> I've hit another problem with this patch, when using XIP_KERNEL, I now see
>
> arch/arm/mm/built-in.o:(.data+0x4bc): undefined reference to `__start_rodata_section_aligned'
>
> in linux-next, apparently because of the combination with "ARM: 8513/1: xip: Move
> XIP linking to a separate file".

Is this due to the copy not taking into account the recent changes to
vmlinux.lds.S?

"git show 538bf4694898b19e" with copy-rename detection shows:

copy from arch/arm/kernel/vmlinux.lds.S
copy to arch/arm/kernel/vmlinux-xip.lds.S
index a6e395c53a48e045..6f59ef290289e078 100644
--- a/arch/arm/kernel/vmlinux.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S

[...]

@@ -117,7 +114,7 @@ SECTIONS
                        ARM_CPU_KEEP(PROC_INFO)
        }

-#ifdef CONFIG_DEBUG_ALIGN_RODATA
+#ifdef CONFIG_DEBUG_RODATA
        . = ALIGN(1<<SECTION_SHIFT);
 #endif
        RO_DATA(PAGE_SIZE)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
