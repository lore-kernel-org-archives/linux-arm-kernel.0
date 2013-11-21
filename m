From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Nov 2013 13:16:03 +0100
Subject: [PATCH v4 2/4] Documentation:: Add documentation for APM X-Gene
 SoC SATA host controller DTS binding
In-Reply-To: <1385014298-15700-3-git-send-email-lho@apm.com>
References: <1385014298-15700-1-git-send-email-lho@apm.com>
 <1385014298-15700-2-git-send-email-lho@apm.com>
 <1385014298-15700-3-git-send-email-lho@apm.com>
Message-ID: <201311211316.03647.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 November 2013, Loc Ho wrote:
> +SATA host controller nodes are defined to describe on-chip Serial ATA
> +controllers. Each SATA controller (pair of ports) have its own node.
> +
> +Required properties:
> +- compatible		: Shall be "apm,xgene-ahci"
> +- reg			: First memory resource shall be the AHCI memory
> +			  resource.
> +			  Second memory resource shall be the host controller
> +			  memory resource.
> +- interrupt-parent	: Interrupt controller
> +- interrupts		: Interrupt mapping for SATA host controller IRQ
> +- clocks		: Reference to the clock entry
> +- phys			: PHY reference
> +- phy-names		: Name of the PHY reference. The name should be
> +			  formed by "sataphy" plus lower case hex for the
> +			  lower 32-bit PHY CSR address (2nd memory resource)

I've tried to explain this before, but apparently you missed the point:

Any "*-names" property is supposed to be the identifier inside the device you
are describing, *not* an identifier for what it points to, as that already
has a name. The idea is that the driver can ask for phy (or clock, irq,
memory, etc) "foo" here, with foo identifying the functionality in the
device. If you only have one phy, you probably don't want to name it at
all. If you imagine a device that was connected to two different phys
depending on the mode it's used in (e.g. SATA-II vs SATA-6G), you would
list this as

 - phy-names		: one name per references in the "phys" property.
			  valid names are "sata-ii" and "sata-6g".

If the generic phy subsystem requires you to name this, I'd suggest either
changing the phy subsystem to make the name optional, or to just call it
"serdes", as that is the kind of phy you are connected to.

Does this make more sense to you now?

	Arnd
