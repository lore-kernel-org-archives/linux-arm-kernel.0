From: james.morse@arm.com (James Morse)
Date: Tue, 08 Dec 2015 10:11:58 +0000
Subject: [PATCH v7 3/3] arm64: Add do_softirq_own_stack() and enable
 irq_stacks
In-Reply-To: <20151204131242.GG10123@e104818-lin.cambridge.arm.com>
References: <1447698128-8490-1-git-send-email-james.morse@arm.com>
 <1447698128-8490-4-git-send-email-james.morse@arm.com>
 <8F6484A9-18B9-4A81-B58D-528D81BC196D@gmail.com>
 <20151127114715.GA25499@e104818-lin.cambridge.arm.com>
 <56617243.5050602@arm.com>
 <20151204131242.GG10123@e104818-lin.cambridge.arm.com>
Message-ID: <5666ACEE.9070303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/15 13:12, Catalin Marinas wrote:
> One thing I'm not clear about is whether __do_softirq can be preempted
> when executed in process context, it could mess up our stack
> assumptions.

Previously I thought not, because in __do_softirq():
> __local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);

Increases the softirq part of preempt_count, before:
> local_irq_enable()

so preempt_count is always non-zero when we have interrupts (re)enabled
on the irq_stack...

... but its a little murkier than I first thought,
__cond_resched_softirq() looks like it will re-schedule a task if it is
processing softirqs, while softirqs are disabled.

net/core/sock.c:__release_sock is the only caller, I haven't yet worked
out if this can happen while on the irq stack.


James
