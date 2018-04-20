From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 20 Apr 2018 11:46:16 +0100
Subject: [RFC PATCH 0/3] arm64: stacktrace: Improve robustness and ensure
 termination of backtraces
Message-ID: <1524221179-19473-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As reported by Ji Zhang, [1] arm64's backtracer currently has limited
protection against stack corruption.  In particular, it is possible to
cycle between stacks.  It is also possible to cycle on a single stack
because the same-stack and different-stack cases of the transition to
the next frame are not distinguished, meaning that it is not
straightforward to check that the frame address is moving in the
correct direction.  Both of these can result in infinite backtrace
loops.

This series attempts to build on the approach in [1] to ensure forward
progress and eventual termination of any backtrace.

It makes some assumptions, particularly about which stack transitions
are valid -- so feedback from anybody who is familiar with arm64
kernel stack management would be very useful here.

This series is also completely untested!  It builds.

[1] [PATCH] arm64: avoid potential infinity loop in dump_backtrace
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/572579.html

Dave Martin (3):
  arm64: stacktrace: Constify stacktrace.h functions
  arm64: stacktrace: Factor out backtrace initialisation
  arm64: stacktrace: Prevent looping and invalid stack transitions

 arch/arm64/include/asm/stacktrace.h | 48 ++++++++++++++++++++++++++++++-------
 arch/arm64/kernel/process.c         |  6 +----
 arch/arm64/kernel/stacktrace.c      | 16 ++++++++-----
 arch/arm64/kernel/time.c            |  6 +----
 arch/arm64/kernel/traps.c           | 21 +++++++---------
 5 files changed, 60 insertions(+), 37 deletions(-)

-- 
2.1.4
