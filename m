From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 04 Jul 2014 20:05:47 +0900
Subject: [PATCH v10 1/3] arm64: Add __NR_* definitions for compat syscalls
In-Reply-To: <5418828.mxvNk2rT0e@wuerfel>
References: <1404458911-8214-1-git-send-email-takahiro.akashi@linaro.org>
 <1404458911-8214-2-git-send-email-takahiro.akashi@linaro.org>
 <5418828.mxvNk2rT0e@wuerfel>
Message-ID: <53B68A8B.1020106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On 07/04/2014 07:06 PM, Arnd Bergmann wrote:
> On Friday 04 July 2014 16:28:29 AKASHI Takahiro wrote:
>> From: Catalin Marinas <catalin.marinas@arm.com>
>>
>> This patch adds __NR_* definitions to asm/unistd32.h, moves the
>> __NR_compat_* definitions to asm/unistd.h and removes all the explicit
>> unistd32.h includes apart from the one building the compat syscall
>> table. The aim is to have the compat __NR_* definitions available but
>> without colliding with the native syscall definitions.
>>
>> And adds more syscall definitions for 3.16.
>
> Can you explain in more detail why you want to add those macros? I've
> looked at all three patches in the series but can't find any code using
> them.

Right. "unistd32.h" is not used by this patch, but by lib/compat_audit.c.
when I thought of adding audit support for arm64, there was duplicated code
of auditing compat system calls across many architectures.
lib/compat_audit.c fixes this issue but at the same time it also requires
__NR_* macros for a couple of compat system calls which arm64 didn't have.

In the first implementation, I generated an extra generated/asm/unistd_32.h
from the original asm/unist32.h by using a sed script. But Catalin suggested
(agreed?) to modify unistd32.h for this purpose.

See
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-January/228992.html

Thanks,
-Takahiro AKASHI

> I would expect that we don't need to define those macros at all for
> compat mode, since they are meant primarily for user space (glibc)
> compilation, which gets them from arch/arm/include/asm/unistd.h.
>
> 	Arnd
>
