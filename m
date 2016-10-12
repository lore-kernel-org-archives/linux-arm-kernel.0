From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 12 Oct 2016 14:07:30 -0500
Subject: [PATCH V2 2/3] ACPI, PCI IRQ: add PCI_USING penalty for ISA
 interrupts
In-Reply-To: <1475615720-31047-3-git-send-email-okaya@codeaurora.org>
References: <1475615720-31047-1-git-send-email-okaya@codeaurora.org>
 <1475615720-31047-3-git-send-email-okaya@codeaurora.org>
Message-ID: <20161012190729.GA15116@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 04, 2016 at 05:15:18PM -0400, Sinan Kaya wrote:
> The change introduced in commit 103544d86976 ("ACPI,PCI,IRQ: reduce
> resource requirements") removed PCI_USING penalty from
> acpi_pci_link_allocate function as there is no longer a fixed size penalty
> array for both PCI and IRQ interrupts.
> 
> We need to add the PCI_USING penalty for ISA interrupts too if the link is
> in use and matches our ISA IRQ number.
> 
> Tested-by: Jonathan Liu <net147@gmail.com>
> Tested-by: Ondrej Zary <linux@rainbow-software.org>
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  drivers/acpi/pci_link.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/pci_link.c b/drivers/acpi/pci_link.c
> index f3792f4..06c2a11 100644
> --- a/drivers/acpi/pci_link.c
> +++ b/drivers/acpi/pci_link.c
> @@ -620,6 +620,10 @@ static int acpi_pci_link_allocate(struct acpi_pci_link *link)
>  			    acpi_device_bid(link->device));
>  		return -ENODEV;
>  	} else {
> +		if (link->irq.active < ACPI_MAX_IRQS)
> +			acpi_irq_penalty[link->irq.active] +=
> +				PIRQ_PENALTY_PCI_USING;

Nit: elsewhere you use ARRAY_SIZE(acpi_irq_penalty), so it'd be nice
to be consistent, e.g.,

  if (link->irq.active < ARRAY_SIZE(acpi_irq_penalty))
    acpi_irq_penalty[link->irq.active] += PIRQ_PENALTY_PCI_USING;

There are a couple other similar uses in acpi_irq_get_penalty() and
acpi_irq_penalty_init().

>  		printk(KERN_WARNING PREFIX "%s [%s] enabled at IRQ %d\n",
>  		       acpi_device_name(link->device),
>  		       acpi_device_bid(link->device), link->irq.active);
> -- 
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
