From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 21 Mar 2017 09:43:24 +0000
Subject: [PATCH] irqchip/gic-v3: Support v2m frame backwards compatibility
 mode
In-Reply-To: <20170320223614.1351-1-sboyd@codeaurora.org>
References: <20170320223614.1351-1-sboyd@codeaurora.org>
Message-ID: <bac1e827-3860-d92c-7bb4-eaf9840c608f@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/17 22:36, Stephen Boyd wrote:
> Some GIC configurations don't have an ITS or v2m frame, but they
> want to support MSIs through the distributor's "v2m backwards
> compatible" mode. This mode allows software written for the v2m
> to treat the distributor as the only frame and support a limited
> number of MSIs through a direct write to the same register offset
> (0x40) as what exists in v2m.
> 
> Support this mode of operation by detecting if a gicv3 device
> node has the "msi-controller" property, and then probe the v2m
> frame code on top of the distributor base. Rely on existing v2m
> DT properties to tell us about the number of SPIs and where they
> start from because the GICD_TYPER register doesn't tell us this
> information.

Hi Stephen,

The whole idea behind this GICD_SETSPI_NSR is to offer a way to signal
SPIs using memory transaction, even allowing level interrupts (in
combinaison with the GICD_CLRSPI_NSR at offset 0x48). This is *not* a
GICv2m at all - only the offset is the same.

The reasoning is that firmware would program the various devices with
the GICD_{CLR,SET}SPI_NSR addresses and the payload, and simply describe
this as an SPI in the device tree. Another reason for doing so is that
while we can always twist the DT to express anything, this cannot be
described in ACPI at all.

Also, as you noticed, there is no provision in the architecture to
describe the range of message-based SPIs, because any SPI can be
signalled through that mechanism. It makes it impossible to distinguish
SPIs that are statically allocated (because it is a real wire) from
those that can be dynamically allocated (because it is just a number).

You end-up having to describe the range of SPIs that can be generated
through messages at least on a per SoC basis, and maybe on a per board
basis. Not to mention that you're still only describing half of the
capability of the HW (what about level interrupts?).

If we really want to support this kind of thing, I'd like to see level
interrupts supported as a first class citizen in our generic MSI
infrastructure, and then the GICv3 message-based SPIs as an client of
that infrastructure.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
