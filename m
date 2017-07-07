From: opendmb@gmail.com (Doug Berger)
Date: Fri, 7 Jul 2017 12:34:03 -0700
Subject: [PATCH 0/6] Add support for BCM7271 style interrupt controller
In-Reply-To: <20170707192016.13001-1-opendmb@gmail.com>
References: <20170707192016.13001-1-opendmb@gmail.com>
Message-ID: <a801afb1-2f54-2137-6fed-d8f83fe3f8ea@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, messed up the CC list.

On 07/07/2017 12:20 PM, Doug Berger wrote:
> This patch set extends the functionality of the irq-brcmstb-l2 interrupt
> controller driver to cover a hardware variant first introduced in the
> BCM7271 SoC.  The main difference between this variant and the block
> found in earlier brcmstb SoCs is that this variant only supports level
> sensitive interrupts and therefore does not latch the interrupt state
> based on edges.  Since there is no longer a need to ack interrupts with
> a register write to clear the latch the register map has been changed.
> 
> Therefore the change to add support for the new hardware block is to
> abstract the register accesses to accommodate different maps and to
> identify the block with a new device-tree compatible string.
> 
> I also took the opportunity to make some small efficiency enhancements
> to the driver.  One of these was to make use of the slightly more
> efficient irq_mask_ack method.  However, I discovered that the defined
> irq_gc_mask_disable_reg_and_ack() generic irq function was insufficient
> for my needs.  The first three commits of this set are intended to be a
> correction and extension of the existing generic irq implementation to
> provide a set of functions that can be used by interrupt controller
> drivers for their irq_mask_ack method.
> 
> I believe these first three commits should be added to the irq/core
> repository and the remaining commits should be added to the Broadcom
> github repository but have included the complete set here for improved
> context.  This entire set is therefore based on the irq/core master
> branch.  Please let me know if you would like a different packaging.
> 
> If the changes to genirq are not acceptable I can implement the
> irq_mask_ask method locally in the irq-brcmstb-l2 driver and submit
> that on its own.
> 
> Doug Berger (5):
>   genirq: generic chip: add generic irq_mask_ack functions
>   genirq: generic chip: remove irq_gc_mask_disable_reg_and_ack()
>   irqchip: brcmstb-l2: Remove some processing from the handler
>   irqchip: brcmstb-l2: Abstract register accesses
>   irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller
> 
> Florian Fainelli (1):
>   irqchip/tango: Use irq_gc_mask_disable_and_ack_set
> 
>  .../bindings/interrupt-controller/brcm,l2-intc.txt |   3 +-
>  drivers/irqchip/irq-brcmstb-l2.c                   | 145 ++++++++++++++-------
>  drivers/irqchip/irq-tango.c                        |   2 +-
>  include/linux/irq.h                                |   7 +-
>  kernel/irq/generic-chip.c                          | 110 +++++++++++++++-
>  5 files changed, 214 insertions(+), 53 deletions(-)
> 
