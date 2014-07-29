From: oleg@redhat.com (Oleg Nesterov)
Date: Tue, 29 Jul 2014 21:20:56 +0200
Subject: [PATCH v4 0/5] x86: two-phase syscall tracing and seccomp fastpath
In-Reply-To: <cover.1406604806.git.luto@amacapital.net>
References: <cover.1406604806.git.luto@amacapital.net>
Message-ID: <20140729192056.GA6308@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy, to avoid the confusion: I am not trying to review this changes.
As you probably know my understanding of asm code in entry.S is very
limited.

Just a couple of questions to ensure I understand this correctly.

On 07/28, Andy Lutomirski wrote:
>
> This is both a cleanup and a speedup.  It reduces overhead due to
> installing a trivial seccomp filter by 87%.  The speedup comes from
> avoiding the full syscall tracing mechanism for filters that don't
> return SECCOMP_RET_TRACE.

And only after I look at 5/5 I _seem_ to actually understand where
this speedup comes from.

So. Currently tracesys: path always lead to "iret" after syscall, with
this change we can avoid it if phase_1() returns zero, correct?

And, this also removes the special TIF_SYSCALL_AUDIT-only case in entry.S,
cool.

I am wondering if we can do something similar with do_notify_resume() ?


Stupid question. To simplify, lets forget that syscall_trace_enter()
already returns the value. Can't we simplify the asm code if we do
not export 2 functions, but make syscall_trace_enter() return
"bool slow_path_is_needed". So that "tracesys:" could do

	// pseudo code

tracesys:
	SAVE_REST
	FIXUP_TOP_OF_STACK

	call syscall_trace_enter

	if (!slow_path_is_needed) {
		addq REST_SKIP, %rsp
		jmp system_call_fastpath
	}
	
	...

?

Once again, I am just curious, it is not that I actually suggest to consider
this option.

Oleg.
