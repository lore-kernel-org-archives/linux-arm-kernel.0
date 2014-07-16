From: keescook@chromium.org (Kees Cook)
Date: Wed, 16 Jul 2014 13:12:32 -0700
Subject: [PATCH 2/7] seccomp: Refactor the filter callback and the API
In-Reply-To: <4f153feea35430104d6d1a7c83805fccbffdf089.1405452484.git.luto@amacapital.net>
References: <cover.1405452484.git.luto@amacapital.net>
 <4f153feea35430104d6d1a7c83805fccbffdf089.1405452484.git.luto@amacapital.net>
Message-ID: <CAGXu5jK0v=dtPNY4Y2m7D01peeNoBSDq8zowgLu_rjZe41=eUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 12:32 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> The reason I did this is to add a seccomp API that will be usable
> for an x86 fast path.  The x86 entry code needs to use a rather
> expensive slow path for a syscall that might be visible to things
> like ptrace.  By splitting seccomp into two phases, we can check
> whether we need the slow path and then use the fast path in if the
> filter allows the syscall or just returns some errno.
>
> As a side effect, I think the new code is much easier to understand
> than the old code.

I'd agree. The #idefs got a little weirder, but the actual code flow
was much easier to read. I wonder if "phase1" and "phase2" should be
renamed "pretrace" and "tracing" or something more meaningful? Or
"fast" and "slow"?

> This has one user-visible effect: the audit record written for
> SECCOMP_RET_TRACE is now a simple indication that SECCOMP_RET_TRACE
> happened.  It used to depend in a complicated way on what the tracer
> did.  I couldn't make much sense of it.

I think this change is okay. The only way to get the audit record to
report SIGSYS before was to have an additional signal come in and kill
it while the tracer was working on it. Which is confusing too. I like
this way better.

-Kees

-- 
Kees Cook
Chrome OS Security
