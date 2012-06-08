From: will.deacon@arm.com (Will Deacon)
Date: Fri,  8 Jun 2012 16:38:53 +0100
Subject: [RFC PATCH 0/2] Implement word-at-a-time string functions
Message-ID: <1339169935-31775-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series does two things:

1. Implements the word-at-a-time API for ARM and replaces our user
   string operations with the generic optimised variants.

2. On CPUs with efficient hardware support for unaligned accesses (v6+),
   select DCACHE_WORD_ACCESS for little-endian configurations.

In standalone tests on a Cortex-A9, this results in a 55% performance
improvement for name hashing and some simple find operations over a
tmpfs filesystem show that the relative improvement for per-word hashing
increases with the length of the pathname (assumedly up to the 55%
ceiling, although with 1k pathnames the improvement is 10% so I doubt
we'd be able to hit the maximum speedup in this simple test).

If anybody has some better pathname-lookup-intensive benchmarks, I'd be
happy to try them out.

All comments welcome,

Will


Will Deacon (2):
  ARM: use generic strnlen_user and strncpy_from_user functions
  ARM: dcache: select DCACHE_WORD_ACCESS for little-endian ARMv6+ CPUs

 arch/arm/Kconfig                      |    3 +
 arch/arm/include/asm/uaccess.h        |   27 ++-------
 arch/arm/include/asm/word-at-a-time.h |   96 +++++++++++++++++++++++++++++++++
 arch/arm/kernel/armksyms.c            |    4 --
 arch/arm/lib/Makefile                 |    1 -
 arch/arm/lib/strncpy_from_user.S      |   43 ---------------
 arch/arm/lib/strnlen_user.S           |   40 --------------
 7 files changed, 105 insertions(+), 109 deletions(-)
 create mode 100644 arch/arm/include/asm/word-at-a-time.h
 delete mode 100644 arch/arm/lib/strncpy_from_user.S
 delete mode 100644 arch/arm/lib/strnlen_user.S

-- 
1.7.4.1
