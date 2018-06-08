From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 8 Jun 2018 13:22:02 +0100
Subject: [PATCH] arm64: Fix syscall restarting around signal suppressed
 by tracer
In-Reply-To: <1528371125-24505-1-git-send-email-Dave.Martin@arm.com>
References: <1528371125-24505-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20180608122201.7h52jstqik6zs22i@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2018 at 12:32:05PM +0100, Dave P Martin wrote:
> Commit 17c2895 ("arm64: Abstract syscallno manipulation") abstracts
> out the pt_regs.syscallno value for a syscall cancelled by a tracer
> as NO_SYSCALL, and provides helpers to set and check for this
> condition.  However, the way this was implemented has the
> unintended side-effect of disabling part of the syscall restart
> logic.
> 
> This comes about because the second in_syscall() check in
> do_signal() re-evaluates the "in a syscall" condition based on the
> updated pt_regs instead of the original pt_regs.  forget_syscall()
> is explicitly called prior to the second check in order to prevent
> restart logic in the ret_to_user path being spuriously triggered,
> which means that the second in_syscall() check always yields false.
> 
> This triggers a failure in
> tools/testing/selftests/seccomp/seccomp_bpf.c, when using ptrace to
> suppress a signal that interrups a nanosleep() syscall.
> 
> Misbehaviour of this type is only expected in the case where a
> tracer suppresses a signal and the target process is either being
> single-stepped or the interrupted syscall attempts to restart via
> -ERESTARTBLOCK.
> 
> This patch restores the old behaviour by performing the
> in_syscall() check only once at the start of the function.
> 
> Fixes: 17c289586009 ("arm64: Abstract syscallno manipulation")
> Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> Reported-by: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: <stable@vger.kernel.org> # 4.14.x-

Applied. Thanks.

-- 
Catalin
