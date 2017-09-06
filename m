From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 6 Sep 2017 23:23:20 +0100
Subject: HAVE_EFFICIENT_UNALIGNED_ACCESS on ARM32 (was: Alignment issues
 in zImage with Linux 4.12, LZ4 and GCC5.3)
In-Reply-To: <CAK8P3a3AQ43t2q1MVN9PoqQXZiuXQo1uDcGnRAPCiT66_oDyLg@mail.gmail.com>
References: <CAGkQfmOKqFWisiRjkCHBHDwgY5A0HA_+hcLYSeDYaoGQ6CVu6Q@mail.gmail.com>
 <CAK8P3a3AQ43t2q1MVN9PoqQXZiuXQo1uDcGnRAPCiT66_oDyLg@mail.gmail.com>
Message-ID: <CAKv+Gu_6kxidH-4YwuCorJx25WSZDsOdtbZ6MZCv+R4ufzUjrw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 September 2017 at 21:57, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Sep 4, 2017 at 6:19 PM, Romain Izard <romain.izard.pro@gmail.com> wrote:
>> 2017-07-24 13:07 GMT+02:00 Ard Biesheuvel <ard.biesheuvel@linaro.org>:
>>> On 24 July 2017 at 11:57, Romain Izard <romain.izard.pro@gmail.com> wrote:
>>>>
>>>> While upgrading the kernel from 4.9 to 4.12 for a custom board with a
>>>> Cortex-A5 based CPU, I have encountered a compilation issue that leads to
>>>> a data abort during the execution of the LZ4 decompression code in
>>>> zImage.
>>>>
>>>> [...]
>>>>
>>>> The compilation options are a little different between both cases:
>>>> The library is built with -O3, whereas the zImage decompressor is built
>>>> with -O2, -DDISABLE_BRANCH_PROFILING, -fpic, -mno-single-pic-base,
>>>> -fno-builtin. All other compilation options are shared in both cases.
>>>>
>>
>> This is a red herring: the critical option here is '-fno-builtin'. If it is
>> not set, the bug disappears. It also disappears if we replace it with
>> '-fno-builtin-putc'. But it only changes the optimizations applied by
>> the compiler itself, and cannot explain the issue.
>>
>> Before updating the LZ4 decompressor, the LZ4 header contained specific
>> code for handling alignment issues, which has been changed.
>>
>>>> For Linux 4.9, the LZ4 decompressor code is completely different, which
>>>> explains why the issue appeared when changing kernel versions.
>>>>
>>>
>>> I see some void* to u32* casts in the new code, which makes me think
>>> that it is perhaps not valid C, and has maybe not been tested on an
>>> architecture that has stricter alignment requirements than x86?
>>>
>>
>> I can reproduce it easily on v4.13 with GCC6.3:
>> - Configure with allnoconfig
>> - Enable CONFIG_MMU, CONFIG_KERNEL_LZ4
>> - Check the generated assembly for arch/arm/boot/compressed/decompress.o:
>> In the LZ4_decompress_fast function, the memory access after the third
>> branch uses ldm and stm. This is invalid, as the addresses can be unaligned.
>>
>> With this configuration, HAVE_EFFICIENT_UNALIGNED_ACCESS is set, but this is
>> wrong. On 32-bit ARM, the compiler is free to generate LDM or LDRD access
>> that will always fail on unaligned addresses. In this case, we have two
>> LDR/STR access to adjascent addresses that appear in inline code. The
>> get_unaligned functions in "include/linux/unaligned/access_ok.h" cast the
>> pointers directly as regular 32-bit access, and as those are by default
>> aligned, the compiler will optimise and combine the access.
>>
>> If we use the functions from "include/linux/unaligned/le_struct.h", the
>> get_unaligned() function correctly tells the compiler that the access is
>> special, and that it should not merge memory access. But we do not fall back
>> to byte-by-byte access, as the compiler itself knows how to use 32-bit
>> access when -funaligned-access is set (by default for ARMv7).
>
> Right, I've come across this in the past as well.
>
>> The issue is probably hidden by the kernel fault handler in normal kernel
>> code, but for this case it does nothing as we are working in the boot
>> decompressor, that cannot use the fault handler. But it should have a
>> performance inpact.
>>
>> As a result, this means that HAVE_EFFICIENT_UNALIGNED_ACCESS should not
>> be set at least in the context of "include/asm-generic/unaligned.h". But
>> as this option is also used in other places, where it is not related to
>> the get_unaligned functions, it is not possible to remove it on ARM 32-bit
>> without further study.
>
> This is a patch I prototyped in the past https://pastebin.com/apPTPXys
>
> I'm not entirely sure if this produces good object code with all compilers
> on all architectures, but it should solve the problem you observed and
> more.
>

HAVE_EFFICIENT_UNALIGNED_ACCESS only affects explicit unaligned
accesses, and selects between fixups in hardware or in software.
AFAICT the issue here is implicit unaligned accesses, where char
pointers are passed as u32 * arguments.

It seems to me that the updated decompression code simply violates the
C spec in ways that you get away with on x86. On ARM, we fix u
unaligned accesses in software (on *all* arch revisions, given that we
are dealing with ldm/stm instructions here), and in the decompressor,
you either get a crash or incorrect data, depending on the version of
the CPU and its current setting for handling of unaligned accesses.

I guess this means we should revert the LZ4 update, or blacklist it
for ARM. Fiddling with HAVE_EFFICIENT_UNALIGNED_ACCESS is not going to
help afaict.
