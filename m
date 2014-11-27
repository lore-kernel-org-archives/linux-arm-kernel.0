From: will.deacon@arm.com (Will Deacon)
Date: Thu, 27 Nov 2014 10:07:22 +0000
Subject: [PATCH v9 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <5476C8C5.4010202@linaro.org>
References: <1416977391-24231-1-git-send-email-takahiro.akashi@linaro.org>
 <1416977391-24231-3-git-send-email-takahiro.akashi@linaro.org>
 <20141126130252.GI14866@arm.com> <5476C8C5.4010202@linaro.org>
Message-ID: <20141127100722.GB20649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 06:46:29AM +0000, AKASHI Takahiro wrote:
> On 11/26/2014 10:02 PM, Will Deacon wrote:
> > On Wed, Nov 26, 2014 at 04:49:47AM +0000, AKASHI Takahiro wrote:
> >> If tracer modifies a syscall number to -1, this traced system call should
> >> be skipped with a return value specified in x0.
> >> This patch implements this semantics.
> >>
> >> Please note:
> >> * syscall entry tracing and syscall exit tracing (ftrace tracepoint and
> >>    audit) are always executed, if enabled, even when skipping a system call
> >>    (that is, -1).
> >>    In this way, we can avoid a potential bug where audit_syscall_entry()
> >>    might be called without audit_syscall_exit() at the previous system call
> >>    being called, that would cause OOPs in audit_syscall_entry().
> >>
> >> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> >> ---
> >>   arch/arm64/kernel/entry.S |   10 +++++++++-
> >>   1 file changed, 9 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> >> index 726b910..946ec52 100644
> >> --- a/arch/arm64/kernel/entry.S
> >> +++ b/arch/arm64/kernel/entry.S
> >> @@ -161,6 +161,7 @@
> >>    */
> >>   sc_nr	.req	x25		// number of system calls
> >>   scno	.req	x26		// syscall number
> >> +scno_w	.req	w26		// syscall number (lower 32 bits)
> >>   stbl	.req	x27		// syscall table pointer
> >>   tsk	.req	x28		// current thread_info
> >>
> >> @@ -668,8 +669,14 @@ ENDPROC(el0_svc)
> >>   	 * switches, and waiting for our parent to respond.
> >>   	 */
> >>   __sys_trace:
> >> -	mov	x0, sp
> >> +	cmp     scno_w, #-1			// set default errno for
> >
> > I hate that we have to use scno_w, but the only alternative I can think of
> > is using w8 directly, which isn't any better and doesn't work for compat.
> > Ho-hum, I guess we'll stick with what you have.
> 
> The possible approaches might be:
> * use 32-bit registers for scno & sc_nr and use "sxtw scno, w8," or
> * use an extra reg like
>      __sys_trace:
>          mov x0, #0xffffffff

or even better: mov w0, #-1

>          cmp scno, x0
>          b.ne 1f

Good thinking, I prefer that.

Will
