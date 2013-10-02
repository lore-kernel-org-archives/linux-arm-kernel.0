From: will.deacon@arm.com (Will Deacon)
Date: Wed, 2 Oct 2013 11:46:26 +0100
Subject: [PATCH] arm64: check for number of arguments in
 syscall_get/set_arguments()
In-Reply-To: <524BC11D.2050003@linaro.org>
References: <1380605584-22125-1-git-send-email-takahiro.akashi@linaro.org>
 <20131001091919.GA17667@mudshark.cambridge.arm.com>
 <524BC11D.2050003@linaro.org>
Message-ID: <20131002104625.GF28311@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 02, 2013 at 07:45:49AM +0100, AKASHI Takahiro wrote:
> On 10/01/2013 06:19 PM, Will Deacon wrote:
> > On Tue, Oct 01, 2013 at 06:33:04AM +0100, AKASHI Takahiro wrote:
> >> In ftrace_syscall_enter(),
> >>      syscall_get_arguments(..., 0, n, ...)
> >> 	if (i == 0) { <handle orig_x0> ...; n--;}
> >> 	memcpy(..., n * sizeof(args[0]));
> >> If 'number of arguments(n)' is zero and 'argument index(i)' is also zero in
> >> syscall_get_arguments(), none of arguments should be copied by memcpy().
> >> Otherwise 'n--' can be a big positive number and unexpected amount of data
> >> will be copied. Tracing system calls which take no argument, say sync(void),
> >> may hit this case and eventually make the system corrupted.
> >> This patch fixes the issue both in syscall_get_arguments() and
> >> syscall_set_arguments().
> >>
> >> Please note, however, that asm-generic/syscall.h says,
> >>   * syscall_get_arguments - extract system call parameter values
> >>   * @i:          argument index [0,5]
> >>   * @n:          number of arguments; n+i must be [1,6].
> >> and so we'd better change the caller's code(ftrace_syscall_enter).
> >
> > Since (most) other architectures deal with n+i == 0, please can you submit a
> > separate patch updating that comment?
> 
> Yes, I will. But is the patch that only modifies a comment acceptable?

Well, if the comment is wrong is should either be fixed or removed. Leaving
it alone just serves to confuse other architectures trying to implement the
backend API.

Of course, if the comment is *correct*, then the tracer is broken, but we
can have that discussion off the back of the patch (just be sure to CC the
right people).

> > Looks sensible. Please can you fix arch/arm/ as well?
> 
> Yes, I will.

Thanks!

Will
