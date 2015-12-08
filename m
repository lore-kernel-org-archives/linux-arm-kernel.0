From: james.morse@arm.com (James Morse)
Date: Tue, 08 Dec 2015 10:29:58 +0000
Subject: [PATCH v8 4/4] arm64: switch to irq_stack during softirq
In-Reply-To: <20151204184038.GQ10123@e104818-lin.cambridge.arm.com>
References: <1449226948-14251-1-git-send-email-james.morse@arm.com>
 <1449226948-14251-5-git-send-email-james.morse@arm.com>
 <20151204140119.GL10123@e104818-lin.cambridge.arm.com>
 <5661A5B0.3080504@arm.com>
 <20151204184038.GQ10123@e104818-lin.cambridge.arm.com>
Message-ID: <5666B126.3020002@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/12/15 18:40, Catalin Marinas wrote:
> BTW, at which point does in_irq() return true for an interrupt (and when
> it ceases to do so)?

It uses hardirq_count(), so its true between irq_enter() and irq_exit().

The calls out from handle_IPI() are wrapped by these (except
scheduler_ipi(), which calls them itself).

The other route looks like:
gic_handle_irq() -> __handle_domain_irq()
which wraps generic_handle_irq() in irq_enter()/irq_exit().


I don't know how chained_irq_enter() changes/affects this.


Thanks,

James
