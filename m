From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 02 Sep 2014 17:47:29 +0900
Subject: [PATCH v6 2/6] arm64: ptrace: allow tracer to skip a system call
In-Reply-To: <20140901114751.GG30401@n2100.arm.linux.org.uk>
References: <1408611405-8943-1-git-send-email-takahiro.akashi@linaro.org>
 <1408611405-8943-3-git-send-email-takahiro.akashi@linaro.org>
 <CAGXu5jJCyqpXkdvNDCu+eMr0qnqwbqUUo4u+2p_7DvFMzfKoEw@mail.gmail.com>
 <53F69045.7010301@linaro.org> <20140826175128.GD23445@arm.com>
 <53FD72E2.4020103@linaro.org> <20140901114751.GG30401@n2100.arm.linux.org.uk>
Message-ID: <54058421.5070506@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2014 08:47 PM, Russell King - ARM Linux wrote:
> On Wed, Aug 27, 2014 at 02:55:46PM +0900, AKASHI Takahiro wrote:
>> 1)
>> setting x0 to -ENOSYS is necessary because, otherwise, user-issued syscall(-1) will
>> return a bogus value when audit tracing is on.
>>
>> Please note that, on arm,
>>                   not traced      traced
>>                   ------          ------
>> syscall(-1)      aborted         OOPs(BUG_ON)
>> syscall(-3000)   aborted         aborted
>> syscall(1000)    ENOSYS          ENOSYS
>
> Two points here:
>
> 1. You've found a case which causes a BUG_ON().  Where is the bug report
>     for this, so the problem can be investigated and resolved?

I think that I mentioned it could also happen on arm somewhere in a talk with Will,
but don't remember exactly when.

> 2. What do you mean by "aborted" ?

I mean that the process will receive SIGILL and get aborted.
A system call number, like -1 and -3000, won't be trapped by *switch* statement
in asm_syscall() and end up with being signaled.

> Please, if you find a problem with 32-bit ARM, report it.  Don't hide it,
> because hiding it can be a security issue or in the case of BUG_ON(), it
> could be a denial of service issue.
>
> As you're part of Linaro, I would have thought you'd be more responsible
> in this regard - after all, Linaro is supposed to be about improving the
> ARM kernel...  Maybe I got that wrong, and Linaro is actually about
> ensuring that the ARM kernel is stuffed full of broken features?

I thought my first priority was on arm64 (and then arm), but now that you and Will
seem to want to see the fix first on arm, okey, I will start with arm issue.

Thanks,
-Takahiro AKASHI
