From: will.deacon@arm.com (Will Deacon)
Date: Wed,  5 Sep 2018 15:34:41 +0100
Subject: [RESEND PATCH 0/2] Don't use SIGMINSTKSZ when enforcing alternative
 signal stack size for compat tasks
Message-ID: <1536158083-30166-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a resend of:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2018-July/593559.html

now based on 4.19-rc2.

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
