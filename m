From: will.deacon@arm.com (Will Deacon)
Date: Tue,  2 Feb 2016 12:46:22 +0000
Subject: [PATCH 0/4] copy_page improvements
Message-ID: <1454417186-21828-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series aims to improve our copy_page implementation on both
CPUs with and without hardware prefetchers. It is inspired by a previous
patch series from Andrew, and one of the patches is lifted directly from
there:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2016-January/399132.html

Changes from that series:

  * Applies on top of mainline
  * Inverted the capability to the more generic ARM64_HAS_NO_HW_PREFETCH
  * Re-jigged the MIDR detection to try to keep it simple

I've left copy_template alone for now, since the template really deals
with 64 bytes per iteration, which would need changing.

Andrew -- it would be helpful if you could take this for a spin on
ThunderX to make sure it didn't screw anything up.

Cheers,

Will

--->8

Andrew Pinski (1):
  arm64: lib: patch in prfm for copy_page if requested

Will Deacon (3):
  arm64: prefetch: don't provide spin_lock_prefetch with LSE
  arm64: prefetch: add alternative pattern for CPUs without a prefetcher
  arm64: lib: improve copy_page to deal with 128 bytes at a time

 arch/arm64/include/asm/cpufeature.h |  3 +-
 arch/arm64/include/asm/cputype.h    | 17 +++++++++-
 arch/arm64/include/asm/processor.h  |  7 +++--
 arch/arm64/kernel/cpu_errata.c      | 18 ++---------
 arch/arm64/kernel/cpufeature.c      | 17 ++++++++++
 arch/arm64/lib/copy_page.S          | 63 ++++++++++++++++++++++++++++++++-----
 6 files changed, 98 insertions(+), 27 deletions(-)

-- 
2.1.4
