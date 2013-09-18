From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Wed, 18 Sep 2013 17:07:20 +0100
Subject: [PATCH RFC 0/3] ARM: cacheinfo support
Message-ID: <1379520443-13857-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi,

This series adds cacheinfo support for ARM. The implementation is based on
x86. However it depends on device tree for cache hierarcy. On non-DT
platforms, first level caches are per-cpu while higher level caches are
assumed system-wide.

Few things I would like to get clarified:
1. Should the populating cacheinfo and sysfs be decoupled completely ?
   i.e. do we need to populate cache data on hotplug path or just once
   during the boot on all cpus will suffice ?

2. Does it make sense to unify sysfs part of implementation across different
   architecture(arm and x86) ? I don't see a reason not to, but I see some
   custom/arch specific sysfs entries(e.g. AMD L3 cache partitioning feature).
   So I would like to get the feedback.

Also this series depends on of_find_next_cache_node which is moved from PPC
to common DT code[1]

Regards,
Sudeep

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-September/111381.html

Sudeep KarkadaNagesha (3):
  ARM: kernel: add support for cpu cache information
  ARM: kernel: add outer cache support for cacheinfo implementation
  ARM: kernel: support cpu cache information interface to userspace via
    sysfs

 arch/arm/include/asm/outercache.h |  13 +
 arch/arm/kernel/Makefile          |   1 +
 arch/arm/kernel/cacheinfo.c       | 687 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/Kconfig               |  13 +
 arch/arm/mm/cache-l2x0.c          |  14 +
 arch/arm/mm/cache-tauros2.c       |  35 ++
 arch/arm/mm/cache-xsc3l2.c        |  15 +
 7 files changed, 778 insertions(+)
 create mode 100644 arch/arm/kernel/cacheinfo.c

-- 
1.8.1.2
