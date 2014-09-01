From: will.deacon@arm.com (Will Deacon)
Date: Mon, 1 Sep 2014 12:37:55 +0100
Subject: [PATCH v6 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <53FD72E2.4020103@linaro.org>
References: <1408611405-8943-1-git-send-email-takahiro.akashi@linaro.org>
 <1408611405-8943-3-git-send-email-takahiro.akashi@linaro.org>
 <CAGXu5jJCyqpXkdvNDCu+eMr0qnqwbqUUo4u+2p_7DvFMzfKoEw@mail.gmail.com>
 <53F69045.7010301@linaro.org> <20140826175128.GD23445@arm.com>
 <53FD72E2.4020103@linaro.org>
Message-ID: <20140901113755.GA24594@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 27, 2014 at 06:55:46AM +0100, AKASHI Takahiro wrote:
> On 08/27/2014 02:51 AM, Will Deacon wrote:
> > On Fri, Aug 22, 2014 at 01:35:17AM +0100, AKASHI Takahiro wrote:
> >> Oops, you're absolutely right. I didn't think of this case.
> >> syscall_trace_enter() should not return a syscallno directly, but always
> >> return -1 if syscallno < 0. (except when secure_computing() returns with -1)
> >> This also implies that tracehook_report_syscall() should also have a return value.
> >>
> >> Will, is this fine with you?
> >
> > Well, the first thing that jumps out at me is why this is being done
> > completely differently for arm64 and arm. I thought adding the new ptrace
> > requests would reconcile the differences?
> 
> I'm not sure what portion of my code you mentioned as "completely different", but
> 
> 1)
> setting x0 to -ENOSYS is necessary because, otherwise, user-issued syscall(-1) will
> return a bogus value when audit tracing is on.
> 
> Please note that, on arm,
>                   not traced      traced
>                   ------          ------
> syscall(-1)      aborted         OOPs(BUG_ON)
> syscall(-3000)   aborted         aborted
> syscall(1000)    ENOSYS          ENOSYS
> 
> So, anyhow, its a bit difficult and meaningless to mimic these invalid cases.

I'm not suggesting we make ourselves bug-compatible with ARM. Instead, I'd
rather see a series of patches getting the ARM code working correctly,
before we go off doing something different for arm64.

> 2)
> branching a new label, syscall_trace_return_skip (see entry.S), after syscall_trace_enter()
> is necessary in order to avoid OOPS in audit_syscall_enter() as we discussed.
> 
> Did I make it clear?

Sure. So let's fix ARM, then look at the arm64 port after that. I really
want to avoid divergence in this area.

Will
