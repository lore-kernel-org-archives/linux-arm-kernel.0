From: mark.rutland@arm.com (Mark Rutland)
Date: Wed,  3 May 2017 16:09:32 +0100
Subject: [PATCH 0/6] arm64: inline assembly fixes + cleanup
Message-ID: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recent attempts to make our inline assembly more clang-friendly [1,2]
made it clear that we have some latent problems. I've reviewed all the
inline assembly under arch/arm64/, and this series fixes the issues that
I noted.

The series is based on the arm64 for-next/core branch. I've built the
series with a Linaro 15,08 GCC 5.1.1 toolchain. I see no new warnings,
and the result boots happily on Juno R1.

The first four patches address latent bugs, with the final two patches
improving consistency and compatibility with clang. I believe that this
supersedes [2], with the GIC accessor having been fixed up by the recent
sysreg rework.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/503535.html
[2] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-May/504072.html

Mark Rutland (6):
  arm64: xchg: hazard against entire exchange variable
  arm64: ensure extension of smp_store_release value
  arm64: uaccess: ensure extension of access_ok() addr
  arm64: armv8_deprecated: ensure extension of addr
  arm64: atomic_lse: match asm register sizes
  arm64: uaccess: suppress spurious clang warning

 arch/arm64/include/asm/atomic_lse.h  |  4 ++--
 arch/arm64/include/asm/barrier.h     | 20 +++++++++++++++-----
 arch/arm64/include/asm/cmpxchg.h     |  2 +-
 arch/arm64/include/asm/uaccess.h     |  7 ++++---
 arch/arm64/kernel/armv8_deprecated.c |  3 ++-
 5 files changed, 24 insertions(+), 12 deletions(-)

-- 
1.9.1
