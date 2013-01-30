From: ccross@android.com (Colin Cross)
Date: Tue, 29 Jan 2013 17:55:44 -0800
Subject: [PATCH v3 0/3] ARM: enable dumping stacks for CONFIG_SMP
Message-ID: <1359510947-3950-1-git-send-email-ccross@android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This topic has come up before, see
http://comments.gmane.org/gmane.linux.ports.arm.kernel/102458
for the previous discussion.

SMP is now the norm for new ARM systems, and the limitation that
CONFIG_STACKTRACE doesn't work for tasks besides 'current' causes
problems.  The particular case I'm dealing with is automated
debugging information collected from /proc/<pid>/stack when
userspace detects a process is not responding.

Dumping stacktraces is currently disabled due to the worry that the
task may be running on another CPU and that the unwinder may be
unstable when presented with a stack that is being modified.  I have
attempted to harden the frame pointer based unwinder and the unwind
table based unwinder against invalid stacks.  I separated the two
into individual patches, as I expect the patch to the table unwinder
to be more controversial than the frame pointer unwinder.

Even without the hardening, unwinding a stack for a running process
is not completely untested.  When CONFIG_ARM_UNWIND is enabled,
sysrq-t calls unwind_backtrace for all tasks including running ones.
In addition, any callers to unwind_frame with preemption enabled,
including proc_pid_stack, could see a modified stack even on a UP
system (pointed out by Rabin Vincent the last time this topic came
up).

v2 of the patchset adds additional checks to avoid starting the
stacktrace in an unmapped region or looping forever when unwinding
a bad stack.

v2:
   add depth parameter to unwind_frame
   verify that sp changes for non-leaf frames
   verify that initial sp value is in mapped lowmem
   verify that stack offsets are in the range
      [sizeof(struct thread_info), THREAD_START_SP)

v3:
   fix calling sp_addr_valid before page structs are set up

 arch/arm/include/asm/stacktrace.h |    6 ++-
 arch/arm/kernel/process.c         |    2 +-
 arch/arm/kernel/stacktrace.c      |  122 +++++++++++++++++++++++++++++++------
 arch/arm/kernel/time.c            |    3 +-
 arch/arm/kernel/unwind.c          |   46 ++++++++++----
 5 files changed, 145 insertions(+), 34 deletions(-)
