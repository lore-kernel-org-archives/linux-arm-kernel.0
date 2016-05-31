From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 31 May 2016 15:57:58 +0100
Subject: [PATCH 0/2] arm64: Fix RANDOMIZE_TEXT_OFFSET for !4K kernels
Message-ID: <1464706680-15713-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Recently we inadvertently broke RANDOMIZE_TEXT_OFFSET for !4K page
kernels, as we changed the way we map the kernel image. Now, when
TEXT_OFFSET is not a multiple of the kernel page size, we may attempt to
create (block) entries for misaligned addresses, leading to failures at
pagetable creation time.

To avoid this issue, these patches ensure that the TEXT_OFFSET value is
always a multiple of the kernel page size. Doing this requires factoring
PAGE_SHIFT out into Kconfig such that it is available to the awk code
that generates TEXT_OFFSET.

Thanks,
Mark.

Mark Rutland (2):
  arm64: move {PAGE,CONT}_SHIFT into Kconfig
  arm64: fix alignment when RANDOMIZE_TEXT_OFFSET is enabled

 arch/arm64/Kconfig            | 12 ++++++++++++
 arch/arm64/Makefile           |  4 +++-
 arch/arm64/include/asm/page.h | 12 ++----------
 3 files changed, 17 insertions(+), 11 deletions(-)

-- 
1.9.1
