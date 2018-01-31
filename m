From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 31 Jan 2018 12:25:33 +0100
Subject: [PATCH] arch/arm/Kconfig: enable ARM_MODULE_PLTS when LOCKDEP=y
In-Reply-To: <20180129235710.GA9418@n2100.armlinux.org.uk>
References: <20180129234900.11121-1-anders.roxell@linaro.org>
 <20180129235710.GA9418@n2100.armlinux.org.uk>
Message-ID: <CAK8P3a1aN0M0hoOB4QJeyMD9zdT-G8Ap5-jV9M2-WpjC4Jo6Vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 30, 2018 at 12:57 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Jan 30, 2018 at 12:49:00AM +0100, Anders Roxell wrote:
>> While testing multi_v7_defconfig with LOCKDEP enabled, the kernel
>> fails to load simple modules, as reported by kselftest:
>>
>> [   34.107620] test_printf: section 4 reloc 2 sym 'memset': relocation
>> 28 out of range (0xbf046044 -> 0xc109f720)
>> selftests: printf.sh [FAIL]
>>
>> The problem that is seen when LOCKDEP is enabled without
>> ARM_MODULE_PLTS, is that LOCKDEP eats so much memory that the top of the
>> kernel gets out of reach from the bottom of the module area.
>
> This really doesn't follow IMHO - enabling various features can cause
> this, and we're not going to end up stuffing the Kconfig full of these
> select statements each time we find a combination of Kconfig symbols
> that cause it.
>
> lockdep isn't that special - I can (and do) build kernels with lockdep
> enabled, with modules, and I do not run into this problem.  So it's
> not as simple as you make out in this commit description.
>
> It's likely that you have either a fairly full kernel configuration (it
> must be to place memset() more than 16MB) or you are not placing the
> kernel at 0xc0008000 due to memory reservations in the low memory.
>
>> Suggested-by: Arnd Bergmann <arnd@arndb.de>
>
> I guess this was discussed privately with Arnd, since there's no record
> of the discussion on the lists - which is even more reason why the
> commit message needs to describe better why you need this change.

I don't remember the original discussion exactly, but it's clear that
the addition of LOCKDEP to the build is what caused the size to
grow dramatically and prevent module loading.

There are two alternative ways to do this without forcing
ARM_MODULE_PLTS on all the time (which also triggered
the 0day bot warning):

a) we could make ARM_MODULE_PLTS default to 'y' when
LOCKDEP is anbled, making it a more reasonable default while
also letting users turn it off when the lockdep-enabled kernel
is still small enough

b) The Kconfig fragment that Anders uses which turns on LOCKDEP
could simply enable ARM_MODULE_PLTS as well. That would
be the easiest solution for him. I assume he already does it, but
it's likely that others run into the same issue with kselftest testing.

       Arnd
