From: arend.vanspriel@broadcom.com (Arend Van Spriel)
Date: Wed, 1 Jun 2016 11:01:42 +0200
Subject: building and using modules on arm64 hikey board
In-Reply-To: <CAKv+Gu_=SCHwi8nBXGQ6wux4T59BGAU_H-942+QnSL0KO=zp4w@mail.gmail.com>
References: <87a3195c-febb-a6c8-a679-272b9f7b59cc@broadcom.com>
 <0240F9F0-0146-4DCC-B512-195415B29B34@linaro.org>
 <CAH7ZN-xMfE-+RiXfdvzEHtOVARy--yAV+fbjS+wsbujrkZgm0A@mail.gmail.com>
 <CAKv+Gu_=SCHwi8nBXGQ6wux4T59BGAU_H-942+QnSL0KO=zp4w@mail.gmail.com>
Message-ID: <370e5b2b-7f7d-6912-0f8e-71324974a9cb@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 31-5-2016 22:58, Ard Biesheuvel wrote:
> On 31 May 2016 at 22:24, Dmitry Shmidt <dimitrysh@google.com> wrote:
>> On Mon, May 30, 2016 at 4:30 AM, Ard Biesheuvel
>> <ard.biesheuvel@linaro.org> wrote:
>>> This is likely caused by the fact that the Android AArch64 toolchain uses -fpic by default. Could you try adding -fno-pic to the CFLAGS?
>>
>> Actually Arend is using 4.4, and we need to pull your fix, Ard:
>>
>> commit 80a2d83376001f6a1993f2e925670ab0e4cdb76d
>> Author: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>> Date:   Tue Jan 5 10:18:52 2016 +0100
>>
>>     arm64: module: avoid undefined shift behavior in reloc_data()
>>
> 
> OK, that was going to be my next question to Arend, i.e., to check
> whether he has all the recent fixes we did for the module loader.
> 
> But I'd also like to understand how we ended up with PREL32
> relocations in the first place, since those are quite unusual in
> object code generated from generic C source code when using the
> non-pic small model, which is normally GCC's default. Are there any
> other code generation defaults for the Android  AArch64 GCC toolchain
> that you are aware of?

For the module I noticed it uses command line parameter -mcmodel=large
so I suppose that could be how I ended up with PREL32.

In arch/arm64/Makefile there is this:
ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
KBUILD_CFLAGS_MODULE    += -mcmodel=large
endif

And that Kconfig item is indeed set.

Regards,
Arend

>>>> On 30 mei 2016, at 12:21, Arend Van Spriel <arend.vanspriel@broadcom.com> wrote:
>>>>
>>>> I got myself an arm64 HiKey board from LeMaker and build an Android AOSP
>>>> image for it (see [1]). For development I would like to use
>>>> CONFIG_MODULES. However, when I try to insmod the build module I get:
>>>>
>>>> [  287.903653] module cfg80211: overflow in relocation type 261 val
>>>> ffffffbffc006530
>>>>
>>>> Looking AArch64 ELF documentation [2], section 4.6.5, it has:
>>>> code|name            |operation |overflow check   |
>>>> 261 |R_AARCH64_PREL32|S + A - P |-2^31 <= X < 2^32|
>>>>
>>>> So basically the highest 32 bits should all be one and so ffffffbf is
>>>> invalid. From what I could find searching internet it could be an issue
>>>> with linker options so I build kernel and modules with V=1. Here the
>>>> linker invocation for them:
>>>>
>>>> + aarch64-linux-android-ld -EL -p --no-undefined -X --build-id -o vmlinux \
>>>> -T ./arch/arm64/kernel/vmlinux.lds arch/arm64/kernel/head.o
>>>> init/built-in.o \
>>>> --start-group usr/built-in.o arch/arm64/kernel/built-in.o
>>>> arch/arm64/mm/built-in.o \
>>>> arch/arm64/net/built-in.o arch/arm64/kvm/built-in.o
>>>> arch/arm64/crypto/built-in.o \
>>>> ./drivers/firmware/efi/libstub/lib.a kernel/built-in.o certs/built-in.o
>>>> mm/built-in.o \
>>>> fs/built-in.o ipc/built-in.o security/built-in.o crypto/built-in.o
>>>> block/built-in.o \
>>>> arch/arm64/lib/lib.a lib/lib.a arch/arm64/lib/built-in.o lib/built-in.o
>>>> drivers/built-in.o \
>>>> sound/built-in.o firmware/built-in.o net/built-in.o virt/built-in.o
>>>> --end-group .tmp_kallsyms2.o
>>>>
>>>>  aarch64-linux-android-ld -EL -r  -T ./scripts/module-common.lds
>>>> --build-id \
>>>>  -o net/wireless/cfg80211.ko net/wireless/cfg80211.o
>>>> net/wireless/cfg80211.mod.o
>>>>
>>>> Attached are vmlinux.lds and module-common.lds. I also tried taking
>>>> upstream arch/arm64/kernel/module.lds in hikey-linaro tree. If someone
>>>> can give a hint or educated guess at what to try it would be appreciated.
>>>>
>>>> Regards,
>>>> Arend
>>>>
>>>> [1] https://source.android.com/source/devices.html#building-kernel
>>>> [2]
>>>> http://infocenter.arm.com/help/topic/com.arm.doc.ihi0056b/IHI0056B_aaelf64.pdf
>>>> <module-common.lds>
>>>> <vmlinux.lds>
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel at lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
