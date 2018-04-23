From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 23 Apr 2018 18:07:00 +0100
Subject: [RFC PATCH v2 0/3] arm64: stacktrace: Improve robustness and ensure
 termination of backtraces
Message-ID: <1524503223-17576-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an update to the previous RFC. [1]

Major changes since RFC v1:

 * Remove assumptions about a strict hierachy of the different stacks. [*]

 * Visited stacks are now tracked using a bitmap in struct stackframe
   to prevent cycling.

 * Still untested.

Comments welcome.

[*] For those interested, I think valid backtraces are as follows.
Nodes in [] are the starting points for the backtrace (depending on
which stack the initial FP points to).  Valid transitions are upwards
and leftwards.  Validity is transitive (so, [sde] -> [task] is allowed
for example).

   [task]---[irq]----sde-----sdec
       \      \         \       \
        `------ ovf     ovf    [ovf]
                   \       \
                    [sde]---[sdec]

(ovf = overflow stack; sde = normal SDEI stack;
sdec = critical SDEI stack).

(It's the overflow stack that complicates this picture.)


Sadly, this ends up a lot more complex to express in the code than
seems reasonable if coded longhand.  A table-driven approach could be
a lot cleaner, but nobody is going to enjoy maintaining the table of
transitions :P

Failing this, this series should at least ensure termination after a
finite number of frames.  The chance of a randomly corrupted stack
frame linking to a frame address that is also on a valid stack is
minimal in practice anyway.


Original blurb:

As reported by Ji Zhang, [2] arm64's backtracer currently has limited
protection against stack corruption.  In particular, it is possible to
cycle between stacks.  It is also possible to cycle on a single stack
because the same-stack and different-stack cases of the transition to
the next frame are not distinguished, meaning that it is not
straightforward to check that the frame address is moving in the
correct direction.  Both of these can result in infinite backtrace
loops.

This series attempts to build on the approach in [2] to ensure forward
progress and eventual termination of any backtrace.

It makes some assumptions, particularly about which stack transitions
are valid -- so feedback from anybody who is familiar with arm64
kernel stack management would be very useful here.

This series is also completely untested!  It builds.

[1] [RFC PATCH 0/3] arm64: stacktrace: Improve robustness and ensure termination of backtraces
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/572685.html

[2] [PATCH] arm64: avoid potential infinity loop in dump_backtrace
http://lists.infradead.org/pipermail/linux-arm-kernel/2018-April/572579.html

Dave Martin (3):
  arm64: stacktrace: Constify stacktrace.h functions
  arm64: stacktrace: Factor out backtrace initialisation
  arm64: stacktrace: Prevent looping and invalid stack transitions

 arch/arm64/include/asm/sdei.h       | 13 +++++++------
 arch/arm64/include/asm/stackid.h    | 22 +++++++++++++++++++++
 arch/arm64/include/asm/stacktrace.h | 38 ++++++++++++++++++++++++++++---------
 arch/arm64/kernel/process.c         |  6 +-----
 arch/arm64/kernel/sdei.c            | 12 ++++++++----
 arch/arm64/kernel/stacktrace.c      | 30 +++++++++++++++++++++++------
 arch/arm64/kernel/time.c            |  6 +-----
 arch/arm64/kernel/traps.c           | 21 ++++++++------------
 8 files changed, 100 insertions(+), 48 deletions(-)
 create mode 100644 arch/arm64/include/asm/stackid.h

-- 
2.1.4
