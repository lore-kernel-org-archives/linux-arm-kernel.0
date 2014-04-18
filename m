From: elder@linaro.org (Alex Elder)
Date: Thu, 17 Apr 2014 21:30:05 -0500
Subject: [PATCH 00/10] ARM: bcm: SCM and L2 cache code cleanup
Message-ID: <1397788215-20279-1-git-send-email-elder@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series cleans up a number of things in the code that issues
secure monitor ("smc") requests for the bcm281xx and bcm21664 SoC
families.  This code is currently used only for enabling the level-2
cache.

There are some bug fixes and other improvements.  An assembly
language file containing a single function has been eliminated by
re-implementing the code using inline assembly.  Some comments have
been expanded and clarified.  Kernel configuration options allow
finer-grained control over how this code gets built.  Finally, the
"kona.c" and "kona.h" files are renamed to reflect the fact that
only contain code related to level-2 cache support.

This series is based on v3.15-rc1, and depends on one patch posted
previously:
    [PATCH v4] mach-bcm: clean up config and build targets
    https://lkml.org/lkml/2014/4/15/303

It is available here:
    http://git.linaro.org/landing-teams/working/broadcom/kernel.git
    Branch review/bcm-smc-cleanup

					-Alex

Alex Elder (10):
  ARM: bcm: use memory accessors for ioremapped area
  ARM: bcm: err, don't BUG() on SMC init failures
  ARM: bcm: clean up SMC code
  ARM: bcm: have bcm_kona_smc() return request result
  ARM: bcm: don't special-case CPU 0 in bcm_kona_smc()
  ARM: bcm: config option for l2 cache support
  ARM: bcm: tidy up a few includes
  ARM: bcm: use inline assembly for "smc" request
  ARM: bcm: rewrite commentary for bcm_kona_do_smc()
  ARM: bcm: rename "kona.h" and "kona.c"

 arch/arm/mach-bcm/Kconfig                     |   12 ++-
 arch/arm/mach-bcm/Makefile                    |   10 +-
 arch/arm/mach-bcm/bcm_kona_smc.c              |  136 ++++++++++++++++++-------
 arch/arm/mach-bcm/bcm_kona_smc.h              |   52 +---------
 arch/arm/mach-bcm/bcm_kona_smc_asm.S          |   41 --------
 arch/arm/mach-bcm/board_bcm21664.c            |    5 +-
 arch/arm/mach-bcm/board_bcm281xx.c            |    2 +-
 arch/arm/mach-bcm/{kona.c => kona_l2_cache.c} |   16 +--
 arch/arm/mach-bcm/{kona.h => kona_l2_cache.h} |    6 ++
 9 files changed, 137 insertions(+), 143 deletions(-)
 delete mode 100644 arch/arm/mach-bcm/bcm_kona_smc_asm.S
 rename arch/arm/mach-bcm/{kona.c => kona_l2_cache.c} (80%)
 rename arch/arm/mach-bcm/{kona.h => kona_l2_cache.h} (82%)

-- 
1.7.9.5
