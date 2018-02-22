From: will.deacon@arm.com (Will Deacon)
Date: Thu, 22 Feb 2018 14:00:48 +0000
Subject: [PATCH 0/9] arm64: Consolidate use of show_unhandled_signals
Message-ID: <1519308057-4953-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series attempts to consolidate our handling of
show_unhandled_signals into arm64_force_sig_info. This helps to keep
things consistent, as well as avoid accidentally printing messages
where they aren't necessarily appropriate, or end up leaking kernel
state.

In writing this, I found a few weird behaviours with the way in which we
populate siginfo_t and also some opportunities for tidy-ups and
simplification.

Patches based on fixes/core.

Cheers,

Will

--->8

Will Deacon (9):
  arm64: signal: Make force_signal_inject more robust
  arm64: signal: Force SIGKILL for unknown signals in
    force_signal_inject
  arm64: Introduce arm64_force_sig_info and hook up in arm64_notify_die
  arm64: signal: Don't print anything directly in force_signal_inject
  arm64: Pass user fault info to arm64_notify_die instead of printing it
  arm64: mm: Rework unhandled user pagefaults to call
    arm64_force_sig_info
  arm64: signal: Call arm64_notify_segfault when failing to deliver
    signal
  arm64: Move show_unhandled_signals_ratelimited into traps.c
  arm64: Use arm64_force_sig_info instead of force_sig_info

 arch/arm64/include/asm/system_misc.h |  11 ----
 arch/arm64/include/asm/traps.h       |   8 +--
 arch/arm64/kernel/debug-monitors.c   |   3 +-
 arch/arm64/kernel/fpsimd.c           |   5 +-
 arch/arm64/kernel/ptrace.c           |   2 +-
 arch/arm64/kernel/signal.c           |   7 +--
 arch/arm64/kernel/signal32.c         |  13 +---
 arch/arm64/kernel/traps.c            |  72 ++++++++++++++-------
 arch/arm64/mm/fault.c                | 117 +++++++++++++----------------------
 9 files changed, 108 insertions(+), 130 deletions(-)

-- 
2.1.4
