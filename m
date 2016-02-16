From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 16 Feb 2016 17:36:33 +0100
Subject: [PATCH 2/2] ARM: mm: hide __start_rodata_section_aligned for
 non-debug builds
In-Reply-To: <4716656.D1MJCNd1N6@wuerfel>
References: <1455638631-3326518-1-git-send-email-arnd@arndb.de>
 <1455638631-3326518-2-git-send-email-arnd@arndb.de>
 <CAKv+Gu8JcWg4BkxZFPqTotkfHFtP744XYdSx6XROJSM_8pmt2w@mail.gmail.com>
 <4716656.D1MJCNd1N6@wuerfel>
Message-ID: <CAKv+Gu-WAcw1q4s_UgOoM5DGerZ-aM_CToVG6C8-Bt6xzt-LMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 February 2016 at 17:34, Arnd Bergmann <arnd@arndb.de> wrote:
> On Tuesday 16 February 2016 17:12:52 Ard Biesheuvel wrote:
>> > +#ifdef CONFIG_DEBUG_RODATA
>> >  /*
>> >   * Without CONFIG_DEBUG_ALIGN_RODATA, __start_rodata_section_aligned will
>> >   * be the first section-aligned location after __start_rodata. Otherwise,
>> >   * it will be equal to __start_rodata.
>> >   */
>> >  __start_rodata_section_aligned = ALIGN(__start_rodata, 1 << SECTION_SHIFT);
>> > +#endif
>> >
>>
>> Does
>>
>> PROVIDE(__start_rodata_section_aligned = xxx);
>>
>> do the trick as well? If it does, it's a bit cleaner.
>>
>
> I would assume not, as the problem is that SECTION_SHIFT is a macro that
> is not defined when the MMU is disabled.
>

I just tested it myself, and it in fact does work.

PROVIDE() means the expression is evaluated lazily, and SECTION_SHIFT
is just an undefined identifier in the linker script scope if the
preprocessor does not define it.

Anyway, I don't have a strong preference, so ack either way.
