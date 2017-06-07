From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  7 Jun 2017 16:35:11 +0100
Subject: [PATCH 0/2] arm64: avoid KASAN stack overflows
Message-ID: <1496849713-17078-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I recently tried building the kernel with a GCC 7.1.0 toolchain, and
encountered a number of new and surprising failures on kernels buitl with
KASAN.

It looks like this is due to stack instrumentation, which my prior toolchain
didn't support. KASAN's stack instrumentation significantly bloats the stack
significantly, leading to stack overflows and subsequent failures as a result
of the data corruption they cause.

These patches avoid the issue by doubling the stack size for kernels built with
KASAN, as is already done for x86.

I've built and booted 4K and 64K kernels with these patches applied (and with
KASAN enabled), and so far I haven't seen stack overflows when testing with
Syzkaller.

Thanks,
Mark.

Mark Rutland (2):
  arm64: avoid open-coding THREAD_SIZE{,_ORDER}
  arm64: use larger stacks for KASAN

 arch/arm64/include/asm/thread_info.h | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

-- 
1.9.1
