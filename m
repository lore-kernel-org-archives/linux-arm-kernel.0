From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Tue, 09 Sep 2014 13:48:51 +0900
Subject: [PATCH] arm: prevent BUG_ON in audit_syscall_entry()
In-Reply-To: <20140905095252.GF30401@n2100.arm.linux.org.uk>
References: <1409910393-30896-1-git-send-email-takahiro.akashi@linaro.org>
 <20140905095252.GF30401@n2100.arm.linux.org.uk>
Message-ID: <540E86B3.7080700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 09/05/2014 06:52 PM, Russell King - ARM Linux wrote:
> On Fri, Sep 05, 2014 at 06:46:33PM +0900, AKASHI Takahiro wrote:
>> BUG_ON() in audit_syscall_entry() will be hit if user issues syscall(-1)
>> while syscall auditing is enabled (that is, by starting auditd).
>> In fact, syscall(-1) just fails (not signaled despite the expectation,
>> this is another minor bug), but the succeeding syscall hits BUG_ON.
>>
>> When auditing syscall(-1), audit_syscall_entry() is called anyway, but
>> audit_syscall_exit() is not called and then 'in_syscall' flag in thread's
>> audit context is kept on. In this way, audit_syscall_entry() against
>> the succeeding syscall will see BUG_ON(in_syscall).
>>
>> This patch fixes this bug by
>> 1) enforcing syscall exit tracing, including audit_syscall_exit(), to be
>>     executed in all cases,
>
> Really, no.  That adds additional overhead to every syscall, and that
> matters for system performance.  We want to have as little as possible
> overhead here.

My words might have confused you, but this issue exists, in the current
mainline kernel, not only against syscall(-1), but any invalid or pseudo syscalls.
(And other archs seem to behave in the same way AFAIK.)
But if you want, I can fix it.
See my next version.

-Takahiro AKASHI

> The second issue here is that you haven't explained where the oops
> occurs.  It's seen as a good practice to include the oops dump for the
> bug you're fixing in the commit changelog, so that others can see the
> starting point for the investigation, and see exactly where things are
> going wrong.
>
