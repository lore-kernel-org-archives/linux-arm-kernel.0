From: rabin@rab.in (Rabin Vincent)
Date: Sat, 24 Jul 2010 16:00:27 +0530
Subject: [PATCH] GIC: Dont disable INT in ack callback
In-Reply-To: <1279839450-6477-1-git-send-email-johlstei@codeaurora.org>
References: <1279839450-6477-1-git-send-email-johlstei@codeaurora.org>
Message-ID: <20100724103027.GA3336@debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 03:57:30PM -0700, Jeff Ohlstein wrote:
> Unless gic_ack_irq is called from __do_IRQ, interrupt should not
> be disabled in the ack function. Disabling the interrupt causes
> handle_edge_irq to never enable it again.

The GIC doesn't use handle_edge_irq.

Anyway, this change is correct since gic_ack_irq is currently doing a
maskack, when it should be just an ack.  However, since
GENERIC_HARDIRQS_NO__DO_IRQ is always true on ARM, I don't see a need to
add the ifndef.
