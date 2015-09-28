From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 29 Sep 2015 00:46:04 +0200
Subject: [PATCH v3 0/7] Early ACPI probing infrastructure
In-Reply-To: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
References: <1443451758-22717-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <3881043.sWK6Pcr0HP@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, September 28, 2015 03:49:11 PM Marc Zyngier wrote:
> IRQ controllers and timers are the two types of device the kernel
> requires before being able to use the device driver model.
> 
> The Device Tree infrastructure makes it very easy to make these
> discoverable by the rest of the kernel. For example, each interrupt
> controller driver has at least one entry like this:
> 
> IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);
> 
> which says: if you find a node having "arm,gic-400" as a compatible
> string in the device tree, then call gic_of_init with this node as a
> parameter. The probing itself is done by the OF layer when the
> architecture code calls of_irq_init() (usually via irqchip_init).
> 
> This has a number of benefits:
> 
> - The irqchip code is self-contained. No architecture specific entry
> point, no exposed symbols. Just a standard interface.
> 
> - The low-level architecture code doesn't have to know about which
> interrupt controller is present. It just calls into the firmware
> interface (of_irq_init) which is going to sort things out.
> 
> Similar infrastructure is provided for the timers/clock sources. Note
> that this is not a replacement for the device model, but acts as a
> probing infrastructure for things that are required too early for the
> device infrastructure to be available.
> 
> What I'm aiming for is to introduce the same level of abstraction for
> ACPI, or at least for the few bits that are required before a full blown
> ACPI/device model can be used. For this, I introduce something vaguely
> similar:
> 
> IRQCHIP_ACPI_DECLARE(gic_v2, ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR,
> 		     gic_validate_dist, ACPI_MADT_GIC_VERSION_V2,
> 		     gic_v2_acpi_init);
> 
> which says: if you find a ACPI_MADT_TYPE_GENERIC_DISTRIBUTOR entry in
> MADT (implied by the macro), and that entry is of type
> ACPI_MADT_GIC_VERSION_V2 (as checked by gic_validate_dist), then call
> gic_v2_acpi_init with the entry as a parameter. A bit more convoluted,
> but still without any special entry point.
> 
> The various interrupt controller drivers can then implement the above,
> and the arch code can use a firmware-specific call to get the probing
> done, still oblivious to what interrupt controller is being used. It
> also makes the adaptation of a DT driver to ACPI easier.
> 
> It turns out that providing such a probing infrastructure is rather
> easy, and provides a much deserved cleanup in both the arch code, the
> GIC driver, and the architected timer driver. An additional (and very
> much optional) patch renames files and symbols to make it obvious that
> the infrastructure is not just for DT anymore.
> 
> I'm sure there is some more code to be deleted, and one can only
> wonder why this wasn't done before the arm64 code was initially merged
> (the diffstat says it all...).
> 
> Patches are against Rafael's bleeding-edge branch, and a branch is
> available at
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git acpi/device-probing-v3
> 
> * From v2:
>   - Addressed Rafael's comments (title for patch #1, macro/field names)
>   - New config symbols for clocksources
>   - Additional and optional last patch to get rid of the apparent
>     dependency between the probing infrastructure and DT.
> 
> * From the initial version:
>   - Make the infrastructure more DT like by providing an
>     acpi_probe_entry array per "device type" (one for irqchips, one
>     for clocksources). This means that entries can depend on any ACPI
>     static table.
>   - Use some cpp magic to reduce the amount of code added to an
>     absolute minimum.
>   - Rebased on v4.3-rc1
> 
> Marc Zyngier (7):
>   acpi: Add early device probing infrastructure
>   irqchip/acpi: Add probing infrastructure for ACPI-based irqchips
>   irqchip/gic: Convert the GIC driver to ACPI probing
>   clocksource/acpi: Add probing infrastructure for ACPI-based
>     clocksources
>   clocksource: Add new CLKSRC_{PROBE,ACPI} config symbols
>   clocksource/arm_arch_timer: Convert to ACPI probing
>   clocksource: cosmetic: Drop OF 'dependency' from symbols

If you want me to apply this series, ACKs are needed for patches [3-7/7].

They are fine by me, but I'd also like to hear from the other maintainers.

Thanks,
Rafael
