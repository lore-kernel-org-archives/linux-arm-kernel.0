From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jul 2018 14:45:10 +0100
Subject: [PATCH 0/2] Don't use SIGMINSTKSZ when enforcing alternative signal
 stack size for compat tasks
Message-ID: <1532526312-26993-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

The Debian folks have observed a failure in the 32-bit arm glibc testsuite
when running under a 64-bit kernel. They tracked this down to sigaltstack(2)
enforcing the alternative signal stack to be at least SIGMINSTKSZ bytes,
which is higher for native arm64 tasks than compat 32-bit tasks.

These patches resolve the issue by allowing an architecture to define
COMPAT_SIGMINSTKSZ for compat tasks, which is then used by the sigaltstack
checking code.

Feedback welcome,

Will

--->8

Will Deacon (2):
  signal: Introduce COMPAT_SIGMINSTKSZ for use in compat_sys_sigaltstack
  arm64: compat: Provide definition for COMPAT_SIGMINSTKSZ

 arch/arm64/include/asm/compat.h |  1 +
 include/linux/compat.h          |  3 +++
 kernel/signal.c                 | 14 +++++++++-----
 3 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.1.4
