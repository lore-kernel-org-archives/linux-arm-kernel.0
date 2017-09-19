From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 19 Sep 2017 11:05:35 -0700
Subject: [PATCH v4 0/3] Add support for BCM7271 style interrupt controller
In-Reply-To: <20170919010000.32072-1-opendmb@gmail.com>
References: <20170919010000.32072-1-opendmb@gmail.com>
Message-ID: <db82458e-5656-1eb2-b4b8-051cc12e7095@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/18/2017 05:59 PM, Doug Berger wrote:
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
> for my needs.  Previous submissions offered candidate solutions to
> address my needs within the generic irqchip library, but since those
> submissions appear to have stalled I am submitting this version that
> includes the function in the driver to prevent controversy and allow
> the new functionality to be included. 

For this entire series:

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Doug.

> 
> Changes in v4:
> 
> - The first three commits were removed from the patch set to remove any
>   dependencies on changing the generic irqchip or irqchip-tango imple-
>   mentations. If there is a will to make those changes in the future
>   they can be applied at that time, but they needn't hold up the accept-
>   ance of this patch set.
>   
> Changes in v3:
> 
> - I did not submit a v3 patch set, but Marc Gonzalez included a PATCH v3
>   in a response to the v2 patch so I am skipping ahead to v4 to avoid
>   confusion.
>   
> Changes in v2:
> 
> - removed unused permutations of irq_mask_ack methods
> - added Reviewed-by and Acked-by responses from first submission
> 
> Doug Berger (3):
>   irqchip: brcmstb-l2: Remove some processing from the handler
>   irqchip: brcmstb-l2: Abstract register accesses
>   irqchip: brcmstb-l2: Add support for the BCM7271 L2 controller
> 
>  .../bindings/interrupt-controller/brcm,l2-intc.txt |   3 +-
>  drivers/irqchip/irq-brcmstb-l2.c                   | 171 +++++++++++++++------
>  2 files changed, 126 insertions(+), 48 deletions(-)
> 


-- 
Florian
