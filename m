From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 9 Sep 2015 09:07:22 +0100
Subject: question about DOMAIN_BUS_ANY
In-Reply-To: <CY1PR0301MB07485D964A46A10E1F80154D87530@CY1PR0301MB0748.namprd03.prod.outlook.com>
References: <CY1PR0301MB07485D964A46A10E1F80154D87530@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <20150909090722.0dd9fa7e@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Sep 2015 22:41:37 +0000
Stuart Yoder <stuart.yoder@freescale.com> wrote:

Hi Stuart,

> Marc,
> 
> Have a question about DOMAIN_BUS_ANY.  Based on your comment in 
> include/linux/irqdomain.h:
> 
>   /*
>    * Should several domains have the same device node, but serve
>    * different purposes (for example one domain is for PCI/MSI, and the
>    * other for wired IRQs), they can be distinguished using a
>    * bus-specific token. Most domains are expected to only carry
>    * DOMAIN_BUS_ANY.
>    */
> 
> ...if there are 2 domains that are based on the same GIC ITS node,
> for example PCI and the new Freescale "fsl-mc" bus, we should
> be extending irq_domain_bus_token with a new token, correct?

If you have a new bus type that is neither PCI nor PLATFORM, then you
will indeed need a new token to disambiguate the domain.

> The reason "most" domains are expected to have BUS_ANY is because
> most domains have 1 associated device node and there is no ambiguity,
> right?

The opposite, actually. Most devices (MSI controllers) only implement a
single domain, while the ITS already implements two (PCI and
platform) - well technically three, as we also have DOMAIN_NEXUS to
implement the global identifier allocator.

> Currently the fsl-mc bus driver is in drivers/staging.  Is that
> an issue with respect to extending the enum?  (not 100% sure
> what the rules are regarding drivers in staging and other
> dependencies like this enum which are outside of staging).

If there is a convincing effort to move this code out of staging, then
I can't see why we couldn't extend the enum.

> Another related question... we are implementing a fsl-mc
> bus specific support in a irq-gic-v3-its-fsl-mc-msi.c file,
> similar to what you did for PCI and platform buses.  Do you
> want to see that file in drivers/staging for now, or should
> we put it under drivers/irqchip?

I think it can stay with the rest of the code until it is ready to be
merged back to where it belongs. You will also need to implement a
generic fsl-mc-msi domain that acts as the high level interface (you
can probably reuse most of what has already been done on the PCI and
PLATFORM fronts).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
