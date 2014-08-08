From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Fri, 08 Aug 2014 16:35:42 +0900
Subject: [PATCH v5 3/3] arm64: Add seccomp support
In-Reply-To: <CAGXu5jJL=zXuSRNomGrB09kqpUhEpkuxDH18JN4NRbWocMw4xg@mail.gmail.com>
References: <1406020499-5537-1-git-send-email-takahiro.akashi@linaro.org>	<1406020499-5537-4-git-send-email-takahiro.akashi@linaro.org>	<53D082E9.8090303@amacapital.net>	<53D09C4F.9010104@linaro.org>	<CALCETrWTDS7VSyuR5wgGxpu-_YMWVUVmv9ht6t1tCSX=GA46cQ@mail.gmail.com>	<53D2255C.9050006@linaro.org>
 <CAGXu5jJL=zXuSRNomGrB09kqpUhEpkuxDH18JN4NRbWocMw4xg@mail.gmail.com>
Message-ID: <53E47DCE.4080902@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2014 12:08 AM, Kees Cook wrote:
> On Fri, Jul 25, 2014 at 2:37 AM, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
>> I found a bug in my current patch (v5). When 32-bit tracer skips a system call,
>> we should not update syscallno from x8 since syscallno is re-written directly
>> via ptrace(PTRACE_SET_SYSCALL).
>
> Ah, yes. Will aarch64 have a PTRACE_SET_SYSCALL option, or is this
> strictly a 32-bit vs 64-bit issue?

As discussed in a few weeks ago, aarch64 won't support PTRACE_SET_SYSCALL.

>> I'm sure that my next version should work with 32/64-bit tracers on 64-bit
>> kernel.
>
> Do you have a git tree uploaded anywhere? I'd love to follow this more
> closely. When do you expect a v6?

I'd like to submit v6 as soon as possible, but
(1) how we should handle syscall(-1) is annoying me.
     Without ptracer, we will normally return -ENOSYS but, for example,
     what if some seccomp filter is installed and it does allow (or doesn't
     have any rule against) '-1' syscall? Since the kernel doesn't know tracer's
     intention, we should just let syscall(-1) return a bogus value.
     Thus we will see inconsistent results of syscall(-1).

(2) I'm investigating some failures in Kees' test suite.
   * 'TRACE.handler' case on compat task:
     Now I found a bug in arm64's compat_siginfo_t and fixed it.
   * 'TSYNC.two_siblings_*' cases on 32/64-bit task:
     I rebased my patch on pre-v3.17-rc1, but those cases still fail.
     I have no clues at this moment.

So please be patient for a while.

-Takahiro AKASHI


> Thanks!
>
> -Kees
>
