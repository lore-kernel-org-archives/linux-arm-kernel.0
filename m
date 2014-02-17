From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 17 Feb 2014 13:40:18 +0100
Subject: [PATCH] arm64: add workaround for ambiguous C99 stdint.h types
In-Reply-To: <20140217122334.GA19102@arm.com>
References: <1390768248-1688-1-git-send-email-ard.biesheuvel@linaro.org>
 <20140217122334.GA19102@arm.com>
Message-ID: <CAKv+Gu_=kgP1LS-HN6n+QfHMyi142aNpGR0roqRo2tinYXdxPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 February 2014 13:23, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Sun, Jan 26, 2014 at 08:30:48PM +0000, Ard Biesheuvel wrote:
>> In a way similar to ARM commit 09096f6a0ee2 ("ARM: 7822/1: add workaround
>> for ambiguous C99 stdint.h types"), this patch redefines the macros that
>> are used in stdint.h so its definitions of uint64_t and int64_t are
>> compatible with those of the kernel.
>>
>> In order to do so, drop types.h from generic-y and create a specific arm64
>> version identical to the generic one with just the #define overrides added.
>
> I tried but still can't get what this patch is about. Do the
> linux/types.h types ever get to user space? We have uapi/linux/types.h
> for this.
>
> Can you give an example of where this is needed? Which source file
> includes both stdint.h and linux/types.h (non-uapi version)?
>

It's not about user space, it is mainly about the use of NEON
instrinsics in the kernel.

If you do the following:

#Include <linux/types.h>
#include <arm_neon.h>

(and build with -ffreestanding or you will get /another/ error) you
will get the following error:

/usr/lib/gcc-cross/aarch64-linux-gnu/4.8/include/stdint-gcc.h:43:24:
error: conflicting types for 'int64_t'
 typedef __INT64_TYPE__ int64_t;
                        ^
In file included from
/home/ard/linux-2.6/drivers/crypto/neon/aes-async-modes.c:11:0:
/home/ard/linux-2.6/include/linux/types.h:113:17: note: previous
declaration of 'int64_t' was here
 typedef  __s64  int64_t;
                 ^
In file included from
/usr/lib/gcc-cross/aarch64-linux-gnu/4.8/include/stdint.h:11:0,
                 from
/usr/lib/gcc-cross/aarch64-linux-gnu/4.8/include/arm_neon.h:30,

This is caused by the fact that GCC and the kernel don't agree on the
definition of int64_t and uint64_t. (long vs long long)

Fortunately, GCC's definition is not built in but based on the builtin
#define __INT64_TYPE, which we can override if we want to. That is
what the patch does.

Regards,
Ard.
