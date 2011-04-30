From: ccross@google.com (Colin Cross)
Date: Fri, 29 Apr 2011 19:38:17 -0700
Subject: [PATCH 6/6] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <1302633340-4795-7-git-send-email-will.deacon@arm.com>
References: <1302633340-4795-1-git-send-email-will.deacon@arm.com>
	<1302633340-4795-7-git-send-email-will.deacon@arm.com>
Message-ID: <BANLkTi=rM=r5UdUHPG5XceX=ppnQ44K+oA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2011 at 11:35 AM, Will Deacon <will.deacon@arm.com> wrote:
> Currently, the gic uses handle_level_irq for handling SPIs (Shared
> Peripheral Interrupts), requiring active interrupts to be masked at
> the distributor level during IRQ handling.
>
> On a virtualised system, only the CPU interfaces are virtualised in
> hardware. Accesses to the distributor must be trapped by the
> hypervisor, adding latency to the critical interrupt path in Linux.
>
> This patch modifies the GIC code to use handle_fasteoi_irq for handling
> interrupts, which only requires us to signal EOI to the CPU interface
> when handling is complete. Cascaded IRQ handling is also updated to use
> the chained IRQ enter/exit functions to honour the flow control of the
> parent chip.
>
> Note that commit 846afbd1 ("GIC: Dont disable INT in ack callback")
> broke cascading interrupts by forgetting to add IRQ masking. This is
> no longer an issue because the unmask call is now unnecessary.
>
> Tested on Versatile Express and Realview EB (1176 w/ cascaded GICs).
>
> Cc: Abhijeet Dharmapurikar <adharmap@codeaurora.org>
> Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Will Deacon <will.deacon@arm.com>

After further testing, I'm having a problem with this patch, although
I think its more of a core issue than the fault of this patch.  One of
my interrupts is getting stuck with the PENDING flag set, and
preventing suspend.  The flow that triggers this is:

level triggered irq
 handle_fasteoi_irq
  handle_irq_event
   isr
    disable_irq_nosync
    schedule_work (because it takes a sleeping i2c transaction to
deassert the irq pin)
   irq_eoi
same irq
 handle_fasteoi_irq
  mark irq pending
  mask_irq
work function
 causes level triggered irq to go low
 enable_irq
  unmask_irq
  check_irq_resend (returns immediately)

At this point, the irq is unmasked, but not being asserted, and marked
as pending.  check_irq_resend doesn't clear the pending flag for level
triggered interrupts, so the pending flag will stay set until the next
time the interrupt occurs.

Should handle_fasteoi_irq mask the interrupt before eoi if it was
disabled by the interrupt handler?  Otherwise, every level triggered
interrupt that is not deasserted by the interrupt handler will
interrupt the cpu twice.  There is still the case where a driver
disables the irq, the interrupt goes high, then goes low again before
enable_irq is called.

This patch fixes the double interrupt problem, but not the vanishing
interrupt problem:

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 4af1e2b..424bdfc 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -398,6 +398,9 @@ handle_fasteoi_irq(unsigned int irq, struct irq_desc *desc)
        preflow_handler(desc);
        handle_irq_event(desc);

+       if (irqd_irq_disabled(&desc->irq_data) &&
+           !irqd_irq_masked(&desc->irq_data))
+               mask_irq(desc);
 out_eoi:
        desc->irq_data.chip->irq_eoi(&desc->irq_data);
 out_unlock:
