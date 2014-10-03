From: will.deacon@arm.com (Will Deacon)
Date: Fri, 3 Oct 2014 16:23:28 +0100
Subject: [PATCH v6 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <542BE095.3010107@linaro.org>
References: <1408611405-8943-1-git-send-email-takahiro.akashi@linaro.org>
 <1408611405-8943-3-git-send-email-takahiro.akashi@linaro.org>
 <CAGXu5jJCyqpXkdvNDCu+eMr0qnqwbqUUo4u+2p_7DvFMzfKoEw@mail.gmail.com>
 <53F69045.7010301@linaro.org> <20140826175128.GD23445@arm.com>
 <542BE095.3010107@linaro.org>
Message-ID: <20141003152328.GB32451@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 01, 2014 at 12:08:05PM +0100, AKASHI Takahiro wrote:
> Will,
> 
> When I was looking into syscall_trace_exit() more closely, I found
> another (big) problem.
> There are two system calls, execve() and rt_sigreturn(), which change
> 'syscallno' in pt_regs to -1 in start_thread() and restore_sigframe(),
> respectively.
> 
> Since syscallno is not valid anymore in syscall_trace_exit() for these
> system calls, we cannot create a correct syscall exit record for tracepoint
> in trace_sys_exit() (=> ftrace_syscall_exit()) and for audit in audit_syscall_exit().
> 
> This does not happen on arm because syscall numbers are kept in
> thread_info on arm.
> 
> How can we deal with this issue?

How is this handled on other architectures? x86, for example, seems to zero
orig_ax when restoring the sigcontext, but leaves it alone in start_thread.

What is the impact of this problem? AFAICT, we just miss some exits, right
(as opposed to an OOPs or the like)?

Will
