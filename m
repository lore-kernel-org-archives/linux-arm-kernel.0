From: cmetcalf@ezchip.com (Chris Metcalf)
Date: Mon, 29 Feb 2016 16:40:20 -0500
Subject: [PATCH 0/4] improvements to the nmi_backtrace code
Message-ID: <1456782024-7122-1-git-send-email-cmetcalf@ezchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series modifies the trigger_xxx_backtrace() NMI-based
remote backtracing code to make it more flexible, and makes a few
small improvements along the way.

The motivation comes from the task isolation code, where there are
scenarios where we want to be able to diagnose a case where some cpu
is about to interrupt a task-isolated cpu.  It can be helpful to
see both where the interrupting cpu is, and also an approximation
of where the cpu that is being interrupted is.  The nmi_backtrace
framework allows us to discover the stack of the interrupted cpu.

The first change adds support for trigger_single_cpu_backtrace(), and
as an "API side-effect", trigger_cpumask_backtrace().  The underlying
abstraction is changed to use cpumasks instead of a "bool except_self".

The second and third changes provide small improvements to the
behavior of the existing nmi_backtrace code: omitting full backtrace
dumps for idle cores, and doing local dump_stack backtraces when we
try to do a "remote" dump of the local core.  Some of this reflects
changes from integrating the arch/tile code into the generic code.

The fourth change hooks the arch/tile backtrace mechanism into
the nmi_backtrace code to share code and take advantage of other
improvements of nmi_backtrace not present in the original arch/tile
code, like co-opting printk to use local buffers instead of just
spewing to the console and hoping for the best.

The changes have been runtime tested on tile, and build-tested on
x86 and arm.

Chris Metcalf (4):
  nmi_backtrace: add more trigger_*_cpu_backtrace() methods
  nmi_backtrace: generate one-line reports for idle cpus
  nmi_backtrace: do a local dump_stack() instead of a self-NMI
  arch/tile: adopt the new nmi_backtrace framework

 arch/arm/include/asm/irq.h    |  4 +--
 arch/arm/kernel/smp.c         | 13 ++------
 arch/tile/include/asm/irq.h   |  4 +--
 arch/tile/kernel/pmc.c        |  3 --
 arch/tile/kernel/process.c    | 72 ++++++++++---------------------------------
 arch/tile/kernel/traps.c      |  7 +++--
 arch/x86/include/asm/irq.h    |  4 +--
 arch/x86/kernel/apic/hw_nmi.c |  6 ++--
 include/linux/nmi.h           | 63 +++++++++++++++++++++++++++++--------
 lib/nmi_backtrace.c           | 48 ++++++++++++++++++++---------
 10 files changed, 116 insertions(+), 108 deletions(-)

-- 
2.1.2
