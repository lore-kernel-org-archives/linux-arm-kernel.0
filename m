From: will.deacon@arm.com (Will Deacon)
Date: Thu,  5 Aug 2010 11:36:47 +0100
Subject: [PATCH 0/2] Detect and handle I-cache aliases when D-cache is
	non-aliasing
Message-ID: <1281004609-7563-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Last month, I posted some patches to fix ptrace software breakpoints:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-July/020649.html

One of these patches added a workaround for a hardware erratum, so I
have submitted that to the patch system. The other patch simply called
__flush_icache_all() in flush_ptrace_access to avoid having to worry
about I-cache aliases when cache_is_vipt_nonaliasing() is true. This
isn't ideal if the debugger decides to insert lots of software breakpoints
sequentially (for example, when single-stepping a number of times).

These two patches add proper identification of aliasing I-caches
when the D-cache is nonaliasing. flush_ptrace_access can then
flush only the relevant I-cache lines instead of the entire cache.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>

Will Deacon (2):
  ARM: setup: detect aliasing I-cache when D-cache is non-aliasing
  ARM: flush_ptrace_access: invalidate correct I-cache alias

 arch/arm/include/asm/cachetype.h |    8 ++++++--
 arch/arm/kernel/setup.c          |   38 +++++++++++++++++++++++++++++++++++---
 arch/arm/mm/flush.c              |   23 ++++++++++++++++++++---
 3 files changed, 61 insertions(+), 8 deletions(-)
