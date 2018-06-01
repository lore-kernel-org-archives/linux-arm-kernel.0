From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 1 Jun 2018 13:53:10 -0500
Subject: [PATCH V2] PCI: move early dump functionality from x86 arch into
 the common code
In-Reply-To: <1527878854-21419-1-git-send-email-okaya@codeaurora.org>
References: <1527878854-21419-1-git-send-email-okaya@codeaurora.org>
Message-ID: <20180601185310.GA175802@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 02:47:28PM -0400, Sinan Kaya wrote:
> Move early dump functionality into common code so that it is available for
> all archtiectures. No need to carry arch specific reads around as the read
> hooks are already initialized by the time pci_setup_device() is getting
> called during scan.

> +static void early_dump_pci_device(struct pci_dev *pdev)
> +{
> +	u32 value[256 / 4];
> +	int i;
> +
> +	if (!pci_early_dump)
> +		return;
> +
> +	pci_info(pdev, "pci 0000:%02x:%02x.%d config space:\n",
> +		 pdev->bus->number, PCI_SLOT(pdev->devfn),
> +		 PCI_FUNC(pdev->devfn));

I'm still missing something -- why go to the trouble of pdev->bus->number,
PCI_SLOT(), etc?  Isn't the output going to look like this?

  pci 0000:00:00.0: pci 0000:00:00.0 config space:

In other words, wouldn't the following be enough?

  pci_info(pdev, "config space:\n");

> +
> +	for (i = 0; i < 256; i += 4)
> +		pci_read_config_dword(pdev, i, &value[i / 4]);
> +
> +	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_OFFSET, 16, 1, value,
> +		       256, false);
> +}
