From: khilman@ti.com (Kevin Hilman)
Date: Fri, 29 Jun 2012 07:55:02 -0500
Subject: [PATCH 1/1] ARM: OMAP3: PM: don't explicitly enable the IO-chain
 interrupt
In-Reply-To: <1340933123-30401-1-git-send-email-javier@dowhile0.org> (Javier
 Martinez Canillas's message of "Fri, 29 Jun 2012 03:25:23 +0200")
References: <1340933123-30401-1-git-send-email-javier@dowhile0.org>
Message-ID: <87obo2mg61.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Paul

Javier Martinez Canillas <javier@dowhile0.org> writes:

> commit 99b59df0 ARM: OMAP3: PM: fix shared PRCM interrupt leave disabled at boot
>
> set the IRQ_NOAUTOEN flag to the PCRM IO-chain irq to avoid this
> interrupt until the PM core code is ready to handle the interrupts.
>
> It seems that this is not needed anymore after the OMAP PRCM I/O chain
> code re-implementation introduced on merge commit:
>
> 9a17d88 Merge tag 'omap-devel-c-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/
>
> The IRQ_NOAUTOEN flags is not set for the PRCM I/O irq anymore on the
> new implementation. This has the effect that a request_irq() for the
> PRCM I/O chain irq will auto-enable the requested IRQ and a later call
> to enable_irq() will lead to the following warning:

I noticed that warning too, but I don't think $SUBJECT patch is the
right fix.

We still need the IRQ_NOAUTOEN so that cases where PM is not enabled,
the IO chain interrupts are not enabled.

Looking closer, it looks like the merge of omap-devel-c-for-3.6 removed
the IRQ_NOAUTOEN in the merge resolution, which wasn't right.

I'll cook up a fix for this.

Kevin
