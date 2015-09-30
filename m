From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 30 Sep 2015 18:17:52 +0200
Subject: [PATCH] ARM: fix vdsomunge depends on glibc specific byteswap.h
In-Reply-To: <B6E60776-A054-4749-BCAF-1433BFFC6AF7@goldelico.com>
References: <cover.1443628457.git.hns@goldelico.com>
 <2039A9BE-ADA4-4D28-84F4-C8B9D76834AD@goldelico.com>
 <CAKv+Gu_098GVMeJPjDWaQ-uXek_cGUe4UMVy+fMdKw=_C+P7Tg@mail.gmail.com>
 <B6E60776-A054-4749-BCAF-1433BFFC6AF7@goldelico.com>
Message-ID: <CAKv+Gu_6DibhUUPGrACCZE3S_k50rcO8A5ZcHh5c4UiDQUNApA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 September 2015 at 18:13, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Am 30.09.2015 um 18:02 schrieb Ard Biesheuvel <ard.biesheuvel@linaro.org>:
>
>> On 30 September 2015 at 17:56, H. Nikolaus Schaller <hns@goldelico.com> wrote:
>>> If the host toolchain is not glibc based then the arm kernel build
>>> fails with
>>>
>>> HOSTCC  arch/arm/vdso/vdsomunge
>>> arch/arm/vdso/vdsomunge.c:48:22: fatal error: byteswap.h: No such file or directory
>>>
>>> Observed with omap2plus_defconfig and compile on Mac OS X with arm ELF
>>> cross-compiler.
>>>
>>> Reason: byteswap.h is a glibc only header.
>>>
>>> Changed to detect the host and include the right file as described at:
>>>
>>> https://bugs.freedesktop.org/show_bug.cgi?id=8882
>>>
>>> Tested to compile on Mac OS X 10.9.5 host.
>>>
>>> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
>>> ---
>>> arch/arm/vdso/vdsomunge.c | 18 ++++++++++++++++++
>>> 1 file changed, 18 insertions(+)
>>>
>>> diff --git a/arch/arm/vdso/vdsomunge.c b/arch/arm/vdso/vdsomunge.c
>>> index aedec81..5364cea 100644
>>> --- a/arch/arm/vdso/vdsomunge.c
>>> +++ b/arch/arm/vdso/vdsomunge.c
>>> @@ -45,7 +45,25 @@
>>> * it does.
>>> */
>>>
>>> +#if defined(__linux__)
>>> #include <byteswap.h>
>>> +#elif defined(__OpenBSD__)
>>> +#include <sys/endian.h>
>>> +#define bswap_16 __swap16
>>> +#define bswap_32 __swap32
>>> +#define bswap_64 __swap64
>>> +#elif defined(__APPLE__)
>>> +#include <libkern/OSByteOrder.h>
>>> +#define bswap_16 OSSwapInt16
>>> +#define bswap_32 OSSwapInt32
>>> +#define bswap_64 OSSwapInt64
>>> +#else
>>> +#include <sys/endian.h>
>>> +#define bswap_16 bswap16
>>> +#define bswap_32 bswap32
>>> +#define bswap_64 bswap64
>>> +#endif
>>> +
>>
>> Have you tried this?
>>
>> #define bswap_16 __builtin_bswap16
>> #define bswap_32 __builtin_bswap32
>> #define bswap_64 __builtin_bswap64
>>
>> https://gcc.gnu.org/onlinedocs/gcc/Other-Builtins.html
>
> OS X host uses llvm and I am not sure if these builtins are
> always available.
>

I am pretty sure recent clang supports these as well. Could you please try it?

> So it replaces an include file dependency by a compiler
> built-in dependency. IMHO my approach is more general
> and should cover a broader range of compile hosts.
>
> This is a tool compiled by HOSTCC to be run on the build
> host - so I think we can't assume to have a gcc host compiler
> (while for the CC cross-compiler we can).
>

If my suggestion works, we'll support host side GCC and clang without
decorating the source code with lots of #ifdefs for OSes few people
care about. That would be an improvement imo

Thanks,
Ard.
