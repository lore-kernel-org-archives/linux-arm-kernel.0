From: tglx@linutronix.de (Thomas Gleixner)
Date: Sun, 11 Oct 2015 23:01:17 +0200 (CEST)
Subject: [PATCH 00/16] Divorcing irqdomain and device_node
In-Reply-To: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
References: <1444152989-31726-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <alpine.DEB.2.11.1510112255330.6097@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 6 Oct 2015, Marc Zyngier wrote:
> [This patch series used to be called "Making the generic ACPI GSI
> layer irqdomain aware", but as I've radically changed my approach to
> this problem, I've decided to reset the counters...]
> 
> The irqdomain code is not entierely ACPI friendly, as it has some
> built-in knowledge of the device-tree. Nothing too harmful, but enough
> to scare the ARM ACPI developpers which end up with their own version
> of the square wheel. And some of the ramifications actually run deeper
> than initially expected.
> 
> This series adapts the irqdomain code to use 'struct fwnode_handle'
> instead of 'struct device_node' as the identifier for a domain
> (compatibility interfaces are of course added). It also introduces a
> generic IRQ specifier that firmware interfaces (DT or ACPI) can
> directly use to configure interrupts, and allow the ACPI GSI code to
> be plugged into this.
> 
> As examples, we convert the ARM GIC ACPI support to use irqdomains as
> originally intended, and rework the MSI code to also move away from
> using device nodes when using irqdomains.
> 
> Overall, this gives us a way to use irqdomains on both DT and ACPI
> enabled platforms, having very little changes made to the actual
> drivers (other than the probing infrastructure). Because we keep the
> flow of information between the various layers identical between ACPI
> and DT, we immediately benefit from the existing infrastructure.
> 
> This has been test-booted on Juno, is based on 4.3-rc4, and available at:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git irq/irq-domain-fwnode-v1
> 
> Marc Zyngier (16):
>   irqdomain: Use an accessor for the of_node field
>   irqdomain: Convert irqdomain->of_node to fwnode
>   irqdomain: Allow irq domain lookup by fwnode
>   irqdomain: Introduce a firmware-specific IRQ specifier structure
>   irqchip: Convert all alloc/xlate users from of_node to fwnode
>   irqdomain: Introduce irq_create_fwspec_mapping
>   irqdomain: Introduce irq_domain_create_{linear,tree}
>   irqdomain: Add a fwnode_handle allocator
>   acpi/gsi: Always perform an irq domain lookup
>   acpi/gsi: Add acpi_set_irq_model to initialize the GSI layer
>   irqchip/gic: Get rid of gic_init_bases()
>   irqchip/gic: Switch ACPI support to stacked domains
>   irqchip/gic: Kill the xlate method
>   acpi/gsi: Cleanup acpi_register_gsi
>   irqdomain: Introduce irq_domain_create_hierarchy
>   irqdomain/msi: Use fwnode instead of of_node

I really like this one way better than the previous attempts and I
couldn't find any real issue when going through them with a fine comb.

I'd like to get that into 4.4, so I have to ask for the opinion of
ACPI folks. Having an ack on those patches would be nice.

Thanks,

	tglx
