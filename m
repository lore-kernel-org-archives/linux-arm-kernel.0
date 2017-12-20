From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 20 Dec 2017 15:22:45 +0100
Subject: [PATCH, RFT] ARM: use --fix-v4bx to allow building ARMv4 with
 future gcc
In-Reply-To: <CAKv+Gu_viATGXTQjywxv8Yyy2iP-nBnAJZBmtnfhsQvS-ueWUA@mail.gmail.com>
References: <20171220130016.3156090-1-arnd@arndb.de>
 <CAKv+Gu_viATGXTQjywxv8Yyy2iP-nBnAJZBmtnfhsQvS-ueWUA@mail.gmail.com>
Message-ID: <CAK8P3a2N4g9FjmTBDBYGrGtY1XxGFRhOB+rMkhvwXUtSJOR+bg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 20, 2017 at 2:46 PM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> On 20 December 2017 at 13:00, Arnd Bergmann <arnd@arndb.de> wrote:
>> For consistency, I'm passing the --fix-v4bx flag for both the
>> vmlinux final link and the individual loadable modules.
>> The module loader code already interprets the R_ARM_V4BX relocations
>> in loadable modules and converts bx instructions into mov even
>> when running on ARMv4T or ARMv5 processors. This is now redundant
>> when we pass --fix-v4bx to the linker for building modules, but
>> I see no harm in leaving the current implementation and doing both.
>>
>
> Are you sure --fix-v4bx is taken into account during a partial link?

No. I made the patch a long time ago, so I don't remember what exactly
led me to this decision, but it should be fine as long as the linker
does the transformation at least once.

>> +tune-$(CONFIG_CPU_SA110)       =$(call cc-option,-mtune=strongarm110)
>> +tune-$(CONFIG_CPU_SA1100)      =$(call cc-option,-mtune=strongarm1100)
>>  tune-$(CONFIG_CPU_XSCALE)      =$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
>>  tune-$(CONFIG_CPU_XSC3)                =$(call cc-option,-mtune=xscale,-mtune=strongarm110) -Wa,-mcpu=xscale
>
> Shouldn't these two be updated as well?

All compilers that drop -mtune=strongarm110 support for now still support
mtune=xscale, so I don't think we need to change them. One thing we could
consider is passing -mtune=xscale when building for StrongARM, if that
produces better code than the default -mtune=arm7tdmi, but from looking
at the gcc-8 sources, it's not clear if that's better or worse. Neither arm7tdmi
nor strongarm have a custom cost function, but xscale has. The difference
between arm7tdmi and strongarm110 tuning is just the maximum number of
conditional instructions (5 vs 3).

A much bigger impact might be to tune for arm9e when building a kernel for
ARM926, no idea why we don't already do that (we do it for arm946, which
nobody really uses). Also, gcc has optimizations for many ARMv7-A cores
that we could use if we decide to make them known in Kconfig.

      Arnd
