From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Mon,  9 May 2016 13:36:59 +0100
Subject: [PATCH 0/2] arm64: Add support for CLOCK_MONOTONIC_RAW in
 clock_gettime() vDSO
Message-ID: <1462797421-33103-1-git-send-email-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This small series adds support for CLOCK_MONOTONIC_RAW to
clock_gettime() (and clock_getres()) in the arm64 vDSO. This should make
calls to clock_gettime() with CLOCK_MONOTONIC_RAW just as fast as
CLOCK_MONOTONIC and such, instead of falling back to the significantly
slower syscall.

Given that gettimeofday.S is already quite difficult to understand, and
directly adding MONOTONIC_RAW support makes it even more so, the first
patch refactors it to make it simpler, and save a few instructions along
the way. The second patch actually adds support for MONOTONIC_RAW, which
is made quite easy by the refactoring.

Thanks,
Kevin

Kevin Brodsky (2):
  arm64: Refactor vDSO time functions
  arm64: Add support for CLOCK_MONOTONIC_RAW in clock_gettime() vDSO

 arch/arm64/include/asm/vdso_datapage.h |   8 +-
 arch/arm64/kernel/asm-offsets.c        |   6 +-
 arch/arm64/kernel/vdso.c               |   8 +-
 arch/arm64/kernel/vdso/gettimeofday.S  | 317 ++++++++++++++++++++-------------
 4 files changed, 215 insertions(+), 124 deletions(-)

-- 
2.8.0
