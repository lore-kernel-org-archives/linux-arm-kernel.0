From: andrew.murray@arm.com (Andrew Murray)
Date: Thu, 11 Apr 2013 13:03:22 +0100
Subject: [PATCH v5 1/3] of/pci: Unify pci_process_bridge_OF_ranges from
 Microblaze and PowerPC
In-Reply-To: <51656592.7070806@gmail.com>
References: <1365578969-30966-1-git-send-email-Andrew.Murray@arm.com>
 <1365578969-30966-2-git-send-email-Andrew.Murray@arm.com>
 <51656592.7070806@gmail.com>
Message-ID: <20130411120322.GA28981@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 02:13:54PM +0100, Rob Herring wrote:
> Adding Ben H and Michal...
> 
> On 04/10/2013 02:29 AM, Andrew Murray wrote:
> > The pci_process_bridge_OF_ranges function, used to parse the "ranges"
> > property of a PCI host device, is found in both Microblaze and PowerPC
> > architectures. These implementations are nearly identical. This patch
> > moves this common code to a common place.
> > 
> > Signed-off-by: Andrew Murray <Andrew.Murray@arm.com>
> > Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
> 
> One comment below. Otherwise,
> 
> Reviewed-by: Rob Herring <rob.herring@calxeda.com>
> 
> You need also need acks from Ben and Michal.
> 
> [...]
> 
> > +		/* Act based on address space type */
> > +		res = NULL;
> > +		switch ((pci_space >> 24) & 0x3) {
> > +		case 1:		/* PCI IO space */
> > +			pr_info("  IO 0x%016llx..0x%016llx -> 0x%016llx\n",
> > +			       cpu_addr, cpu_addr + size - 1, pci_addr);
> > +
> > +			/* We support only one IO range */
> > +			if (hose->pci_io_size) {
> > +				pr_info(" \\--> Skipped (too many) !\n");
> > +				continue;
> > +			}
> > +#if defined(CONFIG_PPC32) || defined(CONFIG_MICROBLAZE)
> 
> How about "if (!IS_ENABLED(CONFIG_64BIT))" instead.

OK I'll add in my next re-spin. Would "#ifndef CONFIG_64BIT" suffice?

> 
> > +			/* On 32 bits, limit I/O space to 16MB */
> > +			if (size > 0x01000000)
> > +				size = 0x01000000;
> > +
> > +			/* 32 bits needs to map IOs here */
> > +			hose->io_base_virt = ioremap(cpu_addr, size);
> > +
> > +			/* Expect trouble if pci_addr is not 0 */
> > +			if (primary)
> > +				isa_io_base =
> > +					(unsigned long)hose->io_base_virt;
> > +#endif /* CONFIG_PPC32 || CONFIG_MICROBLAZE */
> > +			/* pci_io_size and io_base_phys always represent IO
> > +			 * space starting at 0 so we factor in pci_addr
> > +			 */
> > +			hose->pci_io_size = pci_addr + size;
> > +			hose->io_base_phys = cpu_addr - pci_addr;
> 
> 
