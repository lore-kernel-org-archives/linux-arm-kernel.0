From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Tue, 17 Nov 2015 05:01:54 +0000
Subject: [PATCH v8] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <564A55C9.40200@broadcom.com>
References: <1447223619-30945-1-git-send-email-bharatku@xilinx.com>
 <564A55C9.40200@broadcom.com>
Message-ID: <8520D5D51A55D047800579B0941471982585CBE6@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> On 11/10/2015 10:33 PM, Bharat Kumar Gogada wrote:
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > ---
> > Added logic to allocate contiguous hwirq in nwl_irq_domain_alloc function.
> > Moved MSI functionality to separate functions.
> > Changed error return values.
> > +static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int
> virq,
> > +				unsigned int nr_irqs, void *args) {
> > +	struct nwl_pcie *pcie = domain->host_data;
> > +	struct nwl_msi *msi = &pcie->msi;
> > +	unsigned long bit;
> > +	int i;
> > +
> > +	mutex_lock(&msi->lock);
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		bit = find_first_zero_bit(msi->used, INT_PCI_MSI_NR);
> > +		if (bit < INT_PCI_MSI_NR)
> > +			set_bit(bit, msi->used);
> > +		else
> > +			bit = -ENOSPC;
> 
> Don't you get a compiler warning with this? Note bit is unsigned long and you
> assign -ENOSPC to it.
> 
Ya that's a mistake, I will address these in next patch.
> > +
> > +		if (bit < 0) {
> 
> how can bit < 0 if it's unsigned long?
> 
> > +			mutex_unlock(&msi->lock);
> > +			return bit;
> > +		}
> > +
> > +		irq_domain_set_info(domain, virq, bit, &nwl_irq_chip,
> > +				domain->host_data, handle_simple_irq,
> > +				NULL, NULL);
> 
> nit, but if you do irq_domain_set_info(domain, virq + i, ...
> 
> then you can get rid of the code below.
> 
> > +		virq = virq + 1;
> > +	}
> > +	mutex_unlock(&msi->lock);
> > +	return 0;
> > +}
> > +
