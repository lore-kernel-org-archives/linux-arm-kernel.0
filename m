From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 25 Mar 2015 15:41:12 +0000
Subject: [PATCH 1/5] ACPI: move arm64 GSI IRQ model to generic GSI IRQ
 layer
In-Reply-To: <5512B62C.7030500@arm.com>
References: <1427219940-27201-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1427219940-27201-2-git-send-email-lorenzo.pieralisi@arm.com>
 <5512B62C.7030500@arm.com>
Message-ID: <20150325154112.GC21478@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 01:20:44PM +0000, Marc Zyngier wrote:
> On 24/03/15 17:58, Lorenzo Pieralisi wrote:
> > The code deployed to implement GSI linux IRQ numbers mapping on arm64 turns
> > out to be generic enough so that it can be moved to ACPI core code along
> > with its respective config option ACPI_GENERIC_GSI selectable on
> > architectures that can reuse the same code.
> > 
> > Current ACPI IRQ mapping code is not integrated in the kernel IRQ domain
> > infrastructure, in particular there is no way to look-up the
> > IRQ domain associated with a particular interrupt controller, so this
> > first version of GSI generic code carries out the GSI<->IRQ mapping relying
> > on the IRQ default domain which is supposed to be always set on a
> > specific architecture in case the domain structure passed to
> > irq_create/find_mapping() functions is missing.
> > 
> > This patch moves the arm64 acpi functions that implement the gsi mappings:
> > 
> > acpi_gsi_to_irq()
> > acpi_register_gsi()
> > acpi_unregister_gsi()
> > 
> > to ACPI core code. Since the generic GSI<->domain mapping is based on IRQ
> > domains, it can be extended as soon as a way to map an interrupt
> > controller to an IRQ domain is implemented for ACPI in the IRQ domain
> > layer.
> > 
> > x86 and ia64 code for GSI mappings cannot rely on the generic GSI
> > layer at present for legacy reasons, so they do not select the
> > ACPI_GENERIC_GSI config options and keep relying on their arch
> > specific GSI mapping layer.
> 
> This looks like the right thing to do. I definitely like the sanity
> checking that has been added here.
> 
> FWIW: Acked-by: Marc Zyngier <marc.zyngier@arm.com>

Thank you, I think it makes it easier to add stacked IRQ domains support
later (ie sooner) and by code inspection I suspect x86 can make some use
of this code too with a bit of refactoring.

Lorenzo
