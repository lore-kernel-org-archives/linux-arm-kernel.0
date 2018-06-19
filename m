From: will.deacon@arm.com (Will Deacon)
Date: Tue, 19 Jun 2018 13:48:12 +0100
Subject: [PATCH 0/3] I-side fixes
Message-ID: <1529412495-17525-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

These three patches attempt to address some issues with ISBs and I-cache
maintenance. Specifically:

  - Ensure we don't invoke dynamically modified I-cache maintenance code
    as part of the instruction patching routines
  - Remove ISBs from pte/pmd/pud setter functions
  - IPI other CPUs when invalidating the I-cache for kernel mappings

Whilst the IPI is a bit nasty, I couldn't figure out a better way to
ensure that CPUs don't retain instructions from freed pages in their
pipelines. I initially hoped to deal with this by hooking into RCU, but
that would rely on RCU being the only mechanism used to defer reclaim of
executable pages and this doesn't appear to be the case for e.g. modules.

Feedback welcome,

Will

--->8

Will Deacon (3):
  arm64: Avoid flush_icache_range() in alternatives patching code
  arm64: Remove unnecessary ISBs from set_{pte,pmd,pud}
  arm64: IPI each CPU after invalidating the I-cache for kernel mappings

 arch/arm64/include/asm/alternative.h |  7 +++++-
 arch/arm64/include/asm/cacheflush.h  | 13 +++++++++-
 arch/arm64/include/asm/pgtable.h     |  6 +----
 arch/arm64/kernel/alternative.c      | 47 ++++++++++++++++++++++++++++++------
 arch/arm64/kernel/cpu_errata.c       |  2 +-
 arch/arm64/kernel/insn.c             | 15 ++----------
 arch/arm64/kernel/module.c           |  5 ++--
 arch/arm64/mm/cache.S                |  4 +--
 8 files changed, 65 insertions(+), 34 deletions(-)

-- 
2.1.4
