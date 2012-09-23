From: ccross@android.com (Colin Cross)
Date: Sat, 22 Sep 2012 19:52:56 -0700
Subject: [PATCH 0/2] ARM: enable dumping stacks for CONFIG_SMP
In-Reply-To: <1346021216-21979-1-git-send-email-ccross@android.com>
References: <1346021216-21979-1-git-send-email-ccross@android.com>
Message-ID: <CAMbhsRRd0y7YvO39WzKu+KttTCG4tYotHyPTxvib=Y2vXdjTRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 26, 2012 at 3:46 PM, Colin Cross <ccross@android.com> wrote:
> This topic has come up before, see
> http://comments.gmane.org/gmane.linux.ports.arm.kernel/102458
> for the previous discussion.
>
> SMP is now the norm for new ARM systems, and the limitation that
> CONFIG_STACKTRACE doesn't work for tasks besides 'current' causes
> problems.  The particular case I'm dealing with is automated
> debugging information collected from /proc/<pid>/stack when
> userspace detects a process is not responding.
>
> Dumping stacktraces is currently disabled due to the worry that the
> task may be running on another CPU and that the unwinder may be
> unstable when presented with a stack that is being modified.  I have
> attempted to harden the frame pointer based unwinder and the unwind
> table based unwinder against invalid stacks.  I separated the two
> into individual patches, as I expect the patch to the table unwinder
> to be more controversial than the frame pointer unwinder.
>
> Even without the hardening, unwinding a stack for a running process
> is not completely untested.  When CONFIG_ARM_UNWIND is enabled,
> sysrq-t calls unwind_backtrace for all tasks including running ones.
> In addition, any callers to unwind_frame with preemption enabled,
> including proc_pid_stack, could see a modified stack even on a UP
> system (pointed out by Rabin Vincent the last time this topic came
> up).
>
>  arch/arm/kernel/stacktrace.c |   24 +++++++++++++-----------
>  arch/arm/kernel/unwind.c     |   31 +++++++++++++++++++++++++++----
>  2 files changed, 40 insertions(+), 15 deletions(-)

I sent this series during Plumbers travel season, so maybe it got
missed.  Any comments?  Enabling stack traces at least for the
CONFIG_ARM_UNWIND=n case would be very helpful for automated bug
report collection.
