From: miguel.ojeda.sandonis@gmail.com (Miguel Ojeda)
Date: Wed, 12 Sep 2018 06:19:08 +0200
Subject: [PATCH] include/linux/compiler-clang.h: define __naked
In-Reply-To: <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
References: <20180910060455.20409-1-stefan@agner.ch>
 <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
Message-ID: <CANiq72mGH3KW+FxVDF0PcAeaTCtnNz_oO=2-u4zZQ9kvbRDCtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Nick, Stefan,

On Mon, Sep 10, 2018 at 2:14 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Sep 10, 2018 at 8:05 AM Stefan Agner <stefan@agner.ch> wrote:
>>
>> ARM32 arch code uses the __naked attribute. This has previously been
>> defined in include/linux/compiler-gcc.h, which is no longer included
>> for Clang. Define __naked for Clang. Conservatively add all attributes
>> previously used (and supported by Clang).
>>
>> This fixes compile errors when building ARM32 using Clang:
>>   arch/arm/mach-exynos/mcpm-exynos.c:193:13: error: variable has incomplete type 'void'
>>   static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
>>               ^
>>
>> Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>
>> +/*
>> + * ARM32 is currently the only user of __naked supported by Clang. Follow
>> + * gcc: Do not trace naked functions and make sure they don't get inlined.
>> + */
>> +#define __naked __attribute__((naked)) noinline notrace
>> +
>
> Please see patches 5 and 6 of the series that Miguel posted:
>
> https://lore.kernel.org/lkml/20180908212459.19736-6-miguel.ojeda.sandonis at gmail.com/
>
> I suppose we want the patch to fix clang build as soon as possible though,
> and follow up with the cleanup for the next merge window, right?

Not sure what the plans of Linus et. al. are, if they have any; but
that would be a safe bet.

In case they want to speed this up and put the entire series into
v4.19 (instead of the two patches), I have done a binary & objdump
diff between -rc2 and v4 (based on -rc2) on all object files (with
UTS_RELEASE fixed to avoid some differences).

In a x86_64 tinyconfig with gcc 7.3, the differences I found are:

$ ./compare.py linux-rc2 linux-v4
[2018-09-12 06:16:39,483] [INFO] [arch/x86/boot/compressed/piggy.o]
Binary diff (use 'bash -c "cmp
linux-rc2/arch/x86/boot/compressed/piggy.o
linux-v4/arch/x86/boot/compressed/piggy.o"' to replicate)
[2018-09-12 06:16:39,606] [INFO] [arch/x86/boot/header.o] Binary diff
(use 'bash -c "cmp linux-rc2/arch/x86/boot/header.o
linux-v4/arch/x86/boot/header.o"' to replicate)
[2018-09-12 06:16:39,659] [INFO] [arch/x86/boot/version.o] Binary diff
(use 'bash -c "cmp linux-rc2/arch/x86/boot/version.o
linux-v4/arch/x86/boot/version.o"' to replicate)
[2018-09-12 06:16:40,483] [INFO] [init/version.o] Binary diff (use
'bash -c "cmp linux-rc2/init/version.o linux-v4/init/version.o"' to
replicate)

I will do a bigger one tomorrow or so and see if there are any
important differences. Regardless of what we do, I will send the
__naked patches separately as well (requested by Nick on GitHub).

Cheers,
Miguel
