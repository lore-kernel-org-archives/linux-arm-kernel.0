From: anton@samba.org (Anton Blanchard)
Date: Tue, 24 Feb 2015 14:30:27 +1100
Subject: [PATCH 0/7] Serialise oopses, BUGs, WARNs, dump_stack,
 soft lockups and hard lockups
Message-ID: <1424748634-9153-1-git-send-email-anton@samba.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Every now and then I end up with an undebuggable issue because multiple
CPUs hit something at the same time and everything is interleaved:

        CR: 48000082  XER: 00000000
        ,RI
        c0000003dc72fd10
        ,LE
        d0000000065b84e8
        Instruction dump:
        MSR: 8000000100029033

Very annoying.

Some architectures already have their own recursive locking for oopses
and we have another version for serialising dump_stack.

Create a common version and use it everywhere (oopses, BUGs, WARNs,
dump_stack, soft lockups and hard lockups). A few testcases were
used to verify the series:

A trivial module to create concurrent WARNs, BUGs and oopses:

http://ozlabs.org/~anton/junkcode/warnstorm.tar.gz

And one to create concurrent soft and hard lockups:

http://ozlabs.org/~anton/junkcode/badguy.tar.gz

Anton Blanchard (7):
  Add die_spin_lock_{irqsave,irqrestore}
  powerpc: Use die_spin_lock_{irqsave,irqrestore}
  arm: Use die_spin_lock_{irqsave,irqrestore}
  x86: Use die_spin_lock_{irqsave,irqrestore}
  watchdog: Serialise soft lockup errors with
    die_spin_lock_{irqsave,irqrestore}
  dump_stack: Serialise dump_stack with
    die_spin_lock_{irqsave,irqrestore}
  powerpc: Serialise BUG and WARNs with
    die_spin_lock_{irqsave,irqrestore}

 arch/arm/kernel/traps.c     | 26 ++---------------
 arch/powerpc/kernel/traps.c | 68 ++++++++++++++++++++++++++-------------------
 arch/x86/kernel/dumpstack.c | 26 ++---------------
 include/linux/die_lock.h    | 23 +++++++++++++++
 kernel/watchdog.c           |  4 +++
 lib/Makefile                |  1 +
 lib/die_lock.c              | 43 ++++++++++++++++++++++++++++
 lib/dump_stack.c            | 40 +++-----------------------
 8 files changed, 120 insertions(+), 111 deletions(-)
 create mode 100644 include/linux/die_lock.h
 create mode 100644 lib/die_lock.c

-- 
2.1.0
