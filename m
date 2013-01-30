From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Jan 2013 15:46:02 +0000
Subject: [PATCH v2 19/27] pci: PCIe driver for Marvell Armada 370/XP
 systems
In-Reply-To: <20130130163659.75360dba@skate>
References: <1359399397-29729-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1359399397-29729-20-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130130113245.GH23505@n2100.arm.linux.org.uk>
 <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <20130130150856.GJ23505@n2100.arm.linux.org.uk>
 <20130130151934.GK23505@n2100.arm.linux.org.uk>
 <20130130163659.75360dba@skate>
Message-ID: <20130130154602.GL23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 04:36:59PM +0100, Thomas Petazzoni wrote:
> Dear Russell King - ARM Linux,
> 
> On Wed, 30 Jan 2013 15:19:34 +0000, Russell King - ARM Linux wrote:
> > diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
> > index db9fedb..bba0cf3 100644
> > --- a/arch/arm/include/asm/mach/pci.h
> > +++ b/arch/arm/include/asm/mach/pci.h
> > @@ -29,6 +29,7 @@ struct hw_pci {
> >  	void		(*postinit)(void);
> >  	u8		(*swizzle)(struct pci_dev *dev, u8 *pin);
> >  	int		(*map_irq)(const struct pci_dev *dev, u8 slot, u8 pin);
> > +	resource_size_t	(*window_align)(struct pci_bus *, unsigned long);
> >  };
> 
> Didn't you say just yesterday that you would prefer a numerical value
> rather than a hook that could do random things? :-)

Hrh, right. :)

And it also helps if I modify the right struct too!  Try this instead.
Overwrite sys->win_align_mem / sys->win_align_io in the setup function
as required.

 arch/arm/include/asm/mach/pci.h |    2 ++
 arch/arm/kernel/bios32.c        |   17 +++++++++++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/mach/pci.h b/arch/arm/include/asm/mach/pci.h
index db9fedb..a2301ae 100644
--- a/arch/arm/include/asm/mach/pci.h
+++ b/arch/arm/include/asm/mach/pci.h
@@ -42,6 +42,8 @@ struct pci_sys_data {
 	int		busnr;		/* primary bus number			*/
 	u64		mem_offset;	/* bus->cpu memory mapping offset	*/
 	unsigned long	io_offset;	/* bus->cpu IO mapping offset		*/
+	resource_size_t	win_align_mem;
+	resource_size_t	win_align_io;
 	struct pci_bus	*bus;		/* PCI bus				*/
 	struct list_head resources;	/* root bus resources (apertures)       */
 	struct resource io_res;
diff --git a/arch/arm/kernel/bios32.c b/arch/arm/kernel/bios32.c
index 379cf32..ba81630 100644
--- a/arch/arm/kernel/bios32.c
+++ b/arch/arm/kernel/bios32.c
@@ -463,6 +463,8 @@ static void __init pcibios_init_hw(struct hw_pci *hw, struct list_head *head)
 		sys->swizzle = hw->swizzle;
 		sys->map_irq = hw->map_irq;
 		INIT_LIST_HEAD(&sys->resources);
+		sys->win_align_mem = 1;
+		sys->win_align_io = 1;
 
 		ret = hw->setup(nr, sys);
 
@@ -581,6 +583,21 @@ resource_size_t pcibios_align_resource(void *data, const struct resource *res,
 	return start;
 }
 
+resource_size_t pcibios_window_alignment(struct pci_bus *bus,
+					 unsigned long type)
+{
+	struct pci_sys_data *sys = bus->sysdata;
+
+	/* Ignore downstream buses */
+	if (!bus->parent) {
+		if (type & IORESOURCE_MEM)
+			return sys->win_align_mem;
+		if (type & IORESOURCE_IO)
+			return sys->win_align_io;
+	}
+	return 1;
+}
+
 /**
  * pcibios_enable_device - Enable I/O and memory.
  * @dev: PCI device to be enabled
