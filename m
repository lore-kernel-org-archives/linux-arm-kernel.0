From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 30 Nov 2010 18:07:18 +0000
Subject: [PATCH v2] [ARM] gic: Unmask private interrupts on all cores
	during IRQ enable
In-Reply-To: <1288820762-16077-1-git-send-email-scaudle@codeaurora.org>
References: <1288820762-16077-1-git-send-email-scaudle@codeaurora.org>
Message-ID: <20101130180718.GB8521@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 03, 2010 at 05:46:02PM -0400, Stephen Caudle wrote:
> Some multi-core ARM chips designate a unique IRQ number for each core for
> private peripheral interrupts (PPIs). Others designate a common IRQ number
> for all cores. In the latter case, requesting/freeing private peripheral
> interrupts currently unmasks/masks the interrupt for only the
> executing core, respectively.
> 
> With this change, request_irq will unmask a PPI on all cores so a separate
> call to enable_irq on the other cores is not required. Likewise, free_irq
> will mask a PPI on the other cores. Also, shutdown is implemented instead
> of disable to allow for lazy IRQ disabling.

Sorry, missed this.

If it's a private peripheral, it can only be accessed from its associated
CPU.  What that means is you don't want to enable the interrupt on other
CPUs as the peripheral may not be present or initialized on that CPU.

So I'm nervous about this change - architecturally it feels like the
wrong thing to do to take the PPI interrupts through the generic IRQ
infrastructure.
