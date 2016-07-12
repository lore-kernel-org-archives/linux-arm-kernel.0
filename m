From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Tue, 12 Jul 2016 11:23:58 +0100
Subject: [PATCH v2 0/2] arm64: Add support for CLOCK_MONOTONIC_RAW in
 clock_gettime() vDSO
Message-ID: <20160712102400.6904-1-kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This small series adds support for CLOCK_MONOTONIC_RAW to
clock_gettime() (and clock_getres()) in the arm64 vDSO. This should make
calls to clock_gettime() with CLOCK_MONOTONIC_RAW just as fast as
CLOCK_MONOTONIC and suchlike, instead of falling back to the significantly
slower syscall.

Given that gettimeofday.S is already quite difficult to understand, and
directly adding MONOTONIC_RAW support makes it even more so, the first
patch refactors it to make it simpler, and save a few instructions along
the way. The second patch actually adds support for MONOTONIC_RAW, which
is made quite easy by the refactoring.

Thanks,
Kevin

Changelog v1..v2:
* As proposed by Will Deacon, align main labels to be nicer to branch
  predictors. Also replace the "store" exit point of
  __kernel_clock_gettime with a macro, making it slightly easier to read
  and removing a branch.

Kevin Brodsky (2):
  arm64: Refactor vDSO time functions
  arm64: Add support for CLOCK_MONOTONIC_RAW in clock_gettime() vDSO

 arch/arm64/include/asm/vdso_datapage.h |   8 +-
 arch/arm64/kernel/asm-offsets.c        |   6 +-
 arch/arm64/kernel/vdso.c               |   8 +-
 arch/arm64/kernel/vdso/gettimeofday.S  | 331 ++++++++++++++++++++-------------
 4 files changed, 224 insertions(+), 129 deletions(-)

-- 
2.9.0
