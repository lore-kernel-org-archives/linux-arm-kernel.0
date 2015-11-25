From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 25 Nov 2015 05:40:49 +0000
Subject: [PATCH v9] PCI: Xilinx-NWL-PCIe: Added support for Xilinx NWL
 PCIe Host Controller
In-Reply-To: <20151124173556.18aff6b5@arm.com>
References: <1447911323-12567-1-git-send-email-bharatku@xilinx.com>
 <20151124173556.18aff6b5@arm.com>
Message-ID: <8520D5D51A55D047800579B0941471982586607F@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Thu, 19 Nov 2015 11:05:23 +0530
> Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com> wrote:
> 
> > Adding PCIe Root Port driver for Xilinx PCIe NWL bridge IP.
> >
> > Signed-off-by: Bharat Kumar Gogada <bharatku@xilinx.com>
> > Signed-off-by: Ravi Kiran Gummaluri <rgummal@xilinx.com>
> > Acked-by: Rob Herring <robh@kernel.org>
> > ---
> > +
> > +#define MSI_ADDRESS				0xDEED0000
> 
> How did you pick this value? What if it intersect with some actual RAM?
> What if a device actually does DMA to that location?
> 
> Wouldn't it make sense to actually pick a real *device* address (hint:
> your MSI controller itself) for this purpose, as the device will never DMA
> there?
>
> 
We have already mentioned in previous patch discussion, we don't have any device address on our SOC for MSI, that's 
 the reason we are allocating a page for MSI in RAM. Since our memory write is consumed by bridge and doesn't write to memory, you suggested to use 
some random address,  so using some random address.
> 
> 
> > +
> > +static int nwl_irq_domain_alloc(struct irq_domain *domain, unsigned int
> virq,
> > +				unsigned int nr_irqs, void *args) {
> > +	struct nwl_pcie *pcie = domain->host_data;
> > +	struct nwl_msi *msi = &pcie->msi;
> > +	int bit;
> > +	int i;
> > +	int ret;
> > +
> > +	mutex_lock(&msi->lock);
> > +	if (nr_irqs > 1) {
> > +		ret = nwl_check_hwirq(msi, nr_irqs);
> > +		if (ret < 0) {
> > +			mutex_unlock(&msi->lock);
> > +			return ret;
> > +		}
> > +	} else {
> > +		ret = find_first_zero_bit(msi->used, INT_PCI_MSI_NR);
> > +		if (ret == INT_PCI_MSI_NR) {
> > +			mutex_unlock(&msi->lock);
> > +			return -ENOSPC;
> > +		}
> > +	}
> 
> Let's be serious for a minute. What's wrong with
> bitmap_find_next_zero_area, for example?
Ok, will explore this API and do accordingly, and address in next patch.
> 
> > +
> > +	for (i = 0; i < nr_irqs; i++) {
> > +		bit = ret + i;
> > +		set_bit(bit, msi->used);
> > +
> > +		irq_domain_set_info(domain, virq + i, bit, &nwl_irq_chip,
> > +				domain->host_data, handle_simple_irq,
> > +				NULL, NULL);
> > +	}
> > +	mutex_unlock(&msi->lock);
> > +
> > +	return 0;
> > +}
> 
> Thanks,
> 
> 	M.
> --
> Jazz is not dead. It just smells funny.
