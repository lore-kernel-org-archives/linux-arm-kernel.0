From: sebastian.capella@linaro.org (Sebastian Capella)
Date: Mon, 14 Apr 2014 15:37:58 -0700
Subject: [PATCH v9 1/2] ARM: avoid tracers in soft_restart
In-Reply-To: <20140414105314.GB3530@arm.com>
References: <1395178858-27343-1-git-send-email-sebastian.capella@linaro.org>
 <1395178858-27343-2-git-send-email-sebastian.capella@linaro.org>
 <20140414105314.GB3530@arm.com>
Message-ID: <CADHgK6vY4tzb3fJRZyTDZ=e7e9sEhDDc5_ja28qna-AhXwaFEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 14 April 2014 03:53, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Mar 18, 2014 at 09:40:57PM +0000, Sebastian Capella wrote:
>> Use of tracers in local_irq_disable is causes abort loops when called
>> with irqs disabled using a temporary stack.  Replace local_irq_disable
>> with raw_local_irq_disable instead to avoid tracers.
>
> Do you have any more information about these aborts? At the time we call
> local_irq_disable, the stack is still intact, so if the issue is simply
> related to having any tracers active at the call_with_stack invocation, we'd
> be better off disabling tracing here altogether.

This is specifically for when soft_restart is called in the
hibernation path with tracers enabled.  At that point, we've already
switched to a temporary stack, and when we call local_irq_disable,
we'll see this:

In the local_irq_disable, it ends up calling trace_hardirqs_off
(CONFIG_TRACE_IRQFLAGS_SUPPORT is enabled), which calls
trace_hardirqs_off_caller which checks lockdep_recursion in the
current task, but we've switched to a temporary stack with the
call_with_stack, and get_current is returning NULL.  This
triggers a data abort, which calls trace_hardirqs_off
again and so on.

We originally had a patch which added a soft restart called
soft_restart_noirq which avoided the irq disable.

You can see the discussion here:
https://patchwork.kernel.org/patch/3677591/

Thanks!

Sebastian
