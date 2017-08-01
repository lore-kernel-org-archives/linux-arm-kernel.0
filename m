From: Dave.Martin@arm.com (Dave Martin)
Date: Tue,  1 Aug 2017 15:35:52 +0100
Subject: [PATCH v2 REPOST 0/2] arm64: Abstract syscallno manipulation
Message-ID: <1501598154-1663-1-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[Reposting to add Will's Ack]


Changes since v1:

 * Change the argument of in_syscall() from int sycallno to a struct
   pt_regs *, since that's more natural for the current callsites.

 * Add missing #include of <asm/ptrace.h>.

 * Minor commit message clarifications.


Original blurb:

The upper 32 bits of the syscallno field in struct pt_regs are handled
inconsistently, being sometimes zero extended and sometimes
sign-extended.  The reason for this appears to be that they are not
intentionally significant at all.

This series attempts to clarify this situation by getting rid of the
spurious extra bits and adding a symbolic #define and helpers.

My current motivation for this series is SVE, which will makes use of
the in_syscall() condition to decide when the user SVE register state
for a thread can be discarded.


The refactoring done by this series also fixes a strange behaviour
observable in ftrace when a tracer cancels a syscall in a compat
binary.  Currently, ftrace traces the syscall number erroneously in
this case:

    cancel-sys32-2142  [001] ....  1740.510558: sys_enter: NR 4294967295 (1, 6a364, e, 0, 0, 85e)

instead of the expected:

    cancel-sys32-2142  [001] ....  1740.510558: sys_enter: NR -1 (1, 6a364, e, 0, 0, 85e)

(Native always says -1, as one might expect.)


The gdb testsuite reports no regressions resulting from this series.

For big-endian, I have only boot-tested, and checked by inspection that
the offset of syscallno in pt_regs is transformed in the correct way
(+4) compared with little-endian.


Dave Martin (2):
  arm64: syscallno is secretly an int, make it official
  arm64: Abstract syscallno manipulation

 arch/arm64/include/asm/processor.h |  2 +-
 arch/arm64/include/asm/ptrace.h    | 30 +++++++++++++++++++++++++++-
 arch/arm64/kernel/entry.S          | 40 ++++++++++++++++++--------------------
 arch/arm64/kernel/ptrace.c         |  2 +-
 arch/arm64/kernel/signal.c         | 10 +++++-----
 arch/arm64/kernel/signal32.c       |  2 +-
 arch/arm64/kernel/traps.c          |  2 +-
 7 files changed, 57 insertions(+), 31 deletions(-)

-- 
2.1.4
