From: will.deacon@arm.com (Will Deacon)
Date: Fri, 22 Jun 2012 16:06:58 +0100
Subject: [RFC PATCH 0/8] Fix restart_block syscall restarting for 3.5
Message-ID: <1340377626-17075-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This RFC series attempts to address the syscall restarting problems
introduced during the merge window and described here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104733.html

I reckon the first two reverts should go in for 3.5 unless anybody has
a better solution. The rest of the code is an RFC since, as Russell has
said before, the code is `rather yucky'.

In my effort to avoid breaking strace, I ended up merging in my audit
fixes with this series since keeping the patch sets separate was
becoming a bit of a nightmare given the amount of common code they are
modifying.

Given the mysterious ability of this code to wrap my brain around my
face and beat it with a hammer, I would really appreciate some feedback!

Cheers,

Will


Will Deacon (8):
  Revert "arm: remove unused restart trampoline"
  Revert "arm: new way of handling ERESTART_RESTARTBLOCK"
  audit: arm: only allow syscall auditing for pure EABI userspace
  ARM: entry: don't bother with syscall tracing on ret_from_fork path
  ARM: audit: move syscall auditing until after ptrace SIGTRAP handling
  ARM: ptrace: provide separate functions for tracing syscall
    {entry,exit}
  ARM: signal: perform restart_block system call restarting in the
    kernel
  Revert "Revert "arm: remove unused restart trampoline""

 arch/arm/include/asm/ptrace.h      |    3 ++
 arch/arm/include/asm/thread_info.h |   11 +++---
 arch/arm/kernel/calls.S            |    2 +-
 arch/arm/kernel/entry-common.S     |   25 ++++++--------
 arch/arm/kernel/ptrace.c           |   37 +++++++++++++-------
 arch/arm/kernel/signal.c           |   63 ++++++++++++++++++++++++------------
 init/Kconfig                       |    2 +-
 7 files changed, 88 insertions(+), 55 deletions(-)

-- 
1.7.4.1
