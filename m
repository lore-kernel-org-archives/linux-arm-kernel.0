From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 8 Sep 2018 01:47:24 +0900
Subject: [PATCH v2 6/9] kbuild: consolidate Devicetree dtb build rules
In-Reply-To: <CAL_JsqJeTqxFPxZfuusPxuOTsVbVk_Uhue6NXwpotkwZWHrCDw@mail.gmail.com>
References: <20180905235327.5996-1-robh@kernel.org>
 <20180905235327.5996-7-robh@kernel.org>
 <CAK7LNARD+_kV=XtJ66mZBU-CPMQgWF+oQtv4bGKaGGARNwzXiQ@mail.gmail.com>
 <CAL_JsqJeTqxFPxZfuusPxuOTsVbVk_Uhue6NXwpotkwZWHrCDw@mail.gmail.com>
Message-ID: <CAK7LNATqTh4oxG5uz2Z4gk0J=kXP62UX2r3cP9Kd2aCSTXzTuA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

2018-09-07 21:17 GMT+09:00 Rob Herring <robh@kernel.org>:
> On Fri, Sep 7, 2018 at 5:33 AM Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
>>
>> 2018-09-06 8:53 GMT+09:00 Rob Herring <robh@kernel.org>:
>> > There is nothing arch specific about building dtb files other than their
>> > location under /arch/*/boot/dts/. Keeping each arch aligned is a pain.
>> > The dependencies and supported targets are all slightly different.
>> > Also, a cross-compiler for each arch is needed, but really the host
>> > compiler preprocessor is perfectly fine for building dtbs. Move the
>> > build rules to a common location and remove the arch specific ones. This
>> > is done in a single step to avoid warnings about overriding rules.
>> >
>> > The build dependencies had been a mixture of 'scripts' and/or 'prepare'.
>> > These pull in several dependencies some of which need a target compiler
>> > (specifically devicetable-offsets.h) and aren't needed to build dtbs.
>> > All that is really needed is dtc, so adjust the dependencies to only be
>> > dtc.
>> >
>> > This change enables support 'dtbs_install' on some arches which were
>> > missing the target.
>> >
>> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>> > Cc: Michal Marek <michal.lkml@markovi.net>
>> > Cc: Vineet Gupta <vgupta@synopsys.com>
>> > Cc: Russell King <linux@armlinux.org.uk>
>> > Cc: Catalin Marinas <catalin.marinas@arm.com>
>> > Cc: Will Deacon <will.deacon@arm.com>
>> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> > Cc: Michal Simek <monstr@monstr.eu>
>> > Cc: Ralf Baechle <ralf@linux-mips.org>
>> > Cc: Paul Burton <paul.burton@mips.com>
>> > Cc: James Hogan <jhogan@kernel.org>
>> > Cc: Ley Foon Tan <lftan@altera.com>
>> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > Cc: Paul Mackerras <paulus@samba.org>
>> > Cc: Michael Ellerman <mpe@ellerman.id.au>
>> > Cc: Chris Zankel <chris@zankel.net>
>> > Cc: Max Filippov <jcmvbkbc@gmail.com>
>> > Cc: linux-kbuild at vger.kernel.org
>> > Cc: linux-snps-arc at lists.infradead.org
>> > Cc: linux-arm-kernel at lists.infradead.org
>> > Cc: uclinux-h8-devel at lists.sourceforge.jp
>> > Cc: linux-mips at linux-mips.org
>> > Cc: nios2-dev at lists.rocketboards.org
>> > Cc: linuxppc-dev at lists.ozlabs.org
>> > Cc: linux-xtensa at linux-xtensa.org
>> > Signed-off-by: Rob Herring <robh@kernel.org>
>> > ---
>> > Please ack so I can take the whole series via the DT tree.
>> >
>> > v2:
>> >  - Fix $arch/boot/dts path check for out of tree builds
>> >  - Fix dtc dependency for building built-in dtbs
>> >  - Fix microblaze built-in dtb building
>>
>>
>> This breaks parallel building
>> because two threads could descend into scripts/dtc
>> at the same time.
>>
>> 'all' depends on both 'scripts' and 'dtc'.
>>
>> * 'scripts' target -- descends into scripts/, then scripts/dtc
>> * 'dtc' target     -- descents into scripts/dtc directly
>
> Any suggestions for how to fix given the problem with depending on
> scripts? I suppose I could make scripts depend on dtc instead, but I'd
> be back to needing to fix cleaning.

How about making 'prepare' depend on 'dtc'?

Then, remove
subdir-$(CONFIG_DTC)         += dtc
from scripts/Makefile

but, add dtc to subdir-


> Or I could just skip removing the
> cross compiler dependency for now.

I want to build scripts/
without target compiler.

modpost is a special host-program
that depends on $(CC).

I will take a look at it
when I find some time.


-- 
Best Regards
Masahiro Yamada
