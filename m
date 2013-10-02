From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 01 Oct 2013 20:23:25 -0600
Subject: [PATCH v3] irq: bmc2835: Re-implement the hardware IRQ handler.
In-Reply-To: <1380275858-1289-1-git-send-email-slapdau@yahoo.com.au>
References: <1379755112-19446-1-git-send-email-slapdau@yahoo.com.au>
 <1380275858-1289-1-git-send-email-slapdau@yahoo.com.au>
Message-ID: <524B839D.7060908@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/27/2013 03:57 AM, Craig McGeachie wrote:
> Force the re-reading of the pending status registers before dispatching
> the next interrupt request.  There is no guarantee that the values will
> remain valid.

That last sentence isn't really the point. The point isn't that the
value previously read may become somehow invalid, but more that some
extra bits may become set. Perhaps this is quibling over words, but I
don't see that as the value becoming invalid, just out-of-date. Perhaps
rewrite that sentence as:

It is possible while processing one interrupt, new interrupts become
pending, and the new interrupts are higher priority and should be
handled first.

> Actions taken by interrupt handlers could handle and
> acknowledge multiple interrupts.  For example, the DMA controller has
> it's own view of the interrupt status of all channels rather than just
> the one that the interrupt was dispatched for.  The cost of re-reading
> is small.  The cost of unnecessary dispatches is large.

DMA is only one interrupt at the top-level, I believe; the multiple
interrupt sources are sub-interrupts within the DMA controller. Naively,
I'd expect it to be very unlikely that one top-level IRQ handler
directly caused an unrelated top-level IRQ status to clear, although I'm
sure someone can come up with some exceptions:-)

> Reorder the internal numbering of interrupt banks so that hardware IRQ
> numbers range from 0 to 71, and match the natural numbering implied by
> the FIQ source register.  This is in anticipation of being to implement
> a viable mechanism for registering one of the available interrupts as a
> fast interrupt.  Preferably based on device tree configuration.

DT shouldn't specify whether an interrupt should be handled as
FIQ-vs-non-FIQ, since that's a SW configuration issue, rather than a
pure HW description.

> Enable device tree interrupt specifications to identify interrupts with
> shortcut bits in the base register by either the shortcut bit, or the
> canonical GPU register bit.   E.g. UART can be either <0, 19> or <2,
> 25>.

Hmmm. Is there a benefit to allowing that? One defined way feels better
than multiple ways of specifying the same thing.

> diff --git a/drivers/irqchip/irq-bcm2835.c b/drivers/irqchip/irq-bcm2835.c

I think I'll hold off reviewing the patch itself until you've had a
chance to look at the other responses I just sent, or I'll just be
saying the same things.
