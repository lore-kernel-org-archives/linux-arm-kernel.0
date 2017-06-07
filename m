From: aryabinin@virtuozzo.com (Andrey Ryabinin)
Date: Wed, 7 Jun 2017 19:12:30 +0300
Subject: [PATCH 0/2] arm64: avoid KASAN stack overflows
In-Reply-To: <1496849713-17078-1-git-send-email-mark.rutland@arm.com>
References: <1496849713-17078-1-git-send-email-mark.rutland@arm.com>
Message-ID: <07c30069-84f5-be51-85ab-c3c84eea9463@virtuozzo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/07/2017 06:35 PM, Mark Rutland wrote:
> Hi,
> 
> I recently tried building the kernel with a GCC 7.1.0 toolchain, and
> encountered a number of new and surprising failures on kernels buitl with
> KASAN.
> 
> It looks like this is due to stack instrumentation, which my prior toolchain
> didn't support. KASAN's stack instrumentation significantly bloats the stack
> significantly, leading to stack overflows and subsequent failures as a result
> of the data corruption they cause.
> 

This is caused by -fsanitize-address-use-after-scope which is added in gcc 7.
Arnd reported that sometimes it causes enormously huge stack growth.

Given that we haven't found any single use-after-scope bug so far, I wouldn't object
removing it completely.  


> These patches avoid the issue by doubling the stack size for kernels built with
> KASAN, as is already done for x86.
> 
> I've built and booted 4K and 64K kernels with these patches applied (and with
> KASAN enabled), and so far I haven't seen stack overflows when testing with
> Syzkaller.
> 
> Thanks,
> Mark.
> 
> Mark Rutland (2):
>   arm64: avoid open-coding THREAD_SIZE{,_ORDER}
>   arm64: use larger stacks for KASAN
> 
>  arch/arm64/include/asm/thread_info.h | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
> 
