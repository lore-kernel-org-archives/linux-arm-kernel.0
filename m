From: bhelgaas@google.com (Bjorn Helgaas)
Date: Thu, 23 Jul 2015 08:06:37 -0500
Subject: [PATCH v5 04/19] PCI/MSI: Add hooks to populate the msi_domain
 field
In-Reply-To: <1437643598-19795-5-git-send-email-marc.zyngier@arm.com>
References: <1437643598-19795-1-git-send-email-marc.zyngier@arm.com>
 <1437643598-19795-5-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150723130637.GR21967@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 23, 2015 at 10:26:23AM +0100, Marc Zyngier wrote:
> In order to be able to populate the device msi_domain field,
> add the necessary hooks to propagate the host bridge msi_domain
> across secondary busses to devices.
> 
> So far, nobody populates the initial msi_domain.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> +static void pci_set_msi_domain(struct pci_dev *dev)
> +{
> +	/*
> +	 * If no domain has been set through the pcibios callback,
> +	 * inherit the default from the bus device.

Nit: there isn't a pcibios callback anymore.

> +	 */
> +	if (!dev_get_msi_domain(&dev->dev))
> +		dev_set_msi_domain(&dev->dev,
> +				   dev_get_msi_domain(&dev->bus->dev));
> +}
