From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 17 Jul 2015 07:45:49 +0100
Subject: [PATCH 4/5] irqchip: gic-v3: Add gic_get_irq_domain() to get
 the irqdomain of the GIC.
In-Reply-To: <55A7EAAC.8000800@arm.com>
References: <1436979285-8177-1-git-send-email-ddaney.cavm@gmail.com>
 <1436979285-8177-5-git-send-email-ddaney.cavm@gmail.com>
 <55A6947F.8070903@arm.com> <55A6AD1F.902@caviumnetworks.com>
 <55A75F8B.3080009@arm.com> <55A7E0C2.8020704@caviumnetworks.com>
 <55A7E52D.9080201@arm.com> <55A7E663.9030000@caviumnetworks.com>
 <55A7EAAC.8000800@arm.com>
Message-ID: <20150717074549.7a502e09@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 16 Jul 2015 18:32:28 +0100
Marc Zyngier <marc.zyngier@arm.com> wrote:

> On 16/07/15 18:14, David Daney wrote:
> > On 07/16/2015 10:09 AM, Marc Zyngier wrote:
> >> On 16/07/15 17:50, David Daney wrote:
> > [...]
> >>>> Patch 5 has established that you're using "virtual wire" SPIs, so we
> >>>> need to work on exposing that with the normal kernel abstraction, and
> >>>> not by messing with the internals of the GIC.
> >>>>
> >>>
> >>> Agreed.
> >>>
> >>> The MSI system has pci_enable_msix()/pci_disable_msix().
> >>>
> >>> I would propose something like:
> >>>
> >>> struct gic_spi_entry {
> >>> 	int spi   /* SPI number */
> >>> 	int irq;  /* kernel irq number mapped to the spi*/
> >>> 	u32 msg;  /* message to be written */
> >>> 	u64 assert_addr;
> >>> 	u64 deassert_addr;
> >>> };
> >>>
> >>> /* Fill in the SPI processing information */
> >>> int gic_map_spi(int spi, struct gic_spi_entry *data);
> >>
> >> Neither.
> >>
> >> The way to do it is to make this a *separate* IRQ domain stacked onto
> >> the SPI domain. No funky hook on the side. If it doesn't go through the
> >> normal kernel API, it doesn't reach the GIC.
> > 
> > Yes, the irqdomain does handle mapping SPI -> irq, and the message can 
> > be derived from the SPI.  However, the irqdomain infrastructure cannot 
> > supply values for either assert_addr or deassert_addr.
> 
> This is why I suggested earlier (in my reply to patch 5) that you have a
> look at the series I posted a couple of days ago to implement non-PCI
> MSI support. This would allow you to compose the domains as such:
> 
> platform-MSI -> message-SPI -> GIC
> 
> You'd end up with a msi_msg containing the GICD_SETSPI_NSR doorbell, and
> the SPI as a payload.
> 
> > Those are needed in order to use SPI.  How would you suggest that they 
> > be obtained?
> 
> Two possibilities: either you derive GICD_CLRSPI_NSR by adding 8 to the
> doorbell you got from the msi_msg structure (ugly, but limited to your
> own code), or you extend msi_msg to cater for this case.

A simpler alternative to the above would be to move all this to
firmware, and only expose a *wired* SPI to the kernel. This would have
the advantage to use the existing infrastructure for both DT and ACPI.

As a side note, that was the intended use of these registers - to
provide a "virtual wire" interface that remains mostly invisible to
software.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
