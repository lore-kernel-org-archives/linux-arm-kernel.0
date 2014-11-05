From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 5 Nov 2014 15:45:04 -0700
Subject: [Patch Part2 v4 20/31] PCI/MSI: Kill redundant calling for
 irq_set_msi_desc() for MSIx interrupts
In-Reply-To: <1415102525-9898-21-git-send-email-jiang.liu@linux.intel.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <1415102525-9898-21-git-send-email-jiang.liu@linux.intel.com>
Message-ID: <20141105224504.GG6168@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 04, 2014 at 08:01:54PM +0800, Jiang Liu wrote:
> It's arch_setup_msi_irq()/arch_setup_msi_irqs()'s responsibility to call
> irq_set_msi_desc() to associate IRQ descriptors and MSI descriptors,
> so kill the redundant call of irq_set_msi_desc() for MSIx interrupts
> in PCI MSI core.

"MSI-X" in English text, "msix" in code.

The default arch_setup_msi_irq() in drivers/pci/msi.c doesn't call
irq_set_msi_desc().  Does it happen somewhere inside chip->setup_irq()?

I don't know how to verify that there are calls in all the places needed.
That makes me wonder if the factoring is wrong -- maybe irq_set_msi_desc()
could be done in some common place.

> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>  drivers/pci/msi.c |    1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index afe974600c7d..da181c59394b 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -685,7 +685,6 @@ static void msix_program_entries(struct pci_dev *dev,
>  						PCI_MSIX_ENTRY_VECTOR_CTRL;
>  
>  		entries[i].vector = entry->irq;
> -		irq_set_msi_desc(entry->irq, entry);
>  		entry->masked = readl(entry->mask_base + offset);
>  		msix_mask_irq(entry, 1);
>  		i++;
> -- 
> 1.7.10.4
> 
