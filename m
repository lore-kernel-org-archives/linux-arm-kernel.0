From: rabin@rab.in (Rabin Vincent)
Date: Wed, 16 Feb 2011 16:59:34 +0530
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <1297697188-5206-1-git-send-email-will.deacon@arm.com>
References: <1297697188-5206-1-git-send-email-will.deacon@arm.com>
Message-ID: <AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 14, 2011 at 20:56, Will Deacon <will.deacon@arm.com> wrote:
> Currently, the gic uses handle_level_irq for handling SPIs (Shared
> Peripheral Interrupts), requiring active interrupts to be masked at
> the distributor level during IRQ handling.
>
> On a virtualised system, only the CPU interfaces are virtualised in
> hardware. Accesses to the distributor must be trapped by the hypervisor,
> adding latency to the critical interrupt path in Linux.
>
> This patch modifies the GIC code to use handle_fasteoi_irq for handling
> interrupts, which only requires us to signal EOI to the CPU interface
> when handling is complete. Cascaded IRQ handling is also updated so that
> EOI is signalled after handling.

Several of the platforms using the GIC also have GPIO code which uses
set_irq_chained_handler().  I think you will have to modify all of
these to call irq_eoi() appropriately and not the other functions.
Some of these will also likely be used with other interrupt handlers
than the GIC, though.
