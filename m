From: luto@amacapital.net (Andy Lutomirski)
Date: Wed, 18 Jun 2014 13:51:39 -0700
Subject: [PATCH] arm: ptrace: fix syscall modification under
 PTRACE_O_TRACESECCOMP
In-Reply-To: <20140618202748.GA9022@www.outflux.net>
References: <20140618202748.GA9022@www.outflux.net>
Message-ID: <CALCETrX+3fVvLncFJmZ+4Esgt1esqinGxwK89LopLAXo=3HR0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 1:27 PM, Kees Cook <keescook@chromium.org> wrote:
> An x86 tracer wanting to change the syscall uses PTRACE_SETREGS
> (stored to regs->orig_ax), and an ARM tracer uses PTRACE_SET_SYSCALL
> (stored to current_thread_info()->syscall). When this happens, the
> syscall can change across the call to secure_computing(), since it may
> block on tracer notification, and the tracer can then make changes
> to the process, before we return from secure_computing(). This
> means the code must respect the changed syscall after the
> secure_computing() call in syscall_trace_enter(). The same is true
> for tracehook_report_syscall_entry() which may also block and change
> the syscall.
>
> The x86 code handles this (it expects orig_ax to always be the
> desired syscall). In the ARM case, this means we should not be touching
> current_thread_info()->syscall after its initial assignment. All failures
> should result in a -1 syscall, though.

This looks sensible.

--Andy
