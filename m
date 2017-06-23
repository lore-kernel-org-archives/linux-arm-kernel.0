From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 23 Jun 2017 10:52:20 -0700
Subject: [PATCH v2 0/7] ARM: Broadcom Brahma-B15 readahead cache support
Message-ID: <20170623175227.19743-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series adds support for the Broadcom Brahma-B15 readahead cache.
I submitted that patch series a couple of years ago, and then slept on it so
here is another stab at it.

Note that we did not implement this cache as a version of an outer cache
for several reasons:

- we initially thought we needed to intercept flush_icache_all and
  flush_kern_cache_louis but upon further inspection we convinced ourselves
  this is no longer needed, still, flush_cache_all() needs special handling
  here and needs to be wrapped around

- the outer cache does not allow differentiating a DMA transfer direction
  this is a readahead cache, so it does not participate in writes, flushing
  it during reads *and* writes kills the performance completely

- finally, most operations that outer_cache cares about are on MVA, which
  is transparent to the readahead cache here

Changes in v2:

- clarify that the read-ahead caches does invalidates on writes (IOW) based
  on Russell's feedback

Florian Fainelli (7):
  ARM: v7: allow setting different cache functions
  ARM: Add Broadcom Brahma-B15 readahead cache support
  ARM: Hook B15 readahead cache functions based on processor
  ARM: B15: Add CPU hotplug awareness
  ARM: B15: Add suspend/resume hooks
  ARM: B15: Register reboot notifier for KEXEC
  MAINTAINERS: Update brcmstb entries to cover B15 code

 MAINTAINERS                                   |   2 +
 arch/arm/include/asm/glue-cache.h             |   4 +
 arch/arm/include/asm/hardware/cache-b15-rac.h |  10 +
 arch/arm/mm/Kconfig                           |   8 +
 arch/arm/mm/Makefile                          |   1 +
 arch/arm/mm/cache-b15-rac.c                   | 360 ++++++++++++++++++++++++++
 arch/arm/mm/cache-v7.S                        |  21 ++
 arch/arm/mm/proc-v7.S                         |   6 +-
 include/linux/cpuhotplug.h                    |   2 +
 9 files changed, 411 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/cache-b15-rac.h
 create mode 100644 arch/arm/mm/cache-b15-rac.c

-- 
2.9.3
