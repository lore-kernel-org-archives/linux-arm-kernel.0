From: ccross@android.com (Colin Cross)
Date: Sun, 26 Aug 2012 15:46:54 -0700
Subject: [PATCH 0/2] ARM: enable dumping stacks for CONFIG_SMP
Message-ID: <1346021216-21979-1-git-send-email-ccross@android.com>
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

 arch/arm/kernel/stacktrace.c |   24 +++++++++++++-----------
 arch/arm/kernel/unwind.c     |   31 +++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 15 deletions(-)
