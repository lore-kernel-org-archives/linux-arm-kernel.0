From: robherring2@gmail.com (Rob Herring)
Date: Fri, 11 Nov 2011 21:55:41 -0600
Subject: [PATCH 0/2] irq/of: Enchance irq_domain support.
In-Reply-To: <1321062616-28317-1-git-send-email-ddaney.cavm@gmail.com>
References: <1321062616-28317-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <4EBDEE3D.1000000@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/11/2011 07:50 PM, ddaney.cavm at gmail.com wrote:
> From: David Daney <david.daney@cavium.com>
> 
> This is the first cut at hooking up my Octeon port to the irq_domain things.
> 
> The Octeon specific patches are part of a larger set, and will need to
> be applied with that set, the first patch is stand-alone.
> 
> The basic problem being solved taken from one of my other e-mails:
> 
>    Unfortunately, although a good idea, kernel/irq/irqdomain.c makes a
>    bunch of assumptions that don't hold for Octeon.  We may be able to
>    improve it so that it flexible enough to suit us.
> 
> 
>    Here are the problems I see:
> 
>    1) It is assumed that there is some sort of linear correspondence
>    between 'hwirq' and 'irq', and that the range of valid values is
>    contiguous.
> 
>    2) It is assumed that the concepts of nr_irq, irq_base and
>    hwirq_base have easy to determine values and you can do iteration
>    over their ranges by adding indexes to the bases.
> 

I still think this is the wrong approach.

Are the gpio interrupts the source of your problem here? That's how I
read it. You have 16 GPIO irqs directly connected into lines on your
primary interrupt controller which has 128 lines. So for a Linux irq
number, you want to translate to a GPIO hwirq number and/or a CIU hwirq
number. Trying to have 2 hwirq mappings for 1 Linux irq number just
won't work. It seems to me you should use a chained handler here because
you need to process the interrupt at both the primary ctrlr and gpio
ctrlr levels.

Rob

> 
> David Daney (2):
>   irq/of/ARM: Enhance irq iteration capability of irq_domain code.
>   MIPS: Octeon: Add irq_create_of_mapping() and GPIO interrupts.
> 
>  arch/arm/common/gic.c                |   32 +++--
>  arch/mips/Kconfig                    |    1 +
>  arch/mips/cavium-octeon/octeon-irq.c |  279 +++++++++++++++++++++++++++++++++-
>  include/linux/irqdomain.h            |   29 +++-
>  kernel/irq/irqdomain.c               |   97 +++++++++---
>  5 files changed, 390 insertions(+), 48 deletions(-)
> 
