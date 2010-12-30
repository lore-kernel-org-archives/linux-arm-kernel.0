From: rabin@rab.in (Rabin Vincent)
Date: Thu, 30 Dec 2010 11:57:23 +0530
Subject: [PATCH] GIC: Assign correct flow handler type in set_type callback
In-Reply-To: <1293686960-12581-1-git-send-email-adharmap@codeaurora.org>
References: <1293686960-12581-1-git-send-email-adharmap@codeaurora.org>
Message-ID: <AANLkTimA8ZP4WL8u0Uvtt-0MWXPkGfjwQ7437pL-h0D-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 30, 2010 at 10:59 AM, Abhijeet Dharmapurikar
<adharmap@codeaurora.org> wrote:
> There are some interrupts that are true edge triggered in nature. If not
> marked IRQ_PENDING, when disabled, they will be lost.
>
> Use the set_type callback to assign the correct flow type handler for
> shared peripheral interrupts.
>
> Signed-off-by: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> ---
> This came to light when a edge triggered interrupt was supposed to wakeup the
> sytem. The flow handler was set to the default handle_level_irq. On the resume
> path the flow handler was invoked right after the I bit was cleared but before
> each individual interrupts were enabled. This made the handle_level_irq ignore

Why does the flow handler hit when the interrupt is disabled?  Have you set
IRQF_NOSUSPEND on this interrupt?

> the interrupt (mask_ack it) and it was lost. handle_edge_irq does the right
> thing by marking the interrupt as IRQ_PENDING and when the resume code gets to
> enabling each interrupt this interrupt is resent again.
