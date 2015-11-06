From: yang.shi@linaro.org (Shi, Yang)
Date: Fri, 06 Nov 2015 09:23:38 -0800
Subject: [PATCH] arm64: remove redundant FRAME_POINTER kconfig option
In-Reply-To: <20151106162538.GU6087@arm.com>
References: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
 <20151106123008.GK6087@arm.com> <20151106125002.GA8116@leverpostej>
 <20151106162109.GZ7637@e104818-lin.cambridge.arm.com>
 <20151106162538.GU6087@arm.com>
Message-ID: <563CE21A.6060803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/6/2015 8:25 AM, Will Deacon wrote:
> On Fri, Nov 06, 2015 at 04:21:09PM +0000, Catalin Marinas wrote:
>> On Fri, Nov 06, 2015 at 12:50:02PM +0000, Mark Rutland wrote:
>>> On Fri, Nov 06, 2015 at 12:30:09PM +0000, Will Deacon wrote:
>>>> On Wed, Nov 04, 2015 at 09:37:51AM -0800, Yang Shi wrote:
>>>>> FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
>>>>> it in arch/arm64/Kconfig.debug.
>>>>
>>>> It might be worth noting that this adds a dependency on DEBUG_KERNEL
>>>> for building with frame pointers. I'm ok with that (it appears to be
>>>> enabled in defconfig and follows the vast majority of other archs) but
>>>> it is a change in behaviour.
>>>>
>>>> With that:
>>>>
>>>>    Acked-by: Will Deacon <will.deacon@arm.com>
>>>
>>> The code in arch/arm64/kernel/stacktrace.c assumes we have frame
>>> pointers regardless of FRAME_POINTER. Depending on what the compiler
>>> decides to use x29 for, we could get some weird fake unwinding and/or
>>> dodgy memory accesses.
>>>
>>> I think we should first audit the uses of frame pointers to ensure that
>>> they are guarded for !FRAME_POINTER.
>>
>> Or we just select FRAME_POINTER in the ARM64 Kconfig entry.
>
> Yang, did you see any benefit disabling frame pointers, or was this patch
> purely based on you spotting a duplicate Kconfig entry?

It just spots a duplicate Kconfig entry.

FRAME_POINTER is defined in both lib/Kconfig.debug and 
arch/arm64/Kconfig.debug.

The lib/Kconfig.debug one looks like:

config FRAME_POINTER
         bool "Compile the kernel with frame pointers"
         depends on DEBUG_KERNEL && \
                 (CRIS || M68K || FRV || UML || \
                  AVR32 || SUPERH || BLACKFIN || MN10300 || METAG) || \
                 ARCH_WANT_FRAME_POINTERS
         default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
         help
           If you say Y here the resulting kernel image will be slightly
           larger and slower, but it gives very useful debugging information
           in case of kernel bugs. (precise oopses/stacktraces/warnings)

The common one just depends on DEBUG_KERNEL && ARCH_WANT_FRAME_POINTERS.

ARCH_WANT_FRAME_POINTERS is selected by ARM64 kconfig entry.

To answer Catalin's question about:

> However, the patch would allow one to
> disable FRAME_POINTERS (not sure it has any effect on the aarch64 gcc
> though).

No, it doesn't. Actually, FRAME_POINTER could be disabled regardless of 
the patch.

Thanks,
Yang

>
> Will
>
